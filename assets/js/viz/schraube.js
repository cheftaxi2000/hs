// Kinemate, Invarianten, Zentralachse und Schraube (Mechanik 1, Kap. 3.4) — dual: Dyname (Kap. 6)
import { C, TAU, clamp, el, slider, seg, chip, readout, transport, layout, stepper, typeset, alpha, onTheme, fmt, Runner, mlabel, line, arrow, text } from '../core.js';

export const meta = {
  id: 'schraube',
  group: 'Mechanik 1',
  short: 'Schraube',
  tag: 'Mechanik 1 · Kapitel 3.4 und 6.5',
  title: 'Warum ist jede Bewegung momentan eine Schraubung?',
  card: 'Die Kinemate im Raum: Beim Wechsel des Bezugspunkts bleibt fast alles gleich, und auf der Zentralachse bleibt nur die Schraube übrig.',
};

/* Beispiel aus dem Skript: a = v = 1, ω = (v/a, 0, 0), Zentralachse durch Z = (0, a, a) parallel zu x. */
const Z0 = [0, 1, 1];
const OM = 1;
const add = (a, b) => [a[0] + b[0], a[1] + b[1], a[2] + b[2]];
const sub = (a, b) => [a[0] - b[0], a[1] - b[1], a[2] - b[2]];
const mul = (a, k) => [a[0] * k, a[1] * k, a[2] * k];
const cross = (a, b) => [a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0]];
const dotp = (a, b) => a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
const norm = (a) => Math.hypot(a[0], a[1], a[2]);

/** state of the screw: ω along x through Z0, pitch h (v_ω = h ω) */
function field(h) {
  const w = [OM, 0, 0];
  return { w, vel: (p) => add(mul(w, h), cross(w, sub(p, Z0))) };
}
/** body point p0 (at t = 0) after screwing for time t */
function screw(p0, t, h) {
  const a = OM * t, c = Math.cos(a), s = Math.sin(a);
  const d = sub(p0, Z0);
  return [Z0[0] + d[0] + h * OM * t, Z0[1] + c * d[1] - s * d[2], Z0[2] + s * d[1] + c * d[2]];
}

const PTS = { A: [1, 0, 0], B: [0, 1, 0], C: [0, 0, 1] };

/* ---------- thumbnail: simple oblique projection ---------- */
export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const s = Math.min(W, H) * 0.3;
  const pr = (p) => [W * 0.44 + s * (p[1] - 0.62 * p[0]), H * 0.7 - s * (p[2] - 0.34 * p[0])];
  const f = field(-1);
  // axis
  const a0 = pr([-2.4, 1, 1]), a1 = pr([2.2, 1, 1]);
  line(ctx, a0[0], a0[1], a1[0], a1[1], C.k, 1.6, [6, 5]);
  // cube
  const V = [[0,0,0],[1,0,0],[1,1,0],[0,1,0],[0,0,1],[1,0,1],[1,1,1],[0,1,1]];
  const E = [[0,1],[1,2],[2,3],[3,0],[4,5],[5,6],[6,7],[7,4],[0,4],[1,5],[2,6],[3,7]];
  for (const [i, j] of E) { const p = pr(V[i]), q = pr(V[j]); line(ctx, p[0], p[1], q[0], q[1], alpha(C.ink, 0.7), 1.1); }
  // helix of B
  const hp = []; for (let i = 0; i <= 120; i++) hp.push(pr(screw(PTS.A, -1.1 + 2.2 * i / 120, -1)));
  ctx.save(); ctx.strokeStyle = alpha(C.v, 0.45); ctx.lineWidth = 1.2; ctx.beginPath(); hp.forEach((p, i) => (i ? ctx.lineTo(...p) : ctx.moveTo(...p))); ctx.stroke(); ctx.restore();
  for (const p of Object.values(PTS)) { const v = f.vel(p), a = pr(p), b = pr(add(p, mul(v, 0.55))); arrow(ctx, a[0], a[1], b[0], b[1], C.v, 2, 8); }
  const z = pr(Z0), wz = pr(add(Z0, [0.9, 0, 0]));
  arrow(ctx, z[0], z[1], wz[0], wz[1], C.m, 2.4, 9);
}

/* ---------- steps ---------- */
const STEPS = [
  { title: 'Zwei Vektoren genügen', set: { mode: 'kin', h: -1, ref: [0, 1, 0], layers: { pts: true, disc: false, split: false, trails: false, axis: false } },
    html: '<p>Bekannt sind der Bezugspunkt $B=(0,a,0)$ mit $\\boldsymbol v_B = (-v, v, 0)$ und die Rotationsgeschwindigkeit $\\boldsymbol\\omega = (v/a, 0, 0)$. Diese <b>Kinemate</b> $\\{\\boldsymbol v_B, \\boldsymbol\\omega\\}$ legt die Geschwindigkeit jedes Punktes fest:</p>$$\\boldsymbol v_M = \\boldsymbol v_B + \\boldsymbol\\omega\\times\\overrightarrow{BM}.$$<p>Die Pfeile an $A$ und $C$ sind genau die Werte aus dem Skript: $\\boldsymbol v_A = (-v, v, -v)$, $\\boldsymbol v_C = (-v, 0, -v)$. Drehe die Ansicht mit einem Finger.</p>' },
  { title: 'Bezugspunkt wechseln: ω bleibt', set: { layers: { pts: false, disc: true, split: false, trails: false, axis: false } },
    html: '<p>Ziehe den Bezugspunkt durch den Raum. Seine Geschwindigkeit ändert sich, $\\boldsymbol\\omega$ nicht: Die Rotationsgeschwindigkeit gehört zum Körper, nicht zu einem Punkt (<b>1. Invariante</b>).</p>$$\\boldsymbol v_{B\'} = \\boldsymbol v_B + \\boldsymbol\\omega\\times\\overrightarrow{BB\'},\\qquad \\boldsymbol\\omega\' = \\boldsymbol\\omega$$<p>Die Pfeile in der Scheibe zeigen das Feld in der Ebene senkrecht zu $\\boldsymbol\\omega$ durch den Bezugspunkt.</p>' },
  { title: 'Nur der Anteil senkrecht zu ω ändert sich', set: { layers: { pts: false, disc: true, split: true, trails: false, axis: false } },
    html: '<p>Zerlege die Geschwindigkeit in den Anteil längs $\\boldsymbol\\omega$ und den Rest:</p>$$\\boldsymbol v_{B\'} = \\boldsymbol v_\\omega + (\\boldsymbol v_{B\'})_\\perp .$$<p>Der Anteil $\\boldsymbol v_\\omega$ ist für alle Punkte gleich (<b>2. Invariante</b>), denn $\\boldsymbol\\omega\\cdot(\\boldsymbol\\omega\\times\\overrightarrow{BM}) = 0$. Wohin du den Punkt auch ziehst: Der hellere Pfeil längs $x$ ändert sich nicht.</p>' },
  { title: 'Die Zentralachse', set: { layers: { pts: false, disc: true, split: true, trails: false, axis: true }, goAxis: true },
    html: '<p>Es gibt Punkte, an denen der senkrechte Anteil ganz verschwindet. Sie liegen auf der <b>Zentralachse</b> parallel zu $\\boldsymbol\\omega$:</p>$$\\overrightarrow{BZ} = \\frac{\\boldsymbol\\omega\\times\\boldsymbol v_B}{\\omega^2} = (0,0,a),\\qquad Z = (0,a,a).$$<p>Dort ist die Kinemate $\\{\\boldsymbol v_\\omega, \\boldsymbol\\omega\\}$ die <b>Schraube</b>. Rund um die Achse dreht sich das senkrechte Feld wie bei einer reinen Rotation.</p>' },
  { title: 'Jede Bewegung ist momentan eine Schraubung', set: { layers: { pts: true, disc: false, split: false, trails: true, axis: true }, play: true },
    html: '<p>Hält man diese Kinemate fest, dreht sich der Würfel um die Zentralachse und gleitet zugleich mit $v_\\omega = v$ in negativer $x$-Richtung. Jede Ecke läuft auf einer Schraubenlinie.</p><p>Bei einer allgemeinen Bewegung ändert sich die Kinemate mit der Zeit. In jedem Augenblick sieht die Bewegung trotzdem genau so aus, nur um eine jeweils andere Achse.</p>' },
  { title: 'Sonderfall: ebene Bewegung', set: { h: 0, layers: { pts: true, disc: true, split: true, trails: true, axis: true }, play: true },
    html: '<p>Setze den Schraubenanteil auf $v_\\omega = 0$, also $\\boldsymbol\\omega\\cdot\\boldsymbol v_B = 0$. Die Schraube entartet zur reinen Drehung, und die Zentralachse wird zur <b>momentanen Drehachse</b>.</p><p>Das ist genau der Fall der ebenen Bewegung: Die Achse durchstößt die Bewegungsebene im Momentanzentrum $Z$.</p>' },
  { title: 'Dieselbe Mathematik für Kräfte', set: { mode: 'dyn', h: -1, layers: { pts: true, disc: true, split: true, trails: false, axis: true } },
    html: '<p>Für eine Kräftegruppe mit Resultierender $\\boldsymbol R$ und Moment $\\boldsymbol M_O$ gilt beim Wechsel des Bezugspunkts</p>$$\\boldsymbol M_P = \\boldsymbol M_O + \\boldsymbol R\\times\\overrightarrow{OP}.$$<p>Das ist dieselbe Struktur mit $\\boldsymbol\\omega\\leftrightarrow\\boldsymbol R$ und $\\boldsymbol v\\leftrightarrow\\boldsymbol M$. Invarianten sind $\\boldsymbol R$ und $\\boldsymbol R\\cdot\\boldsymbol M$; auf der Zentralachse bleibt die Kraftschraube $\\{\\boldsymbol R, \\lambda\\boldsymbol R\\}$.</p>' },
];

/* ---------- mount ---------- */
export function mount(root) {
  const L0 = layout(root, meta);
  const S = { mode: 'kin', h: -1, ref: [0, 1, 0], t: 0, layers: { ...STEPS[0].set.layers }, anim: null };
  const lbl = el('div', { class: 'overlay' });
  const loading = el('div', { class: 'hint', html: '3D-Ansicht wird geladen …' });
  L0.stage.append(lbl, loading);
  let destroyed = false, api = null;

  const runner = new Runner({ stages: [], update(dt) {
    S.t += dt;
    if (S.t > 3.2) S.t = -3.2;
    syncScrub();
    api?.dirty();
  } });

  const scrub = el('input', { type: 'range', min: -320, max: 320, step: 1, value: 0, 'aria-label': 'Zeit' });
  const tlabel = el('span', { class: 'tlabel' });
  const syncScrub = () => { scrub.value = Math.round(S.t * 100); scrub.style.setProperty('--p', ((S.t + 3.2) / 6.4) * 100 + '%'); tlabel.textContent = `t = ${fmt(S.t, 2)} s`; };
  scrub.addEventListener('input', () => { runner.pause(); S.t = scrub.value / 100; syncScrub(); api?.dirty(); });
  const tp = transport(runner, { onRestart: () => { S.t = -3.2; runner.play(); api?.dirty(); }, scrub, label: tlabel });
  L0.tslot.append(tp);

  const modeSeg = seg([['kin', 'Kinemate'], ['dyn', 'Dyname']], S.mode, (m) => { setMode(m); }, 'scenes');
  L0.scenes.append(modeSeg);

  // panel
  const q = el('p', { class: 'question', html: 'Ein starrer Körper bewegt sich völlig frei. <b>Gibt es trotzdem eine einfache Beschreibung, die in jedem Augenblick gilt?</b>' });
  const steps = stepper(STEPS, (st) => applyStep(st.set));
  const chips = {
    pts: chip('Ecken A, B, C', true, C.v, (v) => { S.layers.pts = v; api?.dirty(); }),
    disc: chip('Feld ⟂ ω', false, C.v, (v) => { S.layers.disc = v; api?.dirty(); }),
    split: chip('Zerlegung', false, C.v, (v) => { S.layers.split = v; api?.dirty(); }),
    axis: chip('Zentralachse', false, C.k, (v) => { S.layers.axis = v; api?.dirty(); }),
    trails: chip('Bahnen', false, C.ink, (v) => { S.layers.trails = v; api?.dirty(); }),
  };
  const hCtrl = slider({ id: 'sc-h', label: 'Schraubenanteil <span class="var">v<sub>ω</sub></span> / <span class="var">ω</span>', min: -1.5, max: 1.5, step: 0.05, value: S.h,
    format: (v) => (Math.abs(v + 1) < 1e-6 ? '−a (Skript)' : fmt(v, 2) + ' a'), onInput: (v) => { S.h = v; api?.dirty(); updateReadout(); } });
  const xCtrl = slider({ id: 'sc-x', label: 'Bezugspunkt parallel zur Achse verschieben', min: -1.5, max: 1.5, step: 0.01, value: 0,
    format: (v) => '<span class="var">x</span> = ' + fmt(v, 2), onInput: (v) => { S.ref[0] = v; api?.dirty(); updateReadout(); } });
  const bAxis = el('button', { type: 'button', class: 'btn', html: 'Bezugspunkt auf die Zentralachse' });
  bAxis.addEventListener('click', () => goAxis());
  const bReset = el('button', { type: 'button', class: 'btn', html: 'Zurück nach <i>B</i>' });
  bReset.addEventListener('click', () => animateRef([S.ref[0], 1, 0]));
  const ro = readout([['p', 'Bezugspunkt'], ['v', 'Geschwindigkeit'], ['vw', 'Anteil längs <span class="var">ω</span>'], ['vp', 'Anteil senkrecht'], ['d', 'Abstand zur Achse']]);
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), el('div', { class: 'toggles' }, ...Object.values(chips)), hCtrl, xCtrl,
    el('div', { class: 'toggles' }, bAxis, bReset), ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Beim Wechsel des Bezugspunkts ändert sich nur der Anteil senkrecht zu $\\boldsymbol\\omega$. Diesen Anteil kann man zum Verschwinden bringen. Was bleibt, ist eine Drehung um die Zentralachse plus ein Gleiten längs dieser Achse.' });
  L0.panel.append(q, steps, box, formulas, insight, el('p', { class: 'src', html: 'Skript Mechanik 1, Abschnitt 3.4 (Beispiel «Kinemate, Invarianten und Zentralachse») und 6.5 (Reduktion, Kraftschraube).' }));

  const FORM = {
    kin: '<p>Wechsel des Bezugspunkts</p>$$\\boldsymbol v_{B\'} = \\boldsymbol v_B + \\boldsymbol\\omega\\times\\overrightarrow{BB\'}$$<p>Invarianten</p>$$\\boldsymbol\\omega,\\qquad \\boldsymbol v_\\omega = \\frac{\\boldsymbol\\omega\\cdot\\boldsymbol v_B}{\\omega^2}\\,\\boldsymbol\\omega$$<p>Zentralachse</p>$$\\overrightarrow{BZ} = \\frac{\\boldsymbol\\omega\\times\\boldsymbol v_B}{\\omega^2},\\qquad d_Z = \\frac{|(\\boldsymbol v_B)_\\perp|}{\\omega}$$',
    dyn: '<p>Wechsel des Bezugspunkts</p>$$\\boldsymbol M_P = \\boldsymbol M_O + \\overrightarrow{PO}\\times\\boldsymbol R$$<p>Invarianten</p>$$\\boldsymbol R,\\qquad \\boldsymbol R\\cdot\\boldsymbol M_P = \\boldsymbol R\\cdot\\boldsymbol M_O$$<p>Zentralachse und Kraftschraube</p>$$\\overrightarrow{BZ} = \\frac{\\boldsymbol R\\times\\boldsymbol M_B}{R^2},\\qquad \\boldsymbol M_Z = \\lambda\\boldsymbol R$$',
  };
  const setFormulas = () => { formulas.lastChild.innerHTML = FORM[S.mode]; typeset(formulas); };

  function syncUI() {
    for (const [k, c] of Object.entries(chips)) c.set(!!S.layers[k]);
    hCtrl.set(S.h); xCtrl.set(S.ref[0]); modeSeg.set(S.mode);
    tp.hidden = S.mode === 'dyn'; chips.trails.hidden = S.mode === 'dyn';
    hCtrl.querySelector('label').innerHTML = S.mode === 'kin' ? 'Schraubenanteil <span class="var">v<sub>ω</sub></span> / <span class="var">ω</span>' : 'Schraubenanteil <span class="var">λ</span> = <span class="var">M<sub>Z</sub></span> / <span class="var">R</span>';
    chips.disc.innerHTML = S.mode === 'kin' ? 'Feld ⟂ ω' : 'Feld ⟂ R';
  }
  function setMode(m) {
    S.mode = m; if (m === 'dyn') { runner.pause(); S.t = 0; syncScrub(); }
    syncUI(); setFormulas(); updateReadout(); api?.dirty();
  }
  function applyStep(set) {
    if (set.mode && set.mode !== S.mode) setMode(set.mode);
    if (set.h !== undefined) S.h = set.h;
    if (set.ref) { S.ref = set.ref.slice(); }
    Object.assign(S.layers, set.layers);
    if (set.goAxis) goAxis();
    if (set.play) { S.t = -3.2; runner.play(); } else if (set.layers && !set.play) { runner.pause(); S.t = 0; syncScrub(); }
    syncUI(); updateReadout(); api?.dirty();
  }
  function goAxis() { animateRef([S.ref[0], Z0[1], Z0[2]]); }
  function animateRef(to) {
    const from = S.ref.slice(), t0 = performance.now(), D = 900;
    S.anim = (now) => {
      const u = clamp((now - t0) / D, 0, 1), e = u < 0.5 ? 4 * u * u * u : 1 - (-2 * u + 2) ** 3 / 2;
      S.ref = from.map((f, i) => f + (to[i] - f) * e);
      updateReadout();
      if (u >= 1) S.anim = null;
    };
    api?.dirty();
  }
  function updateReadout() {
    const f = field(S.h), p = S.ref, v = f.vel(p);
    const vw = mul(f.w, dotp(f.w, v) / (OM * OM)), vp = sub(v, vw);
    const V = (a) => `(${a.map((x) => fmt(x, 2)).join(', ')})`;
    const nm = S.mode === 'kin' ? ['v', 'v<sub>ω</sub>', '(v)<sub>⊥</sub>'] : ['M', 'M<sup>(R)</sup>', 'M<sub>⊥</sub>'];
    ro.set('p', V(p));
    ro.set('v', V(v)); ro.set('vw', V(vw)); ro.set('vp', V(vp));
    ro.set('d', fmt(Math.hypot(p[1] - Z0[1], p[2] - Z0[2]), 3) + ' a');
    const dts = ro.querySelectorAll('dt');
    dts[1].innerHTML = `<span class="var">${nm[0]}</span> im Bezugspunkt`; dts[2].innerHTML = `Anteil längs <span class="var">${S.mode === 'kin' ? 'ω' : 'R'}</span>`; dts[3].innerHTML = 'Anteil senkrecht';
  }

  steps.go(0);
  syncUI(); setFormulas(); updateReadout(); syncScrub();
  typeset(L0.panel);

  // three.js part, loaded lazily
  import('./schraube3d.js').then(({ create }) => {
    if (destroyed) return;
    loading.remove();
    api = create(L0.stage, lbl, S, { field, screw, PTS, Z0, OM, onRef: () => { updateReadout(); }, runner, syncScrub });
  }).catch((e) => { loading.innerHTML = '3D-Ansicht konnte nicht geladen werden (keine Verbindung zum CDN).'; console.error(e); });

  runner.on(() => api?.dirty());
  return { destroy() { destroyed = true; runner.destroy(); api?.destroy(); } };
}
