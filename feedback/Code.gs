/**
 * Lernstoff DMAVT – Ablage für «Verbesserung vorschlagen».
 * In ein Google Sheet einfügen: Erweiterungen → Apps Script, diesen Code einfügen,
 * PASSWORT ändern, dann Bereitstellen → Neue Bereitstellung → Web-App
 * (Ausführen als: Ich, Zugriff: Jeder). Die Web-App-URL in assets/js/config.js eintragen.
 */
const PASSWORT = 'bitte-aendern';      // schützt die Übersicht unter /errors
const MAIL_BEI_NEUER_MELDUNG = true;   // E-Mail an dich bei jeder neuen Meldung
const BLATT = 'Meldungen';
const KOPF = ['id', 'zeit', 'art', 'wo', 'nachricht', 'name', 'email', 'seite', 'status', 'browser'];

function blatt_() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  let sh = ss.getSheetByName(BLATT);
  if (!sh) { sh = ss.insertSheet(BLATT); sh.appendRow(KOPF); sh.setFrozenRows(1); }
  return sh;
}
function text_(v, n) {
  let s = String(v == null ? '' : v).slice(0, n);
  if (/^[=+\-@]/.test(s)) s = "'" + s;   // keine Formeln aus dem Formular
  return s;
}
function json_(o) {
  return ContentService.createTextOutput(JSON.stringify(o)).setMimeType(ContentService.MimeType.JSON);
}

function doPost(e) {
  let d = {};
  try { d = JSON.parse(e.postData.contents || '{}'); } catch (err) { return json_({ ok: false }); }
  const sh = blatt_();
  if (d.action === 'status') {
    if (d.key !== PASSWORT) return json_({ ok: false, error: 'passwort' });
    const ids = sh.getRange(2, 1, Math.max(0, sh.getLastRow() - 1), 1).getValues();
    for (let i = 0; i < ids.length; i++) if (String(ids[i][0]) === String(d.id)) {
      sh.getRange(i + 2, 9).setValue(text_(d.status, 20));
      return json_({ ok: true });
    }
    return json_({ ok: false });
  }
  const nachricht = text_(d.message, 5000);
  if (!nachricht.trim()) return json_({ ok: false });
  const lock = LockService.getScriptLock(); lock.waitLock(5000);
  const id = Utilities.getUuid().slice(0, 8);
  sh.appendRow([id, new Date(), text_(d.kind, 30), text_(d.where, 300), nachricht, text_(d.name, 100), text_(d.email, 200), text_(d.page, 500), 'offen', text_(d.ua, 300)]);
  lock.releaseLock();
  if (MAIL_BEI_NEUER_MELDUNG) {
    try { MailApp.sendEmail(Session.getEffectiveUser().getEmail(), '[Lernstoff] ' + d.kind + ': ' + text_(d.where, 80), nachricht + '\n\n' + text_(d.page, 500)); } catch (err) {}
  }
  return json_({ ok: true, id: id });
}

function doGet(e) {
  if ((e.parameter.key || '') !== PASSWORT) return json_({ ok: false, error: 'passwort' });
  const rows = blatt_().getDataRange().getValues();
  rows.shift();
  const items = rows.map(function (r) {
    return { id: r[0], time: r[1], kind: r[2], where: r[3], message: r[4], name: r[5], email: r[6], page: r[7], status: r[8] };
  }).reverse();
  return json_({ ok: true, items: items });
}
