// Zeiger und verkettete Liste: Speicherdiagramm Zeile für Zeile (Informatik, Kap. 11)
import { C, clamp, Stage, Runner, line, dot, text, fmt, el, seg, chip, readout, transport, layout, stepper, typeset, alpha, slider, smooth, arrow } from '../core.js';

export const meta = {
  id: 'liste',
  group: 'Informatik',
  short: 'Zeiger',
  tag: 'Informatik · Kapitel 11',
  title: 'Was passiert im Speicher, wenn man Zeiger umhängt?',
  card: 'Einfügen, Löschen, Umkehren einer verketteten Liste als Speicherdiagramm. Die falsche Reihenfolge zweier Zuweisungen genügt, und ein Teil der Liste ist verloren.',
};

/* ---------- scenarios: hand-written traces of the code in list2.cpp ---------- */
function build(kind) {
  const steps = [];
  const N = {}; // id → {value, next, alive, slot}
  const V = []; // variables {frame, name, val}
  const setV = (frame, name, val) => { const v = V.find((x) => x.frame === frame && x.name === name); if (v) v.val = val; else V.push({ frame, name, val }); };
  const dropFrame = (frame) => { for (let i = V.length - 1; i >= 0; i--) if (V[i].frame === frame) V.splice(i, 1); };
  const snap = (line, msg, hot = null) => steps.push({ line, msg, hot, nodes: JSON.parse(JSON.stringify(N)), vars: V.map((v) => ({ ...v })) });
  const mk = (id, value, next, slot) => { N[id] = { value, next, alive: true, slot }; };
  let code;
  if (kind === 'insert' || kind === 'falsch') {
    mk('a', 1, 'b', [0, 0]); mk('b', 2, 'c', [1, 0]); mk('c', 4, null, [2, 0]);
    setV('main', 'head', 'a');
    if (kind === 'insert') {
      code = ['void insert_after(Node* p, int v) {', '    Node* n = new Node{v, p->next};', '    p->next = n;', '}', '', '// im Skript in einer Zeile:', '// p->next = new Node{v, p->next};'];
      setV('fn', 'p', 'b'); setV('fn', 'v', 3); snap(0, 'insert_after(head->next, 3): p zeigt auf den Knoten mit 2.');
      mk('n', 3, 'c', [1.5, 1]); setV('fn', 'n', 'n'); snap(1, 'Ein neuer Knoten entsteht auf dem Heap. Sein next zeigt schon auf den Rest der Liste (die 4).', 'n.next');
      N.b.next = 'n'; snap(2, 'Erst jetzt wird p->next umgehängt. Kein Knoten ging verloren.', 'b.next');
      dropFrame('fn'); snap(3, 'Die Funktion ist fertig: p, v und n verschwinden vom Stack, der neue Knoten bleibt auf dem Heap.');
    } else {
      code = ['void insert_after_falsch(Node* p, int v) {', '    Node* n = new Node{v, nullptr};', '    p->next = n;          // zu früh!', '    n->next = p->next;    // ist jetzt n selbst', '}'];
      setV('fn', 'p', 'b'); setV('fn', 'v', 3); snap(0, 'Dieselbe Aufgabe, aber die Zuweisungen in der anderen Reihenfolge.');
      mk('n', 3, null, [1.5, 1]); setV('fn', 'n', 'n'); snap(1, 'Neuer Knoten mit next = nullptr.', 'n.next');
      N.b.next = 'n'; snap(2, 'p->next zeigt jetzt auf den neuen Knoten. Auf die 4 zeigt nichts mehr: Sie ist unerreichbar.', 'b.next');
      N.n.next = 'n'; snap(3, 'n->next = p->next, aber p->next ist n selbst. Der Knoten zeigt auf sich selbst, und wer die Liste durchläuft, kreist für immer.', 'n.next');
      dropFrame('fn'); snap(4, 'Ergebnis: eine Schleife statt einer Liste, und ein Speicherleck (die 4 kann nie mehr freigegeben werden).');
    }
  }
  if (kind === 'remove') {
    code = ['Node* remove(Node* head, int v) {', '    if (head == nullptr) return nullptr;', '    if (head->value == v) { /* Spezialfall */ }', '    Node* p = head;', '    while (p->next != nullptr && p->next->value != v)', '        p = p->next;', '    if (p->next != nullptr) {', '        Node* victim = p->next;', '        p->next = victim->next;', '        delete victim;', '    }', '    return head;', '}'];
    mk('a', 1, 'b', [0, 0]); mk('b', 2, 'n', [1, 0]); mk('n', 3, 'c', [2, 0]); mk('c', 4, null, [3, 0]);
    setV('main', 'head', 'a'); setV('fn', 'head', 'a'); setV('fn', 'v', 3);
    snap(0, 'remove(head, 3): Die Funktion bekommt eine Kopie des Zeigers head.');
    snap(2, 'Der erste Knoten hat nicht den Wert 3: kein Spezialfall.');
    setV('fn', 'p', 'a'); snap(3, 'p startet am Anfang.', 'p');
    snap(4, 'p->next->value ist 2, nicht 3: weiter.');
    setV('fn', 'p', 'b'); snap(5, 'p = p->next', 'p');
    snap(4, 'p->next->value ist 3: Schleife endet. p steht vor dem Opfer.');
    setV('fn', 'victim', 'n'); snap(7, 'Zuerst einen Zeiger auf das Opfer sichern.', 'victim');
    N.b.next = 'c'; snap(8, 'Den Vorgänger am Opfer vorbei verbinden. Das Opfer hängt nur noch an victim.', 'b.next');
    N.n.alive = false; snap(9, 'delete victim gibt den Speicher frei. victim zeigt jetzt ins Leere (hängender Zeiger), wird aber nicht mehr benutzt.');
    snap(11, 'head ist unverändert und wird zurückgegeben.');
    dropFrame('fn'); snap(12, 'Fertig: 1 → 2 → 4.');
  }
  if (kind === 'reverse') {
    code = ['Node* reverse(Node* head) {', '    Node* prev = nullptr;', '    while (head != nullptr) {', '        Node* next = head->next;', '        head->next = prev;', '        prev = head;', '        head = next;', '    }', '    return prev;', '}'];
    mk('a', 1, 'b', [0, 0]); mk('b', 2, 'n', [1, 0]); mk('n', 3, 'c', [2, 0]); mk('c', 4, null, [3, 0]);
    setV('main', 'head', 'a'); setV('fn', 'head', 'a');
    snap(0, 'reverse(head): Keiner der Knoten wird bewegt. Nur die next-Zeiger werden umgedreht.');
    setV('fn', 'prev', null); snap(1, 'prev ist der schon umgedrehte Teil: am Anfang leer.', 'prev');
    const order = ['a', 'b', 'n', 'c'];
    for (let i = 0; i < 4; i++) {
      const h = order[i];
      snap(2, `head zeigt auf ${N[h].value}: noch etwas zu tun.`);
      setV('fn', 'next', N[h].next); snap(3, 'Den Rest sichern, bevor head->next überschrieben wird.', 'next');
      N[h].next = i === 0 ? null : order[i - 1]; snap(4, `Der Zeiger von ${N[h].value} dreht sich um${i === 0 ? ' (auf nullptr)' : ` und zeigt jetzt auf ${N[order[i - 1]].value}`}.`, `${h}.next`);
      setV('fn', 'prev', h); snap(5, `prev rückt vor: Der umgedrehte Teil beginnt jetzt bei ${N[h].value}.`, 'prev');
      setV('fn', 'head', i < 3 ? order[i + 1] : null); snap(6, i < 3 ? `head rückt vor zu ${N[order[i + 1]].value}.` : 'head ist nullptr: alles umgedreht.', 'head');
    }
    snap(2, 'Die Schleife endet.');
    snap(8, 'prev zeigt auf den neuen Anfang: die 4.');
    setV('main', 'head', 'c'); dropFrame('fn'); snap(8, 'In main: head = reverse(head). Jetzt 4 → 3 → 2 → 1.', 'main.head');
  }
  return { code, steps };
}

/* ---------- drawing ---------- */
function geom(W, H, code) {
  const wide = W >= 760;
  const lh = wide ? 21 : 18;
  if (wide) {
    const lw = Math.max(300, W * 0.37);
    return { wide, lh, code: { x: 16, y: 16, w: lw - 24, h: code.length * lh + 26 }, stack: { x: 16, y: 16 + code.length * lh + 40, w: lw - 24, h: H - code.length * lh - 72 }, heap: { x: lw + 6, y: 16, w: W - lw - 22, h: H - 32 } };
  }
  const ch = code.length * lh + 22;
  return { wide, lh, code: { x: 10, y: 10, w: W - 20, h: ch }, stack: { x: 10, y: ch + 20, w: W - 20, h: 92 }, heap: { x: 10, y: ch + 122, w: W - 20, h: H - ch - 134 } };
}
const rr = (ctx, x, y, w, h, r, fill, stroke, lw = 1, dash) => { ctx.save(); ctx.beginPath(); ctx.roundRect(x, y, w, h, r); if (fill) { ctx.fillStyle = fill; ctx.fill(); } if (stroke) { ctx.strokeStyle = stroke; ctx.lineWidth = lw; if (dash) ctx.setLineDash(dash); ctx.stroke(); } ctx.restore(); };

function curve(ctx, x0, y0, x1, y1, cx, cy, color, w, dash) {
  ctx.save(); ctx.strokeStyle = color; ctx.lineWidth = w; if (dash) ctx.setLineDash(dash);
  ctx.beginPath(); ctx.moveTo(x0, y0); ctx.quadraticCurveTo(cx, cy, x1, y1); ctx.stroke(); ctx.restore();
  // head along the tangent at the end
  const tx = x1 - cx, ty = y1 - cy, L = Math.hypot(tx, ty) || 1;
  arrow(ctx, x1 - (tx / L) * 9, y1 - (ty / L) * 9, x1, y1, color, w, 10);
}

function draw(ctx, W, H, S) {
  const sc = S.sc, st = sc.steps[S.k], prev = sc.steps[Math.max(0, S.k - 1)], t = smooth(clamp(S.tween, 0, 1));
  const G = geom(W, H, sc.code);
  // ---- code ----
  const cb = G.code;
  rr(ctx, cb.x, cb.y, cb.w, cb.h, 8, C.surface2);
  sc.code.forEach((ln, i) => {
    const y = cb.y + 13 + i * G.lh + G.lh / 2;
    if (i === st.line) { rr(ctx, cb.x + 4, y - G.lh / 2 + 1, cb.w - 8, G.lh - 2, 4, alpha(C.k, C.dark ? 0.28 : 0.2)); ctx.fillStyle = C.k; ctx.fillRect(cb.x + 4, y - G.lh / 2 + 1, 3, G.lh - 2); }
    ctx.save(); ctx.beginPath(); ctx.rect(cb.x, cb.y, cb.w - 4, cb.h); ctx.clip();
    text(ctx, ln, cb.x + 14, y, ln.trim().startsWith('//') ? C.muted : i === st.line ? C.ink : C.ink2, { size: Math.min(G.wide ? 12.5 : 11, (cb.w - 24) / (Math.max(...sc.code.map((l) => l.length)) * 0.61)), font: 'mono' });
    ctx.restore();
  });
  // ---- heap layout ----
  const hb = G.heap;
  text(ctx, 'HEAP', hb.x + 2, hb.y + 8, C.muted, { size: 11, weight: 600 });
  const cols = Math.max(4, ...Object.values(st.nodes).map((n) => n.slot[0] + 1));
  const nw = clamp(hb.w / cols - 34, 70, 118), nh = 40;
  const nodePos = (n) => [hb.x + 10 + (n.slot[0] / (cols - 1 || 1)) * (hb.w - nw - 20), hb.y + hb.h * 0.22 + n.slot[1] * Math.min(150, hb.h * 0.36)];
  const all = { ...prev.nodes, ...st.nodes };
  // reachability for leak detection
  const reach = new Set();
  for (const v of st.vars) { let p = v.val, guard = 0; while (typeof p === 'string' && st.nodes[p] && !reach.has(p) && guard++ < 20) { reach.add(p); p = st.nodes[p].next; } }
  // nodes
  const box = {};
  for (const [id, n] of Object.entries(all)) {
    const cur = st.nodes[id]; if (!cur) continue;
    const [x, y] = nodePos(cur); box[id] = { x, y, w: nw, h: nh };
    const born = !prev.nodes[id] && S.k > 0 ? t : 1;
    ctx.save(); ctx.globalAlpha = born * (cur.alive ? 1 : 0.45);
    const leak = cur.alive && !reach.has(id);
    rr(ctx, x, y, nw, nh, 6, leak ? alpha(C.f, 0.12) : C.surface, leak ? C.f : cur.alive ? C.ink : C.muted, 1.6, cur.alive ? null : [5, 4]);
    line(ctx, x + nw * 0.55, y, x + nw * 0.55, y + nh, cur.alive ? C.ink : C.muted, 1);
    text(ctx, String(cur.value), x + nw * 0.275, y + nh / 2, C.ink, { size: 17, font: 'mono', align: 'center', weight: 500 });
    if (cur.slot[0] === 0 && cur.slot[1] === 0) { text(ctx, 'value', x + nw * 0.275, y - 9, C.muted, { size: 9.5, font: 'mono', align: 'center' }); text(ctx, 'next', x + nw * 0.775, y - 9, C.muted, { size: 9.5, font: 'mono', align: 'center' }); }
    else text(ctx, `0x${(0x7a0 + id.charCodeAt(0) * 16).toString(16)}`, x, y - 9, C.muted, { size: 10, font: 'mono' });
    if (!cur.alive) text(ctx, 'gelöscht', x + nw / 2, y - 22, C.f, { size: 11, align: 'center', weight: 600 });
    if (leak) text(ctx, 'unerreichbar: Speicherleck', x + nw / 2, y + nh + 26, C.f, { size: 11, align: 'center', weight: 600 });
    ctx.restore();
  }
  // pointer arrow to a node, from (sx,sy); kind 'var' or 'next'
  const target = (id, sx, sy) => { const b = box[id]; if (!b) return null; const cx = b.x + b.w / 2; if (sy < b.y - 4) return [cx - b.w * 0.2, b.y]; if (sy > b.y + b.h + 4) return [cx - b.w * 0.2, b.y + b.h]; return sx < b.x ? [b.x, b.y + b.h / 2] : [b.x + b.w, b.y + b.h / 2]; };
  const drawPtr = (sx, sy, oldT, newT, hot, from) => {
    const col = hot && t < 1 ? C.k : C.v;
    const dead = (id) => id && st.nodes[id] && !st.nodes[id].alive;
    const endOf = (id) => (id == null ? null : id === from ? null : target(id, sx, sy));
    let e1 = endOf(newT), e0 = endOf(oldT);
    if (newT === from && newT != null) { // self loop
      const b = box[from]; const lx = b.x + b.w * 0.775;
      ctx.save(); ctx.strokeStyle = C.f; ctx.lineWidth = 2; ctx.beginPath(); ctx.moveTo(sx, sy); ctx.bezierCurveTo(lx + 60, b.y - 70, b.x - 40, b.y - 70, b.x + b.w * 0.25, b.y - 2); ctx.stroke(); ctx.restore();
      arrow(ctx, b.x + b.w * 0.25 - 4, b.y - 12, b.x + b.w * 0.25, b.y - 2, C.f, 2, 10);
      return;
    }
    if (newT == null && (oldT == null || t >= 1)) { // nullptr
      text(ctx, '∅', sx, sy, C.muted, { size: 15, align: 'center', weight: 600 }); return;
    }
    if (oldT != null && newT != null && oldT !== newT && e0 && t < 1) e1 = [e0[0] + (e1[0] - e0[0]) * t, e0[1] + (e1[1] - e0[1]) * t];
    else if (newT == null && e0) { e1 = [e0[0] + (sx + 30 - e0[0]) * t, e0[1] + (sy - e0[1]) * t]; }
    if (!e1) return;
    const dx = e1[0] - sx, dy = e1[1] - sy;
    let cx = sx + dx / 2, cy = sy + dy / 2;
    if (Math.abs(dy) < 8 && dx < 0) cy += 70; else if (Math.abs(dy) < 8 && Math.abs(dx) > nw * 1.6) cy -= 55; else { cx -= dy * 0.15; cy += dx * 0.12; }
    const c = dead(newT) ? C.f : col;
    dot(ctx, sx, sy, 3.2, c);
    curve(ctx, sx, sy, e1[0], e1[1], cx, cy, c, hot && t < 1 ? 2.6 : 1.9, dead(newT) ? [5, 4] : null);
  };
  for (const [id, n] of Object.entries(st.nodes)) {
    const b = box[id]; if (!b) continue;
    const old = prev.nodes[id] ? prev.nodes[id].next : n.next;
    ctx.save(); ctx.globalAlpha = n.alive ? 1 : 0.4;
    drawPtr(b.x + b.w * 0.775, b.y + b.h / 2, old, n.next, st.hot === `${id}.next`, id);
    ctx.restore();
  }
  // ---- stack ----
  const sb = G.stack;
  text(ctx, 'STACK', sb.x + 2, sb.y + 8, C.muted, { size: 11, weight: 600 });
  const frames = ['main', 'fn'].filter((f) => st.vars.some((v) => v.frame === f));
  let y = sb.y + 22;
  const fname = { insert: 'insert_after', falsch: 'insert_after_falsch', remove: 'remove', reverse: 'reverse' }[S.kind];
  for (const f of frames) {
    const vs = st.vars.filter((v) => v.frame === f);
    if (G.wide) {
      const fh = 28 + vs.length * 34;
      rr(ctx, sb.x, y, sb.w, fh, 6, f === 'fn' ? alpha(C.k, C.dark ? 0.14 : 0.08) : C.surface, f === 'fn' ? C.k : C.hair, 1.2);
      text(ctx, f === 'main' ? 'main' : fname, sb.x + 10, y + 14, C.ink2, { size: 11.5, font: 'mono', weight: 600 });
      vs.forEach((v, i) => {
        const vy = y + 34 + i * 34, cx = sb.x + sb.w - 34;
        const hot = st.hot === v.name || st.hot === `${f}.${v.name}`;
        text(ctx, typeof v.val === 'number' ? `int ${v.name}` : `Node* ${v.name}`, sb.x + 12, vy + 10, C.ink, { size: 12.5, font: 'mono' });
        rr(ctx, cx - 20, vy - 4, 40, 28, 4, hot && t < 1 ? alpha(C.k, 0.3) : C.surface2, C.ink, 1.2);
        if (typeof v.val === 'number') text(ctx, String(v.val), cx, vy + 10, C.ink, { size: 13, font: 'mono', align: 'center' });
        else {
          const pv = prev.vars.find((x) => x.frame === v.frame && x.name === v.name);
          drawPtr(cx, vy + 10, pv ? pv.val : v.val, v.val, hot, null);
        }
      });
      y += fh + 10;
    } else {
      // narrow: one row of variable chips
      const n = vs.length; const w = Math.min(130, (sb.w - 8) / Math.max(1, st.vars.length) - 6);
      vs.forEach((v, i) => {
        const idx = st.vars.indexOf(v), x = sb.x + idx * (w + 6);
        rr(ctx, x, sb.y + 18, w, 62, 6, f === 'fn' ? alpha(C.k, 0.08) : C.surface, f === 'fn' ? C.k : C.hair, 1.2);
        text(ctx, `${f === 'main' ? 'main.' : ''}${v.name}`, x + 6, sb.y + 32, C.ink, { size: 11, font: 'mono' });
        if (typeof v.val === 'number') text(ctx, String(v.val), x + w / 2, sb.y + 60, C.ink, { size: 12, font: 'mono', align: 'center' });
        else { const pv = prev.vars.find((q) => q.frame === v.frame && q.name === v.name); drawPtr(x + w / 2, sb.y + 62, pv ? pv.val : v.val, v.val, st.hot === v.name, null); }
      });
      void n;
    }
  }
}

export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const nw = W / 6, y = H * 0.45;
  const xs = [0.08, 0.31, 0.54, 0.77].map((f) => f * W);
  xs.forEach((x, i) => {
    rr(ctx, x, y, nw, 30, 5, C.surface, C.ink, 1.4); line(ctx, x + nw * 0.55, y, x + nw * 0.55, y + 30, C.ink, 1);
    text(ctx, String(4 - i), x + nw * 0.27, y + 15, C.ink, { size: 13, font: 'mono', align: 'center' });
    if (i < 3) curve(ctx, x + nw * 0.77, y + 15, xs[i + 1], y + 15, (x + nw * 0.77 + xs[i + 1]) / 2, y + 15, i === 1 ? C.k : C.v, 1.8);
    else text(ctx, '∅', x + nw * 0.77, y + 15, C.muted, { size: 13, align: 'center' });
  });
  text(ctx, 'head', xs[0], y - 38, C.ink, { size: 11, font: 'mono' });
  curve(ctx, xs[0] + 34, y - 38, xs[0] + nw * 0.3, y, xs[0] + 40, y - 20, C.v, 1.8);
}

const STEPS = [
  { title: 'Knoten, Zeiger, nullptr', set: { kind: 'insert', k: 0 },
    html: '<p>Jeder Knoten liegt in einem eigenen Block auf dem <b>Heap</b> und hält einen Wert und den Zeiger <code>next</code> auf den nächsten Knoten. Die Liste selbst ist nur der Zeiger <code>head</code> auf dem <b>Stack</b>. Der letzte <code>next</code> ist <code>nullptr</code> (∅).</p>' },
  { title: 'Einfügen in der richtigen Reihenfolge', set: { kind: 'insert', k: 0, play: true },
    html: '<p>Erst bekommt der neue Knoten seinen <code>next</code> (auf den Rest der Liste), dann wird <code>p->next</code> auf ihn umgehängt. Zu keinem Zeitpunkt zeigt nichts mehr auf die 4.</p>' },
  { title: 'Die falsche Reihenfolge', set: { kind: 'falsch', k: 0, play: true },
    html: '<p>Dieselben zwei Zuweisungen, vertauscht. Nach <code>p->next = n</code> zeigt nichts mehr auf die 4: Sie ist für immer verloren (Speicherleck). Danach zeigt der neue Knoten auf sich selbst.</p><p>Deshalb das Rezept aus dem Skript: <b>erst sichern, dann überschreiben</b>.</p>' },
  { title: 'Löschen: erst sichern, dann umgehen, dann freigeben', set: { kind: 'remove', k: 0, play: true },
    html: '<p><code>p</code> läuft bis vor das Opfer. <code>victim</code> sichert den Zeiger, <code>p->next</code> überspringt das Opfer, und erst dann gibt <code>delete</code> den Speicher frei. Danach ist <code>victim</code> ein hängender Zeiger (rot gestrichelt): Er darf nicht mehr dereferenziert werden.</p>' },
  { title: 'Umkehren: kein Knoten bewegt sich', set: { kind: 'reverse', k: 0, play: true },
    html: '<p>Die Knoten bleiben, wo sie sind. In jeder Runde dreht sich genau ein <code>next</code>-Zeiger um. <code>prev</code> zeigt auf den schon umgedrehten Teil, <code>head</code> auf den Rest, <code>next</code> sichert den Rest, bevor er überschrieben wird.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { kind: 'insert', k: 0, sc: build('insert'), tween: 1, acc: 0, speed: 0.8 };
  const stage = new Stage(L0.stage, { draw: (ctx, W, H) => draw(ctx, W, H, S) });
  const runner = new Runner({
    stages: [stage],
    update(dt) {
      S.tween = Math.min(1, S.tween + dt * 1.6);
      S.acc += dt * S.speed;
      if (S.acc >= 1) { S.acc = 0; if (S.k < S.sc.steps.length - 1) { S.k++; S.tween = 0; sync(); } else runner.pause(); }
    },
  });
  const scrub = el('input', { type: 'range', min: 0, max: 10, step: 1, value: 0, 'aria-label': 'Schritt' });
  const tlabel = el('span', { class: 'tlabel' });
  scrub.addEventListener('input', () => { runner.pause(); S.k = +scrub.value; S.tween = 1; sync(); });
  L0.tslot.append(transport(runner, { onRestart: () => { S.k = 0; S.acc = 0.6; S.tween = 1; sync(); runner.play(); }, scrub, label: tlabel }));
  runner.on((p) => { if (p && S.k >= S.sc.steps.length - 1) { S.k = 0; S.tween = 1; sync(); } });
  const kindSeg = seg([['insert', 'Einfügen'], ['falsch', 'Falsche Reihenfolge'], ['remove', 'Löschen'], ['reverse', 'Umkehren']], S.kind, (k) => setKind(k), 'scenes');
  L0.scenes.append(kindSeg);
  function setKind(k) { runner.pause(); S.kind = k; kindSeg.set(k); S.sc = build(k); S.k = 0; S.tween = 1; sync(); }
  const q = el('p', { class: 'question', html: '<b>Was genau passiert im Speicher, wenn man in einer verketteten Liste Zeiger umhängt, und wie verliert man dabei Knoten?</b>' });
  const msg = el('div', { class: 'gauss-op', style: 'font-family:var(--serif);font-size:15px;font-weight:400;line-height:1.45' });
  const steps = stepper(STEPS, (st) => { setKind(st.set.kind); S.k = st.set.k; sync(); if (st.set.play) { S.acc = 0.5; setTimeout(() => runner.play(), 300); } });
  const bBack = el('button', { type: 'button', class: 'btn', html: '← Zeile' }), bFwd = el('button', { type: 'button', class: 'btn solid', html: 'Nächste Zeile →' });
  bBack.addEventListener('click', () => { runner.pause(); S.k = Math.max(0, S.k - 1); S.tween = 1; sync(); });
  bFwd.addEventListener('click', () => { runner.pause(); if (S.k < S.sc.steps.length - 1) { S.k++; S.tween = 0; sync(); const t0 = performance.now(); const f = (now) => { S.tween = Math.min(1, (now - t0) / 650); stage.invalidate(); if (S.tween < 1) requestAnimationFrame(f); }; requestAnimationFrame(f); } });
  const spSl = slider({ id: 'li-sp', label: 'Tempo', min: 0.3, max: 3, step: 0.1, value: S.speed, format: (v) => `${fmt(v, 1)} Zeilen/s`, onInput: (v) => { S.speed = v; } });
  function sync() {
    const st = S.sc.steps[S.k];
    msg.textContent = st.msg;
    scrub.max = S.sc.steps.length - 1; scrub.value = S.k; scrub.style.setProperty('--p', (S.k / Math.max(1, S.sc.steps.length - 1)) * 100 + '%');
    tlabel.textContent = `${S.k + 1} / ${S.sc.steps.length}`;
    bBack.disabled = S.k === 0; bFwd.disabled = S.k >= S.sc.steps.length - 1;
    stage.invalidate();
  }
  const legend = el('dl', { class: 'readout', html: '<dt><span style="color:var(--v)">→</span> Zeiger</dt><dd>zeigt auf einen Knoten</dd><dt>∅</dt><dd>nullptr</dd><dt><span style="color:var(--f)">- - →</span></dt><dd>hängender Zeiger</dd><dt><span style="color:var(--f)">rot</span></dt><dd>unerreichbar (Leck)</dd>' });
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Was gerade passiert' }), msg, el('div', { class: 'toggles' }, bBack, bFwd), spSl, legend);
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Eine Liste ist nur so lange eine Liste, wie jeder Knoten von irgendwoher erreichbar ist. Bei jeder Zuweisung an einen Zeiger fragen: Zeigt danach noch etwas auf das, worauf er vorher zeigte?' });
  L0.panel.append(q, steps, box, insight, el('p', { class: 'src', html: 'Skript Informatik, Kapitel 11: Zeiger, Heap, verkettete Liste, Rezept «Pointer surgery», Code aus list2.cpp.' }));
  steps.go(0); typeset(L0.panel);
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
