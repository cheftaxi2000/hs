import { useEffect, useState } from 'react';
import { CHAPTERS } from './content';

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

function useCurrentChapter() {
  const [cur, setCur] = useState(CHAPTERS[0].id);
  useEffect(() => {
    if (typeof IntersectionObserver === 'undefined') return;
    const io = new IntersectionObserver((es) => {
      for (const e of es) if (e.isIntersecting) setCur(e.target.id);
    }, { rootMargin: '-35% 0px -60% 0px' });
    CHAPTERS.forEach((c) => { const el = document.getElementById(c.id); if (el) io.observe(el); });
    return () => io.disconnect();
  }, []);
  return cur;
}

export function App() {
  const { toggle, dark } = useTheme();
  const cur = useCurrentChapter();
  const plates = CHAPTERS.reduce((n, c) => n + c.plates.length, 0);
  return (
    <>
      <header className="top">
        <a className="mark" href="#">Mechanik 1</a>
        <button className="theme" onClick={toggle} aria-label={dark ? 'Helle Darstellung' : 'Dunkle Darstellung'}>
          {dark
            ? <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" strokeWidth="1.5"><circle cx="10" cy="10" r="3.6" /><path d="M10 1.8v2.4M10 15.8v2.4M1.8 10h2.4M15.8 10h2.4M4.2 4.2l1.7 1.7M14.1 14.1l1.7 1.7M4.2 15.8l1.7-1.7M14.1 5.9l1.7-1.7" /></svg>
            : <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" strokeWidth="1.5"><path d="M16.5 12.6A7 7 0 0 1 7.4 3.5a7 7 0 1 0 9.1 9.1Z" /></svg>}
        </button>
      </header>
      <main className="shell">
        <nav className="toc" aria-label="Kapitel">
          <ol>
            {CHAPTERS.map((c) => (
              <li key={c.id}><a href={'#' + c.id} className={cur === c.id ? 'here' : ''}><span className="n">{c.num}</span><span>{c.title}</span></a></li>
            ))}
          </ol>
        </nav>
        <div className="hero">
          <h1>Mechanik 1 in bewegten Tafeln</h1>
          <p>{plates} Figuren zum Lernskript, eine pro Begriff. Jede Bewegung ist aus den Gleichungen berechnet, nicht gezeichnet.</p>
        </div>
        {CHAPTERS.map((c) => (
          <section key={c.id} id={c.id} className="chapter" aria-labelledby={c.id + '-t'}>
            <div className="chapter-h"><span className="n">{c.num}</span><h2 id={c.id + '-t'}>{c.title}</h2></div>
            {c.plates.map((P, i) => <P key={i} />)}
          </section>
        ))}
        <footer className="foot">
          Farben wie im Skript: Geschwindigkeiten blau, Kräfte rot, Drehungen und Momente grün. Vektoren fett.
        </footer>
      </main>
    </>
  );
}
