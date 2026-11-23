// In-page PDF reader (PDF.js): the script stays inside the site, so «back» always works.
import { el } from './core.js';

const PDFJS = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/';
let libPromise = null;
function loadLib() {
  if (window.pdfjsLib) return Promise.resolve(window.pdfjsLib);
  if (!libPromise) libPromise = new Promise((res, rej) => {
    const s = document.createElement('script'); s.src = PDFJS + 'pdf.min.js';
    s.onload = () => { window.pdfjsLib.GlobalWorkerOptions.workerSrc = PDFJS + 'pdf.worker.min.js'; res(window.pdfjsLib); };
    s.onerror = () => { libPromise = null; rej(new Error('PDF.js konnte nicht geladen werden')); };
    document.head.append(s);
  });
  return libPromise;
}

export function openReader(root, subject, { onBack } = {}) {
  const file = subject.pdf.split('/').pop();
  const count = el('span', { class: 'rd-count num', html: `${subject.pages} Seiten` });
  const zoomOut = el('button', { type: 'button', class: 'rd-btn', 'aria-label': 'Verkleinern', html: '−' });
  const zoomIn = el('button', { type: 'button', class: 'rd-btn', 'aria-label': 'Vergrößern', html: '+' });
  const back = el('button', { type: 'button', class: 'rd-back', html: '← Bibliothek' });
  back.addEventListener('click', () => onBack?.());
  const bar = el('div', { class: 'rd-bar' }, back,
    el('div', { class: 'rd-title' }, el('span', { html: `Lernskript ${subject.group}` }), count),
    el('div', { class: 'rd-tools' }, zoomOut, zoomIn,
      el('a', { class: 'rd-btn rd-dl', href: subject.pdf, download: file, html: 'Laden ↓' })));
  const pagesEl = el('div', { class: 'rd-pages' });
  const status = el('div', { class: 'rd-status', html: 'Skript wird geladen …' });
  const wrap = el('div', { class: 'reader' }, bar, status, pagesEl);
  root.append(wrap);

  let alive = true, doc = null, zoom = 1, io = null, slots = [], cur = 1;
  const width = () => Math.min(pagesEl.clientWidth - 32, 860) * zoom;

  function layout() {
    if (!doc) return;
    const w = width();
    for (const s of slots) { s.el.style.width = w + 'px'; s.el.style.height = w * s.ratio + 'px'; s.done = 0; s.el.querySelector('canvas')?.remove(); }
    io?.disconnect();
    io = new IntersectionObserver((ents) => ents.forEach((e) => { if (e.isIntersecting) render(slots[+e.target.dataset.i]); }), { root: null, rootMargin: '1200px 0px' });
    slots.forEach((s) => io.observe(s.el));
  }
  async function render(s) {
    const w = width();
    if (!alive || s.done === w || s.busy) return;
    s.busy = true;
    try {
      const page = await doc.getPage(s.n);
      const vp0 = page.getViewport({ scale: 1 }), scale = w / vp0.width, dpr = Math.min(devicePixelRatio || 1, 2.5);
      const vp = page.getViewport({ scale: scale * dpr });
      const cv = document.createElement('canvas'); cv.width = Math.round(vp.width); cv.height = Math.round(vp.height);
      await page.render({ canvasContext: cv.getContext('2d'), viewport: vp }).promise;
      if (!alive) return;
      s.el.querySelector('canvas')?.remove(); s.el.append(cv); s.done = w;
    } catch (e) { console.error(e); }
    s.busy = false;
  }
  const onScroll = () => {
    if (!slots.length) return;
    const mid = window.innerHeight * 0.4;
    for (const s of slots) { const r = s.el.getBoundingClientRect(); if (r.top <= mid && r.bottom >= mid) { if (cur !== s.n) { cur = s.n; count.textContent = `Seite ${cur} / ${doc.numPages}`; } break; } }
  };
  addEventListener('scroll', onScroll, { passive: true });
  let rt = 0; const onResize = () => { clearTimeout(rt); rt = setTimeout(layout, 150); };
  addEventListener('resize', onResize);
  zoomIn.addEventListener('click', () => { zoom = Math.min(2, zoom + 0.25); layout(); });
  zoomOut.addEventListener('click', () => { zoom = Math.max(0.5, zoom - 0.25); layout(); });

  loadLib().then((lib) => lib.getDocument({ url: subject.pdf }).promise).then(async (d) => {
    if (!alive) return; doc = d;
    const first = await d.getPage(1), v = first.getViewport({ scale: 1 }), ratio = v.height / v.width;
    status.remove();
    for (let n = 1; n <= d.numPages; n++) {
      const s = { n, ratio, el: el('div', { class: 'rd-page', 'data-i': n - 1, 'aria-label': `Seite ${n}` }), done: 0 };
      slots.push(s); pagesEl.append(s.el);
    }
    count.textContent = `Seite 1 / ${d.numPages}`;
    layout();
  }).catch((e) => {
    console.error(e);
    status.innerHTML = '';
    status.append('Das Skript konnte hier nicht angezeigt werden. ', el('a', { href: subject.pdf, html: 'PDF direkt öffnen' }));
  });

  return { destroy() { alive = false; io?.disconnect(); removeEventListener('scroll', onScroll); removeEventListener('resize', onResize); doc?.destroy?.(); } };
}
