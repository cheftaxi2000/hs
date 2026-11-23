// Rekursion: Code, Call-Stack und Aufrufbaum im Gleichschritt (Informatik, Kap. 4, 7, 9)
import {
  C, clamp, Stage, Runner, line, dot, text, fmt,
  el, seg, chip, readout, transport, layout, stepper, typeset, alpha, slider, smooth,
} from '../core.js';

export const meta = {
  id: 'rekursion',
  group: 'Informatik',
  short: 'Rekursion',
  tag: 'Informatik · Kapitel 4, 7 und 9',
  title: 'Was passiert bei einem rekursiven Aufruf?',
  card: 'Code, Call-Stack und Aufrufbaum laufen im Gleichschritt. Der Stack ist immer genau der Weg von der Wurzel zum aktiven Aufruf.',
};

const CODE = {
  fact: ['int factorial(int n) {', '    if (n == 0) return 1;', '    return n * factorial(n - 1);', '}'],
  fib: ['int fib(int n) {', '    ++calls;', '    if (n <= 1) return n;', '    return fib(n - 1) + fib(n - 2);', '}'],
  fibm: ['long fib(int n, std::vector<long>& memo) {', '    ++calls;', '    if (n <= 1) return n;', '    if (memo[n] != -1) return memo[n];', '    memo[n] = fib(n - 1, memo) + fib(n - 2, memo);', '    return memo[n];', '}'],
  hanoi: ['void hanoi(int n, char from, char to, char via) {', '    if (n == 0) return;', '    hanoi(n - 1, from, via, to);', '    // Scheibe n von from nach to', '    hanoi(n - 1, via, to, from);', '}'],
};

/* ---------- simulation: a list of complete snapshots ---------- */
function simulate(kind, n, memoOn) {
  const nodes = [], steps = [], stack = [{ name: 'main', args: '', note: '', line: -1 }];
  let calls = 0; const memo = new Array(n + 1).fill(-1);
  const pegs = [[], [], []]; if (kind === 'hanoi') for (let d = n; d >= 1; d--) pegs[0].push(d);
  const snap = (msg, extra = {}) => steps.push({
    line: stack[stack.length - 1].line, msg, calls,
    stack: stack.map((f) => ({ ...f })), status: nodes.map((d) => ({ st: d.st, ret: d.ret })),
    memo: memo.slice(), pegs: pegs.map((p) => p.slice()), ...extra,
  });
  const node = (label, parent) => { const id = nodes.length; nodes.push({ id, label, parent, kids: [], st: 'active', ret: null }); if (parent != null) nodes[parent].kids.push(id); return id; };
  const top = () => stack[stack.length - 1];

  function fact(m, parent) {
    const id = node(`f(${m})`, parent); calls++;
    stack.push({ name: 'factorial', args: `n = ${m}`, note: 'prüft den Basisfall', line: 1, id }); snap(`factorial(${m}) wird aufgerufen: ein neuer Rahmen mit eigenem n.`);
    if (m === 0) { nodes[id].ret = 1; top().note = 'gibt 1 zurück'; snap('Basisfall erreicht: 0! = 1, keine weiteren Aufrufe.'); return ret(id, 1); }
    top().line = 2; top().note = `wartet auf factorial(${m - 1})`; nodes[id].st = 'waiting'; snap(`factorial(${m}) braucht factorial(${m - 1}) und wartet.`);
    const r = fact(m - 1, id);
    nodes[id].st = 'active'; top().note = `${m} · ${r} = ${m * r}`; snap(`factorial(${m - 1}) lieferte ${r}. Jetzt wird multipliziert.`);
    return ret(id, m * r);
  }
  function fib(m, parent) {
    const id = node(`fib(${m})`, parent); calls++;
    stack.push({ name: 'fib', args: `n = ${m}`, note: '', line: 1, id }); snap(`fib(${m}) wird aufgerufen (Aufruf Nr. ${calls}).`);
    top().line = 2;
    if (m <= 1) { nodes[id].ret = m; top().note = `gibt ${m} zurück`; snap(`Basisfall: fib(${m}) = ${m}.`); return ret(id, m); }
    if (memoOn) {
      top().line = 3;
      if (memo[m] !== -1) { nodes[id].st = 'memo'; nodes[id].ret = memo[m]; top().note = `memo[${m}] = ${memo[m]}`; snap(`fib(${m}) ist schon bekannt: Ergebnis aus dem Memo, kein neuer Teilbaum.`); return ret(id, memo[m], true); }
    }
    const L = memoOn ? 4 : 3;
    top().line = L; top().note = `wartet auf fib(${m - 1})`; nodes[id].st = 'waiting'; snap(`fib(${m}) ruft zuerst fib(${m - 1}) auf.`);
    const a = fib(m - 1, id);
    top().note = `${a} + wartet auf fib(${m - 2})`; snap(`fib(${m - 1}) = ${a}. Jetzt kommt fib(${m - 2}).`);
    const b = fib(m - 2, id);
    nodes[id].st = 'active'; top().note = `${a} + ${b} = ${a + b}`;
    if (memoOn) { memo[m] = a + b; snap(`fib(${m}) = ${a + b} wird im Memo gespeichert.`); top().line = 5; }
    else snap(`fib(${m}) = ${a} + ${b} = ${a + b}.`);
    return ret(id, a + b);
  }
  const P = 'ABC';
  function hanoi(m, from, to, via, parent) {
    const id = node(`h(${m}) ${P[from]}→${P[to]}`, parent); calls++;
    stack.push({ name: 'hanoi', args: `n = ${m}, ${P[from]} → ${P[to]}`, note: '', line: 1, id }); snap(m ? `${m} Scheibe${m > 1 ? 'n' : ''} von ${P[from]} nach ${P[to]} (Hilfsstab ${P[via]}).` : 'n = 0: nichts zu tun.');
    if (m === 0) { top().note = 'nichts zu tun'; return ret(id, null); }
    top().line = 2; top().note = `räumt ${m - 1} nach ${P[via]}`; nodes[id].st = 'waiting'; snap(`Zuerst die oberen ${m - 1} Scheibe${m - 1 === 1 ? '' : 'n'} aus dem Weg: nach ${P[via]}.`);
    hanoi(m - 1, from, via, to, id);
    top().line = 3; nodes[id].st = 'active'; top().note = `bewegt Scheibe ${m}`;
    pegs[from].pop(); pegs[to].push(m);
    snap(`Die größte freie Scheibe ${m} geht von ${P[from]} nach ${P[to]}.`, { move: { d: m, from, to } });
    top().line = 4; nodes[id].st = 'waiting'; top().note = `holt ${m - 1} von ${P[via]}`; snap(`Jetzt die ${m - 1} Scheibe${m - 1 === 1 ? '' : 'n'} von ${P[via]} auf Scheibe ${m}.`);
    hanoi(m - 1, via, to, from, id);
    return ret(id, null);
  }
  function ret(id, v, memoHit) {
    stack.pop(); if (!memoHit) nodes[id].st = 'done'; nodes[id].ret = v;
    snap(v == null ? 'Rücksprung: Der Rahmen wird vom Stack entfernt.' : `Rücksprung mit dem Wert ${v}: Der Rahmen verschwindet, der Aufrufer macht weiter.`);
    return v;
  }
  stack[0].note = kind === 'fact' ? `ruft factorial(${n})` : kind === 'hanoi' ? `ruft hanoi(${n}, A, C, B)` : `ruft fib(${n})`;
  snap('Das Programm steht in main.');
  if (kind === 'fact') fact(n, null); else if (kind === 'fib') fib(n, null); else hanoi(n, 0, 2, 1, null);
  stack[0].note = 'fertig'; snap('Fertig. Alle Rahmen sind wieder vom Stack verschwunden.');
  // tree layout: leaves in order, parents centred, depth = row
  let leaf = 0; const lay = (id, d) => { const nd = nodes[id]; nd.d = d; if (!nd.kids.length) nd.x = leaf++; else { nd.kids.forEach((k) => lay(k, d + 1)); nd.x = (nodes[nd.kids[0]].x + nodes[nd.kids[nd.kids.length - 1]].x) / 2; } };
  if (nodes.length) lay(0, 0);
  return { nodes, steps, leaves: leaf, depth: Math.max(...nodes.map((d) => d.d)) + 1, calls };
}

/* ---------- drawing ---------- */
function geom(W, H, kind, code) {
  const wide = W >= 760;
  if (wide) {
    const lw = Math.max(300, W * 0.36), ch = code.length * 22 + 28;
    return { wide, code: { x: 16, y: 16, w: lw - 24, h: ch }, stack: { x: 16, y: 16 + ch + 14, w: lw - 24, h: H - ch - 46 }, tree: { x: lw + 8, y: 16, w: W - lw - 24, h: kind === 'hanoi' ? H * 0.6 - 16 : H - 32 }, pegs: kind === 'hanoi' ? { x: lw + 8, y: H * 0.6 + 8, w: W - lw - 24, h: H * 0.4 - 24 } : null };
  }
  const ch = code.length * 19 + 22, sh = 120;
  const rest = H - ch - sh - 40;
  return { wide, code: { x: 10, y: 10, w: W - 20, h: ch }, tree: { x: 10, y: ch + 18, w: W - 20, h: kind === 'hanoi' ? rest * 0.58 : rest }, pegs: kind === 'hanoi' ? { x: 10, y: ch + 18 + rest * 0.58, w: W - 20, h: rest * 0.42 } : null, stack: { x: 10, y: H - sh - 12, w: W - 20, h: sh } };
}
function rr(ctx, x, y, w, h, r, fill, stroke, lw = 1, dash) {
  ctx.save(); ctx.beginPath(); ctx.roundRect(x, y, w, h, r);
  if (fill) { ctx.fillStyle = fill; ctx.fill(); }
  if (stroke) { ctx.strokeStyle = stroke; ctx.lineWidth = lw; if (dash) ctx.setLineDash(dash); ctx.stroke(); }
  ctx.restore();
}

function draw(ctx, W, H, S, opt = {}) {
  const sim = S.sim, st = sim.steps[S.k];
  const code = CODE[S.kind === 'fib' && S.memo ? 'fibm' : S.kind];
  const G = geom(W, H, S.kind, code);
  // ---- code ----
  const cb = G.code, lh = G.wide ? 22 : 19, longest = Math.max(...code.map((l) => l.length));
  const fs = Math.min(G.wide ? 13 : 11.5, (cb.w - 44) / (longest * 0.61));
  rr(ctx, cb.x, cb.y, cb.w, cb.h, 8, C.surface2);
  code.forEach((ln, i) => {
    const y = cb.y + 14 + i * lh + lh / 2;
    if (i === st.line) { rr(ctx, cb.x + 4, y - lh / 2 + 1, cb.w - 8, lh - 2, 4, alpha(C.k, C.dark ? 0.28 : 0.2)); ctx.fillStyle = C.k; ctx.fillRect(cb.x + 4, y - lh / 2 + 1, 3, lh - 2); }
    text(ctx, String(i + 1), cb.x + 22, y, C.muted, { size: fs - 1.5, font: 'mono', align: 'right' });
    ctx.save(); ctx.beginPath(); ctx.rect(cb.x + 30, cb.y, cb.w - 34, cb.h); ctx.clip();
    text(ctx, ln, cb.x + 34, y, i === st.line ? C.ink : C.ink2, { size: fs, font: 'mono' });
    ctx.restore();
  });
  // ---- stack ----
  const sb = G.stack, frames = st.stack;
  text(ctx, 'CALL-STACK', sb.x + 2, sb.y + 8, C.muted, { size: 11, weight: 600 });
  if (G.wide) {
    const fh = clamp((sb.h - 30) / Math.max(frames.length, 5), 30, 48);
    frames.forEach((f, i) => {
      const y = sb.y + sb.h - (i + 1) * (fh + 4), isTop = i === frames.length - 1;
      rr(ctx, sb.x, y, sb.w, fh, 6, isTop ? alpha(C.k, C.dark ? 0.2 : 0.14) : C.surface, isTop ? C.k : C.hair, isTop ? 1.6 : 1);
      text(ctx, `${f.name}${f.args ? '(' + f.args + ')' : ''}`, sb.x + 12, y + fh / 2 - (fh > 36 ? 8 : 0), C.ink, { size: 12.5, font: 'mono', weight: 500 });
      text(ctx, f.note, fh > 36 ? sb.x + 12 : sb.x + sb.w - 10, y + fh / 2 + (fh > 36 ? 9 : 0), C.muted, { size: 11.5, align: fh > 36 ? 'left' : 'right' });
    });
    text(ctx, '↑ wächst nach oben', sb.x + sb.w - 4, sb.y + 8, C.muted, { size: 10.5, align: 'right' });
  } else {
    const fw = Math.min(150, (sb.w - 4 * (frames.length - 1)) / frames.length);
    frames.forEach((f, i) => {
      const x = sb.x + i * (fw + 4), isTop = i === frames.length - 1;
      rr(ctx, x, sb.y + 20, fw, sb.h - 24, 6, isTop ? alpha(C.k, 0.16) : C.surface, isTop ? C.k : C.hair, isTop ? 1.6 : 1);
      ctx.save(); ctx.beginPath(); ctx.rect(x + 2, sb.y + 20, fw - 4, sb.h - 24); ctx.clip();
      text(ctx, f.name, x + 6, sb.y + 36, C.ink, { size: 11, font: 'mono', weight: 500 });
      text(ctx, f.args, x + 6, sb.y + 54, C.ink2, { size: 10.5, font: 'mono' });
      text(ctx, f.note, x + 6, sb.y + 72, C.muted, { size: 10 });
      ctx.restore();
    });
  }
  // ---- tree ----
  const tb = G.tree, nodes = sim.nodes;
  if (S.layers.tree) {
    const nw = clamp(tb.w / Math.max(sim.leaves, 1) - 6, 30, S.kind === 'hanoi' ? 74 : 58), nh = 24;
    const X = (x) => tb.x + (sim.leaves <= 1 ? tb.w / 2 : nw / 2 + 4 + (x / (sim.leaves - 1)) * (tb.w - nw - 8));
    const Y = (d) => tb.y + 30 + (sim.depth <= 1 ? 0 : (d / (sim.depth - 1)) * (tb.h - 64));
    text(ctx, 'AUFRUFBAUM', tb.x + 2, tb.y + 8, C.muted, { size: 11, weight: 600 });
    const onPath = new Set(st.stack.map((f) => f.id).filter((v) => v != null));
    nodes.forEach((nd, i) => {
      if (nd.parent == null) return; const s = st.status[i]; if (!s) return;
      const p = nodes[nd.parent], hot = onPath.has(i) && onPath.has(nd.parent);
      line(ctx, X(p.x), Y(p.d) + nh / 2, X(nd.x), Y(nd.d) - nh / 2, hot ? C.k : alpha(C.muted, 0.7), hot ? 2.4 : 1.1);
    });
    nodes.forEach((nd, i) => {
      const s = st.status[i]; if (!s) return;
      const x = X(nd.x) - nw / 2, y = Y(nd.d) - nh / 2;
      const isTop = st.stack.length > 1 && st.stack[st.stack.length - 1].id === i;
      let fill = C.surface, stroke = C.ink, lw = 1.4, dash = null, tc = C.ink;
      if (s.st === 'done') { fill = C.surface2; stroke = C.hair; tc = C.muted; }
      if (s.st === 'memo') { fill = alpha(C.m, 0.12); stroke = C.m; dash = [4, 3]; tc = C.m; }
      if (s.st === 'waiting') { stroke = C.k; }
      if (isTop) { fill = alpha(C.k, C.dark ? 0.3 : 0.22); stroke = C.k; lw = 2.2; }
      rr(ctx, x, y, nw, nh, nh / 2, fill, stroke, lw, dash);
      ctx.save(); ctx.beginPath(); ctx.rect(x + 2, y, nw - 4, nh); ctx.clip();
      text(ctx, nd.label, x + nw / 2, y + nh / 2, tc, { size: nw < 44 ? 9.5 : 11, font: 'mono', align: 'center', weight: 500 });
      ctx.restore();
      if (s.ret != null && (s.st === 'done' || s.st === 'memo')) text(ctx, `= ${s.ret}`, x + nw / 2, y + nh + 9, s.st === 'memo' ? C.m : C.ink2, { size: 10.5, font: 'mono', align: 'center', halo: true });
    });
  }
  // ---- pegs (Hanoi) ----
  if (G.pegs) {
    const pb = G.pegs, base = pb.y + pb.h - 10, ph = pb.h - 26, n = S.n;
    const dh = Math.min(20, ph / (n + 1)), maxW = Math.min(pb.w / 3 - 20, 150);
    const colors = [C.v, C.m, C.k, C.f, C.ink2];
    line(ctx, pb.x + 6, base, pb.x + pb.w - 6, base, C.ink, 2);
    const px = (i) => pb.x + pb.w * (i + 0.5) / 3;
    for (let i = 0; i < 3; i++) { line(ctx, px(i), base, px(i), base - ph, C.muted, 3); text(ctx, 'ABC'[i], px(i), base + 12, C.muted, { size: 12, font: 'mono', align: 'center', weight: 600 }); }
    const dw = (d) => 26 + (maxW - 26) * (d - 1) / Math.max(1, n - 1);
    const mv = st.move && S.tween < 1 ? st.move : null;
    const pegs = st.pegs.map((p) => p.slice());
    let fly = null;
    if (mv) { pegs[mv.to].pop(); const prev = sim.steps[S.k - 1].pegs; const h0 = prev[mv.from].length - 1, h1 = pegs[mv.to].length; fly = { d: mv.d, from: mv.from, to: mv.to, h0, h1 }; }
    pegs.forEach((p, i) => p.forEach((d, h) => { const w = dw(d); rr(ctx, px(i) - w / 2, base - (h + 1) * dh, w, dh - 2, 4, colors[(d - 1) % colors.length], null); }));
    if (fly) {
      const t = smooth(clamp(S.tween, 0, 1)), w = dw(fly.d);
      const x0 = px(fly.from), x1 = px(fly.to), y0 = base - (fly.h0 + 1) * dh, y1 = base - (fly.h1 + 1) * dh, top = base - ph - dh * 0.6;
      // up – across – down
      let x, y;
      if (t < 0.3) { x = x0; y = y0 + (top - y0) * (t / 0.3); } else if (t < 0.7) { x = x0 + (x1 - x0) * ((t - 0.3) / 0.4); y = top; } else { x = x1; y = top + (y1 - top) * ((t - 0.7) / 0.3); }
      rr(ctx, x - w / 2, y, w, dh - 2, 4, colors[(fly.d - 1) % colors.length], null);
    }
  }
}

export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const sim = simulate('fib', 5, false);
  const S = { kind: 'fib', memo: false, n: 5, sim, k: 22, layers: { tree: true }, tween: 1 };
  // draw only the tree, full width
  ctx.save();
  const st = sim.steps[S.k], nodes = sim.nodes, nw = Math.min(40, W / sim.leaves - 4), nh = 16;
  const X = (x) => 10 + nw / 2 + (x / (sim.leaves - 1)) * (W - 20 - nw), Y = (d) => 18 + (d / (sim.depth - 1)) * (H - 36);
  const onPath = new Set(st.stack.map((f) => f.id).filter((v) => v != null));
  nodes.forEach((nd, i) => { if (nd.parent == null || !st.status[i]) return; const p = nodes[nd.parent]; line(ctx, X(p.x), Y(p.d), X(nd.x), Y(nd.d), onPath.has(i) ? C.k : alpha(C.muted, 0.7), onPath.has(i) ? 2 : 1); });
  nodes.forEach((nd, i) => { const s = st.status[i]; if (!s) return; const top = onPath.has(i); rr(ctx, X(nd.x) - nw / 2, Y(nd.d) - nh / 2, nw, nh, 8, top ? alpha(C.k, 0.25) : s.st === 'done' ? C.surface2 : C.surface, top ? C.k : s.st === 'done' ? C.hair : C.ink, 1.2); text(ctx, nd.label.replace('fib', 'f'), X(nd.x), Y(nd.d), C.ink, { size: 9, font: 'mono', align: 'center' }); });
  ctx.restore();
}

const STEPS = [
  { title: 'Jeder Aufruf bekommt einen eigenen Rahmen', set: { kind: 'fact', n: 4, k: 0, play: true },
    html: '<p>Beim Aufruf von <code>factorial(4)</code> legt das Programm einen neuen <b>Rahmen</b> auf den Call-Stack, mit einem eigenen <code>n</code>. Ruft die Funktion sich selbst auf, kommt ein weiterer Rahmen darauf. Jeder Rahmen hat seine eigene Kopie von <code>n</code>.</p><p>Die gelbe Zeile im Code ist die Stelle, an der der oberste Rahmen gerade steht.</p>' },
  { title: 'Hinunter bis zum Basisfall, dann zurück', set: { kind: 'fact', n: 4, k: 9 },
    html: '<p>Bis <code>factorial(0)</code> wird nur gewartet; gerechnet wird erst auf dem Rückweg: $1$, dann $1\\cdot 1$, $2\\cdot 1$, $3\\cdot 2$, $4\\cdot 6$. An der tiefsten Stelle liegen fünf Rahmen gleichzeitig auf dem Stack.</p><p>Deshalb braucht Rekursion Speicher proportional zur <b>Tiefe</b>. Bei einer Million Rahmen läuft der Stack über.</p>' },
  { title: 'Der Stack ist ein Weg im Aufrufbaum', set: { kind: 'fib', n: 5, memo: false, k: 0, play: true },
    html: '<p>Bei Fibonacci ruft jede Funktion sich zweimal auf. Der Aufrufbaum verzweigt sich, aber der Stack enthält immer nur die Aufrufe auf dem <b>Weg</b> von der Wurzel zum aktiven Knoten (gelb hervorgehoben).</p><p>Abgearbeitete Teilbäume werden grau. Ihre Rahmen sind längst wieder weg.</p>' },
  { title: 'Dieselbe Arbeit, immer wieder', set: { kind: 'fib', n: 6, memo: false, k: 0, play: true, speed: 9 },
    html: '<p>Zähle, wie oft <code>fib(2)</code> und <code>fib(3)</code> im Baum vorkommen. Die Zahl der Aufrufe wächst ungefähr um den Faktor $1.6$ pro Schritt in $n$: <code>fib(30)</code> braucht 2.7 Millionen Aufrufe.</p>' },
  { title: 'Memoization: einmal rechnen, dann nachschlagen', set: { kind: 'fib', n: 6, memo: true, k: 0, play: true, speed: 6 },
    html: '<p>Mit einem Memo wird jedes Ergebnis beim ersten Mal gespeichert. Kommt dasselbe Teilproblem wieder, wird nur nachgeschlagen (grün gestrichelt), und der ganze Teilbaum darunter fällt weg. Aus exponentiell vielen Aufrufen werden $2n - 1$.</p>' },
  { title: 'Türme von Hanoi', set: { kind: 'hanoi', n: 3, k: 0, play: true },
    html: '<p>Um $n$ Scheiben von A nach C zu bringen: erst $n-1$ Scheiben nach B, dann die größte nach C, dann die $n-1$ Scheiben von B auf sie. Der Aufrufbaum ist ein vollständiger Binärbaum, und jeder innere Knoten bewegt genau eine Scheibe:</p>$$M(n) = 2M(n-1) + 1 = 2^n - 1 .$$' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { kind: 'fact', n: 4, memo: false, k: 0, sim: simulate('fact', 4, false), layers: { tree: true }, tween: 1, acc: 0, speed: 2.2 };
  const rebuild = (keepK) => { S.sim = simulate(S.kind, S.n, S.memo); S.k = keepK ? Math.min(S.k, S.sim.steps.length - 1) : 0; S.tween = 1; sync(); };
  const stage = new Stage(L0.stage, { draw: (ctx, W, H) => draw(ctx, W, H, S) });
  const runner = new Runner({
    stages: [stage],
    update(dt) {
      S.tween = Math.min(1, S.tween + dt * S.speed * 1.4);
      S.acc += dt * S.speed;
      if (S.acc >= 1) { S.acc = 0; if (S.k < S.sim.steps.length - 1) { S.k++; S.tween = 0; sync(); } else runner.pause(); }
    },
  });
  const scrub = el('input', { type: 'range', min: 0, max: 100, step: 1, value: 0, 'aria-label': 'Schritt' });
  const tlabel = el('span', { class: 'tlabel' });
  scrub.addEventListener('input', () => { runner.pause(); S.k = +scrub.value; S.tween = 1; sync(); });
  L0.tslot.append(transport(runner, { onRestart: () => { S.k = 0; S.acc = 0; sync(); runner.play(); }, scrub, label: tlabel }));
  runner.on((p) => { if (p && S.k >= S.sim.steps.length - 1) { S.k = 0; sync(); } });

  const kindSeg = seg([['fact', 'Fakultät'], ['fib', 'Fibonacci'], ['hanoi', 'Türme von Hanoi']], S.kind, (k) => { runner.pause(); S.kind = k; S.n = k === 'fact' ? 4 : k === 'fib' ? 5 : 3; nSl.set(S.n); syncN(); rebuild(); }, 'scenes');
  L0.scenes.append(kindSeg);
  const q = el('p', { class: 'question', html: 'Eine Funktion ruft sich selbst auf. <b>Wo merkt sich das Programm, wer auf wen wartet, und warum ist das manchmal so teuer?</b>' });
  const msg = el('div', { class: 'gauss-op', style: 'font-family:var(--serif);font-size:15px;font-weight:400' });
  const steps = stepper(STEPS, (st) => {
    const s = st.set; runner.pause();
    S.kind = s.kind; kindSeg.set(s.kind); S.n = s.n; if (s.memo !== undefined) S.memo = s.memo; memoChip.set(S.memo);
    S.speed = s.speed || 2.2; spSl.set(S.speed); nSl.set(S.n); syncN();
    S.sim = simulate(S.kind, S.n, S.memo); S.k = clamp(s.k || 0, 0, S.sim.steps.length - 1);
    if (s.k === 9) S.k = S.sim.steps.findIndex((x) => x.stack.length === S.n + 2 && x.msg.startsWith('Basisfall'));
    S.tween = 1; sync();
    if (s.play) setTimeout(() => runner.play(), 300);
  });
  const nSl = slider({ id: 'rk-n', label: 'Argument <span class="var">n</span>', min: 1, max: 6, step: 1, value: S.n, format: (v) => `${v}`, onInput: (v) => { runner.pause(); S.n = v; rebuild(); } });
  const syncN = () => { const mx = S.kind === 'fact' ? 6 : S.kind === 'fib' ? 7 : 4; nSl.input.max = mx; nSl.input.min = S.kind === 'fib' ? 2 : 1; nSl.set(clamp(S.n, +nSl.input.min, mx)); memoChip.hidden = S.kind !== 'fib'; };
  const spSl = slider({ id: 'rk-sp', label: 'Tempo', min: 0.5, max: 10, step: 0.5, value: S.speed, format: (v) => `${fmt(v, 1)} Schritte/s`, onInput: (v) => { S.speed = v; } });
  const memoChip = chip('mit Memo', false, C.m, (v) => { runner.pause(); S.memo = v; rebuild(); });
  const bBack = el('button', { type: 'button', class: 'btn', html: '← Schritt' }), bFwd = el('button', { type: 'button', class: 'btn solid', html: 'Schritt →' });
  bBack.addEventListener('click', () => { runner.pause(); S.k = Math.max(0, S.k - 1); S.tween = 1; sync(); });
  bFwd.addEventListener('click', () => { runner.pause(); if (S.k < S.sim.steps.length - 1) { S.k++; S.tween = 0; sync(); runner.playing = false; animTween(); } });
  function animTween() { const t0 = performance.now(); const f = (now) => { S.tween = Math.min(1, (now - t0) / 500); stage.invalidate(); if (S.tween < 1) requestAnimationFrame(f); }; requestAnimationFrame(f); }
  const ro = readout([['c', 'Aufrufe bisher'], ['d', 'Stacktiefe'], ['t', 'Aufrufe insgesamt']]);
  function sync() {
    const st = S.sim.steps[S.k];
    msg.textContent = st.msg;
    scrub.max = S.sim.steps.length - 1; scrub.value = S.k; scrub.style.setProperty('--p', (S.k / Math.max(1, S.sim.steps.length - 1)) * 100 + '%');
    tlabel.textContent = `${S.k + 1} / ${S.sim.steps.length}`;
    ro.set('c', `${st.calls}`); ro.set('d', `${st.stack.length - 1}`);
    let tot = `${S.sim.calls}`;
    if (S.kind === 'fib') { const other = simulate('fib', S.n, !S.memo).calls; tot += S.memo ? ` (ohne Memo: ${other})` : ` (mit Memo: ${other})`; }
    if (S.kind === 'hanoi') tot += ` · ${2 ** S.n - 1} Züge`;
    ro.set('t', tot);
    stage.invalidate();
  }
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Was gerade passiert' }), msg, el('div', { class: 'toggles' }, bBack, bFwd), nSl, memoChip, spSl, ro);
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Jeder Aufruf hat seinen eigenen Rahmen. Der Stack enthält genau die Aufrufe, die noch auf ein Ergebnis warten, also den Weg von der Wurzel zum aktiven Knoten. Seine Höhe ist die Rekursionstiefe, die Größe des Baums die Laufzeit.' });
  L0.panel.append(q, steps, box, insight, el('p', { class: 'src', html: 'Skript Informatik, Kapitel 4 (Call-Stack), 7 (Rekursion, Fibonacci, Hanoi) und 9 (Memoization). Code wie im Skript.' }));
  syncN(); rebuild(); steps.go(0); typeset(L0.panel);
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
