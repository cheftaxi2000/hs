import { el, onTheme, readTheme } from './core.js';
import { openFeedback } from './feedback.js';
import { KBD, initLibrary, libReady, openSearch, remember, renderHome, renderRoom } from './library.js';
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

/* the five scripts; their contents (chapters, pages, previews) come from assets/library/library.json */
const SUBJECTS = [
  { slug: 'mechanik', group: 'Mechanik 1', pdf: 'mechanik1/Mechanik1_Lernskript.pdf', lang: 'Deutsch',
    atlas: { href: 'mechanik/', img: 'mechanik', title: 'Mechanik 1 in Tafeln', n: 19 },
    desc: 'Kinematik des Punktes und des starren Körpers, Kräfte und Momente, Statik, Reibung, Seile, Beanspruchung.',
    viz: [[polbahn, 'Momentanzentrum und Polbahnen'], [schraube, 'Kinemate und Schraube'], [balken, 'Querkraft und Biegemoment']] },
  { slug: 'analysis', group: 'Analysis 1', pdf: 'analysis1/Analysis1_Lernskript.pdf', lang: 'Deutsch',
    atlas: { href: 'analysis/', img: 'analysis', title: 'Analysis I in Tafeln', n: 17 },
    desc: 'Folgen und Funktionen, Differentialrechnung, komplexe Zahlen, Integralrechnung, Reihen und Taylor.',
    viz: [[taylor, 'Taylorpolynome und Konvergenzradius'], [kruemmung, 'Krümmung, Krümmungskreis, Evolute']] },
  { slug: 'linalg', group: 'Lineare Algebra', pdf: 'linalg1/Lineare_Algebra_Skript.pdf', lang: 'Deutsch',
    desc: 'Gleichungssysteme und Gauss, Matrizen, Determinanten, Vektorräume, lineare Abbildungen und Fraktale.',
    viz: [[gauss, 'Das Gauss-Verfahren im Raum'], [abbildung, 'Matrizen als Abbildungen'], [fraktal, 'Kontraktionen und Fraktale']] },
  { slug: 'informatik', group: 'Informatik', pdf: 'informatics1/Informatics_Script.pdf', lang: 'Englisch',
    desc: 'Programmieren in C++: Ausdrücke, Kontrollfluss, Funktionen, Rekursion, Zeiger, Klassen und Datenstrukturen.',
    viz: [[rekursion, 'Rekursion und Call-Stack'], [liste, 'Zeiger und verkettete Listen']] },
  { slug: 'chemie', group: 'Chemie', pdf: 'chemistry1/Chemistry_Script.pdf', lang: 'Englisch',
    desc: 'Stöchiometrie, Gase, wässrige Lösungen, Thermodynamik, Atombau, Bindung, Lösungen und Kinetik.',
    viz: [[gas, 'Kinetische Gastheorie'], [entropie, 'Entropie und Mikrozustände']] },
];
SUBJECTS.forEach((s) => { s.cover = `assets/covers/${s.pdf.split('/')[0]}.webp`; });
const ALL = [];
SUBJECTS.forEach((s) => s.viz.forEach(([m, name]) => ALL.push({ m, name, subject: s, n: ALL.length + 1 })));
const byId = Object.fromEntries(ALL.map((v) => [v.m.meta.id, v]));
const app = document.getElementById('app');
const crumbs = document.getElementById('crumbs');
const pager = document.getElementById('pager');
const tools = document.getElementById('tools');
const nn = (n) => String(n).padStart(2, '0');
const bySlug = Object.fromEntries(SUBJECTS.map((s) => [s.slug, s]));
let current = null, routeId = 0;
initLibrary(SUBJECTS, ALL);

function crumb(s, here) {
  crumbs.replaceChildren(el('span', { class: 'sl', html: '/' }), el('a', { href: '#' + s.slug, class: 'c-subj', html: s.group }));
  if (here) crumbs.append(el('span', { class: 'sl', html: '/' }), el('span', { class: 'here', html: here }));
}

/* thumbnails of the models (canvas), drawn once visible and again on resize or theme change */
function drawThumbs(thumbs) {
  if (!thumbs.length) return { destroy() {} };
  const draw = () => { readTheme(); for (const [cv, m] of thumbs) { const r = cv.getBoundingClientRect(); if (!r.width) continue; const dpr = Math.min(2, devicePixelRatio || 1); cv.width = Math.round(r.width * dpr); cv.height = Math.round(r.height * dpr); const ctx = cv.getContext('2d'); ctx.setTransform(dpr, 0, 0, dpr, 0, 0); try { m.thumb(ctx, r.width, r.height); } catch (e) { console.error(e); } } };
  const ro = new ResizeObserver(() => draw()); thumbs.forEach(([cv]) => ro.observe(cv));
  requestAnimationFrame(draw); document.fonts?.ready.then(draw);
  const off = onTheme(draw);
  return { destroy() { ro.disconnect(); off(); } };
}

function vizPage(v) {
  const i = v.n - 1, prev = ALL[i - 1], next = ALL[i + 1], s = v.subject;
  crumb(s, `${nn(v.n)} ${v.name}`);
  pager.replaceChildren(el('a', { class: 'pdf', href: '#' + s.slug, title: `Lernskript ${s.group}: Inhalt und Download`, html: 'Skript' }));
  if (prev) pager.append(el('a', { class: 'pv', href: '#' + prev.m.meta.id, 'aria-label': `Vorheriges Modell: ${prev.name}`, html: `← ${nn(prev.n)}` }));
  if (next) pager.append(el('a', { href: '#' + next.m.meta.id, 'aria-label': `Nächstes Modell: ${next.name}`, html: `${nn(next.n)} →` }));
  remember({ href: '#' + v.m.meta.id, slug: s.slug, title: v.name, sub: `${s.group} · Modell ${nn(v.n)}` });
  const h = v.m.mount(app);
  const src = app.querySelector('.panel .src');
  if (src) src.append(' ', el('a', { href: '#' + s.slug, html: 'Zum Skript' }));
  const eb = app.querySelector('.stage-head .eyebrow'); if (eb) eb.textContent = `Modell ${nn(v.n)} · ${v.m.meta.tag}`;
  return h;
}

function route() {
  const id = decodeURIComponent(location.hash.replace(/^#/, ''));
  const old = /^fach-(\d)$/.exec(id); // links from the previous design
  if (old && SUBJECTS[+old[1] - 1]) { history.replaceState(null, '', '#' + SUBJECTS[+old[1] - 1].slug); return route(); }
  const token = ++routeId;
  current?.destroy?.();
  app.replaceChildren();
  window.scrollTo(0, 0);
  readTheme();
  crumbs.replaceChildren(); pager.replaceChildren();
  const v = byId[id];
  const room = /^([a-z]+)(?:\/(?:p(\d+)|(aufgaben|formeln)))?$/.exec(id);
  const s = v ? v.subject : room && bySlug[room[1]] ? bySlug[room[1]] : null;
  document.body.dataset.page = v ? 'model' : s ? 'room' : 'home';
  if (s) document.body.dataset.subject = s.slug; else delete document.body.dataset.subject;
  if (v) { document.title = `${v.name} · Lernstoff DMAVT`; current = vizPage(v); return; }
  if (s) {
    document.title = `${s.group} · Lernstoff DMAVT`;
    crumb(s);
    current = { destroy() {} };
    libReady.then(() => { if (token !== routeId) return; const r = renderRoom(app, s, { page: room[2] ? +room[2] : null, filter: room[3] }); current = drawThumbs(r.thumbs); });
    return;
  }
  document.title = 'Lernstoff DMAVT';
  current = { destroy() {} };
  libReady.then(() => { if (token === routeId) renderHome(app); });
}
addEventListener('hashchange', route);

/* tools in the bar: search, light/dark, feedback */
const searchBtn = el('button', { type: 'button', class: 'tool tool-search', 'aria-label': `Suchen (${KBD})`, html: `<svg viewBox="0 0 20 20" aria-hidden="true"><circle cx="8.5" cy="8.5" r="5.5" fill="none" stroke="currentColor" stroke-width="1.6"/><path d="m13 13 4.5 4.5" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg><span class="t-l">Suchen</span><kbd>${KBD}</kbd>` });
searchBtn.addEventListener('click', () => openSearch());
const isDark = () => (document.documentElement.dataset.theme || (matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light')) === 'dark';
const themeBtn = el('button', { type: 'button', class: 'tool' });
const syncTheme = () => { themeBtn.textContent = isDark() ? 'Hell' : 'Dunkel'; themeBtn.setAttribute('aria-label', isDark() ? 'Helle Darstellung' : 'Dunkle Darstellung'); };
themeBtn.addEventListener('click', () => { const t = isDark() ? 'light' : 'dark'; document.documentElement.dataset.theme = t; try { localStorage.setItem('atlas.theme', t); } catch { /* keep it for this visit */ } syncTheme(); });
matchMedia('(prefers-color-scheme: dark)').addEventListener?.('change', syncTheme);
syncTheme();
const fb = el('button', { type: 'button', class: 'tool fb-open', html: '<span class="long">Verbesserung vorschlagen</span><span class="short">Feedback</span>' });
fb.addEventListener('click', () => { const v = byId[location.hash.slice(1)]; openFeedback(v ? `${v.subject.group}, Modell ${nn(v.n)} ${v.name}` : ''); });
tools.append(searchBtn, themeBtn, fb);
route();
