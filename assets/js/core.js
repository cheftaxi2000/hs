// Shared infrastructure: theme tokens, canvas stage, animation loop, 2D drawing primitives, UI controls.

export const TAU = Math.PI * 2;
export const clamp = (x, a, b) => Math.min(b, Math.max(a, x));
export const lerp = (a, b, t) => a + (b - a) * t;
export const smooth = (t) => t * t * (3 - 2 * t);

/* ---------------- theme ---------------- */
const TOKENS = ['bg', 'surface', 'surface-2', 'ink', 'ink-2', 'muted', 'hair', 'grid', 'v', 'v-soft', 'f', 'm', 'k', 'k-soft'];
export const C = {};
const themeListeners = new Set();
export function readTheme() {
  const cs = getComputedStyle(document.documentElement);
  for (const t of TOKENS) C[t.replace('-', '')] = cs.getPropertyValue('--' + t).trim() || '#888';
  C.dark = luminance(C.bg) < 0.4;
}
function luminance(hex) {
  const m = hex.replace('#', '');
  if (m.length < 6) return 1;
  const r = parseInt(m.slice(0, 2), 16) / 255, g = parseInt(m.slice(2, 4), 16) / 255, b = parseInt(m.slice(4, 6), 16) / 255;
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}
export function onTheme(fn) { themeListeners.add(fn); return () => themeListeners.delete(fn); }
function fireTheme() { readTheme(); themeListeners.forEach((f) => f()); }
readTheme();
matchMedia('(prefers-color-scheme: dark)').addEventListener?.('change', fireTheme);
new MutationObserver(fireTheme).observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme', 'class', 'style'] });

/** colour with alpha, accepts #rrggbb */
export function alpha(hex, a) {
  const m = hex.replace('#', '');
  const r = parseInt(m.slice(0, 2), 16), g = parseInt(m.slice(2, 4), 16), b = parseInt(m.slice(4, 6), 16);
  return `rgba(${r},${g},${b},${a})`;
}
export function mix(h1, h2, t) {
  const p = (h) => [1, 3, 5].map((i) => parseInt(h.slice(i, i + 2), 16));
  const a = p(h1), b = p(h2);
  return '#' + a.map((x, i) => Math.round(lerp(x, b[i], t)).toString(16).padStart(2, '0')).join('');
}

export const FONT = {
  sans: '"Atkinson Hyperlegible Next", "Helvetica Neue", Arial, sans-serif',
  serif: '"STIX Two Text", "Times New Roman", Times, serif',
  mono: '"Atkinson Hyperlegible Mono", ui-monospace, Menlo, monospace',
};

/* ---------------- stage ---------------- */
export class Stage {
  constructor(host, { draw, pointer } = {}) {
    this.host = host;
    this.canvas = document.createElement('canvas');
    host.appendChild(this.canvas);
    this.ctx = this.canvas.getContext('2d');
    this.drawFn = draw;
    this.w = 1; this.h = 1; this.dpr = 1;
    this.dirty = true;
    this.ro = new ResizeObserver(() => this.resize());
    this.ro.observe(host);
    this.resize();
    if (pointer) this.bindPointer(pointer);
    this.offTheme = onTheme(() => this.invalidate());
  }
  resize() {
    const r = this.host.getBoundingClientRect();
    this.dpr = Math.min(window.devicePixelRatio || 1, 2.5);
    this.w = Math.max(1, r.width); this.h = Math.max(1, r.height);
    this.canvas.width = Math.round(this.w * this.dpr);
    this.canvas.height = Math.round(this.h * this.dpr);
    this.onResize?.(this.w, this.h);
    this.invalidate();
    this.render();
  }
  invalidate() { this.dirty = true; }
  render() {
    const { ctx } = this;
    ctx.setTransform(this.dpr, 0, 0, this.dpr, 0, 0);
    ctx.clearRect(0, 0, this.w, this.h);
    ctx.fillStyle = C.surface; ctx.fillRect(0, 0, this.w, this.h);
    this.drawFn?.(ctx, this.w, this.h);
    this.dirty = false;
  }
  bindPointer(p) {
    const cv = this.canvas;
    let active = null;
    const pos = (e) => { const r = cv.getBoundingClientRect(); return [e.clientX - r.left, e.clientY - r.top]; };
    cv.addEventListener('pointerdown', (e) => {
      const [x, y] = pos(e);
      const h = p.down?.(x, y, e);
      if (h) { active = h; cv.setPointerCapture(e.pointerId); e.preventDefault(); this.invalidate(); }
    });
    cv.addEventListener('pointermove', (e) => {
      const [x, y] = pos(e);
      if (active) { p.drag?.(active, x, y, e); this.invalidate(); e.preventDefault(); }
      else if (e.pointerType === 'mouse') { const hov = p.hover?.(x, y); cv.style.cursor = hov ? (hov === true ? 'grab' : hov) : 'default'; }
    });
    const up = (e) => { if (active) { p.up?.(active, e); active = null; this.invalidate(); } };
    cv.addEventListener('pointerup', up);
    cv.addEventListener('pointercancel', up);
  }
  destroy() { this.ro.disconnect(); this.offTheme(); this.canvas.remove(); }
}

/* ---------------- animation loop ---------------- */
export class Runner {
  constructor({ update, stages, onTick }) {
    this.update = update; this.stages = stages; this.onTick = onTick;
    this.playing = false; this.raf = 0; this.last = 0; this.alive = true;
    this.listeners = new Set();
    const loop = (ts) => {
      if (!this.alive) return;
      this.raf = requestAnimationFrame(loop);
      const dt = this.last ? Math.min(0.05, (ts - this.last) / 1000) : 0;
      this.last = ts;
      if (this.playing && dt > 0) { this.update?.(dt); this.stages.forEach((s) => s.invalidate()); }
      let drew = false;
      this.stages.forEach((s) => { if (s.dirty) { s.render(); drew = true; } });
      if (drew) this.onTick?.();
    };
    this.raf = requestAnimationFrame(loop);
  }
  play() { this.playing = true; this.emit(); }
  pause() { this.playing = false; this.emit(); }
  toggle() { this.playing ? this.pause() : this.play(); }
  on(fn) { this.listeners.add(fn); }
  emit() { this.listeners.forEach((f) => f(this.playing)); }
  destroy() { this.alive = false; cancelAnimationFrame(this.raf); }
}

/* ---------------- 2D view (world units, y up) ---------------- */
export class View {
  constructor() { this.s = 100; this.ox = 0; this.oy = 0; }
  /** fit world box [x0,x1]×[y0,y1] into rect (px) keeping aspect */
  fit(x0, x1, y0, y1, rx, ry, rw, rh, pad = 24) {
    const s = Math.min((rw - 2 * pad) / (x1 - x0), (rh - 2 * pad) / (y1 - y0));
    this.s = s;
    this.ox = rx + rw / 2 - s * (x0 + x1) / 2;
    this.oy = ry + rh / 2 + s * (y0 + y1) / 2;
    return this;
  }
  X(x) { return this.ox + this.s * x; }
  Y(y) { return this.oy - this.s * y; }
  P(p) { return [this.X(p[0]), this.Y(p[1])]; }
  inv(px, py) { return [(px - this.ox) / this.s, (this.oy - py) / this.s]; }
}

/* ---------------- drawing primitives (pixel space) ---------------- */
export function line(ctx, x0, y0, x1, y1, color, w = 1, dash = null) {
  ctx.save(); ctx.strokeStyle = color; ctx.lineWidth = w; ctx.lineCap = 'round';
  if (dash) ctx.setLineDash(dash);
  ctx.beginPath(); ctx.moveTo(x0, y0); ctx.lineTo(x1, y1); ctx.stroke(); ctx.restore();
}
export function poly(ctx, pts, color, w = 1, { dash = null, close = false, fill = null, join = 'round' } = {}) {
  if (pts.length < 2) return;
  ctx.save(); ctx.lineJoin = join; ctx.lineCap = 'round';
  ctx.beginPath(); ctx.moveTo(pts[0][0], pts[0][1]);
  for (let i = 1; i < pts.length; i++) ctx.lineTo(pts[i][0], pts[i][1]);
  if (close) ctx.closePath();
  if (fill) { ctx.fillStyle = fill; ctx.fill(); }
  if (color) { ctx.strokeStyle = color; ctx.lineWidth = w; if (dash) ctx.setLineDash(dash); ctx.stroke(); }
  ctx.restore();
}
/** polyline with breaks where points are null */
export function path(ctx, pts, color, w = 1, dash = null) {
  ctx.save(); ctx.strokeStyle = color; ctx.lineWidth = w; ctx.lineJoin = 'round'; ctx.lineCap = 'round';
  if (dash) ctx.setLineDash(dash);
  ctx.beginPath(); let pen = false;
  for (const p of pts) {
    if (!p) { pen = false; continue; }
    if (!pen) { ctx.moveTo(p[0], p[1]); pen = true; } else ctx.lineTo(p[0], p[1]);
  }
  ctx.stroke(); ctx.restore();
}
export function circle(ctx, x, y, r, stroke, w = 1, fill = null, dash = null) {
  ctx.save(); ctx.beginPath(); ctx.arc(x, y, Math.max(0, r), 0, TAU);
  if (fill) { ctx.fillStyle = fill; ctx.fill(); }
  if (stroke) { ctx.strokeStyle = stroke; ctx.lineWidth = w; if (dash) ctx.setLineDash(dash); ctx.stroke(); }
  ctx.restore();
}
export function dot(ctx, x, y, r, color, ring = C.surface) {
  ctx.save(); ctx.beginPath(); ctx.arc(x, y, r + 1.6, 0, TAU); ctx.fillStyle = ring; ctx.fill();
  ctx.beginPath(); ctx.arc(x, y, r, 0, TAU); ctx.fillStyle = color; ctx.fill(); ctx.restore();
}
export function ring(ctx, x, y, r, color, w = 1.6) {
  ctx.save(); ctx.beginPath(); ctx.arc(x, y, r, 0, TAU); ctx.fillStyle = C.surface; ctx.fill();
  ctx.strokeStyle = color; ctx.lineWidth = w; ctx.stroke(); ctx.restore();
}
/** arrow from (x0,y0) to (x1,y1) in px */
export function arrow(ctx, x0, y0, x1, y1, color, w = 2, head = 10) {
  // technical-drawing arrow: slender filled head, shaft slightly lighter than the caller asks for
  w = w * 0.82;
  const dx = x1 - x0, dy = y1 - y0, L = Math.hypot(dx, dy);
  if (L < 0.5) return;
  const ux = dx / L, uy = dy / L;
  const h = Math.min(head * 0.95 + w, L * 0.6), hw = h * 0.3;
  const bx = x1 - ux * h * 0.7, by = y1 - uy * h * 0.7;
  ctx.save(); ctx.strokeStyle = color; ctx.fillStyle = color; ctx.lineWidth = w; ctx.lineCap = 'butt';
  ctx.beginPath(); ctx.moveTo(x0, y0); ctx.lineTo(bx, by); ctx.stroke();
  ctx.beginPath(); ctx.moveTo(x1, y1);
  ctx.lineTo(x1 - ux * h - uy * hw, y1 - uy * h + ux * hw);
  ctx.lineTo(x1 - ux * h * 0.8, y1 - uy * h * 0.8);
  ctx.lineTo(x1 - ux * h + uy * hw, y1 - uy * h - ux * hw);
  ctx.closePath(); ctx.fill(); ctx.restore();
}
/** curved arrow (moment) around (cx,cy), radius r, from a0 to a1 (canvas angles, radians) */
export function arcArrow(ctx, cx, cy, r, a0, a1, color, w = 2, head = 9) {
  ctx.save(); ctx.strokeStyle = color; ctx.fillStyle = color; ctx.lineWidth = w; ctx.lineCap = 'round';
  const ccw = a1 < a0;
  const trim = (head * 0.7) / r * (ccw ? -1 : 1);
  ctx.beginPath(); ctx.arc(cx, cy, r, a0, a1 - trim, ccw); ctx.stroke();
  const ex = cx + r * Math.cos(a1), ey = cy + r * Math.sin(a1);
  const tx = -Math.sin(a1) * (ccw ? -1 : 1), ty = Math.cos(a1) * (ccw ? -1 : 1);
  const hw = head * 0.42;
  ctx.beginPath(); ctx.moveTo(ex, ey);
  ctx.lineTo(ex - tx * head - ty * hw, ey - ty * head + tx * hw);
  ctx.lineTo(ex - tx * head * 0.78, ey - ty * head * 0.78);
  ctx.lineTo(ex - tx * head + ty * hw, ey - ty * head - tx * hw);
  ctx.closePath(); ctx.fill(); ctx.restore();
}
export function rightAngle(ctx, x, y, ux, uy, vx, vy, s, color) {
  // corner at (x,y), unit directions u and v (px)
  ctx.save(); ctx.strokeStyle = color; ctx.lineWidth = 1;
  ctx.beginPath(); ctx.moveTo(x + ux * s, y + uy * s); ctx.lineTo(x + ux * s + vx * s, y + uy * s + vy * s); ctx.lineTo(x + vx * s, y + vy * s); ctx.stroke();
  ctx.restore();
}
/** engineering hatch along a segment; side = +1 hatch on the left of p0→p1 */
export function hatch(ctx, x0, y0, x1, y1, color, side = 1, depth = 9, gap = 7) {
  const dx = x1 - x0, dy = y1 - y0, L = Math.hypot(dx, dy); if (L < 1) return;
  const ux = dx / L, uy = dy / L, nx = -uy * side, ny = ux * side;
  ctx.save(); ctx.strokeStyle = color; ctx.lineWidth = 1;
  ctx.beginPath();
  for (let s = gap / 2; s < L; s += gap) {
    const px = x0 + ux * s, py = y0 + uy * s;
    ctx.moveTo(px, py); ctx.lineTo(px + nx * depth - ux * depth * 0.8, py + ny * depth - uy * depth * 0.8);
  }
  ctx.stroke();
  ctx.lineWidth = 1.6; ctx.beginPath(); ctx.moveTo(x0, y0); ctx.lineTo(x1, y1); ctx.stroke();
  ctx.restore();
}

/** math label: "v_M", "ω", "**v**_B" (bold = vector). Draws italic serif with subscript. */
export function mlabel(ctx, text, x, y, color, { size = 16, align = 'left', base = 'middle', halo = true, upright = false } = {}) {
  let bold = false, t = text;
  if (t.startsWith('**')) { bold = true; t = t.slice(2).replace('**', ''); }
  const [b, sub] = t.split('_');
  const st = upright ? '' : 'italic ';
  const fb = `${st}${bold ? 600 : 400} ${size}px ${FONT.serif}`;
  const fs = `${st}400 ${Math.round(size * 0.7)}px ${FONT.serif}`;
  ctx.save();
  ctx.font = fb; const wb = ctx.measureText(b).width;
  ctx.font = fs; const ws = sub ? ctx.measureText(sub).width + 1 : 0;
  const W = wb + ws;
  let x0 = x; if (align === 'center') x0 = x - W / 2; else if (align === 'right') x0 = x - W;
  ctx.textBaseline = base;
  const drawAll = (stroke) => {
    ctx.font = fb; stroke ? ctx.strokeText(b, x0, y) : ctx.fillText(b, x0, y);
    if (sub) { ctx.font = fs; const yy = y + size * 0.28; stroke ? ctx.strokeText(sub, x0 + wb + 1, yy) : ctx.fillText(sub, x0 + wb + 1, yy); }
  };
  if (halo) { ctx.strokeStyle = C.surface; ctx.lineWidth = 4; ctx.lineJoin = 'round'; drawAll(true); }
  ctx.fillStyle = color; drawAll(false);
  ctx.restore();
  return W;
}
export function text(ctx, s, x, y, color, { size = 12, font = 'sans', weight = 400, align = 'left', base = 'middle', halo = false } = {}) {
  ctx.save(); ctx.font = `${weight} ${size}px ${FONT[font]}`; ctx.textAlign = align; ctx.textBaseline = base;
  if (halo) { ctx.strokeStyle = C.surface; ctx.lineWidth = 4; ctx.lineJoin = 'round'; ctx.strokeText(s, x, y); }
  ctx.fillStyle = color; ctx.fillText(s, x, y); ctx.restore();
}
export const fmt = (x, d = 2) => (Math.abs(x) < 0.5 * 10 ** -d ? 0 : x).toFixed(d).replace('-', '−');

/* ---------------- UI builders ---------------- */
export function el(tag, attrs = {}, ...kids) {
  const e = document.createElement(tag);
  for (const [k, v] of Object.entries(attrs)) {
    if (k === 'class') e.className = v; else if (k === 'html') e.innerHTML = v;
    else if (k.startsWith('on')) e.addEventListener(k.slice(2), v); else if (v !== false && v != null) e.setAttribute(k, v);
  }
  for (const k of kids) if (k != null) e.append(k);
  return e;
}
let uid = 0;
export function slider({ id, label, min, max, step, value, format = (v) => v, onInput }) {
  const inp = el('input', { type: 'range', id: id || 'sl' + uid++, min, max, step, value });
  const out = el('output', { for: inp.id });
  const lab = el('label', { for: inp.id, html: label });
  const wrap = el('div', { class: 'ctrl' }, el('div', { class: 'ctrl-top' }, lab, out), inp);
  const sync = () => {
    const v = parseFloat(inp.value);
    out.innerHTML = format(v);
    inp.style.setProperty('--p', ((v - min) / (max - min)) * 100 + '%');
  };
  inp.addEventListener('input', () => { sync(); onInput?.(parseFloat(inp.value)); });
  sync();
  wrap.set = (v, silent = true) => { inp.value = v; sync(); if (!silent) onInput?.(parseFloat(inp.value)); };
  wrap.input = inp;
  return wrap;
}
export function seg(options, value, onChange, cls = 'seg') {
  const wrap = el('div', { class: cls, role: 'group' });
  const btns = options.map(([v, l]) => {
    const b = el('button', { type: 'button', 'aria-pressed': String(v === value), html: l });
    b.addEventListener('click', () => { wrap.set(v); onChange(v); });
    wrap.append(b); return [v, b];
  });
  wrap.set = (v) => btns.forEach(([k, b]) => b.setAttribute('aria-pressed', String(k === v)));
  return wrap;
}
export function chip(label, on, color, onChange) {
  const b = el('button', { type: 'button', class: 'chip', 'aria-pressed': String(on), html: label });
  if (color) b.style.setProperty('--c', color);
  b.addEventListener('click', () => { const v = b.getAttribute('aria-pressed') !== 'true'; b.setAttribute('aria-pressed', String(v)); onChange(v); });
  b.set = (v) => b.setAttribute('aria-pressed', String(v));
  return b;
}
export function readout(rows) {
  const dl = el('dl', { class: 'readout' });
  const dds = {};
  for (const [key, label] of rows) { dl.append(el('dt', { html: label })); dds[key] = el('dd'); dl.append(dds[key]); }
  dl.set = (key, html) => { if (dds[key] && dds[key]._v !== html) { dds[key].innerHTML = html; dds[key]._v = html; } };
  return dl;
}
export const ICON = {
  play: '<svg viewBox="0 0 16 16"><path d="M4 2.5v11l9.5-5.5z" fill="currentColor"/></svg>',
  pause: '<svg viewBox="0 0 16 16"><rect x="3.5" y="2.5" width="3" height="11" rx=".8" fill="currentColor"/><rect x="9.5" y="2.5" width="3" height="11" rx=".8" fill="currentColor"/></svg>',
  restart: '<svg viewBox="0 0 16 16"><path d="M3 8a5 5 0 1 0 1.6-3.7" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M2.4 1.8v3.6H6" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  prev: '<svg viewBox="0 0 16 16"><path d="M10 3 5 8l5 5" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  next: '<svg viewBox="0 0 16 16"><path d="m6 3 5 5-5 5" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/></svg>',
};

/** transport bar: play/pause, restart, optional scrubber */
export function transport(runner, { onRestart, scrub, label } = {}) {
  const bPlay = el('button', { type: 'button', class: 'tbtn primary', 'aria-label': 'Abspielen' });
  const bRe = el('button', { type: 'button', class: 'tbtn', 'aria-label': 'Neu starten', html: ICON.restart });
  const sync = (p) => { bPlay.innerHTML = p ? ICON.pause : ICON.play; bPlay.setAttribute('aria-label', p ? 'Pause' : 'Abspielen'); };
  bPlay.addEventListener('click', () => runner.toggle());
  bRe.addEventListener('click', () => onRestart?.());
  runner.on(sync); sync(runner.playing);
  const bar = el('div', { class: 'transport' }, bPlay, bRe);
  if (scrub) { scrub.classList.add('scrub'); bar.append(scrub); }
  if (label) bar.append(label);
  return bar;
}

export function typeset(node) {
  const go = () => window.MathJax?.typesetPromise?.([node]).catch(() => {});
  if (window.MathJax?.typesetPromise) go();
  else {
    let tries = 0;
    const iv = setInterval(() => { if (window.MathJax?.typesetPromise) { clearInterval(iv); go(); } else if (++tries > 200) clearInterval(iv); }, 100);
  }
}

/** Builds the standard viz layout and returns handles. */
export function layout(root, meta) {
  const scenes = el('div', { class: 'scenes-slot' });
  const head = el('div', { class: 'stage-head' },
    el('div', {}, el('div', { class: 'eyebrow', html: meta.tag }), el('h1', { html: meta.title })), scenes);
  const stage = el('div', { class: 'stage' });
  const tslot = el('div');
  const stageWrap = el('section', { class: 'stage-wrap' }, head, stage, tslot);
  const panel = el('aside', { class: 'panel' });
  const viz = el('div', { class: 'viz' }, stageWrap, panel);
  root.append(viz);
  return { stage, panel, scenes, tslot, viz };
}

/** progressive explanation card */
export function stepper(steps, onStep) {
  let i = 0;
  const count = el('span', { class: 'count' });
  const dots = el('div', { class: 'dots' });
  const h = el('h2');
  const body = el('div', { class: 'body' });
  const bPrev = el('button', { type: 'button', class: 'btn', html: '← Zurück' });
  const bNext = el('button', { type: 'button', class: 'btn solid', html: 'Weiter →' });
  const card = el('section', { class: 'steps', 'aria-live': 'polite' },
    el('div', { class: 'steps-top' }, dots, count), h, body, el('div', { class: 'step-nav' }, bPrev, bNext));
  const ds = steps.map((s, k) => {
    const d = el('button', { type: 'button', 'aria-label': `Schritt ${k + 1}: ${s.title}`, html: String(k + 1).padStart(2, '0') });
    d.addEventListener('click', () => go(k)); dots.append(d); return d;
  });
  function go(k) {
    i = clamp(k, 0, steps.length - 1);
    const s = steps[i];
    count.textContent = 'Erklärung';
    h.innerHTML = s.title; body.innerHTML = s.html;
    ds.forEach((d, j) => j === i ? d.setAttribute('aria-current', 'step') : d.removeAttribute('aria-current'));
    bPrev.disabled = i === 0; bNext.disabled = i === steps.length - 1;
    typeset(body);
    onStep?.(s, i);
  }
  bPrev.addEventListener('click', () => go(i - 1));
  bNext.addEventListener('click', () => go(i + 1));
  card.go = go; card.index = () => i;
  return card;
}
