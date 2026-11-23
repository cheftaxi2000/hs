import { useEffect, useLayoutEffect, useState } from 'react';
import { SUBJECTS, subjectOf, type Subject } from './content';

function useTheme() {
  const read = (): 'light' | 'dark' | null => { try { const v = localStorage.getItem('atlas.theme'); return v === 'light' || v === 'dark' ? v : null; } catch { return null; } };
  const [theme, setTheme] = useState(read);
  useEffect(() => {
    if (theme) document.documentElement.dataset.theme = theme; else delete document.documentElement.dataset.theme;
  }, [theme]);
  const isDark = () => theme ? theme === 'dark' : typeof matchMedia !== 'undefined' && matchMedia('(prefers-color-scheme: dark)').matches;
  const toggle = () => {
    const next = isDark() ? 'light' : 'dark';
    setTheme(next);
    try { localStorage.setItem('atlas.theme', next); } catch { /* private mode: keep it for this visit */ }
  };
  return { toggle, dark: isDark() };
}

/** Back to the library: relative on GitHub Pages (/hs/mechanik/ → /hs/), absolute elsewhere (single-file preview). */
const LIBRARY = typeof location !== 'undefined' && /\/hs\/(mechanik|analysis)\/?$/.test(location.pathname) ? '../' : 'https://cheftaxi2000.github.io/hs/';

const readHash = () => (typeof location !== 'undefined' ? decodeURIComponent(location.hash.replace(/^#/, '')) : '');

/** The subject comes from the hash (#analysis, #mechanik, or a chapter anchor such as #a3). */
function useSubject() {
  const [hash, setHash] = useState(readHash);
  const [subject, setSubject] = useState<Subject>(() => subjectOf(readHash()));
  useEffect(() => {
    const on = () => {
      const h = readHash();
      setHash(h);
      if (h) setSubject((s) => (s.chapters.some((c) => c.id === h) ? s : subjectOf(h)));
    };
    addEventListener('hashchange', on);
    return () => removeEventListener('hashchange', on);
  }, []);
  // after a switch: a subject link goes to the top, a chapter link to its chapter
  useLayoutEffect(() => {
    const el = hash && subject.chapters.some((c) => c.id === hash) ? document.getElementById(hash) : null;
    if (el) el.scrollIntoView(); else if (SUBJECTS.some((s) => s.id === hash)) scrollTo(0, 0);
  }, [subject, hash]);
  return subject;
}

function useCurrentChapter(subject: Subject) {
  const [cur, setCur] = useState(subject.chapters[0].id);
  useEffect(() => {
    setCur(subject.chapters[0].id);
    if (typeof IntersectionObserver === 'undefined') return;
    const io = new IntersectionObserver((es) => {
      for (const e of es) if (e.isIntersecting) setCur(e.target.id);
    }, { rootMargin: '-35% 0px -60% 0px' });
    subject.chapters.forEach((c) => { const el = document.getElementById(c.id); if (el) io.observe(el); });
    return () => io.disconnect();
  }, [subject]);
  return cur;
}

export function App() {
  const { toggle, dark } = useTheme();
  const subject = useSubject();
  const cur = useCurrentChapter(subject);
  useEffect(() => { document.title = `${subject.name} in Tafeln`; }, [subject]);
  return (
    <>
      <header className="top">
        <div className="top-in">
          <a className="mark" href={LIBRARY}>Lernstoff DMAVT</a>
          <span className="sl crumb-sl" aria-hidden="true">/</span>
          <nav className="subjects" aria-label="Fach">
            {SUBJECTS.map((s) => (
              <a key={s.id} href={'#' + s.id} className={s.id === subject.id ? 'on' : ''} aria-current={s.id === subject.id ? 'page' : undefined}>{s.name}</a>
            ))}
          </nav>
          <button className="theme" onClick={toggle}>{dark ? 'Hell' : 'Dunkel'}</button>
        </div>
      </header>
      <main className="shell" key={subject.id}>
        <nav className="toc" aria-label="Kapitel">
          <ol>
            {subject.chapters.map((c) => (
              <li key={c.id}><a href={'#' + c.id} className={cur === c.id ? 'here' : ''}><span className="n">{c.num}</span><span>{c.title}</span></a></li>
            ))}
          </ol>
        </nav>
        <div className="hero">
          <h1>{subject.title}</h1>
          <p>{subject.lede}</p>
        </div>
        {subject.chapters.map((c) => (
          <section key={c.id} id={c.id} className="chapter" aria-labelledby={c.id + '-t'}>
            <div className="chapter-h"><span className="n">{c.num}</span><h2 id={c.id + '-t'}>{c.title}</h2></div>
            {c.plates.map((P, i) => <P key={i} />)}
          </section>
        ))}
        <footer className="foot">
          {subject.id === 'mechanik'
            ? 'Farben wie im Skript: Geschwindigkeiten blau, Kräfte rot, Drehungen und Momente grün. Vektoren fett.'
            : 'Schwarz die Funktion, blau ihre Steigung und Näherungen, grün Flächen, violett Konstruktionen.'}
        </footer>
      </main>
    </>
  );
}
