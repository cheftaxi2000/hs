import { el, onTheme, readTheme } from './core.js';
import * as polbahn from './viz/polbahn.js';
import * as schraube from './viz/schraube.js';
import * as balken from './viz/balken.js';
import * as taylor from './viz/taylor.js';
import * as kruemmung from './viz/kruemmung.js';
import * as gauss from './viz/gauss.js';
import * as abbildung from './viz/abbildung.js';
import * as fraktal from './viz/fraktal.js';

const VIZ = [polbahn, schraube, balken, taylor, kruemmung, gauss, abbildung, fraktal];
const byId = Object.fromEntries(VIZ.map((m) => [m.meta.id, m]));
const app = document.getElementById('app');
const nav = document.getElementById('topnav');
let current = null;

function buildNav() {
  nav.innerHTML = '';
  let group = null;
  for (const m of VIZ) {
    if (group && group !== m.meta.group) nav.append(el('span', { class: 'sep' }));
    group = m.meta.group;
    nav.append(el('a', { href: '#' + m.meta.id, 'data-id': m.meta.id, html: m.meta.short }));
  }
}

function overview() {
  const root = el('div', { class: 'overview' });
  root.append(el('div', { class: 'ov-head' },
    el('h1', { html: 'Ideen aus den Lernskripten, <span>die man sehen muss, um sie zu verstehen.</span>' }),
    el('p', { html: 'Die Lernskripte erklären fast alles gut mit Text, Formeln und Skizzen. Diese Seite nimmt nur die Stellen auf, an denen eine Skizze zu wenig ist: wo sich etwas bewegt, wo ein Punkt wandert, wo eine Aussage erst beim Verändern eines Parameters greifbar wird. Jede Visualisierung rechnet mit den Formeln aus dem Skript.' })));
  const groups = [['Mechanik 1', 'Kinematik und Statik'], ['Analysis 1', 'Differential- und Reihenrechnung'], ['Lineare Algebra', 'Gleichungssysteme, Matrizen, Abbildungen']];
  const thumbs = [];
  for (const [g, sub] of groups) {
    const grid = el('div', { class: 'ov-grid' });
    for (const m of VIZ.filter((v) => v.meta.group === g)) {
      const cv = el('canvas', { class: 'ov-thumb', 'aria-hidden': 'true' });
      thumbs.push([cv, m]);
      grid.append(el('a', { class: 'ov-card', href: '#' + m.meta.id }, cv,
        el('div', { class: 'ov-body' }, el('span', { class: 'ov-tag', html: m.meta.tag }), el('h3', { html: m.meta.title }), el('p', { html: m.meta.card }))));
    }
    root.append(el('section', { class: 'ov-group' }, el('div', { class: 'ov-group-h' }, el('h2', { html: g }), el('span', { html: sub })), grid));
  }
  root.append(el('div', { class: 'ov-note' },
    el('div', {}, el('h4', { html: 'Farben' }), el('ul', { class: 'legend', html:
      '<li><i style="background:var(--v)"></i>Geschwindigkeit, Näherung</li><li><i style="background:var(--f)"></i>Kraft, Singularität</li><li><i style="background:var(--m)"></i>Drehung, Moment, Krümmung</li><li><i style="background:var(--k)"></i>Momentanzentrum, Polbahn</li>' })),
    el('div', {}, el('h4', { html: 'Bewusst weggelassen' }), el('p', { html: 'Sekante und Tangente, Riemann-Summen, Seilreibung, Lagertypen, Fachwerke, Einsteinsche Summenkonvention, Vektorraum-Axiome, LR-Zerlegung: Dort sind Text, Rechnung und die Abbildungen im Skript schon das bessere Medium.' }))));
  app.append(root);
  const draw = () => {
    for (const [cv, m] of thumbs) {
      const r = cv.getBoundingClientRect(); const dpr = Math.min(2, devicePixelRatio || 1);
      cv.width = Math.round(r.width * dpr); cv.height = Math.round(r.height * dpr);
      const ctx = cv.getContext('2d'); ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      try { m.thumb(ctx, r.width, r.height); } catch (e) { console.error(e); }
    }
  };
  requestAnimationFrame(draw);
  const ro = new ResizeObserver(() => draw()); thumbs.forEach(([cv]) => ro.observe(cv));
  const off = onTheme(draw);
  document.fonts?.ready.then(draw);
  return { destroy() { ro.disconnect(); off(); } };
}

function route() {
  const id = location.hash.replace('#', '');
  current?.destroy?.();
  app.innerHTML = '';
  window.scrollTo(0, 0);
  readTheme();
  const m = byId[id];
  nav.querySelectorAll('a').forEach((a) => a.toggleAttribute('aria-current', a.dataset.id === id) && a.setAttribute('aria-current', 'page'));
  if (m) { document.title = m.meta.short + ' · Lernskripte in Bewegung'; current = m.mount(app); }
  else { document.title = 'Lernskripte in Bewegung'; current = overview(); }
}

buildNav();
addEventListener('hashchange', route);
route();
