#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

build() {
  echo "Building document"
  pandoc doc.md \
    --pdf-engine=xelatex \
    -f markdown+mark-implicit_figures \
    --template=template.tex \
    -o doc.pdf
  current_date_time="`date +%d/%m/%Y-%H:%M:%S`";
  echo "Done at $current_date_time"
  echo "----------------"
}

watch() {
find "$SCRIPT_DIR" \
  -name "*.md" -o -name "*.tex" -o -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.svg" | entr -r "$0" build
}

case "$1" in
  build)
    build
    ;;
  watch)
    watch
    ;;
    *)
    echo "Usage: $0 {build|watch}"
    exit 1
    ;;
esac
