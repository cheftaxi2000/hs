// Entropie als Abzählen von Mikrozuständen: S = k ln W (Chemie, Kap. 5)
import { C, clamp, Stage, Runner, line, path, dot, text, fmt, el, seg, readout, transport, layout, stepper, typeset, alpha, slider, smooth } from '../core.js';

export const meta = {
  id: 'entropie',
  group: 'Chemie',
  short: 'Entropie',
  tag: 'Chemie · Kapitel 5.4',
  title: 'Warum verteilt sich ein Gas von selbst?',
  card: 'Teilchen wandern zufällig zwischen zwei Kolben. Bei 10 Teilchen kommt «alle links» immer wieder vor, bei 1000 nie. Entropie zählt Möglichkeiten: S = k ln W.',
};

/* log of the binomial coefficient via log-gamma (Lanczos) */
function lgamma(z) {
  const g = 7, c = [0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313, -176.61503916999185, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7];
  if (z < 0.5) return Math.log(Math.PI / Math.sin(Math.PI * z)) - lgamma(1 - z);
  z -= 1; let x = c[0]; for (let i = 1; i < g + 2; i++) x += c[i] / (z + i);
  const t = z + g + 0.5; return 0.5 * Math.log(2 * Math.PI) + (z + 0.5) * Math.log(t) - t + Math.log(x);
}
const lnC = (n, k) => lgamma(n + 1) - lgamma(k + 1) - lgamma(n - k + 1);

/* flask geometry in model units: left flask centre (-1,0), right (1,0), radius .78, neck at x ∈ [-0.25, 0.25] */
const FR = 0.78, FC = [[-1.05, 0], [1.05, 0]];
function randIn(side) { const a = Math.random() * Math.PI * 2, r = Math.sqrt(Math.random()) * (FR - 0.05); return [FC[side][0] + r * Math.cos(a), FC[side][1] + r * Math.sin(a)]; }

class Model {
  init(N) {
    this.N = N; this.p = []; for (let i = 0; i < N; i++) { const [x, y] = randIn(0); this.p.push({ side: 0, x, y, fly: null }); }
    this.k = N; this.trace = [N]; this.t = 0; this.hits = 0; this.events = 0;
  }
  event() {
    // Ehrenfest model: a random molecule passes through the connection
    const i = (Math.random() * this.N) | 0, q = this.p[i], to = 1 - q.side;
    q.fly = { from: [q.x, q.y], to: randIn(to), t: 0 }; q.side = to;
    this.k += to === 0 ? 1 : -1; this.events++;
    this.trace.push(this.k); if (this.trace.length > 700) this.trace.shift();
    if (this.k === this.N && this.events > 1) this.hits++;
  }
}

function geom(W, H) {
  const wide = W >= 760;
  if (wide) return { wide, flask: { x: 16, y: 16, w: W - 32, h: H * 0.5 - 16 }, trace: { x: 56, y: H * 0.5 + 30, w: W * 0.5 - 76, h: H * 0.5 - 60 }, dist: { x: W * 0.5 + 30, y: H * 0.5 + 30, w: W * 0.5 - 50, h: H * 0.5 - 60 } };
  return { wide, flask: { x: 10, y: 10, w: W - 20, h: H * 0.42 }, trace: { x: 46, y: H * 0.42 + 36, w: W - 62, h: H * 0.25 - 30 }, dist: { x: 46, y: H * 0.67 + 34, w: W - 62, h: H * 0.33 - 50 } };
}

function draw(ctx, W, H, S) {
  const m = S.m, G = geom(W, H), fb = G.flask;
  const sc = Math.min(fb.w / 4.2, fb.h / 1.9), ox = fb.x + fb.w / 2, oy = fb.y + fb.h / 2;
  const X = (x) => ox + x * sc, Y = (y) => oy - y * sc;
  // flasks
  ctx.save(); ctx.lineWidth = 2; ctx.strokeStyle = C.ink; ctx.fillStyle = C.surface2;
  ctx.beginPath();
  const a = Math.asin(0.09 / FR);
  ctx.arc(X(FC[0][0]), Y(0), FR * sc, a, Math.PI * 2 - a, false);
  ctx.lineTo(X(FC[1][0] - FR * Math.cos(a)), Y(0.09));
  ctx.arc(X(FC[1][0]), Y(0), FR * sc, Math.PI + a, Math.PI - a, false);
  ctx.closePath(); ctx.fill(); ctx.stroke(); ctx.restore();
  // particles
  const r = clamp(sc * 0.032 * Math.sqrt(100 / m.N), 1.3, 6);
  for (const q of m.p) {
    let x = q.x, y = q.y;
    if (q.fly) { const t = smooth(q.fly.t); const mid = [0, (Math.random() - 0.5) * 0.04]; const u = t < 0.5 ? t * 2 : (t - 0.5) * 2; if (t < 0.5) { x = q.fly.from[0] + (mid[0] - q.fly.from[0]) * u; y = q.fly.from[1] + (mid[1] - q.fly.from[1]) * u; } else { x = mid[0] + (q.fly.to[0] - mid[0]) * u; y = mid[1] + (q.fly.to[1] - mid[1]) * u; } }
    ctx.beginPath(); ctx.arc(X(x), Y(y), r, 0, 7); ctx.fillStyle = q.side === 0 ? C.v : C.f; ctx.fill();
  }
  const k = m.k, N = m.N;
  text(ctx, `links ${k}`, X(FC[0][0]), Y(-FR) + 18, C.v, { size: 13, font: 'mono', align: 'center', weight: 500 });
  text(ctx, `rechts ${N - k}`, X(FC[1][0]), Y(-FR) + 18, C.f, { size: 13, font: 'mono', align: 'center', weight: 500 });
  // ---- trace of k/N ----
  const tb = G.trace;
  text(ctx, 'ANTEIL LINKS ÜBER DIE ZEIT', tb.x - 40, tb.y - 14, C.muted, { size: 11, weight: 600 });
  const TY = (f) => tb.y + tb.h - f * tb.h;
  ctx.fillStyle = C.surface2; ctx.fillRect(tb.x, tb.y, tb.w, tb.h);
  line(ctx, tb.x, TY(0.5), tb.x + tb.w, TY(0.5), alpha(C.ink, 0.3), 1, [3, 3]);
  for (const f of [0, 0.5, 1]) text(ctx, f === 0.5 ? '½' : String(f), tb.x - 8, TY(f), C.muted, { size: 11, font: 'mono', align: 'right' });
  const tr = m.trace; if (tr.length > 1) path(ctx, tr.map((v, i) => [tb.x + (i / 699) * tb.w, TY(v / N)]), C.ink, 1.4);
  // ---- distribution of microstates ----
  const db = G.dist;
  text(ctx, 'MIKROZUSTÄNDE W(k) = C(N, k)', db.x - 40, db.y - 14, C.muted, { size: 11, weight: 600 });
  ctx.fillStyle = C.surface2; ctx.fillRect(db.x, db.y, db.w, db.h);
  const lnMax = lnC(N, Math.floor(N / 2));
  const DX = (kk) => db.x + (kk / N) * db.w;
  const bwid = Math.max(1, db.w / (N + 1));
  const step = Math.max(1, Math.floor(N / 300));
  for (let kk = 0; kk <= N; kk += step) {
    const h = Math.exp(lnC(N, kk) - lnMax) * (db.h - 18);
    ctx.fillStyle = kk === k ? C.k : alpha(C.ink, 0.28);
    ctx.fillRect(DX(kk) - bwid / 2, db.y + db.h - h, Math.max(1, bwid - (N <= 50 ? 1 : 0)), h);
  }
  const ck = Math.exp(lnC(N, k) - lnMax) * (db.h - 18);
  dot(ctx, DX(k), db.y + db.h - ck, 4, C.k);
  text(ctx, '0', DX(0), db.y + db.h + 12, C.muted, { size: 10.5, font: 'mono', align: 'center' });
  text(ctx, `${N}`, DX(N), db.y + db.h + 12, C.muted, { size: 10.5, font: 'mono', align: 'center' });
  text(ctx, 'k = Teilchen links', DX(N / 2), db.y + db.h + 12, C.muted, { size: 10.5, font: 'mono', align: 'center' });
}

export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const N = 40, lnMax = lnC(N, 20);
  for (let k = 0; k <= N; k++) { const h = Math.exp(lnC(N, k) - lnMax) * (H - 40); ctx.fillStyle = k === 26 ? C.k : alpha(C.ink, 0.25); ctx.fillRect(20 + (k / N) * (W - 40) - 3, H - 20 - h, 5, h); }
}

const STEPS = [
  { title: 'Alle Teilchen links', set: { N: 10, speed: 2 },
    html: '<p>Zwei Kolben, verbunden durch eine Öffnung. Am Anfang sind alle Teilchen links. Dafür gibt es genau eine Möglichkeit: $W = 1$, also $S = k_B\\ln 1 = 0$.</p><p>In jedem Schritt wandert ein zufällig gewähltes Teilchen durch die Öffnung. Kein Teilchen «will» nach rechts.</p>' },
  { title: 'Zehn Teilchen: 252 Möglichkeiten für 5 : 5', set: { N: 10, speed: 6 },
    html: '<p>Mit $N = 10$ gibt es $\\binom{10}{5} = 252$ Mikrozustände mit fünf Teilchen auf jeder Seite, aber nur einen mit allen links. Rechts unten siehst du $W(k)$ für jedes $k$.</p><p>Bei so wenigen Teilchen schwankt der Anteil stark, und «alle links» kommt immer wieder vor, im Mittel einmal in $2^{10} = 1024$ Schritten.</p>' },
  { title: 'Mehr Teilchen, schmalere Verteilung', set: { N: 100, speed: 20 },
    html: '<p>Bei $N = 100$ ist die Verteilung $W(k)$ schon schmal. Der Anteil links schwankt nur noch wenig um $\\tfrac12$. Die Wahrscheinlichkeit, alle links zu finden, ist $2^{-100} \\approx 10^{-30}$.</p>' },
  { title: 'Bei einem Mol: praktisch nie', set: { N: 1000, speed: 80 },
    html: '<p>Mit $1000$ Teilchen ist die Kurve rechts eine Nadel. Für ein Mol ($6\\cdot 10^{23}$ Teilchen) ist die Chance für «alle auf einer Seite» $(\\tfrac12)^{6\\cdot 10^{23}}$: Sie tritt im Lebensalter des Universums nicht ein.</p><p>Der zweite Hauptsatz ist ein Gesetz der großen Zahlen.</p>' },
  { title: 'S = k ln W', set: { N: 1000, speed: 80 },
    html: '<p>Für die Ausdehnung auf das doppelte Volumen hat jedes Teilchen doppelt so viele Plätze: $W_\\text{end}/W_\\text{anfang} = 2^{N}$. Für ein Mol:</p>$$\\Delta S = k_B \\ln 2^{N_A} = R\\ln 2 = 5.76\\ \\text{J\\,mol}^{-1}\\text{K}^{-1}.$$' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { m: new Model(), speed: 2, acc: 0 };
  S.m.init(10);
  const stage = new Stage(L0.stage, { draw: (ctx, W, H) => draw(ctx, W, H, S) });
  const runner = new Runner({
    stages: [stage],
    update(dt) {
      for (const q of S.m.p) {
        if (q.fly) { q.fly.t += dt * 2.2; if (q.fly.t >= 1) { q.x = q.fly.to[0]; q.y = q.fly.to[1]; q.fly = null; } continue; }
        // gentle Brownian jitter inside the own flask
        const nx = q.x + (Math.random() - 0.5) * 0.03, ny = q.y + (Math.random() - 0.5) * 0.03;
        if (Math.hypot(nx - FC[q.side][0], ny) < FR - 0.05) { q.x = nx; q.y = ny; }
      }
      S.acc += dt * S.speed;
      while (S.acc >= 1) { S.acc -= 1; S.m.event(); }
      upd();
    },
  });
  L0.tslot.append(transport(runner, { onRestart: () => { S.m.init(S.m.N); runner.play(); } }));
  const q = el('p', { class: 'question', html: 'Öffnet man den Hahn zwischen einem vollen und einem leeren Kolben, verteilt sich das Gas. Zurück geht es nie. <b>Warum eigentlich, wenn jedes einzelne Teilchen in beide Richtungen wandern kann?</b>' });
  const nSeg = seg([[10, 'N = 10'], [100, 'N = 100'], [1000, 'N = 1000']], 10, (n) => { S.m.init(n); upd(true); });
  const spSl = slider({ id: 'en-sp', label: 'Tempo', min: 1, max: 200, step: 1, value: S.speed, format: (v) => `${v} Wechsel/s`, onInput: (v) => { S.speed = v; } });
  const ro = readout([['k', 'Teilchen links <span class="var">k</span>'], ['W', 'Mikrozustände <span class="var">W</span>'], ['S', '<span class="var">S</span> / <span class="var">k</span><sub>B</sub> = ln <span class="var">W</span>'], ['Sm', 'größtmöglich'], ['h', '«alle links» erreicht']]);
  let last = 0;
  function upd(force) {
    const now = performance.now(); if (!force && now - last < 120) return; last = now;
    const m = S.m, lw = lnC(m.N, m.k);
    ro.set('k', `${m.k} von ${m.N}`);
    ro.set('W', lw < Math.log(1e9) ? Math.round(Math.exp(lw)).toLocaleString('de-CH') : `≈ 10^${Math.floor(lw / Math.LN10)}`);
    ro.set('S', fmt(lw, 2)); ro.set('Sm', `${fmt(lnC(m.N, Math.floor(m.N / 2)), 2)} (bei ${Math.floor(m.N / 2)} : ${Math.ceil(m.N / 2)})`);
    ro.set('h', `${m.hits} × in ${m.events.toLocaleString('de-CH')} Schritten`);
    stage.invalidate();
  }
  const steps = stepper(STEPS, (st) => { const s = st.set; if (s.N !== S.m.N || st === STEPS[0]) { S.m.init(s.N); nSeg.set(s.N); } S.speed = s.speed; spSl.set(s.speed); upd(true); runner.play(); });
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), nSeg, spSl, ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas', html:
    '$$S = k_B\\ln W,\\qquad \\Delta S = k_B\\ln\\frac{W_\\text{end}}{W_\\text{anfang}}$$<p>Freie Expansion auf das doppelte Volumen</p>$$\\Delta S = R\\ln 2 = 5.76\\ \\text{J\\,mol}^{-1}\\text{K}^{-1}$$' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Das Gas strebt nicht nach Unordnung. Es gibt nur astronomisch viel mehr Mikrozustände mit gleichmäßiger Verteilung, und das System wandert zufällig durch alle. Je mehr Teilchen, desto sicherer findet man es in den häufigsten.' });
  L0.panel.append(q, steps, box, formulas, insight, el('p', { class: 'src', html: 'Skript Chemie, Abschnitt 5.4 (Molekulare Deutung der Entropie, Abb. «Ten molecules» mit 252 Mikrozuständen). Modell: Ehrenfest-Urnenmodell.' }));
  steps.go(0); typeset(L0.panel); runner.play();
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
