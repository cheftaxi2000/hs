#!/usr/bin/env python3
"""Builds the library data for the website from the PDFs.

Reads the bookmarks (outline) of every Lernskript and writes
  assets/library/library.json        table of contents: level, number, title, page, kind
  assets/library/<slug>/p<NNN>.webp  a preview image of every page a chapter or section starts on

Run it after a PDF changes:
    pip install pymupdf pillow
    python3 scripts/build_library.py

Kinds: "kapitel" (theory), "aufgaben" (exercises with solutions), "formeln" (appendix / formula sheet).
"""
import json
import re
import sys
from pathlib import Path

import pymupdf  # PyMuPDF
from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "assets" / "library"
PREVIEW_WIDTH = 560  # px; enough to recognise a page, ~20 KB as WebP
QUALITY = 50

BOOKS = [
    ("mechanik", "mechanik1/Mechanik1_Lernskript.pdf"),
    ("analysis", "analysis1/Analysis1_Lernskript.pdf"),
    ("linalg", "linalg1/Lineare_Algebra_Skript.pdf"),
    ("informatik", "informatics1/Informatics_Script.pdf"),
    ("chemie", "chemistry1/Chemistry_Script.pdf"),
]

EXERCISES = re.compile(r"aufgaben mit lösungen|problems with solutions", re.I)
APPENDIX = re.compile(r"^(anhang|appendix)\b", re.I)
NUMBERED = re.compile(r"^(\d+(?:\.\d+)*)\s+(.*)$")


def entries(doc):
    out, in_appendix = [], False
    for level, title, page in doc.get_toc(simple=True):
        title = " ".join(title.split())
        if level == 1:
            in_appendix = bool(APPENDIX.match(title))
        m = NUMBERED.match(title)
        num, text = (m.group(1), m.group(2)) if m else ("", title)
        kind = "formeln" if in_appendix else "aufgaben" if EXERCISES.search(text) else "kapitel"
        out.append({"level": level, "num": num, "title": text, "page": page, "kind": kind})
    return out


def render(doc, page, path):
    p = doc[page - 1]
    z = PREVIEW_WIDTH / p.rect.width
    pix = p.get_pixmap(matrix=pymupdf.Matrix(z, z), alpha=False)
    Image.frombytes("RGB", (pix.width, pix.height), pix.samples).save(path, "WEBP", quality=QUALITY, method=6)


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    library = {"previewWidth": PREVIEW_WIDTH, "books": {}}
    total_imgs = 0
    for slug, rel in BOOKS:
        pdf = ROOT / rel
        doc = pymupdf.open(pdf)
        toc = entries(doc)
        pages = sorted({e["page"] for e in toc if e["level"] <= 2} | {1})
        d = OUT / slug
        d.mkdir(exist_ok=True)
        keep = set()
        for pg in pages:
            f = d / f"p{pg:03d}.webp"
            keep.add(f.name)
            render(doc, pg, f)
        for old in d.glob("p*.webp"):  # pages that no longer start a section
            if old.name not in keep:
                old.unlink()
        total_imgs += len(pages)
        library["books"][slug] = {
            "pdf": rel,
            "pages": doc.page_count,
            "bytes": pdf.stat().st_size,
            "previews": pages,
            "toc": toc,
        }
        kinds = {k: sum(1 for e in toc if e["kind"] == k and e["level"] <= 2) for k in ("kapitel", "aufgaben", "formeln")}
        print(f"{slug:11s} {doc.page_count:4d} pages  {len(toc):3d} entries  {len(pages):3d} previews  {kinds}")
    (OUT / "library.json").write_text(json.dumps(library, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    size = sum(f.stat().st_size for f in OUT.rglob("*.webp")) / 1e6
    print(f"{total_imgs} previews, {size:.1f} MB -> {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
