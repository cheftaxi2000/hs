// Gauss-Verfahren geometrisch: Zeilenbild und Spaltenbild (Lineare Algebra, Woche 1–3)
import { C, clamp, el, seg, chip, readout, transport, layout, stepper, typeset, Runner, fmt, line, alpha, text } from '../core.js';

export const meta = {
  id: 'gauss',
  group: 'Lineare Algebra',
  short: 'Gauss',
  tag: 'Lineare Algebra · Woche 1–3',
  title: 'Was macht das Gauss-Verfahren mit den Ebenen?',
  card: 'Jede Zeilenumformung dreht eine Ebene, aber nie um einen Punkt, der nicht schon Lösung war. Die Lösungsmenge bleibt stehen, bis man sie ablesen kann.',
};

/* die vier Systeme aus dem Skript (Woche 3, «Vier Systeme, vier Bilder») */
export const SYSTEMS = {
  punkt: { label: 'Ein Punkt', M: [[1, 1, 1, 3], [1, -1, 0, 0], [0, 0, 1, 1]] },
  gerade: { label: 'Eine Gerade', M: [[1, 1, 1, 3], [1, -1, 0, 1], [2, 0, 1, 4]] },
  parallel: { label: 'Parallel', M: [[1, 1, 1, 3], [1, 1, 1, 5], [1, -1, 0, 0]] },
  prisma: { label: 'Prisma', M: [[1, 1, 0, 1], [0, 1, 1, 1], [1, 0, -1, 1]] },
};

const EPS = 1e-9;
const copy = (M) => M.map((r) => r.slice());
/** Gauss-Jordan with the operations a person would write down */
export function gaussOps(M0) {
  const M = copy(M0), ops = [], states = [copy(M)];
  const apply = (op) => {
    if (op.t === 'add') for (let k = 0; k < 4; k++) M[op.i][k] += op.l * M[op.j][k];
    if (op.t === 'scale') for (let k = 0; k < 4; k++) M[op.i][k] *= op.c;
    if (op.t === 'swap') { const t = M[op.i]; M[op.i] = M[op.j]; M[op.j] = t; }
    for (const r of M) for (let k = 0; k < 4; k++) if (Math.abs(r[k]) < 1e-12) r[k] = 0;
    ops.push(op); states.push(copy(M));
  };
  const piv = [];
  let row = 0;
  for (let col = 0; col < 3 && row < 3; col++) {
    let p = -1; for (let i = row; i < 3; i++) if (Math.abs(M[i][col]) > EPS) { p = i; break; }
    if (p < 0) continue;
    if (p !== row) apply({ t: 'swap', i: row, j: p });
    for (let i = row + 1; i < 3; i++) if (Math.abs(M[i][col]) > EPS) apply({ t: 'add', i, j: row, l: -M[i][col] / M[row][col], phase: 'vor' });
    piv.push([row, col]); row++;
  }
  for (let k = piv.length - 1; k >= 0; k--) {
    const [r, c] = piv[k];
    if (Math.abs(M[r][c] - 1) > EPS) apply({ t: 'scale', i: r, c: 1 / M[r][c], phase: 'rück' });
    for (let i = r - 1; i >= 0; i--) if (Math.abs(M[i][c]) > EPS) apply({ t: 'add', i, j: r, l: -M[i][c], phase: 'rück' });
  }
  return { ops, states, rank: piv.length };
}

/** analyse the solution set of the original system */
export function solution(M0) {
  const { states, rank } = gaussOps(M0);
  const R = states[states.length - 1];
  const bad = R.some((r) => Math.abs(r[0]) + Math.abs(r[1]) + Math.abs(r[2]) < EPS && Math.abs(r[3]) > EPS);
  if (bad) return { kind: 'leer', rank };
  if (rank === 3) return { kind: 'punkt', p: [R[0][3], R[1][3], R[2][3]], rank };
  // rank 2: one free variable
  const pivCols = [], free = [];
  for (const r of R) { const c = r.findIndex((v, k) => k < 3 && Math.abs(v) > EPS); if (c >= 0) pivCols.push([c, r]); }
  for (let c = 0; c < 3; c++) if (!pivCols.some(([pc]) => pc === c)) free.push(c);
  const p = [0, 0, 0], u = [0, 0, 0]; const f = free[0]; u[f] = 1;
  for (const [c, r] of pivCols) { p[c] = r[3]; u[c] = -r[f]; }
  return { kind: rank === 2 ? 'gerade' : 'ebene', p, u, rank };
}

export function interp(state, op, s) {
  const M = copy(state);
  if (!op) return M;
  if (op.t === 'add') for (let k = 0; k < 4; k++) M[op.i][k] += s * op.l * state[op.j][k];
  if (op.t === 'scale') for (let k = 0; k < 4; k++) M[op.i][k] *= 1 + s * (op.c - 1);
  return M;
}

/* number formatting as fractions */
export function frac(x) {
  if (Math.abs(x) < 1e-9) return '0';
  for (let d = 1; d <= 12; d++) { const n = Math.round(x * d); if (Math.abs(n / d - x) < 1e-7) return d === 1 ? `${n}`.replace('-', '−') : `${n < 0 ? '−' : ''}${Math.abs(n)}/${d}`; }
  return fmt(x, 2);
}
const SUB = ['₁', '₂', '₃'];
export function opText(op) {
  if (!op) return 'Ausgangssystem';
  if (op.t === 'swap') return `Z${SUB[op.i]} ↔ Z${SUB[op.j]}`;
  if (op.t === 'scale') return `Z${SUB[op.i]} ← ${frac(op.c)} · Z${SUB[op.i]}`;
  const l = op.l; return `Z${SUB[op.i]} ← Z${SUB[op.i]} ${l < 0 ? '−' : '+'} ${Math.abs(Math.abs(l) - 1) < 1e-9 ? '' : frac(Math.abs(l)) + ' · '}Z${SUB[op.j]}`;
}

/* ---------- thumbnail ---------- */
export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  // three planes through one point, oblique projection, outlines only
  const k = Math.min(W, H) * 0.3, cx = W * 0.5, cy = H * 0.55;
  const pr = (p) => [cx + (p[1] - p[0] * 0.55) * k, cy - (p[2] - p[0] * 0.32) * k];
  const quad = (pts, col) => { ctx.save(); ctx.beginPath(); pts.map(pr).forEach((q, i) => (i ? ctx.lineTo(...q) : ctx.moveTo(...q))); ctx.closePath(); ctx.fillStyle = alpha(col, 0.07); ctx.fill(); ctx.strokeStyle = col; ctx.lineWidth = 1; ctx.stroke(); ctx.restore(); };
  const a = 1.1;
  quad([[0, -a, -a], [0, a, -a], [0, a, a], [0, -a, a]], C.v);
  quad([[-a, 0, -a], [a, 0, -a], [a, 0, a], [-a, 0, a]], C.f);
  quad([[-a, -a, 0], [a, -a, 0], [a, a, 0], [-a, a, 0]], C.m);
  const p = pr([0, 0, 0]);
  ctx.beginPath(); ctx.arc(p[0], p[1], 3.2, 0, 7); ctx.fillStyle = C.k; ctx.fill();
}

/* ---------- steps ---------- */
const STEPS = [
  { title: 'Drei Gleichungen, drei Ebenen', set: { sys: 'punkt', mode: 'zeilen', at: 0 },
    html: '<p>Jede Gleichung $a x + b y + c z = d$ ist eine Ebene. Die Lösungsmenge ist der Durchschnitt aller Ebenen: hier genau ein Punkt.</p>$$x + y + z = 3,\\quad x - y = 0,\\quad z = 1$$<p>Drehe die Ansicht. Die dunklen Linien sind die Schnittgeraden je zweier Ebenen.</p>' },
  { title: 'Eine Zeilenumformung dreht eine Ebene', set: { sys: 'punkt', mode: 'zeilen', at: 0, play: 1 },
    html: '<p>$Z_2 \\leftarrow Z_2 - Z_1$ ersetzt die zweite Ebene. Während die Umformung läuft, ist jede Zwischenstufe $Z_2 + s\\lambda Z_1$ wieder eine Ebene durch den Lösungspunkt. Die Ebene dreht sich um die Schnittgerade mit $Z_1$.</p><p>Deshalb ändern Äquivalenzumformungen die Lösungsmenge nicht.</p>' },
  { title: 'Bis man ablesen kann', set: { sys: 'punkt', mode: 'zeilen', at: 0, play: 99 },
    html: '<p>Vorwärts entsteht die Dreiecksform, rückwärts die reduzierte Zeilenstufenform. Am Ende stehen da $x = 1$, $y = 1$, $z = 1$: drei Ebenen parallel zu den Koordinatenebenen. Der Schnittpunkt ist die ganze Zeit derselbe geblieben.</p>' },
  { title: 'Unendlich viele Lösungen', set: { sys: 'gerade', mode: 'zeilen', at: 0, play: 99 },
    html: '<p>Die dritte Gleichung ist die Summe der ersten beiden. Alle drei Ebenen enthalten dieselbe Gerade. Beim Eliminieren wird $Z_3$ zu $0 = 0$: Diese Ebene verschwindet, weil sie keine Bedingung mehr stellt. Rang $2$, ein freier Parameter:</p>$$\\boldsymbol x = (0,-1,4) + t\\,(1,1,-2).$$' },
  { title: 'Keine Lösung: parallel oder Prisma', set: { sys: 'prisma', mode: 'zeilen', at: 0, play: 99 },
    html: '<p>Je zwei Ebenen schneiden sich, aber die drei Schnittgeraden sind parallel: ein Prisma. Kein Punkt liegt auf allen drei. Gauss zeigt das als Widerspruch $0 = c$ mit $c \\neq 0$; die Ebene wandert dabei ins Unendliche.</p><p>Probiere auch «Parallel»: zwei Ebenen mit gleicher Normalen, aber verschiedenem Abstand.</p>' },
  { title: 'Das Spaltenbild', set: { sys: 'punkt', mode: 'spalten', at: 0 },
    html: '<p>Dasselbe System als Frage nach einer Linearkombination der Spalten:</p>$$x\\,\\boldsymbol a_1 + y\\,\\boldsymbol a_2 + z\\,\\boldsymbol a_3 = \\boldsymbol b .$$<p>Die gestrichelte Kette läuft mit den Koeffizienten $(1,1,1)$ von $\\boldsymbol 0$ nach $\\boldsymbol b$. Beim Prisma spannen die Spalten nur eine Ebene auf, und $\\boldsymbol b$ liegt nicht darin: Das System ist unlösbar.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { sys: 'punkt', mode: 'zeilen', pos: 0, target: 0, layers: { lines: true, box: true }, G: null, sol: null };
  const setSys = (k) => { S.sys = k; S.G = gaussOps(SYSTEMS[k].M); S.sol = solution(SYSTEMS[k].M); S.pos = 0; S.target = 0; sysSeg.set(k); refresh(); };
  const lbl = el('div', { class: 'overlay' });
  const loading = el('div', { class: 'hint', html: '3D-Ansicht wird geladen …' });
  L0.stage.append(lbl, loading);
  let api = null, destroyed = false;

  /** current interpolated matrix: pos = k + s means op k is s complete */
  S.current = () => {
    const k = Math.floor(S.pos), s = S.pos - k;
    return interp(S.G.states[Math.min(k, S.G.ops.length)], S.G.ops[k], k < S.G.ops.length ? s * s * (3 - 2 * s) : 0);
  };
  const SPEED = 0.7;
  const runner = new Runner({ stages: [], update(dt) {
    if (S.hold > 0) { S.hold -= dt; return; }
    const goal = Math.min(S.target, S.G.ops.length);
    if (S.pos < goal - 1e-9) {
      const k = Math.floor(S.pos + 1e-9);
      S.pos = Math.min(goal, S.pos + dt * SPEED);
      if (Math.floor(S.pos + 1e-9) > k && S.pos < goal) { S.pos = Math.floor(S.pos + 1e-9); S.hold = 0.55; }
    } else runner.pause();
    refresh();
  } });
  S.hold = 0;

  const scrub = el('input', { type: 'range', min: 0, max: 1000, step: 1, value: 0, 'aria-label': 'Fortschritt' });
  const tlabel = el('span', { class: 'tlabel' });
  scrub.addEventListener('input', () => { runner.pause(); S.pos = (scrub.value / 1000) * S.G.ops.length; S.target = S.pos; refresh(); });
  L0.tslot.append(transport(runner, { onRestart: () => { S.pos = 0; S.target = 99; S.hold = 0.6; runner.play(); }, scrub, label: tlabel }));
  runner.on((p) => { if (p && S.pos >= S.G.ops.length - 1e-6) { S.pos = 0; S.hold = 0.6; } if (p && S.target <= S.pos) S.target = 99; });

  const sysSeg = seg(Object.entries(SYSTEMS).map(([k, v]) => [k, v.label]), S.sys, (k) => { runner.pause(); setSys(k); }, 'scenes');
  L0.scenes.append(sysSeg);

  const q = el('p', { class: 'question', html: 'Das Gauss-Verfahren formt Gleichungen um, bis man die Lösung ablesen kann. <b>Was passiert dabei geometrisch, und warum geht nie eine Lösung verloren?</b>' });
  const steps = stepper(STEPS, (st) => {
    const s = st.set; runner.pause();
    setSys(s.sys); S.mode = s.mode; modeSeg.set(s.mode); S.pos = s.at || 0;
    if (s.play) { S.target = s.play; S.hold = 0.8; setTimeout(() => runner.play(), 250); }
    refresh();
  });
  const modeSeg = seg([['zeilen', 'Zeilenbild'], ['spalten', 'Spaltenbild']], S.mode, (m) => { S.mode = m; refresh(); });
  const chips = {
    lines: chip('Schnittgeraden', true, C.ink, (v) => { S.layers.lines = v; api?.dirty(); }),
    box: chip('Rahmen', true, C.muted, (v) => { S.layers.box = v; api?.dirty(); }),
  };
  const opBox = el('div', { class: 'gauss-op' });
  const matBox = el('div', { class: 'gauss-mat' });
  const bPrev = el('button', { type: 'button', class: 'btn', html: '← Umformung' });
  const bNext = el('button', { type: 'button', class: 'btn solid', html: 'Nächste Umformung →' });
  bPrev.addEventListener('click', () => { runner.pause(); S.pos = Math.max(0, Math.ceil(S.pos) - 1); S.target = S.pos; refresh(); });
  bNext.addEventListener('click', () => { S.target = Math.min(S.G.ops.length, Math.floor(S.pos + 1e-6) + 1); S.hold = 0; runner.play(); });
  const ro = readout([['r', 'Rang <span class="var">A</span>'], ['l', 'Lösungsmenge']]);
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Rechnung' }), modeSeg, opBox, matBox, el('div', { class: 'toggles' }, bPrev, bNext), el('div', { class: 'toggles' }, ...Object.values(chips)), ro);
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Eine Zeilenumformung ersetzt eine Ebene durch eine andere Ebene durch dieselbe Schnittmenge. Gauss dreht die Ebenen so lange, bis sie parallel zu den Koordinatenebenen stehen und man den Schnitt ablesen kann.' });
  L0.panel.append(q, steps, box, insight, el('p', { class: 'src', html: 'Skript Lineare Algebra, Woche 1–3: Äquivalenzumformungen, Gauss-Verfahren, Zeilenbild und Spaltenbild, Beispiel «Vier Systeme, vier Bilder».' }));

  function refresh() {
    const M = S.current(), k = Math.floor(S.pos + 1e-9), n = S.G.ops.length;
    const op = S.G.ops[Math.min(k, n - 1)];
    const active = S.pos > 0 && S.pos < n ? S.G.ops[Math.floor(S.pos)] : null;
    opBox.textContent = S.pos <= 1e-9 ? 'Ausgangssystem' : S.pos >= n - 1e-9 ? 'Reduzierte Zeilenstufenform' : opText(active || op);
    const cls = (i) => (active && active.i === i ? ' class="hot"' : active && active.j === i && active.t !== 'scale' ? ' class="src"' : '');
    const cell = (v) => frac(Math.round(v * 1000) / 1000);
    matBox.innerHTML = '<table>' + M.map((r, i) => `<tr${cls(i)}><th>Z${SUB[i]}</th>${r.slice(0, 3).map((v) => `<td>${cell(v)}</td>`).join('')}<td class="rhs">${cell(r[3])}</td></tr>`).join('') + '</table>';
    tlabel.textContent = `${Math.min(n, Math.ceil(S.pos - 1e-6))} / ${n}`;
    scrub.value = Math.round((S.pos / Math.max(1, n)) * 1000); scrub.style.setProperty('--p', (S.pos / Math.max(1, n)) * 100 + '%');
    ro.set('r', `${S.sol.rank}`);
    const so = S.sol;
    ro.set('l', so.kind === 'punkt' ? `Punkt (${so.p.map(frac).join(', ')})` : so.kind === 'gerade' ? 'Gerade' : so.kind === 'leer' ? 'leer' : 'Ebene');
    bPrev.disabled = S.pos <= 0; bNext.disabled = S.pos >= n - 1e-9;
    api?.dirty();
  }
  steps.go(0);
  typeset(L0.panel);
  import('./gauss3d.js').then(({ create }) => {
    if (destroyed) return; loading.remove();
    api = create(L0.stage, lbl, S, runner);
  }).catch((e) => { loading.innerHTML = '3D-Ansicht konnte nicht geladen werden (keine Verbindung zum CDN).'; console.error(e); });
  return { destroy() { destroyed = true; runner.destroy(); api?.destroy(); } };
}
