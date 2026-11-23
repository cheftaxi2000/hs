import katex from 'katex';

/** Lecture notation: vectors bold (as in the Lernskript). */
const macros = {
  '\\v': '\\boldsymbol{#1}',
  '\\e': '\\boldsymbol{e}_{#1}',
};

const cache = new Map<string, string>();
export function texHtml(tex: string, display = false): string {
  const key = (display ? 'D' : 'I') + tex;
  let html = cache.get(key);
  if (html === undefined) {
    html = katex.renderToString(tex, { displayMode: display, throwOnError: false, macros: { ...macros }, strict: false });
    cache.set(key, html);
  }
  return html;
}

export function Tex({ children, display = false, className }: { children: string; display?: boolean; className?: string }) {
  return <span className={className} dangerouslySetInnerHTML={{ __html: texHtml(children, display) }} />;
}

/** Decimal comma, fixed digits, true minus sign: a number ready to go inside TeX. */
export function num(x: number, digits = 2): string {
  const s = Math.abs(x) < 0.5 * 10 ** -digits ? (0).toFixed(digits) : x.toFixed(digits);
  return s.replace('-', '-').replace('.', '{,}');
}
