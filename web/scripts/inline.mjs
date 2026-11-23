// Turns dist-artifact/ into one self-contained HTML file (for the claude.ai artifact preview).
import { readFileSync, writeFileSync, readdirSync } from 'node:fs';
import { join } from 'node:path';

const dir = new URL('../dist-artifact/', import.meta.url).pathname;
let html = readFileSync(join(dir, 'index.html'), 'utf8');
const assets = join(dir, 'assets');
const files = readdirSync(assets);

// KaTeX ships woff2, woff and ttf for every face; browsers that run this page all read woff2.
const slimFonts = (css) => css.replace(/,\s*url\(data:font\/(woff|ttf)[^)]*\)\s*format\("(woff|truetype)"\)/g, '');

for (const f of files.filter((f) => f.endsWith('.css'))) {
  const css = slimFonts(readFileSync(join(assets, f), 'utf8'));
  html = html.replace(new RegExp(`<link rel="stylesheet"[^>]*${f}[^>]*>`), () => `<style>${css}</style>`);
}
for (const f of files.filter((f) => f.endsWith('.js'))) {
  const js = readFileSync(join(assets, f), 'utf8').replace(/<\/script/g, '<\\/script');
  html = html.replace(new RegExp(`<script type="module"[^>]*${f}[^>]*></script>`), () => `<script type="module">${js}</script>`);
}
writeFileSync(join(dir, 'standalone.html'), html);
// The artifact host supplies doctype, head and body itself: publish only the title, styles, root and script.
const head = readFileSync(join(dir, 'index.html'), 'utf8');
const css = files.filter((f) => f.endsWith('.css')).map((f) => slimFonts(readFileSync(join(assets, f), 'utf8'))).join('\n');
const js = files.filter((f) => f.endsWith('.js')).map((f) => readFileSync(join(assets, f), 'utf8').replace(/<\/script/g, '<\\/script')).join('\n');
const fragment = [
  head.match(/<title>[\s\S]*?<\/title>/)[0],
  head.match(/<meta name="description"[^>]*>/)[0],
  `<style>${css}</style>`,
  '<div id="root"></div>',
  `<script type="module">${js}</script>`,
].join('\n');
writeFileSync(join(dir, 'mechanik-tafeln.html'), fragment);
console.log('mechanik-tafeln.html', (fragment.length / 1024).toFixed(0), 'KiB');
