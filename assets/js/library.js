// The library: home (search, recently opened, five subjects), subject rooms (table of contents with page
// previews), the search dialog (⌘K) and the local «recently opened» list. Data: assets/library/library.json,
// written by scripts/build_library.py from the PDF bookmarks.
import { el } from './core.js';

const V = new URL(import.meta.url).search; // ?v=<commit> on GitHub Pages, so the data is never stale
export let LIB = null;
export const libReady = fetch('assets/library/library.json' + V).then((r) => r.json()).then((j) => (LIB = j));

let SUBJECTS = [], MODELS = [];
export function initLibrary(subjects, models) { SUBJECTS = subjects; MODELS = models; }

const KIND = { kapitel: 'Kapitel', aufgaben: 'Aufgaben', formeln: 'Formelsammlung' };
const mb = (b) => (b / 1e6).toFixed(1).replace('.', ',') + ' MB';
const pdfAt = (s, page) => `${s.pdf}#page=${page}`;
const fileName = (s) => s.pdf.split('/').pop();
const book = (s) => LIB.books[s.slug];
const fold = (t) => t.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/ß/g, 'ss');
const esc = (t) => String(t).replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));
const narrow = () => matchMedia('(max-width: 899px)').matches;
const reduced = () => matchMedia('(prefers-reduced-motion: reduce)').matches;

/* ---------------- recently opened (this browser only) ---------------- */
const RKEY = 'lernstoff.recent';
export function recent() { try { return JSON.parse(localStorage.getItem(RKEY) || '[]'); } catch { return []; } }
export function remember(item) {
  try {
    const list = recent().filter((x) => x.href !== item.href);
    list.unshift({ ...item, t: Date.now() });
    localStorage.setItem(RKEY, JSON.stringify(list.slice(0, 8)));
  } catch { /* private mode: nothing to remember */ }
}
const ago = (t) => {
  const m = Math.round((Date.now() - t) / 60000);
  if (m < 1) return 'gerade eben';
  if (m < 60) return `vor ${m} Min.`;
  const h = Math.round(m / 60);
  if (h < 24) return `vor ${h} Std.`;
  const d = Math.round(h / 24);
  return d === 1 ? 'gestern' : `vor ${d} Tagen`;
};

/* ---------------- table of contents helpers ---------------- */
function chapters(b) {
  const out = [];
  for (const e of b.toc) {
    if (e.level === 1) out.push({ ...e, items: [] });
    else if (e.level === 2 && out.length) out[out.length - 1].items.push({ ...e, chapter: out[out.length - 1] });
  }
  return out;
}
const previewFor = (b, page) => { let best = 1; for (const p of b.previews) if (p <= page) best = p; return best; };
const previewSrc = (s, page) => `assets/library/${s.slug}/p${String(previewFor(book(s), page)).padStart(3, '0')}.webp${V}`;

const SEARCH_ICON = '<svg viewBox="0 0 20 20" aria-hidden="true"><circle cx="8.5" cy="8.5" r="5.5" fill="none" stroke="currentColor" stroke-width="1.6"/><path d="m13 13 4.5 4.5" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>';
const isMac = typeof navigator !== 'undefined' && /Mac|iPhone|iPad/.test(navigator.platform || navigator.userAgent);
export const KBD = isMac ? '⌘K' : 'Strg K';

/* ================================================================ home */
export function renderHome(app) {
  const root = el('div', { class: 'home' });
  root.append(el('section', { class: 'home-head' },
    el('h1', { html: 'Lernstoff DMAVT' }),
    el('p', { class: 'lede', html: 'Fünf Lernskripte für das erste Studienjahr. Mit Inhaltsverzeichnis, Seitenvorschau und interaktiven Modellen.' }),
    searchField()));

  const rec = recent().slice(0, 4);
  if (rec.length) {
    root.append(el('section', { class: 'recent', 'aria-labelledby': 'recent-h' },
      el('h2', { id: 'recent-h', html: 'Zuletzt geöffnet' }),
      el('ol', {}, ...rec.map((r) => el('li', { 'data-subject': r.slug },
        el('a', { href: r.href, ...(r.ext ? { target: '_blank', rel: 'noopener' } : {}), onclick: () => remember(r) },
          el('span', { class: 'r-t', html: esc(r.title) }),
          el('span', { class: 'r-m', html: `${esc(r.sub)}<span class="r-ago">${ago(r.t)}</span>` })))))));
  }

  const list = el('ol', { class: 'spines' });
  for (const s of SUBJECTS) {
    const b = book(s), ch = chapters(b);
    const nCh = ch.filter((c) => c.kind === 'kapitel').length;
    const nEx = b.toc.filter((e) => e.level === 2 && e.kind === 'aufgaben').length;
    const models = MODELS.filter((m) => m.subject === s).length;
    list.append(el('li', { class: 'spine', 'data-subject': s.slug }, el('a', { href: '#' + s.slug },
      el('img', { class: 'spine-cover', src: s.cover, alt: '', width: 640, height: 905, loading: 'lazy', decoding: 'async' }),
      el('div', { class: 'spine-main' },
        el('h2', { html: s.group }),
        el('p', { class: 'spine-desc', html: s.desc }),
        el('p', { class: 'spine-topics', html: ch.filter((c) => c.kind === 'kapitel').map((c) => esc(c.title)).join('<span aria-hidden="true"> · </span>') })),
      el('dl', { class: 'facts' },
        fact('Kapitel', nCh), fact('Aufgaben', nEx), fact('Seiten', b.pages),
        fact('Sprache', s.lang, 'word'), fact('Modelle', models), fact('Tafeln', s.atlas ? s.atlas.n : '–', s.atlas ? '' : 'none')))));
  }
  root.append(el('section', { class: 'shelf', 'aria-label': 'Fächer' }, list), footer());
  app.append(root);
  return {};
}
function footer(s) {
  const fb = el('button', { type: 'button', class: 'link', html: 'Verbesserung vorschlagen' });
  fb.addEventListener('click', () => document.querySelector('.fb-open')?.click());
  return el('footer', { class: 'page-foot' },
    el('p', { html: s ? `Fehler in ${esc(s.group)} gefunden? ` : 'Fehler gefunden oder etwas unklar? ' }, fb),
    el('p', { class: 'pf-keys', html: `Suchen mit <kbd>${KBD}</kbd> oder <kbd>/</kbd>` }));
}
const fact = (k, v, cls = '') => el('div', {}, el('dt', { html: k }), el('dd', { class: cls, html: String(v) }));

function searchField() {
  const b = el('button', { type: 'button', class: 'searchfield', 'aria-label': `Suchen (${KBD})` },
    el('span', { class: 'sf-ic', html: SEARCH_ICON }),
    el('span', { class: 'sf-t', html: 'Kapitel, Thema oder Aufgabe suchen' }),
    el('kbd', { html: KBD }));
  b.addEventListener('click', () => openSearch());
  return b;
}

/* ================================================================ subject room */
export function renderRoom(app, s, state = {}) {
  const b = book(s);
  const ch = chapters(b);
  const nEx = b.toc.filter((e) => e.level === 2 && e.kind === 'aufgaben').length;
  const hasFormeln = b.toc.some((e) => e.kind === 'formeln');
  const root = el('div', { class: 'room', 'data-subject': s.slug });

  const openBtn = el('a', { class: 'btn primary', href: s.pdf, target: '_blank', rel: 'noopener', html: 'PDF öffnen' });
  openBtn.addEventListener('click', () => remember({ href: s.pdf, ext: true, slug: s.slug, title: `Lernskript ${s.group}`, sub: `${s.group} · ganzes PDF` }));
  root.append(el('header', { class: 'room-head' },
    el('img', { class: 'room-cover', src: s.cover, alt: `Umschlag Lernskript ${s.group}`, width: 640, height: 905, decoding: 'async' }),
    el('div', { class: 'room-id' },
      el('p', { class: 'kicker', html: `Lernskript · ${b.pages} Seiten · ${s.lang}` }),
      el('h1', { html: s.group }),
      el('p', { class: 'room-desc', html: s.desc }),
      el('div', { class: 'room-actions' }, openBtn,
        el('a', { class: 'btn', href: s.pdf, download: fileName(s), html: `Herunterladen <span class="btn-m">${mb(b.bytes)}</span>` })))));

  // filters
  const filters = [['inhalt', 'Inhalt', ch.filter((c) => c.kind === 'kapitel').length], ['aufgaben', 'Aufgaben', nEx]];
  if (hasFormeln) filters.push(['formeln', 'Formelsammlung', null]);
  let filter = state.filter && filters.some(([k]) => k === state.filter) ? state.filter : 'inhalt';
  const tabs = el('div', { class: 'tabs', role: 'tablist', 'aria-label': 'Ansicht' });
  const tabBtns = filters.map(([k, label, n]) => {
    const t = el('button', { type: 'button', role: 'tab', 'aria-selected': String(k === filter), 'aria-controls': 'toc', html: `${label}${n != null ? `<span class="tab-n">${n}</span>` : ''}` });
    t.addEventListener('click', () => { filter = k; tabBtns.forEach((x, i) => x.setAttribute('aria-selected', String(filters[i][0] === k))); drawToc(); history.replaceState(null, '', `#${s.slug}${k === 'inhalt' ? '' : '/' + k}`); });
    tabs.append(t); return t;
  });
  const models = MODELS.filter((m) => m.subject === s);
  if (models.length || s.atlas) tabs.append(el('a', { class: 'tab-link', href: '#' + s.slug + '-modelle', html: 'Interaktiv ↓', onclick: (e) => { e.preventDefault(); root.querySelector('.room-models').scrollIntoView({ behavior: reduced() ? 'auto' : 'smooth' }); } }));

  const toc = el('ol', { class: 'toc', id: 'toc' });
  const preview = makePreview(s), sheetPreview = makePreview(s, true);
  const sheet = el('dialog', { class: 'sheet', 'aria-label': 'Seitenvorschau' },
    el('div', { class: 'sheet-bar' }, el('button', { type: 'button', class: 'sheet-close', html: 'Schliessen', onclick: () => sheet.close() })), sheetPreview.el);
  sheet.addEventListener('click', (e) => { if (e.target === sheet) sheet.close(); });

  let selected = null;
  const rows = [];
  function row(e, { context = false } = {}) {
    // in the exercise view the chapter is what you look for; the section name becomes the small line
    const main = context && e.chapter ? e.chapter.title : e.title;
    const r = el('button', { type: 'button', class: `entry lv${e.level} k-${e.kind}`, 'data-page': e.page },
      el('span', { class: 'e-num', html: e.num || '' }),
      el('span', { class: 'e-t' },
        el('span', { class: 'e-title', html: esc(main) }),
        context && e.chapter ? el('span', { class: 'e-ctx', html: esc(e.title) }) : null),
      e.kind === 'aufgaben' && !context ? el('span', { class: 'e-tag', html: 'Aufgaben' }) : null,
      el('span', { class: 'e-page', html: String(e.page) }));
    r.addEventListener('click', () => { select(e, r); if (narrow()) sheet.showModal(); });
    rows.push([e, r]);
    return r;
  }
  function drawToc() {
    toc.replaceChildren(); rows.length = 0;
    if (filter === 'inhalt') {
      for (const c of ch) {
        const li = el('li', { class: 'ch' + (c.kind === 'formeln' ? ' ch-formeln' : '') }, row(c));
        if (c.items.length) li.append(el('ol', {}, ...c.items.map((x) => el('li', {}, row(x)))));
        toc.append(li);
      }
    } else if (filter === 'aufgaben') {
      for (const c of ch) for (const x of c.items) if (x.kind === 'aufgaben') toc.append(el('li', {}, row(x, { context: true })));
    } else {
      for (const c of ch) if (c.kind === 'formeln') { toc.append(el('li', { class: 'ch ch-formeln' }, row(c))); if (c.items.length) toc.append(el('li', {}, el('ol', {}, ...c.items.map((x) => el('li', {}, row(x)))))); }
    }
    const keep = selected && rows.find(([e]) => e.page === selected.page && e.title === selected.title);
    if (keep) select(keep[0], keep[1], false); else if (rows.length) select(rows[0][0], rows[0][1], false);
  }
  function select(e, r, updateUrl = true) {
    selected = e;
    rows.forEach(([, x]) => x.removeAttribute('aria-current'));
    r.setAttribute('aria-current', 'true');
    preview.show(e); sheetPreview.show(e);
    if (updateUrl) history.replaceState(null, '', `#${s.slug}/p${e.page}`);
  }

  root.append(tabs, el('div', { class: 'room-body' }, el('nav', { class: 'toc-wrap', 'aria-label': 'Inhaltsverzeichnis' }, toc), el('aside', { class: 'preview-col', 'aria-label': 'Seitenvorschau' }, preview.el)), sheet);

  // models and Tafeln
  if (models.length || s.atlas) {
    const plates = el('ol', { class: 'plates' });
    const thumbs = [];
    for (const m of models) {
      const cv = el('canvas', { 'aria-hidden': 'true' });
      thumbs.push([cv, m.m]);
      plates.append(el('li', {}, el('a', { class: 'plate', href: '#' + m.m.meta.id },
        cv, el('span', { class: 'plate-k', html: `Modell ${String(m.n).padStart(2, '0')}` }), el('span', { class: 'plate-t', html: m.name }))));
    }
    if (s.atlas) {
      const a = el('a', { class: 'plate', href: s.atlas.href },
        el('picture', { class: 'plate-pic' },
          el('source', { srcset: `assets/tafeln/${s.atlas.img}-dark.webp`, media: '(prefers-color-scheme: dark)' }),
          el('img', { src: `assets/tafeln/${s.atlas.img}-light.webp`, alt: '', width: 960, height: 600, loading: 'lazy', decoding: 'async' })),
        el('span', { class: 'plate-k', html: `${s.atlas.n} Tafeln` }), el('span', { class: 'plate-t', html: s.atlas.title }));
      a.addEventListener('click', () => remember({ href: s.atlas.href, slug: s.slug, title: s.atlas.title, sub: `${s.group} · ${s.atlas.n} Tafeln` }));
      plates.append(el('li', {}, a));
    }
    root.append(el('section', { class: 'room-models', id: s.slug + '-modelle', 'aria-labelledby': 'rm-h' },
      el('h2', { id: 'rm-h', html: 'Interaktiv' }), plates));
    root._thumbs = thumbs;
  }
  root.append(footer(s));
  app.append(root);
  drawToc();
  if (state.page) {
    const hit = rows.find(([e]) => e.page === state.page) || rows.filter(([e]) => e.page <= state.page).pop();
    if (hit) {
      select(hit[0], hit[1], false);
      hit[1].scrollIntoView({ block: 'center' });
      if (narrow()) sheet.showModal();
    }
  }
  return { thumbs: root._thumbs || [] };
}

function makePreview(s, inSheet = false) {
  const img = el('img', { alt: '', width: 560, height: 792, decoding: 'async' });
  const page = el('span', { class: 'pv-page' });
  const title = el('span', { class: 'pv-title' });
  const kind = el('span', { class: 'pv-kind' });
  const open = el('a', { class: 'btn primary', target: '_blank', rel: 'noopener' });
  const node = el('div', { class: 'pv' + (inSheet ? ' in-sheet' : '') },
    el('figure', { class: 'pv-paper' }, img),
    el('div', { class: 'pv-cap' }, kind, title, page),
    el('div', { class: 'pv-actions' }, open, el('a', { class: 'btn', href: s.pdf, download: fileName(s), html: 'Herunterladen' })));
  let cur = null;
  open.addEventListener('click', () => cur && remember({
    href: pdfAt(s, cur.page), ext: true, slug: s.slug, title: `${cur.num ? cur.num + ' ' : ''}${cur.title}`, sub: `${s.group} · Seite ${cur.page}`,
  }));
  return {
    el: node,
    show(e) {
      cur = e;
      const src = previewSrc(s, e.page);
      if (img.getAttribute('src') !== src) img.src = src;
      img.alt = `Seite ${e.page} aus dem Lernskript ${s.group}`;
      kind.textContent = KIND[e.kind];
      title.textContent = `${e.num ? e.num + '  ' : ''}${e.title}`;
      page.textContent = `Seite ${e.page} von ${book(s).pages}`;
      open.href = pdfAt(s, e.page);
      open.textContent = `Auf Seite ${e.page} öffnen`;
    },
  };
}

/* ================================================================ search (⌘K) */
let dlg = null, index = null;
function buildIndex() {
  const out = [];
  for (const s of SUBJECTS) {
    out.push({ type: 'subject', s, title: s.group, href: '#' + s.slug, meta: `Lernskript · ${book(s).pages} Seiten`, hay: fold(`${s.group} ${s.desc}`) });
    let chap = null;
    for (const e of book(s).toc) {
      if (e.level === 1) chap = e;
      out.push({ type: 'entry', s, e, title: e.title, num: e.num, href: `#${s.slug}/p${e.page}`, chap,
        meta: `${s.group}${e.num ? ' · ' + e.num : ''} · S. ${e.page}`, hay: fold(`${e.num} ${e.title} ${KIND[e.kind]}`), ctx: fold(`${s.group} ${s.slug} ${chap && chap !== e ? chap.title : ''}`) });
    }
    if (s.atlas) out.push({ type: 'tafeln', s, title: s.atlas.title, href: s.atlas.href, meta: `${s.group} · ${s.atlas.n} bewegte Figuren`, hay: fold(`${s.atlas.title} tafeln animation`) });
  }
  for (const m of MODELS) out.push({ type: 'model', s: m.subject, title: m.name, href: '#' + m.m.meta.id, meta: `${m.subject.group} · Modell ${String(m.n).padStart(2, '0')}`, hay: fold(`${m.name} ${m.m.meta.title} modell`) });
  return out;
}
function search(q) {
  const toks = fold(q).split(/\s+/).filter(Boolean);
  if (!toks.length) return null;
  const hits = [];
  for (const it of index) {
    let score = 0, ok = true;
    for (const t of toks) {
      const inTitle = it.hay.indexOf(t);
      const inCtx = it.ctx ? it.ctx.indexOf(t) : -1;
      if (inTitle < 0 && inCtx < 0) { ok = false; break; }
      if (inTitle === 0) score += 30; else if (inTitle > 0 && /[\s(.-]/.test(it.hay[inTitle - 1])) score += 16; else if (inTitle > 0) score += 6; else score += 2;
    }
    if (!ok) continue;
    if (it.type === 'subject') score += 12;
    else if (it.type === 'model' || it.type === 'tafeln') score += 6;
    else score += it.e.level === 1 ? 6 : it.e.level === 2 ? 3 : 0;
    hits.push([score, it]);
  }
  hits.sort((a, b) => b[0] - a[0] || SUBJECTS.indexOf(a[1].s) - SUBJECTS.indexOf(b[1].s) || (a[1].e?.page || 0) - (b[1].e?.page || 0));
  return hits.slice(0, 40).map((h) => h[1]);
}
const TYPE = { subject: 'Fach', model: 'Modell', tafeln: 'Tafeln' };
function mark(text, q) {
  let html = esc(text);
  for (const t of fold(q).split(/\s+/).filter(Boolean)) {
    const f = fold(text), i = f.indexOf(t);
    if (i >= 0 && f.length === text.length) { html = esc(text.slice(0, i)) + '<mark>' + esc(text.slice(i, i + t.length)) + '</mark>' + esc(text.slice(i + t.length)); break; }
  }
  return html;
}
export async function openSearch() {
  await libReady;
  if (!index) index = buildIndex();
  if (!dlg) {
    const input = el('input', { type: 'search', class: 'search-in', placeholder: 'Kapitel, Thema, Aufgabe, Modell …', 'aria-label': 'Suchen', autocomplete: 'off', spellcheck: 'false', role: 'combobox', 'aria-expanded': 'true', 'aria-controls': 'hits' });
    const hits = el('ol', { class: 'hits', id: 'hits', role: 'listbox', 'aria-label': 'Treffer' });
    const foot = el('p', { class: 'search-foot', html: '<span><kbd>↑</kbd><kbd>↓</kbd> wählen</span><span><kbd>Enter</kbd> öffnen</span><span><kbd>Esc</kbd> schliessen</span>' });
    dlg = el('dialog', { class: 'search', 'aria-label': 'Suche' },
      el('div', { class: 'search-top' }, el('span', { class: 'sf-ic', html: SEARCH_ICON }), input), hits, foot);
    let items = [], act = 0;
    const go = (it) => { dlg.close(); if (it.type === 'tafeln') { remember({ href: it.href, slug: it.s.slug, title: it.title, sub: it.meta }); location.href = it.href; } else location.hash = it.href.slice(1); };
    const paint = () => {
      const q = input.value.trim();
      const res = search(q);
      items = res || [
        ...SUBJECTS.map((s) => index.find((x) => x.type === 'subject' && x.s === s)),
        ...index.filter((x) => x.type === 'entry' && x.e.level === 1 && x.e.kind === 'formeln'),
      ];
      act = 0;
      hits.replaceChildren(...(items.length ? items.map((it, i) => {
        const li = el('li', { role: 'option', id: 'hit-' + i, 'aria-selected': String(i === 0), 'data-subject': it.s.slug },
          el('span', { class: 'h-dot', 'aria-hidden': 'true' }),
          el('span', { class: 'h-t' }, el('span', { class: 'h-title', html: (it.num ? `<span class="h-num">${esc(it.num)}</span>` : '') + mark(it.title, q) }), el('span', { class: 'h-meta', html: esc(it.meta) })),
          el('span', { class: 'h-type', html: it.type === 'entry' ? KIND[it.e.kind] : TYPE[it.type] }));
        li.addEventListener('click', () => go(it));
        li.addEventListener('mousemove', () => { if (act !== i) { act = i; sync(); } });
        return li;
      }) : [el('li', { class: 'h-none', html: `Nichts gefunden für «${esc(q)}».` })]));
      if (!res) hits.prepend(el('li', { class: 'h-head', role: 'presentation', html: 'Fächer und Formelsammlungen' }));
      sync();
    };
    const sync = () => {
      hits.querySelectorAll('[role=option]').forEach((li, i) => li.setAttribute('aria-selected', String(i === act)));
      const a = hits.querySelector(`#hit-${act}`);
      if (a) { input.setAttribute('aria-activedescendant', a.id); a.scrollIntoView({ block: 'nearest' }); }
    };
    input.addEventListener('input', paint);
    input.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowDown') { e.preventDefault(); act = Math.min(items.length - 1, act + 1); sync(); }
      else if (e.key === 'ArrowUp') { e.preventDefault(); act = Math.max(0, act - 1); sync(); }
      else if (e.key === 'Enter' && items[act]) { e.preventDefault(); go(items[act]); }
      else if (e.key === 'Escape') { e.preventDefault(); dlg.close(); }
    });
    dlg.addEventListener('click', (e) => { if (e.target === dlg) dlg.close(); });
    dlg.paint = paint; dlg.input = input;
    document.body.append(dlg);
  }
  dlg.input.value = '';
  dlg.paint();
  dlg.showModal();
  dlg.input.focus();
}
addEventListener('keydown', (e) => {
  const typing = /^(input|textarea|select)$/i.test(document.activeElement?.tagName || '') || document.activeElement?.isContentEditable;
  if ((e.key === 'k' || e.key === 'K') && (e.metaKey || e.ctrlKey)) { e.preventDefault(); if (dlg?.open) dlg.close(); else openSearch(); }
  else if (e.key === '/' && !typing && !document.querySelector('dialog[open]')) { e.preventDefault(); openSearch(); }
});
