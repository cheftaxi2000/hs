// «Verbesserung vorschlagen»: a small dialog that sends a report to the Apps Script endpoint.
import { el } from './core.js';
import { FEEDBACK_URL, REPO } from './config.js';

let dlg = null;
function build() {
  const kind = el('div', { class: 'fb-kind', role: 'radiogroup', 'aria-label': 'Art der Meldung' });
  for (const [v, l] of [['fehler', 'Fehler'], ['verbesserung', 'Verbesserung'], ['frage', 'Frage'], ['sonstiges', 'Sonstiges']]) {
    const id = 'fb-k-' + v;
    kind.append(el('input', { type: 'radio', name: 'kind', id, value: v, checked: v === 'fehler' || null }), el('label', { for: id, html: l }));
  }
  const where = el('input', { type: 'text', id: 'fb-where', name: 'where', autocomplete: 'off', placeholder: 'z. B. Mechanik 1, Seite 42, Gleichung (3.7)' });
  const msg = el('textarea', { id: 'fb-msg', name: 'message', rows: 6, required: true, placeholder: 'Was ist falsch oder was könnte besser sein?' });
  const name = el('input', { type: 'text', id: 'fb-name', name: 'name', autocomplete: 'name', placeholder: 'optional' });
  const mail = el('input', { type: 'email', id: 'fb-mail', name: 'email', autocomplete: 'email', placeholder: 'optional, für eine Rückmeldung' });
  const trap = el('input', { type: 'text', name: 'website', tabindex: '-1', autocomplete: 'off', class: 'fb-trap', 'aria-hidden': 'true' });
  const note = el('p', { class: 'fb-note' });
  const send = el('button', { type: 'submit', class: 'btn solid', html: 'Senden' });
  const cancel = el('button', { type: 'button', class: 'btn', html: 'Abbrechen' });
  const form = el('form', { class: 'fb-form', novalidate: true },
    el('div', { class: 'fb-head' }, el('h2', { html: 'Verbesserung vorschlagen' }), el('p', { html: 'Fehler gefunden oder etwas unklar? Die Meldung geht direkt an den Autor.' })),
    el('fieldset', {}, el('legend', { html: 'Art' }), kind),
    el('label', { for: 'fb-where', html: 'Wo' }), where,
    el('label', { for: 'fb-msg', html: 'Nachricht' }), msg,
    el('div', { class: 'fb-two' }, el('div', {}, el('label', { for: 'fb-name', html: 'Name' }), name), el('div', {}, el('label', { for: 'fb-mail', html: 'E-Mail' }), mail)),
    trap, note, el('div', { class: 'fb-actions' }, cancel, send));
  const d = el('dialog', { class: 'fb' }, form);
  cancel.addEventListener('click', () => d.close());
  d.addEventListener('click', (e) => { if (e.target === d) d.close(); });
  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    if (!msg.value.trim()) { note.textContent = 'Bitte eine Nachricht eingeben.'; msg.focus(); return; }
    if (trap.value) { d.close(); return; }
    const data = {
      action: 'add', kind: form.kind.value, where: where.value.trim(), message: msg.value.trim(),
      name: name.value.trim(), email: mail.value.trim(), page: location.href, ua: navigator.userAgent,
    };
    if (!FEEDBACK_URL) {
      const body = `**Art:** ${data.kind}\n**Wo:** ${data.where || '—'}\n**Seite:** ${data.page}\n\n${data.message}\n\n${data.name ? '— ' + data.name : ''}`;
      window.open(`https://github.com/${REPO}/issues/new?title=${encodeURIComponent(`[${data.kind}] ${data.where || 'Lernstoff'}`)}&body=${encodeURIComponent(body)}`, '_blank', 'noopener');
      d.close(); return;
    }
    send.disabled = true; note.textContent = 'Wird gesendet …';
    try {
      // text/plain avoids a CORS preflight; Apps Script reads e.postData.contents
      await fetch(FEEDBACK_URL, { method: 'POST', mode: 'no-cors', headers: { 'Content-Type': 'text/plain;charset=utf-8' }, body: JSON.stringify(data) });
      form.replaceChildren(el('div', { class: 'fb-head' }, el('h2', { html: 'Danke' }), el('p', { html: 'Die Meldung ist angekommen. Sie wird gelesen und das Skript gegebenenfalls korrigiert.' })),
        el('div', { class: 'fb-actions' }, Object.assign(el('button', { type: 'button', class: 'btn solid', html: 'Schließen' }), { onclick: () => { d.close(); dlg?.remove(); dlg = null; } })));
    } catch (err) {
      note.textContent = 'Senden hat nicht geklappt. Bitte später noch einmal versuchen.'; send.disabled = false;
    }
  });
  document.body.append(d);
  d._where = where;
  return d;
}

export function openFeedback(context = '') {
  if (!dlg) dlg = build();
  if (context && !dlg._where.value) dlg._where.value = context;
  dlg.showModal();
  dlg.querySelector('textarea')?.focus();
}
