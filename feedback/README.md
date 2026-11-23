# Meldungen einrichten («Verbesserung vorschlagen» und /errors)

GitHub Pages kann nichts speichern. Die Meldungen landen deshalb in einem Google Sheet, das du besitzt.
Einmalig, etwa drei Minuten:

1. Neues Google Sheet anlegen, z. B. «Lernstoff Meldungen».
2. Im Sheet: **Erweiterungen → Apps Script**. Den Inhalt von `Code.gs` einfügen und speichern.
3. Oben in `Code.gs` das `PASSWORT` ändern. Damit öffnest du später die Übersicht.
4. **Bereitstellen → Neue Bereitstellung → Typ: Web-App**
   - Ausführen als: **Ich**
   - Zugriff: **Jeder**
   Bereitstellen, Zugriff erlauben, die **Web-App-URL** kopieren (endet auf `/exec`).
5. In `assets/js/config.js` die URL bei `FEEDBACK_URL` eintragen, committen, pushen.

Danach:

- Auf jeder Seite gibt es oben rechts **Verbesserung vorschlagen**. Jede Meldung wird eine Zeile im Sheet,
  und du bekommst eine E-Mail (abschaltbar mit `MAIL_BEI_NEUER_MELDUNG = false`).
- Alle Meldungen siehst du unter **https://cheftaxi2000.github.io/hs/errors/** nach Eingabe des Passworts.
  Dort kannst du sie als erledigt markieren.

Solange `FEEDBACK_URL` leer ist, öffnet das Formular ein vorausgefülltes GitHub-Issue (dafür braucht der
Absender ein GitHub-Konto).

Ändert sich `Code.gs` später, unter **Bereitstellen → Bereitstellungen verwalten** eine neue Version der
bestehenden Bereitstellung anlegen, damit die URL gleich bleibt.
