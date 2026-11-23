/** Analysis I: sequences, derivatives, complex numbers, integrals, series. */
import { useState, type ReactNode } from 'react';
import {
  altHarmonic, bisection, cabs, carg, cexp, cmul, darboux, ellipse, evolute, roots, seqA, seqN, simpson, taylorRational, taylorSin, type C,
} from '../math/ana';
import { add, ease, mul, seg, TAU, type V2, type V3 } from '../lib/vec';
import { Plate, Seg, useOrbit } from '../ui/Plate';
import { ClipBox, axes2, plotter, sample } from '../ui/plot';
import { Arrow, Dot, Fig, Line, Poly, lab, type Lab } from '../ui/svg';
import { num } from '../ui/Tex';
import { useProj } from '../ui/three';

const W = 960, H = 560;
const t = String.raw;
const Curves = ({ ps, cls = 'ink', w, o, clip }: { ps: V2[][]; cls?: string; w?: number; o?: number; clip?: string }) =>
  <g clipPath={clip ? `url(#${clip})` : undefined}>{ps.map((p, i) => <Poly key={i} p={p} cls={cls} w={w} o={o} />)}</g>;
const loopEase = (time: number, a: number, b: number) => ease(seg(time, a, b));

/* ================================================================== 1 sequences, series, functions */

export function EpsSchlauch() {
  return (
    <Plate id="grenzwert" num="1.1" title="Grenzwert einer Folge" still={8} period={11.5}
      formula={t`|a_n - L| < \varepsilon \quad\text{für alle } n \ge N(\varepsilon)`}
      note="Wie schmal der Schlauch auch wird: Ab einem Index N bleiben alle Glieder darin.">
      {(time) => <EpsFig time={time} />}
    </Plate>
  );
}
function EpsFig({ time }: { time: number }) {
  const P = plotter({ x0: 0, x1: 41, y0: -0.35, y1: 1.85 }, { l: 70, t: 36, r: 880, b: 512 });
  const eps = 0.55 * Math.pow(0.075 / 0.55, loopEase(time, 0.8, 9));
  const N = seqN(eps);
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xt: [1, 5, 10, 15, 20, 25, 30, 35, 40], yt: [0, 0.5, 1, 1.5], xl: 'n' });
  const band = [P.X([0.4, 1 + eps]), P.X([41, 1 + eps]), P.X([41, 1 - eps]), P.X([0.4, 1 - eps])];
  labels.push(lab(P.X([41, 1 + eps]), t`L+\varepsilon`, 'r', 'v'), lab(P.X([41, 1 - eps]), t`L-\varepsilon`, 'r', 'v'),
    lab(P.X([41, 1]), 'L', 'r', 'ink'), lab(P.X([N, 1.85]), 'N', 't', 'k'));
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\varepsilon = ${num(eps, 3)},\quad N = ${N}`}>
      {ax}
      <Poly p={band} closed cls="wash-v" />
      <Line a={band[0]} b={band[1]} cls="v" w={1} /><Line a={band[3]} b={band[2]} cls="v" w={1} />
      <Line a={P.X([0.4, 1])} b={P.X([41, 1])} cls="guide" />
      <Line a={P.X([N, -0.35])} b={P.X([N, 1.85])} cls="k" w={1.2} />
      {Array.from({ length: 40 }, (_, i) => i + 1).map((n) => {
        const p = P.X([n, seqA(n)]), inside = n >= N;
        return <g key={n}>
          <Line a={P.X([n, 1])} b={p} cls="faint" />
          <Dot p={p} r={inside ? 3.6 : 3.2} c={inside ? 'v' : 'g'} />
        </g>;
      })}
    </Fig>
  );
}

export function GeoReihe() {
  return (
    <Plate id="geometrische-reihe" num="1.2" title="Geometrische Reihe" still={11} period={13}
      formula={t`\sum_{k=1}^{n}\Bigl(\tfrac12\Bigr)^{k} = 1-\Bigl(\tfrac12\Bigr)^{n}\;\xrightarrow{\;n\to\infty\;}\;1,\qquad \sum_{k=0}^{\infty} q^k = \frac{1}{1-q}\ \ (|q|<1)`}
      note="Jeder Summand füllt die Hälfte des Rests. Das Quadrat wird nie überschritten.">
      {(time) => <GeoFig time={time} />}
    </Plate>
  );
}
function GeoFig({ time }: { time: number }) {
  const n = Math.min(14, Math.floor(seg(time, 0.4, 10.2) * 14) + 1);
  const fresh = seg(time, 0.4, 10.2) * 14 - (n - 1);
  const L = 400, x0 = 96, y0 = 80;
  let r = { x: 0, y: 0, w: 1, h: 1 };
  const tiles: { x: number; y: number; w: number; h: number; k: number }[] = [];
  for (let k = 1; k <= 14; k++) {
    if (k % 2) { tiles.push({ ...r, w: r.w / 2, k }); r = { ...r, x: r.x + r.w / 2, w: r.w / 2 }; }
    else { tiles.push({ ...r, y: r.y + r.h / 2, h: r.h / 2, k }); r = { ...r, h: r.h / 2 }; }
  }
  const S = 1 - 0.5 ** n;
  const bx0 = 600, bx1 = 900, by = 280;
  const labels: Lab[] = [
    lab([bx0, by + 16], '0', 'b', 'g'), lab([bx1, by + 16], '1', 'b', 'g'),
    lab([bx0 + (bx1 - bx0) * S, by - 22], t`S_{${n}}`, 't', 'v'),
  ];
  tiles.slice(0, 5).forEach((tl) => { if (tl.k <= n) labels.push({ x: x0 + (tl.x + tl.w / 2) * L, y: y0 + (tl.y + tl.h / 2) * L, tex: t`\tfrac{1}{${2 ** tl.k}}`, pos: 'c', c: 'ink', size: tl.k < 3 ? 'l' : tl.k < 5 ? 'm' : 's', o: tl.k === n ? ease(fresh) : 1 }); });
  let acc = 0;
  return (
    <Fig w={W} h={H} labels={labels} readout={t`S_{${n}} = 1 - 2^{-${n}} = ${num(S, 5)}`}>
      <rect x={x0} y={y0} width={L} height={L} className="ln faint" />
      {tiles.filter((tl) => tl.k <= n).map((tl) => (
        <rect key={tl.k} x={x0 + tl.x * L + 1.5} y={y0 + tl.y * L + 1.5} width={Math.max(0, tl.w * L - 3)} height={Math.max(0, tl.h * L - 3)}
          className="tile" style={{ fillOpacity: (0.62 - 0.035 * tl.k) * (tl.k === n ? ease(fresh) : 1) }} />
      ))}
      <Line a={[bx0, by]} b={[bx1, by]} cls="thin" />
      {[0, 0.5, 0.75, 0.875, 1].map((x) => <Line key={x} a={[bx0 + (bx1 - bx0) * x, by - 5]} b={[bx0 + (bx1 - bx0) * x, by + 5]} cls="thin" />)}
      {tiles.filter((tl) => tl.k <= n).map((tl) => {
        const a = acc; acc += 0.5 ** tl.k;
        return <rect key={'b' + tl.k} x={bx0 + (bx1 - bx0) * a + 0.6} y={by - 10} width={Math.max(0, (bx1 - bx0) * 0.5 ** tl.k - 1.2)} height={20}
          className="tile" style={{ fillOpacity: (0.62 - 0.035 * tl.k) * (tl.k === n ? ease(fresh) : 1) }} />;
      })}
      <Line a={[bx0 + (bx1 - bx0) * S, by - 18]} b={[bx0 + (bx1 - bx0) * S, by + 18]} cls="v" w={1.6} />
    </Fig>
  );
}

const fBis = (x: number) => x ** 3 - x - 1;
const BIS = bisection(fBis, 0, 2, 22);
export function Bisektion() {
  return (
    <Plate id="zwischenwertsatz" num="1.3" title="Zwischenwertsatz und Bisektion" still={12} period={21}
      formula={t`f(a)<0<f(b) \;\Longrightarrow\; \exists\,\xi\in(a,b):\ f(\xi)=0`}
      note="Halbieren, Vorzeichen prüfen, weiter. Die Ansicht zoomt mit: Jeder Schritt verdoppelt die Vergrösserung.">
      {(time) => <BisFig time={time} />}
    </Plate>
  );
}
function BisFig({ time }: { time: number }) {
  const per = 1.25, kf = Math.min(16, Math.max(0, (time - 0.8) / per));
  const k = Math.floor(kf), fr = ease(Math.min(1, (kf - k) / 0.55));
  // window around bracket j: wide enough for [a, b], tall enough for f(a) and f(b)
  const win = (j: number) => {
    const [a, b] = BIS[j], hw = 0.95 * (b - a);
    return { c: (a + b) / 2, hw, yh: 1.25 * Math.max(Math.abs(fBis(a)), Math.abs(fBis(b)), 2.4 * hw) };
  };
  const w0 = win(k), w1 = win(Math.min(16, k + 1));
  const lg = (p: number, q: number) => Math.exp(Math.log(p) + (Math.log(q) - Math.log(p)) * fr);
  const c = w0.c + (w1.c - w0.c) * fr, hw = lg(w0.hw, w1.hw), yh = lg(w0.yh, w1.yh);
  const box = { l: 70, t: 36, r: 900, b: 512 };
  const P = plotter({ x0: c - hw, x1: c + hw, y0: -yh, y1: yh }, box);
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xl: 'x', yl: 'y', yt: false });
  const [a, b] = BIS[Math.min(16, k + (fr > 0.99 ? 1 : 0))];
  const m = (a + b) / 2;
  const A = P.X([a, 0]), B = P.X([b, 0]);
  labels.push(lab(P.X([a, fBis(a)]), 'f(a)', 'l', 'f'), lab(P.X([b, fBis(b)]), 'f(b)', 'r', 'v'));
  return (
    <Fig w={W} h={H} labels={labels} readout={t`k = ${Math.min(16, k + (fr > 0.99 ? 1 : 0))},\quad b-a = 2^{${1 - Math.min(16, k + (fr > 0.99 ? 1 : 0))}}`}>
      <ClipBox id="bis-clip" box={box} />
      {ax}
      <g clipPath="url(#bis-clip)">
        <Line a={A} b={P.X([a, fBis(a)])} cls="guide" /><Line a={B} b={P.X([b, fBis(b)])} cls="guide" />
        <Curves ps={sample(P, fBis, c - hw * 1.05, c + hw * 1.05, 300)} w={2} />
        <Line a={A} b={B} cls="k" w={5} />
        <Line a={P.X([m, 0])} b={[P.X([m, 0])[0], P.X([m, 0])[1] - 12]} cls="k" w={1.4} />
        <Dot p={P.X([a, fBis(a)])} r={4} c="f" /><Dot p={P.X([b, fBis(b)])} r={4} c="v" />
      </g>
    </Fig>
  );
}

export function Umkehr() {
  return (
    <Plate id="umkehrfunktion" num="1.4" title="Umkehrfunktion" still={5} period={10}
      formula={t`y = f(x) \iff x = f^{-1}(y)`}
      note="Der Graph von f wird an der Winkelhalbierenden y = x umgeklappt. So entsteht ln aus exp.">
      {(time) => <UmkehrFig time={time} />}
    </Plate>
  );
}
function UmkehrFig({ time }: { time: number }) {
  const box = { l: 230, t: 30, r: 730, b: 530 };
  const P = plotter({ x0: -3, x1: 4.4, y0: -3, y1: 4.4 }, box);
  const s = loopEase(time, 1.2, 3.8) - loopEase(time, 6.4, 9);
  const cs = Math.cos(Math.PI * s);
  const fold = (p: V2): V2 => { const u = (p[0] + p[1]) / 2, d = (p[0] - p[1]) / 2; return [u + d * cs, u - d * cs]; };
  const xs = Array.from({ length: 181 }, (_, i) => -3 + (Math.log(4.4) + 3) * (i / 180));
  const graph = xs.map((x) => [x, Math.exp(x)] as V2);
  const moved = graph.map(fold).map(P.X);
  const p0: V2 = [0.75, Math.exp(0.75)], p1 = fold(p0);
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xl: 'x', yl: 'y', xt: [-2, -1, 1, 2, 3, 4], yt: [-2, -1, 1, 2, 3, 4] });
  labels.push(lab(P.X([3.9, 3.9]), 'y = x', 'tl', 'g'), lab(P.X([1.2, Math.exp(1.2)]), t`f = \exp`, 'l', 'ink'),
    lab(P.X([4.1, Math.log(4.1)]), t`f^{-1} = \ln`, 'b', 'v', seg(s, 0.9, 1)));
  return (
    <Fig w={W} h={H} labels={labels}>
      <ClipBox id="inv-clip" box={box} />
      {ax}
      <g clipPath="url(#inv-clip)">
        <Line a={P.X([-3, -3])} b={P.X([4.4, 4.4])} cls="guide" />
        <Poly p={graph.map(P.X)} cls="ink" w={2} />
        <Line a={P.X(p0)} b={P.X([p0[1], p0[0]])} cls="faint" />
        <Poly p={moved} cls="v" w={2.4} o={s > 0.002 ? 1 : 0} />
        <Dot p={P.X(p0)} r={3.8} />
        <Dot p={P.X(p1)} r={3.8} c="v" o={s > 0.002 ? 1 : 0} />
      </g>
    </Fig>
  );
}

/* ================================================================== 2 differential calculus */

const fD = (x: number) => 0.1 * x ** 3 - 0.6 * x ** 2 + 0.5 * x + 2.5;
const fD1 = (x: number) => 0.3 * x ** 2 - 1.2 * x + 0.5;

export function Differenzenquotient() {
  return (
    <Plate id="ableitung" num="2.1" title="Vom Differenzenquotienten zur Ableitung" still={8} period={11}
      formula={t`f'(x_0) = \lim_{h\to 0}\frac{f(x_0+h)-f(x_0)}{h}`}
      note="Q rückt an P heran. Aus der Sekante wird die Tangente, aus Δy/Δx die Steigung f′(x₀).">
      {(time) => <DQFig time={time} />}
    </Plate>
  );
}
function DQFig({ time }: { time: number }) {
  const box = { l: 70, t: 30, r: 900, b: 520 };
  const P = plotter({ x0: -1.6, x1: 6.3, y0: -0.4, y1: 7.4 }, box);
  const x0 = 1.15, h = 3.6 * Math.pow(0.001 / 3.6, loopEase(time, 0.8, 8.4));
  const pP: V2 = [x0, fD(x0)], pQ: V2 = [x0 + h, fD(x0 + h)];
  const m = (pQ[1] - pP[1]) / h, k = fD1(x0);
  const line = (sl: number) => [P.X([-1.6, pP[1] + sl * (-1.6 - x0)]), P.X([6.3, pP[1] + sl * (6.3 - x0)])];
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xl: 'x', yl: 'y', xt: [x0], yt: false, xFmt: () => 'x_0' });
  const big = h > 0.35;
  labels.push(lab(P.X(pP), 'P', 'tl'), lab(P.X(pQ), 'Q', 'br', 'ink', big ? 1 : 0),
    lab(P.X([x0 + h / 2, pP[1]]), t`\Delta x = h`, 't', 'k', big ? 1 : 0), lab(P.X([x0 + h, (pP[1] + pQ[1]) / 2]), t`\Delta y`, 'r', 'k', big ? 1 : 0),
    lab(P.X([5.6, fD(5.6)]), 'f', 'r'));
  const tg = 1 - seg(h, 0.02, 0.6);
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\frac{\Delta y}{\Delta x} = ${num(m, 4)}\qquad f'(x_0) = ${num(k, 4)}`}>
      <ClipBox id="dq-clip" box={box} />
      {ax}
      <g clipPath="url(#dq-clip)">
        <Line a={P.X([x0, 0])} b={P.X(pP)} cls="faint" />
        <Line a={line(k)[0]} b={line(k)[1]} cls="v" w={1.6} o={0.25 + 0.75 * tg} />
        <Line a={line(m)[0]} b={line(m)[1]} cls="k" w={1.6} o={1 - 0.6 * tg} />
        <Curves ps={sample(P, fD, -1.6, 6.3)} w={2.2} />
        <Poly p={[P.X(pP), P.X([x0 + h, pP[1]]), P.X(pQ)]} cls="k" w={1.2} o={big ? 1 : seg(h, 0.05, 0.35)} />
        <Dot p={P.X(pQ)} r={3.8} c="k" />
        <Dot p={P.X(pP)} r={4.2} />
      </g>
    </Fig>
  );
}

const fA = (x: number) => 1.2 * Math.sin(0.9 * x) + 0.15 * x;
const fA1 = (x: number) => 1.08 * Math.cos(0.9 * x) + 0.15;
export function Ableitungsfunktion() {
  return (
    <Plate id="ableitungsfunktion" num="2.2" title="Die Ableitung als Funktion" still={6.5} period={12}
      formula={t`x \;\longmapsto\; f'(x) = \text{Steigung der Tangente an der Stelle } x`}
      note="Wo f einen Hoch- oder Tiefpunkt hat, geht f′ durch null.">
      {(time) => <AbFig time={time} />}
    </Plate>
  );
}
function AbFig({ time }: { time: number }) {
  const top = { l: 70, t: 24, r: 900, b: 268 }, bot = { l: 70, t: 306, r: 900, b: 536 };
  const Pt = plotter({ x0: -0.3, x1: 10.3, y0: -1.3, y1: 2.9 }, top);
  const Pb = plotter({ x0: -0.3, x1: 10.3, y0: -1.35, y1: 1.35 }, bot);
  const x = 0.05 + 10 * loopEase(time, 0.6, 10.4);
  const labels: Lab[] = [];
  const at = axes2(Pt, labels, { xt: [2, 4, 6, 8, 10], yt: false });
  const ab = axes2(Pb, labels, { xt: false, yt: [-1, 1] });
  const k = fA1(x), p: V2 = [x, fA(x)];
  const d = 0.9 / Math.hypot(1, k);
  const ext = [0.36, 2.105, 5.85, 9.0].filter((z) => Math.abs(fA1(z)) < 0.2);
  void ext;
  const zeros: number[] = [];
  for (let z = 0; z < 10; z += 0.01) if (fA1(z) * fA1(z + 0.01) < 0) zeros.push(z + 0.005);
  labels.push(lab(Pt.X([10, fA(10)]), 'f', 'r'), lab(Pb.X([10, fA1(10)]), `f'`, 'r', 'v'));
  return (
    <Fig w={W} h={H} labels={labels} readout={t`f'(${num(x, 2)}) = ${num(k, 3)}`}>
      {at}{ab}
      {zeros.map((z) => <Line key={z} a={Pt.X([z, fA(z)])} b={Pb.X([z, 0])} cls="faint" />)}
      <Line a={Pt.X(p)} b={Pb.X([x, k])} cls="guide" />
      <Curves ps={sample(Pt, fA, 0, 10)} w={2.2} />
      <Curves ps={sample(Pb, fA1, 0, 10)} cls="faint" w={1.6} />
      <Curves ps={sample(Pb, fA1, 0, x, Math.max(2, Math.round(x * 40)))} cls="v" w={2.2} />
      <Line a={Pt.X([x - d, p[1] - d * k])} b={Pt.X([x + d, p[1] + d * k])} cls="v" w={2.4} />
      {zeros.map((z) => <Dot key={'z' + z} p={Pb.X([z, 0])} r={3} c="g" />)}
      <Dot p={Pt.X(p)} r={4.2} /><Dot p={Pb.X([x, k])} r={4.2} c="v" />
    </Fig>
  );
}

export function Mittelwertsatz() {
  return (
    <Plate id="mittelwertsatz" num="2.3" title="Mittelwertsatz" still={5} period={8.5}
      formula={t`\exists\,\xi\in(a,b):\quad f'(\xi) = \frac{f(b)-f(a)}{b-a}`}
      note="Die Sekante wird parallel verschoben, bis sie die Kurve nur noch berührt.">
      {(time) => <MWSFig time={time} />}
    </Plate>
  );
}
function MWSFig({ time }: { time: number }) {
  const box = { l: 70, t: 30, r: 900, b: 520 };
  const P = plotter({ x0: -0.4, x1: 6.4, y0: -0.4, y1: 5 }, box);
  const a = 0.5, b = 5.5, m = (fD(b) - fD(a)) / (b - a);
  const xi = (1.2 + Math.sqrt(1.44 - 4 * 0.3 * (0.5 - m))) / 0.6;
  const off = fD(xi) - (fD(a) + m * (xi - a));
  const s = loopEase(time, 1.2, 4.2) - loopEase(time, 7.4, 8.4);
  const yl = (x: number) => fD(a) + m * (x - a) + off * s;
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xt: [a, xi, b], yt: false, xFmt: (x) => (x === a ? 'a' : x === b ? 'b' : t`\xi`) });
  labels.push(lab(P.X([a, fD(a)]), 'A', 'tl'), lab(P.X([b, fD(b)]), 'B', 'tr'), lab(P.X([6.1, fD(6.1)]), 'f', 'r'));
  return (
    <Fig w={W} h={H} labels={labels}>
      <ClipBox id="mws-clip" box={box} />
      {ax}
      <g clipPath="url(#mws-clip)">
        <Line a={P.X([a, 0])} b={P.X([a, fD(a)])} cls="faint" /><Line a={P.X([b, 0])} b={P.X([b, fD(b)])} cls="faint" />
        <Line a={P.X([xi, 0])} b={P.X([xi, fD(xi)])} cls="guide" o={seg(s, 0.8, 1)} />
        <Line a={P.X([-0.4, fD(a) + m * (-0.4 - a)])} b={P.X([6.4, fD(a) + m * (6.4 - a)])} cls="k" w={1.4} />
        <Curves ps={sample(P, fD, -0.4, 6.4)} w={2.2} />
        <Line a={P.X([-0.4, yl(-0.4)])} b={P.X([6.4, yl(6.4)])} cls="v" w={2} o={s > 0.01 ? 1 : 0} />
        <Dot p={P.X([a, fD(a)])} r={4} /><Dot p={P.X([b, fD(b)])} r={4} />
        <Dot p={P.X([xi, fD(xi)])} r={4.4} c="v" o={seg(s, 0.9, 1)} />
      </g>
    </Fig>
  );
}

export function Kruemmung() {
  return (
    <Plate id="kruemmungskreis" num="2.4" title="Krümmungskreis und Evolute" still={4.1} period={TAU / 0.34}
      formula={t`\kappa = \frac{\dot x\,\ddot y-\dot y\,\ddot x}{\bigl(\dot x^2+\dot y^2\bigr)^{3/2}},\qquad \rho = \frac1\kappa`}
      note="Der Mittelpunkt des Krümmungskreises läuft auf der Evolute. Wo die Ellipse am flachsten ist, ist der Kreis am grössten.">
      {(time) => <KrFig time={time} />}
    </Plate>
  );
}
function KrFig({ time }: { time: number }) {
  const box = { l: 190, t: 20, r: 770, b: 540 };
  const P = plotter({ x0: -4.4, x1: 4.4, y0: -3.95, y1: 3.95 }, box);
  const A = 3, B = 2.1, tt = 0.34 * time + 0.35;
  const e = ellipse(A, B, tt);
  const ell = Array.from({ length: 181 }, (_, i) => P.X([A * Math.cos((i / 180) * TAU), B * Math.sin((i / 180) * TAU)]));
  const evo = Array.from({ length: 241 }, (_, i) => P.X(evolute(A, B, (i / 240) * TAU)));
  const done = Array.from({ length: 121 }, (_, i) => P.X(evolute(A, B, 0.35 + ((tt - 0.35) % TAU) * (i / 120))));
  const circ = Array.from({ length: 145 }, (_, i) => P.X(add(e.C, [e.rho * Math.cos((i / 144) * TAU), e.rho * Math.sin((i / 144) * TAU)])));
  const labels: Lab[] = [lab(P.X(e.P), t`\v r(t)`, 'r'), lab(P.X(e.C), 'M', 'l', 'k')];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\kappa = ${num(e.kappa, 3)},\quad \rho = ${num(e.rho, 3)}`}>
      <ClipBox id="kr-clip" box={{ l: 0, t: 0, r: W, b: H }} />
      <Line a={P.X([-4.4, 0])} b={P.X([4.4, 0])} cls="faint" /><Line a={P.X([0, -3.95])} b={P.X([0, 3.95])} cls="faint" />
      <Poly p={evo} cls="guide" />
      <Poly p={done} cls="k" w={1.8} />
      <g clipPath="url(#kr-clip)"><Poly p={circ} cls="v" w={1.4} /></g>
      <Line a={P.X(e.P)} b={P.X(e.C)} cls="thin" o={0.6} />
      <Poly p={ell} cls="ink" w={2.4} />
      <Dot p={P.X(e.C)} r={4} c="k" /><Dot p={P.X(e.P)} r={4.4} />
    </Fig>
  );
}

/* ================================================================== 3 complex numbers */

export function Euler() {
  return (
    <Plate id="eulerformel" num="3.1" title="Eulerformel" still={2.2} period={TAU / 0.8}
      formula={t`e^{i\varphi} = \cos\varphi + i\,\sin\varphi`}>
      {(time) => <EulerFig phi={0.8 * time} />}
    </Plate>
  );
}
function EulerFig({ phi }: { phi: number }) {
  const R = 150, O: V2 = [235, 280];
  const Z = (z: C): V2 => [O[0] + R * z[0], O[1] - R * z[1]];
  const ph = ((phi % TAU) + TAU) % TAU;
  const z = cexp(1, ph), Pz = Z(z);
  const wx0 = 450, wx1 = 915, wx = (p: number) => wx0 + ((wx1 - wx0) * p) / TAU;
  const wave = (f: (p: number) => number, upto: number) => Array.from({ length: 121 }, (_, i) => { const p = (upto * i) / 120; return [wx(p), O[1] - R * f(p)] as V2; });
  const labels: Lab[] = [
    lab(Z([1.3, 0]), t`\mathrm{Re}`, 'b', 'g'), lab(Z([0, 1.25]), t`\mathrm{Im}`, 't', 'g'),
    lab(Pz, t`e^{i\varphi}`, z[0] >= 0 ? 'tr' : 'tl'), lab(Z([z[0] / 2, 0]), t`\cos\varphi`, z[1] >= 0 ? 'b' : 't', 'v'),
    lab(Z([z[0], z[1] / 2]), t`\sin\varphi`, z[0] >= 0 ? 'r' : 'l', 'f'), lab(Z(cexp(0.32, ph / 2)), t`\varphi`, 'c', 'k'),
    lab([wx1 + 6, O[1]], t`\varphi`, 'r', 'g'),
    ...[1, 2, 3, 4].map((k) => lab([wx((k * Math.PI) / 2), O[1] + 8], ['\\tfrac{\\pi}{2}', '\\pi', '\\tfrac{3\\pi}{2}', '2\\pi'][k - 1], 'b', 'g')),
  ];
  const arc: V2[] = Array.from({ length: 30 }, (_, i) => Z(cexp(0.2, (ph * i) / 29)));
  return (
    <Fig w={W} h={H} labels={labels}>
      <Line a={Z([-1.3, 0])} b={Z([1.3, 0])} cls="faint" /><Line a={Z([0, -1.25])} b={Z([0, 1.25])} cls="faint" />
      <circle cx={O[0]} cy={O[1]} r={R} className="ln thin" />
      <Line a={[wx0, O[1]]} b={[wx1, O[1]]} cls="faint" />
      {[1, 2, 3, 4].map((k) => <Line key={k} a={[wx((k * Math.PI) / 2), O[1] - 4]} b={[wx((k * Math.PI) / 2), O[1] + 4]} cls="thin" />)}
      <Poly p={wave(Math.sin, TAU)} cls="faint" w={1.4} /><Poly p={wave(Math.cos, TAU)} cls="faint" w={1.4} />
      <Poly p={wave(Math.cos, ph)} cls="v" w={2} />
      <Poly p={wave(Math.sin, ph)} cls="f" w={2.2} />
      <Line a={Pz} b={[wx(ph), Pz[1]]} cls="guide" />
      <Poly p={arc} cls="k" w={1.4} />
      <Line a={O} b={Pz} cls="ink" w={1.6} />
      <Line a={O} b={Z([z[0], 0])} cls="v" w={4} />
      <Line a={Z([z[0], 0])} b={Pz} cls="f" w={4} />
      <Dot p={[wx(ph), Pz[1]]} r={4} c="f" /><Dot p={[wx(ph), O[1] - R * z[0]]} r={3.4} c="v" />
      <Dot p={Pz} r={4.4} />
    </Fig>
  );
}

export function KMult() {
  return (
    <Plate id="multiplikation" num="3.2" title="Multiplizieren heisst drehstrecken" still={3} period={12}
      formula={t`z\,w = r_z\,r_w\;e^{i(\varphi_z+\varphi_w)}`}
      note="Das Dreieck 0, 1, w und das Dreieck 0, z, zw sind ähnlich: Mal z dreht um φ_z und streckt mit r_z.">
      {(time) => <MultFig time={time} />}
    </Plate>
  );
}
function MultFig({ time }: { time: number }) {
  const box = { l: 100, t: 30, r: 860, b: 530 };
  const P = plotter({ x0: -1.7, x1: 2.69, y0: -0.6, y1: 2.29 }, box);
  const z = cexp(1.32, 0.46);
  const th = 0.35 + 1.15 * (0.5 - 0.5 * Math.cos((TAU * time) / 12)), rw = 1.0 + 0.28 * Math.sin((TAU * time) / 6);
  const w = cexp(rw, th), zw = cmul(z, w);
  const O = P.X([0, 0]);
  const arcPts = (r: number, a0: number, a1: number) => Array.from({ length: 24 }, (_, i) => P.X(cexp(r, a0 + ((a1 - a0) * i) / 23)));
  const labels: Lab[] = [
    lab(P.X(z), 'z', 'r', 'v'), lab(P.X(w), 'w', 'l', 'm'), lab(P.X(zw), 'zw', 'tr', 'k'), lab(P.X([1, 0]), '1', 'b', 'g'),
    lab(P.X([2.55, 0]), t`\mathrm{Re}`, 'r', 'g'), lab(P.X([0, 2.2]), t`\mathrm{Im}`, 'r', 'g'),
  ];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`|zw| = ${num(cabs(z), 2)}\cdot${num(rw, 2)} = ${num(cabs(zw), 2)}`}>
      <Line a={P.X([-1.7, 0])} b={P.X([2.6, 0])} cls="faint" /><Line a={P.X([0, -0.6])} b={P.X([0, 2.2])} cls="faint" />
      <Poly p={[O, P.X([1, 0]), P.X(w)]} closed cls="wash-m" />
      <Poly p={[O, P.X(z), P.X(zw)]} closed cls="wash-k" />
      <Line a={P.X([1, 0])} b={P.X(w)} cls="m" w={1} o={0.7} />
      <Line a={P.X(z)} b={P.X(zw)} cls="k" w={1} o={0.7} />
      <Poly p={arcPts(0.36, 0, carg(z))} cls="v" w={1.6} />
      <Poly p={arcPts(0.5, 0, carg(w) < 0 ? carg(w) + TAU : carg(w))} cls="m" w={1.6} />
      <Poly p={arcPts(0.64, 0, carg(z) + th)} cls="k" w={1.6} />
      <Arrow a={O} b={P.X([1, 0])} c="g" w={1.4} />
      <Arrow a={O} b={P.X(z)} c="v" w={2.2} />
      <Arrow a={O} b={P.X(w)} c="m" w={2.2} />
      <Arrow a={O} b={P.X(zw)} c="k" w={2.6} head={13} />
    </Fig>
  );
}

export function Wurzeln() {
  const [n, setN] = useState('5');
  return (
    <Plate id="wurzeln" num="3.3" title="Die n-ten Wurzeln" still={3} period={TAU / 0.3}
      formula={t`w_k = \sqrt[n]{r}\;e^{\,i(\varphi+2\pi k)/n},\qquad k = 0,1,\dots,n-1`}
      note="Dreht sich z einmal ganz herum, rückt das Vieleck der Wurzeln nur um eine Ecke weiter."
      controls={<Seg label="n" value={n} onChange={setN} options={['2', '3', '4', '5', '6', '7'].map((v) => ({ v, l: '$n = ' + v }))} />}>
      {(time) => <WurzelFig phi={0.3 * time + 0.6} n={+n} />}
    </Plate>
  );
}
function WurzelFig({ phi, n }: { phi: number; n: number }) {
  const box = { l: 230, t: 30, r: 730, b: 530 };
  const P = plotter({ x0: -2.25, x1: 2.25, y0: -2.25, y1: 2.25 }, box);
  const r = 1.95, z = cexp(r, phi), ws = roots(z, n), rr = Math.pow(r, 1 / n);
  const O = P.X([0, 0]);
  const circ = (q: number) => Array.from({ length: 121 }, (_, i) => P.X(cexp(q, (i / 120) * TAU)));
  const ph = ((phi % TAU) + TAU) % TAU;
  const labels: Lab[] = [lab(P.X(z), 'z', 'tr'), ...ws.map((w, k) => lab(P.X(mul(w, 1.16)), t`w_{${k}}`, 'c', 'v')),
    lab(P.X([2.2, 0]), t`\mathrm{Re}`, 'b', 'g'), lab(P.X([0, 2.2]), t`\mathrm{Im}`, 'r', 'g')];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\varphi = ${num(ph, 2)},\quad \varphi/n = ${num(ph / n, 2)}`}>
      <Line a={P.X([-2.25, 0])} b={P.X([2.25, 0])} cls="faint" /><Line a={P.X([0, -2.25])} b={P.X([0, 2.25])} cls="faint" />
      <Poly p={circ(r)} cls="faint" />
      <Poly p={circ(rr)} cls="guide" />
      <Poly p={ws.map(P.X)} closed cls="wash-v" />
      <Poly p={ws.map(P.X)} closed cls="v" w={1.4} />
      <Poly p={Array.from({ length: 30 }, (_, i) => P.X(cexp(0.42, (ph * i) / 29)))} cls="thin" w={1.2} />
      <Poly p={Array.from({ length: 20 }, (_, i) => P.X(cexp(0.62, (ph / n) * (i / 19))))} cls="v" w={1.8} />
      <Line a={O} b={P.X(z)} cls="ink" w={1.6} />
      {ws.map((w, k) => <Line key={k} a={O} b={P.X(w)} cls="v" w={k === 0 ? 1.8 : 0.9} o={k === 0 ? 1 : 0.5} />)}
      {ws.map((w, k) => <Dot key={'d' + k} p={P.X(w)} r={k === 0 ? 5 : 4.2} c="v" />)}
      <Dot p={P.X(z)} r={4.6} />
    </Fig>
  );
}

/* ================================================================== 4 integral calculus */

const fR = (x: number) => 1 + 0.6 * Math.sin(1.3 * x) + 0.05 * x * x;
const I_R = simpson(fR, 0, 6);
export function Riemann() {
  return (
    <Plate id="riemann" num="4.1" title="Fläche als Grenzwert" still={9.5} period={11}
      formula={t`\underline S_n \;\le\; \int_a^b f(x)\,\mathrm dx \;\le\; \overline S_n,\qquad \overline S_n-\underline S_n \xrightarrow{\;n\to\infty\;} 0`}
      note="Grün: Untersumme. Darüber, hell: was die Obersumme zu viel zählt. Es schrumpft gegen null.">
      {(time) => <RiemannFig time={time} />}
    </Plate>
  );
}
function RiemannFig({ time }: { time: number }) {
  const box = { l: 70, t: 30, r: 900, b: 510 };
  const P = plotter({ x0: -0.35, x1: 6.5, y0: -0.25, y1: 4.1 }, box);
  const ns = [2, 4, 8, 16, 32, 64, 128];
  const n = ns[Math.min(6, Math.floor(seg(time, 0.3, 9.2) * 7))];
  const d = darboux(fR, 0, 6, n);
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xt: [0, 6], yt: [1, 2, 3], skipZero: false, xFmt: (x) => (x === 0 ? 'a' : 'b') });
  labels.push(lab(P.X([6.2, fR(6.2)]), 'f', 'r'));
  const thin = n >= 64;
  return (
    <Fig w={W} h={H} labels={labels} readout={t`n = ${n}:\ \ ${num(d.lo, 3)} \le ${num(I_R, 3)} \le ${num(d.up, 3)}`}>
      {ax}
      {d.parts.map((p, i) => {
        const a = P.X([p.x0, 0]), b = P.X([p.x1, p.m]), c = P.X([p.x1, p.M]);
        return <g key={n + '-' + i}>
          <rect x={a[0]} y={b[1]} width={b[0] - a[0]} height={a[1] - b[1]} className="ln wash-m" style={{ stroke: thin ? 'none' : 'var(--m)', strokeWidth: 0.8 }} />
          <rect x={a[0]} y={c[1]} width={b[0] - a[0]} height={b[1] - c[1]} className="ln wash-k" style={{ stroke: thin ? 'none' : 'var(--k)', strokeWidth: 0.6, strokeOpacity: 0.5 }} />
        </g>;
      })}
      <Curves ps={sample(P, fR, -0.2, 6.4)} w={2.2} />
    </Fig>
  );
}

const fH = (x: number) => 0.9 * Math.sin(0.9 * x) + 0.25;
const FH = (x: number) => 1 - Math.cos(0.9 * x) + 0.25 * x;
export function Hauptsatz() {
  return (
    <Plate id="hauptsatz" num="4.2" title="Hauptsatz der Differential- und Integralrechnung" still={6} period={12}
      formula={t`F(x) = \int_a^x f(t)\,\mathrm dt \quad\Longrightarrow\quad F'(x) = f(x)`}
      note="Oben wächst die Fläche, unten ihr Wert. Die Höhe f(x) wird zur Steigung von F.">
      {(time) => <HSFig time={time} />}
    </Plate>
  );
}
function HSFig({ time }: { time: number }) {
  const top = { l: 70, t: 24, r: 900, b: 250 }, bot = { l: 70, t: 288, r: 900, b: 536 };
  const Pt = plotter({ x0: -0.3, x1: 10.3, y0: -0.85, y1: 1.3 }, top);
  const Pb = plotter({ x0: -0.3, x1: 10.3, y0: -0.2, y1: 4.9 }, bot);
  const x = 0.02 + 9.96 * loopEase(time, 0.6, 10.6);
  const labels: Lab[] = [];
  const at = axes2(Pt, labels, { xt: [0], yt: false, skipZero: false, xFmt: () => 'a' });
  const ab = axes2(Pb, labels, { xt: false, yt: [1, 2, 3, 4] });
  // signed area between f and the axis, one polygon per stretch of constant sign
  const areas: { p: V2[]; pos: boolean }[] = [];
  const N = Math.max(4, Math.round(x * 50));
  let x0s = 0, cur: V2[] = [Pt.X([0, 0])];
  for (let i = 0; i <= N; i++) {
    const xx = (x * i) / N, y = fH(xx);
    if (i > 0) {
      const xp = (x * (i - 1)) / N, yp = fH(xp);
      if (yp * y < 0) {
        const xz = xp + (yp / (yp - y)) * (xx - xp);
        cur.push(Pt.X([xz, 0]));
        areas.push({ p: cur, pos: yp > 0 });
        x0s = xz; cur = [Pt.X([x0s, 0])];
      }
    }
    cur.push(Pt.X([xx, y]));
  }
  cur.push(Pt.X([x, 0]));
  areas.push({ p: cur, pos: fH(x) > 0 });
  const k = fH(x), pB: V2 = [x, FH(x)], d = 0.9 / Math.hypot(1, k * (Pb.sy / Pb.sx));
  labels.push(lab(Pt.X([10.1, fH(10.1)]), 'f', 'r'), lab(Pb.X([10.1, FH(10.1)]), 'F', 'r', 'm'), lab(Pt.X([x, k]), t`f(x)`, k > 0 ? 'tr' : 'br', 'v'));
  return (
    <Fig w={W} h={H} labels={labels} readout={t`F(${num(x, 2)}) = ${num(FH(x), 3)},\quad F' = f = ${num(k, 3)}`}>
      {at}{ab}
      {areas.map((a, i) => <Poly key={i} p={a.p} closed cls={a.pos ? 'wash-m' : 'wash-f'} />)}
      <Curves ps={sample(Pt, fH, 0, 10)} w={2.2} />
      <Line a={Pt.X([x, 0])} b={Pt.X([x, k])} cls="v" w={3} />
      <Line a={Pt.X([x, Math.min(0, k)])} b={Pb.X(pB)} cls="guide" />
      <Curves ps={sample(Pb, FH, 0, 10)} cls="faint" w={1.6} />
      <Curves ps={sample(Pb, FH, 0, x, Math.max(2, Math.round(x * 40)))} cls="m" w={2.4} />
      <Line a={Pb.X([x - d, pB[1] - d * k])} b={Pb.X([x + d, pB[1] + d * k])} cls="v" w={2.4} />
      <Dot p={Pb.X(pB)} r={4.4} c="m" />
    </Fig>
  );
}

const fV = (x: number) => 0.62 + 0.32 * Math.sin(1.3 * x + 0.4) + 0.12 * x;
export function Rotationskoerper() {
  const orbit = useOrbit(-1.22, 0.32);
  return (
    <Plate id="rotationskoerper" num="4.3" title="Rotationskörper" still={9} period={14}
      formula={t`V = \pi\int_a^b f(x)^2\,\mathrm dx`}
      note="Die Kurve dreht sich um die x-Achse. Dann wird der Körper in Scheiben der Dicke dx zerlegt: Jede hat das Volumen π f(x)² dx.">
      {(time) => <RotFig time={time} cam={orbit.cam} bind={orbit.bind} />}
    </Plate>
  );
}
function RotFig({ time, cam, bind }: { time: number; cam: { az: number; el: number }; bind: object }) {
  const { P, depth } = useProj(cam, 480, 300, 112);
  const a = 0, b = 4, cx = 2;
  const sweep = TAU * loopEase(time, 0.5, 4.5);
  const xs = loopEase(time, 5.2, 12.8) * (b - a) + a;
  const showSlice = time > 5 && time < 13.6;
  const pt = (x: number, th: number): V3 => [x - cx, fV(x) * Math.cos(th + Math.PI / 2), fV(x) * Math.sin(th + Math.PI / 2)];
  const front = (q: V3) => depth(q) - depth([q[0], 0, 0]) >= 0;
  const segs: ReactNode[] = [];
  const M = 28;
  for (let j = 0; j < M; j++) {
    const th = (j / M) * TAU;
    if (th > sweep + 1e-9) break;
    const pts = Array.from({ length: 41 }, (_, i) => pt(a + ((b - a) * i) / 40, th));
    const f = front(pts[20]);
    segs.push(<Poly key={'m' + j} p={pts.map(P)} cls={f ? 'thin' : 'faint'} w={f ? 0.9 : 1} o={f ? 0.55 : 1} />);
  }
  const rings = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4];
  rings.forEach((x, k) => {
    const n = Math.max(2, Math.ceil((sweep / TAU) * 60));
    for (let i = 0; i < n; i++) {
      const t0 = (sweep * i) / n, t1 = (sweep * (i + 1)) / n, q0 = pt(x, t0), q1 = pt(x, t1);
      const f = front(pt(x, (t0 + t1) / 2));
      segs.push(<Line key={`r${k}-${i}`} a={P(q0)} b={P(q1)} cls={f ? 'thin' : 'faint'} o={f ? 0.6 : 1} />);
    }
  });
  const curve = Array.from({ length: 81 }, (_, i) => P(pt(a + ((b - a) * i) / 80, sweep)));
  const disc = (x: number) => Array.from({ length: 73 }, (_, i) => P(pt(x, (i / 72) * TAU)));
  const dx = 0.12;
  const V = Math.PI * simpson((x) => fV(x) ** 2, a, xs, 200);
  const labels: Lab[] = [lab(P([b - cx + 0.5, 0, 0]), 'x', 'r', 'g'), lab(P(pt(b, sweep)), t`f(x)`, 'r', 'ink', time < 5 ? 1 : 0)];
  if (showSlice) labels.push(lab(P(pt(xs, 0)), t`\pi f(x)^2\,\mathrm dx`, 't', 'm'));
  return (
    <Fig w={W} h={H} labels={labels} readout={showSlice ? t`V(x) = ${num(V, 3)}` : undefined} {...bind}>
      <Line a={P([a - cx - 0.6, 0, 0])} b={P([b - cx + 0.45, 0, 0])} cls="guide" />
      <Arrow a={P([b - cx + 0.2, 0, 0])} b={P([b - cx + 0.5, 0, 0])} c="g" w={1} head={8} />
      {segs}
      {showSlice && <g>
        <Poly p={disc(xs)} closed cls="wash-m" />
        <Poly p={disc(xs)} cls="m" w={1.6} />
        <Poly p={disc(xs + dx)} cls="m" w={1} o={0.7} />
        <Line a={P([xs - cx, 0, 0])} b={P(pt(xs, 0))} cls="m" w={1.2} />
      </g>}
      <Poly p={curve} cls="ink" w={2.4} />
    </Fig>
  );
}

/* ================================================================== 5 series and Taylor */

const DEG = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23];
export function Taylor() {
  return (
    <Plate id="taylor" num="5.1" title="Taylorpolynome des Sinus" still={11} period={15}
      formula={t`\sin x = \sum_{k=0}^{\infty}\frac{(-1)^k\,x^{2k+1}}{(2k+1)!} = x-\frac{x^3}{3!}+\frac{x^5}{5!}-\dots`}
      note="Jeder weitere Term schmiegt sich auf einem längeren Stück an.">
      {(time) => <TaylorFig time={time} />}
    </Plate>
  );
}
function TaylorFig({ time }: { time: number }) {
  const box = { l: 40, t: 30, r: 920, b: 530 };
  const P = plotter({ x0: -11.2, x1: 11.2, y0: -2.7, y1: 2.7 }, box);
  const j = Math.min(DEG.length - 1, Math.floor(seg(time, 0.3, 13.5) * DEG.length));
  const n = DEG[j];
  const labels: Lab[] = [];
  const ax = axes2(P, labels, {
    xt: [-3, -2, -1, 1, 2, 3].map((k) => k * Math.PI), yt: [-2, -1, 1, 2],
    xFmt: (x) => { const k = Math.round(x / Math.PI); return k === 1 ? '\\pi' : k === -1 ? '-\\pi' : `${k}\\pi`; },
  });
  labels.push(lab(P.X([-10.6, 2.3]), t`T_{${n}}(x)`, 'r', 'v'));
  return (
    <Fig w={W} h={H} labels={labels}>
      <ClipBox id="ty-clip" box={box} />
      {ax}
      <g clipPath="url(#ty-clip)">
        <Curves ps={sample(P, Math.sin, -11.2, 11.2, 500)} w={2.4} />
        {j > 0 && <Curves ps={sample(P, (x) => taylorSin(x, DEG[j - 1]), -11.2, 11.2, 500)} cls="v" w={1.2} o={0.28} />}
        <Curves ps={sample(P, (x) => taylorSin(x, n), -11.2, 11.2, 600)} cls="v" w={2.2} />
      </g>
    </Fig>
  );
}

export function Konvergenzradius() {
  return (
    <Plate id="konvergenzradius" num="5.2" title="Konvergenzradius" still={9} period={13}
      formula={t`\frac{1}{1+x^2} = \sum_{k=0}^{\infty} (-1)^k x^{2k}\qquad (|x|<1)`}
      note="Auf ganz ℝ ist die Funktion glatt. Trotzdem endet die Konvergenz bei |x| = 1: In der komplexen Ebene liegen Pole bei ±i.">
      {(time) => <KRFig time={time} />}
    </Plate>
  );
}
function KRFig({ time }: { time: number }) {
  const box = { l: 60, t: 30, r: 610, b: 520 };
  const P = plotter({ x0: -1.85, x1: 1.85, y0: -0.75, y1: 1.75 }, box);
  const m = 1 + Math.min(13, Math.floor(seg(time, 0.3, 11.5) * 14));
  const f = (x: number) => 1 / (1 + x * x);
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xt: [-1.5, -1, -0.5, 0.5, 1, 1.5], yt: [0.5, 1, 1.5] });
  labels.push(lab(P.X([-1.75, 1.6]), t`T_{${2 * m}}(x)`, 'r', 'v'));
  // complex plane inset
  const cb = { l: 660, t: 150, r: 900, b: 390 };
  const Q = plotter({ x0: -1.6, x1: 1.6, y0: -1.6, y1: 1.6 }, cb);
  const disk = Array.from({ length: 97 }, (_, i) => Q.X(cexp(1, (i / 96) * TAU)));
  labels.push(lab(Q.X([0, 1]), 'i', 'tr', 'f'), lab(Q.X([0, -1]), '-i', 'br', 'f'), lab(Q.X([1.55, 0]), t`\mathrm{Re}`, 'b', 'g'),
    lab(Q.X([0, 1.55]), t`\mathrm{Im}`, 'r', 'g'), lab(Q.X([0, -1.75]), t`\mathbb C`, 'c', 'g'));
  const cross = (p: V2) => [<Line key="a" a={[p[0] - 7, p[1] - 7]} b={[p[0] + 7, p[1] + 7]} cls="f" w={2} />, <Line key="b" a={[p[0] - 7, p[1] + 7]} b={[p[0] + 7, p[1] - 7]} cls="f" w={2} />];
  return (
    <Fig w={W} h={H} labels={labels}>
      <ClipBox id="kr2-clip" box={box} />
      <rect x={P.X([-1, 0])[0]} y={box.t} width={P.X([1, 0])[0] - P.X([-1, 0])[0]} height={box.b - box.t} className="ln wash-m" />
      {ax}
      <g clipPath="url(#kr2-clip)">
        <Line a={P.X([-1, -0.75])} b={P.X([-1, 1.75])} cls="guide" /><Line a={P.X([1, -0.75])} b={P.X([1, 1.75])} cls="guide" />
        <Curves ps={sample(P, f, -1.85, 1.85)} w={2.4} />
        {m > 1 && <Curves ps={sample(P, (x) => taylorRational(x, m - 1), -1.85, 1.85, 600)} cls="v" w={1.2} o={0.28} />}
        <Curves ps={sample(P, (x) => taylorRational(x, m), -1.85, 1.85, 600)} cls="v" w={2.2} />
      </g>
      <Poly p={disk} closed cls="wash-m" /><Poly p={disk} cls="m" w={1.2} />
      <Line a={Q.X([-1.6, 0])} b={Q.X([1.6, 0])} cls="faint" /><Line a={Q.X([0, -1.6])} b={Q.X([0, 1.6])} cls="faint" />
      <Line a={Q.X([-1, 0])} b={Q.X([1, 0])} cls="m" w={3} />
      {cross(Q.X([0, 1]))}{cross(Q.X([0, -1]))}
    </Fig>
  );
}

export function Leibniz() {
  return (
    <Plate id="leibniz" num="5.3" title="Alternierende Reihe" still={9} period={11}
      formula={t`\sum_{k=1}^{\infty}\frac{(-1)^{k+1}}{k} = \ln 2,\qquad |S_n-\ln 2| \le \frac{1}{n+1}`}
      note="Die Partialsummen springen abwechselnd über und unter den Grenzwert. Der Fehler ist kleiner als der nächste Summand.">
      {(time) => <LeibnizFig time={time} />}
    </Plate>
  );
}
function LeibnizFig({ time }: { time: number }) {
  const box = { l: 70, t: 30, r: 880, b: 510 };
  const P = plotter({ x0: 0, x1: 41, y0: 0.38, y1: 1.06 }, box);
  const n = Math.max(1, Math.min(40, Math.floor(seg(time, 0.3, 9) * 40) + 1));
  const pts = Array.from({ length: n }, (_, i) => P.X([i + 1, altHarmonic(i + 1)]));
  const band: V2[] = [];
  for (let k = 1; k <= n; k++) band.push(P.X([k, Math.LN2 + 1 / (k + 1)]));
  for (let k = n; k >= 1; k--) band.push(P.X([k, Math.LN2 - 1 / (k + 1)]));
  const labels: Lab[] = [];
  const ax = axes2(P, labels, { xt: [1, 10, 20, 30, 40], yt: [0.4, 0.6, 0.8, 1], xl: 'n' });
  labels.push(lab(P.X([41, Math.LN2]), t`\ln 2`, 'r', 'ink'), lab(pts[n - 1], t`S_{${n}}`, n % 2 ? 'tr' : 'br', 'v'));
  return (
    <Fig w={W} h={H} labels={labels} readout={t`S_{${n}} = ${num(altHarmonic(n), 4)},\quad \ln 2 = ${num(Math.LN2, 4)}`}>
      <ClipBox id="lb-clip" box={box} />
      {ax}
      <g clipPath="url(#lb-clip)"><Poly p={band} closed cls="wash-v" /></g>
      <Line a={P.X([0.5, Math.LN2])} b={P.X([41, Math.LN2])} cls="guide" />
      <Poly p={pts} cls="v" w={1.3} o={0.7} />
      {pts.map((p, i) => <Dot key={i} p={p} r={3.4} c="v" />)}
    </Fig>
  );
}

