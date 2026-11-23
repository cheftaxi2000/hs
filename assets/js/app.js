import { el, onTheme, readTheme } from './core.js';
import { openFeedback } from './feedback.js';
import * as polbahn from './viz/polbahn.js';
import * as schraube from './viz/schraube.js';
import * as balken from './viz/balken.js';
import * as taylor from './viz/taylor.js';
import * as kruemmung from './viz/kruemmung.js';
import * as gauss from './viz/gauss.js';
import * as abbildung from './viz/abbildung.js';
import * as fraktal from './viz/fraktal.js';
import * as rekursion from './viz/rekursion.js';
import * as liste from './viz/liste.js';
import * as gas from './viz/gas.js';
import * as entropie from './viz/entropie.js';

/* the five scripts, with the PDFs that live next to their sources in this repository */
const SUBJECTS = [
  { group: 'Mechanik 1', pdf: 'mechanik1/Mechanik1_Lernskript.pdf', pages: 131, size: '5.3 MB', lang: 'Deutsch',
    atlas: { href: 'mechanik/', title: 'Mechanik 1 in Tafeln', n: 19, text: '19 bewegte Figuren zu den Kapiteln 1 bis 14: von der Zykloide über Polbahnen, Fachwerke und Reibungskegel bis zur Kettenlinie.', ch: 'Kapitel 1–14' },
    desc: 'Kinematik des Punktes und des starren Körpers, Kräfte und Momente, Statik, Reibung, Seile, Beanspruchung.',
    viz: [[polbahn, 'Momentanzentrum und Polbahnen'], [schraube, 'Kinemate und Schraube'], [balken, 'Querkraft und Biegemoment']] },
  { group: 'Analysis 1', pdf: 'analysis1/Analysis1_Lernskript.pdf', pages: 106, size: '3.6 MB', lang: 'Deutsch',
    atlas: { href: 'analysis/', title: 'Analysis I in Tafeln', n: 17, text: '17 bewegte Figuren zu den Kapiteln 1 bis 5: vom ε-Schlauch über Krümmungskreis und Eulerformel bis zum Konvergenzradius.', ch: 'Kapitel 1–5' },
    desc: 'Folgen und Funktionen, Differentialrechnung, komplexe Zahlen, Integralrechnung, Reihen und Taylor.',
    viz: [[taylor, 'Taylorpolynome und Konvergenzradius'], [kruemmung, 'Krümmung, Krümmungskreis, Evolute']] },
  { group: 'Lineare Algebra', pdf: 'linalg1/Lineare_Algebra_Skript.pdf', pages: 130, size: '4.0 MB', lang: 'Deutsch',
    desc: 'Gleichungssysteme und Gauss, Matrizen, Determinanten, Vektorräume, lineare Abbildungen und Fraktale.',
    viz: [[gauss, 'Das Gauss-Verfahren im Raum'], [abbildung, 'Matrizen als Abbildungen'], [fraktal, 'Kontraktionen und Fraktale']] },
  { group: 'Informatik', pdf: 'informatics1/Informatics_Script.pdf', pages: 163, size: '3.8 MB', lang: 'Englisch',
    desc: 'Programmieren in C++: Ausdrücke, Kontrollfluss, Funktionen, Rekursion, Zeiger, Klassen und Datenstrukturen.',
    viz: [[rekursion, 'Rekursion und Call-Stack'], [liste, 'Zeiger und verkettete Listen']] },
  { group: 'Chemie', pdf: 'chemistry1/Chemistry_Script.pdf', pages: 117, size: '7.7 MB', lang: 'Englisch',
    desc: 'Stöchiometrie, Gase, wässrige Lösungen, Thermodynamik, Atombau, Bindung, Lösungen und Kinetik.',
    viz: [[gas, 'Kinetische Gastheorie'], [entropie, 'Entropie und Mikrozustände']] },
];
const ALL = [];
SUBJECTS.forEach((s) => s.viz.forEach(([m, name]) => ALL.push({ m, name, subject: s, n: ALL.length + 1 })));
const byId = Object.fromEntries(ALL.map((v) => [v.m.meta.id, v]));
const app = document.getElementById('app');
const crumbs = document.getElementById('crumbs');
const pager = document.getElementById('pager');
const nn = (n) => String(n).padStart(2, '0');
const cover = (s) => `assets/covers/${s.pdf.split('/')[0]}.webp`;
const dl = (s) => ({ href: s.pdf, download: s.pdf.split('/').pop() });
let current = null;

const SEL_KEY = 'lernstoff.book';
const readSel = () => { try { const v = +localStorage.getItem(SEL_KEY); return v >= 0 && v < SUBJECTS.length ? v : 0; } catch { return 0; } };

/* The start page is one gesture: choose a book. The five covers are the page; the chosen book opens its plates below. */
function index(initial) {
  crumbs.innerHTML = ''; pager.innerHTML = '';
  const root = el('div', { class: 'idx' });
  root.append(el('h1', { class: 'vh', html: 'Lernstoff DMAVT' }));
  const covers = SUBJECTS.map((s, si) => el('li', {},
    el('button', { type: 'button', class: 'pick', 'aria-pressed': 'false', 'aria-controls': 'room' },
      el('img', { src: cover(s), alt: '', width: 640, height: 905, decoding: 'async' }),
      el('span', { class: 'pick-t', html: s.group }))));
  const shelf = el('ol', { class: 'shelf', 'aria-label': 'Skripte' }, ...covers);
  const room = el('section', { class: 'room', id: 'room', 'aria-live': 'polite' });
  root.append(shelf, room);
  root.append(el('footer', { class: 'legend-line' }, el('ul', { class: 'legend', html:
    '<li><i style="background:var(--v)"></i>Geschwindigkeit, Näherung</li><li><i style="background:var(--f)"></i>Kraft, Singularität</li><li><i style="background:var(--m)"></i>Drehung, Moment, Krümmung</li><li><i style="background:var(--k)"></i>Momentanzentrum, aktiver Zustand</li>' })));
  app.append(root);

  let thumbs = [];
  const draw = () => { readTheme(); for (const [cv, m] of thumbs) { const r = cv.getBoundingClientRect(); if (!r.width) continue; const dpr = Math.min(2, devicePixelRatio || 1); cv.width = Math.round(r.width * dpr); cv.height = Math.round(r.height * dpr); const ctx = cv.getContext('2d'); ctx.setTransform(dpr, 0, 0, dpr, 0, 0); try { m.thumb(ctx, r.width, r.height); } catch (e) { console.error(e); } } };
  const ro = new ResizeObserver(() => draw());

  function select(si, { scroll = false } = {}) {
    const s = SUBJECTS[si];
    covers.forEach((li, k) => { li.classList.toggle('on', k === si); li.querySelector('.pick').setAttribute('aria-pressed', String(k === si)); });
    shelf.classList.add('has-sel');
    try { localStorage.setItem(SEL_KEY, String(si)); } catch { /* private mode */ }
    history.replaceState(null, '', '#fach-' + (si + 1));
    ro.disconnect(); thumbs = [];
    const plates = el('ol', { class: 'plates' });
    for (const v of ALL.filter((x) => x.subject === s)) {
      const cv = el('canvas', { 'aria-hidden': 'true' });
      thumbs.push([cv, v.m]); ro.observe(cv);
      plates.append(el('li', {}, el('a', { class: 'plate', href: '#' + v.m.meta.id },
        cv, el('span', { class: 'plate-t' }, el('span', { class: 'n', html: nn(v.n) }), el('span', { html: v.name })))));
    }
    if (s.atlas) plates.append(el('li', {}, el('a', { class: 'plate tafeln', href: s.atlas.href },
      el('picture', { class: 'tafeln-face' },
        el('source', { srcset: `assets/tafeln/${s.atlas.href.replace('/', '')}-dark.webp`, media: '(prefers-color-scheme: dark)' }),
        el('img', { src: `assets/tafeln/${s.atlas.href.replace('/', '')}-light.webp`, alt: '', width: 960, height: 600, loading: 'lazy', decoding: 'async' })),
      el('span', { class: 'plate-t' }, el('span', { class: 'n', html: '' }), el('span', { html: s.atlas.title })))));
    room.replaceChildren(
      el('header', { class: 'room-h' },
        el('h2', { html: s.group }),
        el('a', { class: 'pdf', ...dl(s), html: `<span class="l">PDF herunterladen</span><span class="m">${s.pages} Seiten · ${s.size}</span>` })),
      plates);
    room.classList.remove('in'); void room.offsetWidth; room.classList.add('in');
    requestAnimationFrame(draw);
    if (scroll) room.scrollIntoView({ block: 'start', behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' });
  }
  covers.forEach((li, si) => li.querySelector('.pick').addEventListener('click', () => select(si, { scroll: innerWidth < 980 })));
  select(initial ?? readSel(), { scroll: initial != null && innerWidth < 980 });
  document.fonts?.ready.then(draw);
  const off = onTheme(draw);
  return { destroy() { ro.disconnect(); off(); } };
}

function vizPage(v) {
  const i = v.n - 1, prev = ALL[i - 1], next = ALL[i + 1];
  crumbs.innerHTML = '';
  crumbs.append(el('span', { class: 'sl', html: '/' }), el('a', { href: '#fach-' + (SUBJECTS.indexOf(v.subject) + 1), html: v.subject.group }), el('span', { class: 'sl', html: '/' }), el('span', { class: 'here', html: `${nn(v.n)} ${v.name}` }));
  pager.innerHTML = '';
  pager.append(el('a', { class: 'pdf', ...dl(v.subject), title: `Lernskript ${v.subject.group} herunterladen`, html: 'Skript ↓' }));
  if (prev) pager.append(el('a', { class: 'pv', href: '#' + prev.m.meta.id, html: `← ${nn(prev.n)}` }));
  pager.append(el('a', { href: '#', html: 'Index' }));
  if (next) pager.append(el('a', { href: '#' + next.m.meta.id, html: `${nn(next.n)} →` }));
  const h = v.m.mount(app);
  const src = app.querySelector('.panel .src');
  if (src) src.append(' ', el('a', { ...dl(v.subject), html: 'Skript herunterladen' }));
  const eb = app.querySelector('.stage-head .eyebrow'); if (eb) eb.textContent = `${nn(v.n)} — ${v.m.meta.tag}`;
  return h;
}


function route() {
  const id = location.hash.replace('#', '');
  current?.destroy?.();
  app.innerHTML = '';
  window.scrollTo(0, 0);
  readTheme();
  const v = byId[id];
  document.body.dataset.page = v ? 'model' : 'index';
  if (v) { document.title = `${v.name} · Lernstoff DMAVT`; current = vizPage(v); }
  else { document.title = 'Lernstoff DMAVT'; const f = /^fach-(\d)$/.exec(id); current = index(f ? +f[1] - 1 : undefined); }
}
addEventListener('hashchange', route);

/* «Verbesserung vorschlagen» in the bar on every page */
const fb = el('button', { type: 'button', class: 'fb-open', html: '<span class="long">Verbesserung vorschlagen</span><span class="short">Feedback</span>' });
fb.addEventListener('click', () => { const v = byId[location.hash.slice(1)]; openFeedback(v ? `${v.subject.group}, Modell ${nn(v.n)} ${v.name}` : ''); });
document.querySelector('.bar-in').append(fb);
route();
