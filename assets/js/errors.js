// /errors: the list of reports, read from the Apps Script endpoint with the owner's password.
import { el } from './core.js';
import { FEEDBACK_URL } from './config.js';

const root = document.getElementById('inbox');
const KEY = 'lernstoff-inbox-key';
const store = { get() { try { return localStorage.getItem(KEY) || ''; } catch { return ''; } }, set(v) { try { localStorage.setItem(KEY, v); } catch {} }, clear() { try { localStorage.removeItem(KEY); } catch {} } };
let items = [], filter = 'offen';

const head = el('section', { class: 'sec-h inbox-h' }, el('h2', { html: 'Meldungen' }));
root.append(head);
const body = el('div');
root.append(body);

if (!FEEDBACK_URL) {
  body.append(el('div', { class: 'inbox-empty', html: '<p>Die Ablage ist noch nicht eingerichtet. Die Anleitung steht im Repository unter <code>feedback/README.md</code>: Google Sheet anlegen, <code>Code.gs</code> einfügen, als Web-App bereitstellen und die URL in <code>assets/js/config.js</code> eintragen.</p><p>Bis dahin werden Meldungen als GitHub-Issues angelegt.</p>' }));
} else if (store.get()) load(); else login();

function login(msg) {
  body.replaceChildren();
  const pw = el('input', { type: 'password', id: 'inbox-pw', autocomplete: 'current-password' });
  const f = el('form', { class: 'inbox-login' }, el('label', { for: 'inbox-pw', html: 'Passwort' }), pw, el('button', { type: 'submit', class: 'btn solid', html: 'Öffnen' }), msg ? el('p', { class: 'fb-note', html: msg }) : null);
  f.addEventListener('submit', (e) => { e.preventDefault(); store.set(pw.value); load(); });
  body.append(f); pw.focus();
}

async function load() {
  body.replaceChildren(el('p', { class: 'inbox-empty', html: 'Wird geladen …' }));
  try {
    const r = await fetch(`${FEEDBACK_URL}?key=${encodeURIComponent(store.get())}&t=${Date.now()}`);
    const d = await r.json();
    if (!d.ok) { store.clear(); login('Passwort falsch.'); return; }
    items = d.items; show();
  } catch (e) { body.replaceChildren(el('p', { class: 'inbox-empty', html: 'Die Meldungen konnten nicht geladen werden. Ist die Web-App-URL in config.js richtig?' })); }
}

function show() {
  const counts = { offen: 0, erledigt: 0 }; items.forEach((i) => (counts[i.status === 'erledigt' ? 'erledigt' : 'offen'] += 1));
  const tabs = el('div', { class: 'scenes inbox-tabs' });
  for (const [k, l] of [['offen', `Offen ${counts.offen}`], ['erledigt', `Erledigt ${counts.erledigt}`], ['alle', `Alle ${items.length}`]]) {
    const b = el('button', { type: 'button', 'aria-pressed': String(filter === k), html: l }); b.addEventListener('click', () => { filter = k; show(); }); tabs.append(b);
  }
  const reload = el('button', { type: 'button', class: 'btn', html: 'Aktualisieren' }); reload.addEventListener('click', load);
  const out = el('button', { type: 'button', class: 'btn', html: 'Abmelden' }); out.addEventListener('click', () => { store.clear(); login(); });
  const list = el('ol', { class: 'inbox-list' });
  const shown = items.filter((i) => filter === 'alle' || (filter === 'erledigt') === (i.status === 'erledigt'));
  if (!shown.length) list.append(el('li', { class: 'inbox-empty', html: 'Keine Meldungen.' }));
  for (const i of shown) {
    const t = new Date(i.time);
    const done = i.status === 'erledigt';
    const tog = el('button', { type: 'button', class: 'btn', html: done ? 'Wieder öffnen' : 'Erledigt' });
    tog.addEventListener('click', async () => {
      tog.disabled = true;
      await fetch(FEEDBACK_URL, { method: 'POST', mode: 'no-cors', headers: { 'Content-Type': 'text/plain;charset=utf-8' }, body: JSON.stringify({ action: 'status', id: i.id, status: done ? 'offen' : 'erledigt', key: store.get() }) });
      i.status = done ? 'offen' : 'erledigt'; show();
    });
    const who = [i.name, i.email ? `<a href="mailto:${encodeURI(i.email)}">${esc(i.email)}</a>` : ''].filter(Boolean).join(' · ');
    list.append(el('li', { class: 'inbox-item' + (done ? ' done' : '') },
      el('div', { class: 'inbox-meta' }, el('span', { class: 'inbox-kind', html: esc(i.kind) }), el('span', { class: 'num', html: isNaN(t) ? '' : t.toLocaleString('de-CH', { dateStyle: 'medium', timeStyle: 'short' }) })),
      el('div', {},
        i.where ? el('h3', { html: esc(i.where) }) : null,
        el('p', { class: 'inbox-msg', html: esc(i.message) }),
        el('p', { class: 'inbox-from', html: [who, i.page ? `<a href="${esc(i.page)}">Seite öffnen</a>` : ''].filter(Boolean).join(' · ') })),
      tog));
  }
  body.replaceChildren(el('div', { class: 'inbox-bar' }, tabs, el('div', { class: 'toggles' }, reload, out)), list);
}
function esc(s) { return String(s ?? '').replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[c]); }
