#!/bin/sh
# usage: build.sh [pages to render e.g. "3 4"]
python3 -c "import typst; typst.compile('main.typ', output='Mechanik1_Lernskript.pdf')" || exit 1
pdfinfo Mechanik1_Lernskript.pdf | grep Pages
S=/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/pg; mkdir -p $S
for p in "$@"; do pdftoppm -r 80 -f $p -l $p -png Mechanik1_Lernskript.pdf $S/p; done
