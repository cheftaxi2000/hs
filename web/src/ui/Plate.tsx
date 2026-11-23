import { useEffect, useRef, useState, type PointerEvent as RPE, type ReactNode } from 'react';
import { Tex } from './Tex';

const reducedQ = '(prefers-reduced-motion: reduce)';
const prefersReduced = () => typeof matchMedia !== 'undefined' && matchMedia(reducedQ).matches;

/**
 * One plate: a large figure, its number and name, one formula.
 * The figure is a function of time t (seconds). The clock runs only while the plate is on screen;
 * under prefers-reduced-motion it starts paused on the frame `still`.
 */
export function Plate({ id, num, title, formula, note, controls, still = 0, period, speed = 1, children }: {
  id: string; num: string; title: string; formula: string; note?: ReactNode;
  controls?: ReactNode; still?: number; period?: number; speed?: number;
  children: (t: number) => ReactNode;
}) {
  // Autoplay starts at t = 0; with reduced motion the plate rests on its most telling frame.
  const [t, setT] = useState(() => (prefersReduced() ? still : 0));
  const [playing, setPlaying] = useState(() => !prefersReduced());
  const [visible, setVisible] = useState(false);
  const ref = useRef<HTMLElement>(null);
  const tRef = useRef(t);

  useEffect(() => {
    const el = ref.current;
    if (!el || typeof IntersectionObserver === 'undefined') { setVisible(true); return; }
    const io = new IntersectionObserver(([e]) => setVisible(e.isIntersecting), { rootMargin: '80px 0px' });
    io.observe(el);
    return () => io.disconnect();
  }, []);

  useEffect(() => {
    if (!playing || !visible) return;
    let raf = 0, last = performance.now();
    const tick = (now: number) => {
      const dt = Math.min(now - last, 50) / 1000;
      last = now;
      let nt = tRef.current + dt * speed;
      if (period) nt %= period;
      tRef.current = nt;
      setT(nt);
      raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, [playing, visible, period, speed]);

  return (
    <section className="plate" id={id} ref={ref} aria-labelledby={id + '-h'}>
      <div className="plate-stage">
        {children(t)}
        <div className="plate-ctl">
          <button className="play" onClick={() => setPlaying((p) => !p)} aria-label={playing ? 'Anhalten' : 'Abspielen'}>
            {playing
              ? <svg viewBox="0 0 16 16" aria-hidden="true"><rect x="4" y="3" width="2.6" height="10" /><rect x="9.4" y="3" width="2.6" height="10" /></svg>
              : <svg viewBox="0 0 16 16" aria-hidden="true"><path d="M5 3 L13 8 L5 13 Z" /></svg>}
          </button>
          {controls}
        </div>
      </div>
      <div className="plate-cap">
        <div className="cap-name">
          <span className="cap-num">{num}</span>
          <h2 id={id + '-h'}>{title}</h2>
        </div>
        <Tex display className="cap-formula">{formula}</Tex>
        {note && <p className="cap-note">{note}</p>}
      </div>
    </section>
  );
}

/** Segmented choice, e.g. «kartesisch | zylindrisch | sphärisch». Labels may be TeX (prefix with $). */
export function Seg<T extends string>({ value, options, onChange, label }: {
  value: T; options: { v: T; l: string }[]; onChange: (v: T) => void; label: string;
}) {
  return (
    <div className="seg" role="radiogroup" aria-label={label}>
      {options.map((o) => (
        <button key={o.v} role="radio" aria-checked={o.v === value} className={o.v === value ? 'on' : ''} onClick={() => onChange(o.v)}>
          {o.l.startsWith('$') ? <Tex>{o.l.slice(1)}</Tex> : o.l}
        </button>
      ))}
    </div>
  );
}

export function Slider({ tex, value, min, max, step, onChange }: {
  tex: string; value: number; min: number; max: number; step: number; onChange: (v: number) => void;
}) {
  return (
    <label className="slider">
      <Tex>{tex}</Tex>
      <input type="range" min={min} max={max} step={step} value={value} onChange={(e) => onChange(+e.target.value)} />
    </label>
  );
}

/** Drag to turn a 3D figure: horizontally (azimuth) always, vertically (elevation) with a mouse or pen. */
export function useOrbit(az0: number, el0: number, elMin = -0.2, elMax = 1.35) {
  const [cam, setCam] = useState({ az: az0, el: el0 });
  const drag = useRef<{ x: number; y: number; az: number; el: number; id: number; touch: boolean } | null>(null);
  const bind = {
    onPointerDown: (e: RPE<HTMLDivElement>) => {
      if ((e.target as HTMLElement).closest('button, input, label')) return;
      drag.current = { x: e.clientX, y: e.clientY, az: cam.az, el: cam.el, id: e.pointerId, touch: e.pointerType === 'touch' };
      e.currentTarget.setPointerCapture(e.pointerId);
    },
    onPointerMove: (e: RPE<HTMLDivElement>) => {
      const d = drag.current;
      if (!d || d.id !== e.pointerId) return;
      const k = 3.2 / Math.max(300, e.currentTarget.clientWidth);
      setCam({
        az: d.az - (e.clientX - d.x) * k,
        el: d.touch ? d.el : Math.min(elMax, Math.max(elMin, d.el + (e.clientY - d.y) * k)),
      });
    },
    onPointerUp: () => { drag.current = null; },
    onPointerCancel: () => { drag.current = null; },
    className: 'orbit',
  };
  return { cam, bind };
}
