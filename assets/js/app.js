import { el, onTheme, readTheme } from './core.js';
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
    desc: 'Kinematik des Punktes und des starren Körpers, Kräfte und Momente, Statik, Reibung, Seile, Beanspruchung.',
    viz: [[polbahn, 'Momentanzentrum und Polbahnen'], [schraube, 'Kinemate und Schraube'], [balken, 'Querkraft und Biegemoment']] },
  { group: 'Analysis 1', pdf: 'analysis1/Analysis1_Lernskript.pdf', pages: 106, size: '3.6 MB', lang: 'Deutsch',
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
let current = null;

function index() {
  crumbs.innerHTML = ''; pager.innerHTML = '';
  const root = el('div', { class: 'idx' });
  root.append(el('section', { class: 'hero' }, el('h1', { html: 'Lernstoff DMAVT' })));
  const shelf = el('ol', { class: 'shelf' });
  SUBJECTS.forEach((s, si) => {
    const file = s.pdf.split('/').pop();
    shelf.append(el('li', { class: 'book' },
      el('a', { class: 'book-cover', href: s.pdf, target: '_blank', rel: 'noopener', 'aria-label': `Lernskript ${s.group} öffnen` },
        el('img', { src: cover(s), alt: `Umschlag Lernskript ${s.group}`, width: 640, height: 905, loading: si < 3 ? 'eager' : 'lazy', decoding: 'async' })),
      el('div', { class: 'book-t', html: s.group }),
      el('div', { class: 'book-m', html: `${s.pages} Seiten · ${s.size} · ${s.lang}` }),
      el('div', { class: 'book-a' },
        el('a', { href: s.pdf, target: '_blank', rel: 'noopener', html: 'Lesen' }),
        el('a', { href: s.pdf, download: file, html: 'Laden ↓' }),
        el('a', { href: '#fach-' + (si + 1), class: 'mut', html: `${s.viz.length} Modelle` }))));
  });
  root.append(el('section', { class: 'library' },
    el('div', { class: 'sec-h' }, el('h2', { html: 'Bibliothek' }), el('p', { html: 'Die Skripte als PDF. Antippen öffnet das Buch im Browser.' })),
    shelf));
  root.append(el('div', { class: 'sec-h models-h' }, el('h2', { html: 'Modelle' }), el('p', { html: 'Interaktive Visualisierungen, geordnet nach Fach.' })));
  const thumbs = [];
  SUBJECTS.forEach((s, si) => {
    const list = el('ol', { class: 'vlist' });
    for (const v of ALL.filter((x) => x.subject === s)) {
      const cv = el('canvas', { 'aria-hidden': 'true' });
      thumbs.push([cv, v.m]);
      list.append(el('li', { class: 'vrow' }, el('a', { href: '#' + v.m.meta.id },
        el('span', { class: 'n', html: nn(v.n) }),
        el('div', {}, el('h3', { html: v.name }), el('p', { html: v.m.meta.title }), el('span', { class: 'ch', html: v.m.meta.tag.split('·')[1]?.trim() || '' })),
        cv)));
    }
    const file = s.pdf.split('/').pop();
    root.append(el('section', { class: 'subject', id: 'fach-' + (si + 1) },
      el('div', { class: 'subject-head' },
        el('span', { class: 'no', html: `${nn(si + 1)} / ${nn(SUBJECTS.length)}` }),
        el('h2', { html: s.group }),
        el('p', { html: s.desc }),
        el('div', { class: 'doc' },
          el('a', { class: 'doc-ic', href: s.pdf, target: '_blank', rel: 'noopener', 'aria-hidden': 'true', tabindex: '-1' }, el('img', { src: cover(s), alt: '', loading: 'lazy' })),
          el('span', { class: 'doc-t', html: `Lernskript ${s.group}` }),
          el('span', { class: 'doc-m', html: `PDF · ${s.pages} Seiten · ${s.size} · ${s.lang}` }),
          el('span', { class: 'doc-a' },
            el('a', { href: s.pdf, target: '_blank', rel: 'noopener', html: 'Öffnen' }),
            el('a', { href: s.pdf, download: file, html: 'Herunterladen' })))),
      list));
  });
  root.append(el('footer', { class: 'colophon' },
    el('div', {}, el('h4', { html: 'FARBEN' }), el('ul', { class: 'legend', html:
      '<li><i style="background:var(--v)"></i>Geschwindigkeit, Näherung</li><li><i style="background:var(--f)"></i>Kraft, Singularität</li><li><i style="background:var(--m)"></i>Drehung, Moment, Krümmung</li><li><i style="background:var(--k)"></i>Momentanzentrum, aktiver Zustand</li>' })),
    el('div', {}, el('h4', { html: 'AUSWAHL' }), el('p', { html: 'Modelliert wurde nur, was in Bewegung verständlicher wird. Alles andere steht im Skript, wo Text, Rechnung und Abbildung das bessere Medium sind.' })),
    el('div', {}, el('h4', { html: 'BEDIENUNG' }), el('p', { html: 'Jedes Modell führt in nummerierten Schritten durch die Idee. Danach ist alles frei: ziehen, verschieben, Parameter ändern. Funktioniert mit Maus, Trackpad und Touch.' }))));
  app.append(root);
  const draw = () => { readTheme(); for (const [cv, m] of thumbs) { const r = cv.getBoundingClientRect(); if (!r.width) continue; const dpr = Math.min(2, devicePixelRatio || 1); cv.width = Math.round(r.width * dpr); cv.height = Math.round(r.height * dpr); const ctx = cv.getContext('2d'); ctx.setTransform(dpr, 0, 0, dpr, 0, 0); try { m.thumb(ctx, r.width, r.height); } catch (e) { console.error(e); } } };
  requestAnimationFrame(draw); document.fonts?.ready.then(draw);
  const ro = new ResizeObserver(() => draw()); thumbs.forEach(([cv]) => ro.observe(cv));
  const off = onTheme(draw);
  return { destroy() { ro.disconnect(); off(); } };
}

function vizPage(v) {
  const i = v.n - 1, prev = ALL[i - 1], next = ALL[i + 1];
  crumbs.innerHTML = '';
  crumbs.append(el('span', { class: 'sl', html: '/' }), el('a', { href: '#fach-' + (SUBJECTS.indexOf(v.subject) + 1), html: v.subject.group }), el('span', { class: 'sl', html: '/' }), el('span', { class: 'here', html: `${nn(v.n)} ${v.name}` }));
  pager.innerHTML = '';
  pager.append(el('a', { class: 'pdf', href: v.subject.pdf, target: '_blank', rel: 'noopener', title: `Lernskript ${v.subject.group} als PDF`, html: 'Skript PDF' }));
  if (prev) pager.append(el('a', { class: 'pv', href: '#' + prev.m.meta.id, html: `← ${nn(prev.n)}` }));
  pager.append(el('a', { href: '#', html: 'Index' }));
  if (next) pager.append(el('a', { href: '#' + next.m.meta.id, html: `${nn(next.n)} →` }));
  const h = v.m.mount(app);
  const src = app.querySelector('.panel .src');
  if (src) src.append(' ', el('a', { href: v.subject.pdf, target: '_blank', rel: 'noopener', html: 'Im Skript nachlesen' }));
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
  if (v) { document.title = `${v.name} · Lernstoff DMAVT`; current = vizPage(v); }
  else { document.title = 'Lernstoff DMAVT'; current = index(); if (id.startsWith('fach-')) document.getElementById(id)?.scrollIntoView(); }
}
addEventListener('hashchange', route);
route();
