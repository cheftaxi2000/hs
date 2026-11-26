import { el } from './core.js';
import { openFeedback } from './feedback.js';

/* the five scripts, with the PDFs that live next to their sources in this repository */
const SUBJECTS = [
  { group: 'Mechanik 1', pdf: 'mechanik1/Mechanik1_Lernskript.pdf', pages: 139, size: '7.2 MB', lang: 'Deutsch',
    desc: 'Kinematik des Punktes und des starren Körpers, Kräfte und Momente, Statik, Fachwerke, Reibung, Seile, Beanspruchung.' },
  { group: 'Analysis 1', pdf: 'analysis1/Analysis1_Lernskript.pdf', pages: 110, size: '4.9 MB', lang: 'Deutsch',
    desc: 'Folgen und Funktionen, Differentialrechnung, komplexe Zahlen, Integralrechnung, Reihen und Taylor.' },
  { group: 'Lineare Algebra', pdf: 'linalg1/Lineare_Algebra_Skript.pdf', pages: 137, size: '4.8 MB', lang: 'Deutsch',
    desc: 'Gleichungssysteme und Gauss, Matrizen, Determinanten, Vektorräume, lineare Abbildungen und Fraktale.' },
  { group: 'Informatik', pdf: 'informatics1/Informatics_Script.pdf', pages: 227, size: '6.6 MB', lang: 'Englisch',
    desc: 'Programmieren in C++: Ausdrücke, Kontrollfluss, Funktionen, Vektoren, Rekursion, Zeiger, Klassen, Datenstrukturen und Vererbung. Ab Kapitel 6 mit Schritt-für-Schritt-Erklärungen und Lösungswegen für Prüfungsaufgaben.' },
  { group: 'Chemie', pdf: 'chemistry1/Chemistry_Script.pdf', pages: 120, size: '7.4 MB', lang: 'Englisch',
    desc: 'Stöchiometrie, Gase, wässrige Lösungen, Thermodynamik, Atombau, Bindung, zwischenmolekulare Kräfte, Lösungen und Kinetik.' },
];
const app = document.getElementById('app');
const cover = (s) => `assets/covers/${s.pdf.split('/')[0]}.webp`;
const dl = (s) => ({ href: s.pdf, download: s.pdf.split('/').pop() });

const SEL_KEY = 'lernstoff.book';
const readSel = () => { try { const v = +localStorage.getItem(SEL_KEY); return v >= 0 && v < SUBJECTS.length ? v : 0; } catch { return 0; } };

/* The start page: five covers. Choosing one shows what is in the script and the download. */
function index(initial) {
  const root = el('div', { class: 'idx' });
  root.append(el('h1', { class: 'vh', html: 'Lernstoff DMAVT' }));
  const covers = SUBJECTS.map((s) => el('li', {},
    el('button', { type: 'button', class: 'pick', 'aria-pressed': 'false', 'aria-controls': 'room' },
      el('img', { src: cover(s), alt: '', width: 640, height: 905, decoding: 'async' }),
      el('span', { class: 'pick-t', html: s.group }))));
  const shelf = el('ol', { class: 'shelf', 'aria-label': 'Skripte' }, ...covers);
  const room = el('section', { class: 'room', id: 'room', 'aria-live': 'polite' });
  root.append(shelf, room);
  app.append(root);

  function select(si, { scroll = false } = {}) {
    const s = SUBJECTS[si];
    covers.forEach((li, k) => { li.classList.toggle('on', k === si); li.querySelector('.pick').setAttribute('aria-pressed', String(k === si)); });
    shelf.classList.add('has-sel');
    try { localStorage.setItem(SEL_KEY, String(si)); } catch { /* private mode */ }
    history.replaceState(null, '', '#fach-' + (si + 1));
    room.replaceChildren(
      el('header', { class: 'room-h' },
        el('h2', { html: s.group }),
        el('a', { class: 'pdf', ...dl(s), html: `<span class="l">PDF herunterladen</span><span class="m">${s.pages} Seiten · ${s.size}</span>` })),
      el('div', { class: 'room-d' },
        el('p', { html: s.desc }),
        el('p', { class: 'room-m', html: `Sprache: ${s.lang} · Jedes Kapitel mit Beispielen, Aufgaben mit Lösungen und einem Abschnitt «Wo man das im Alltag und im Beruf braucht».` }),
        el('a', { class: 'btn solid', ...dl(s), html: 'PDF herunterladen' })));
    room.classList.remove('in'); void room.offsetWidth; room.classList.add('in');
    if (scroll) room.scrollIntoView({ block: 'start', behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' });
  }
  covers.forEach((li, si) => li.querySelector('.pick').addEventListener('click', () => select(si, { scroll: innerWidth < 980 })));
  select(initial ?? readSel(), { scroll: initial != null && innerWidth < 980 });
}

document.body.dataset.page = 'index';
const f = /^#fach-(\d)$/.exec(location.hash);
index(f ? +f[1] - 1 : undefined);

/* «Verbesserung vorschlagen» in the bar */
const fb = el('button', { type: 'button', class: 'fb-open', html: '<span class="long">Verbesserung vorschlagen</span><span class="short">Feedback</span>' });
fb.addEventListener('click', () => openFeedback(''));
document.querySelector('.bar-in').append(fb);
