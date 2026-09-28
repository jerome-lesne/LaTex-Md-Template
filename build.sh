#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Enable colors only when output is a terminal and NO_COLOR is unset.
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  RESET=$'\033[0m'
  BOLD=$'\033[1m'
  BLUE=$'\033[34m'
  GREEN=$'\033[32m'
  YELLOW=$'\033[33m'
  RED=$'\033[31m'
  DIM=$'\033[2m'
else
  RESET=""
  BOLD=""
  BLUE=""
  GREEN=""
  YELLOW=""
  RED=""
  DIM=""
fi

spinner() {
  local process_id="$1"
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local index=0

  [[ -t 1 ]] || return 0

  # Hide cursor.
  printf '\033[?25l'

  while kill -0 "$process_id" 2>/dev/null; do
    printf "\r  ${BLUE}%s${RESET} Compiling PDF…" \
      "${frames[index]}"

    index=$(( (index + 1) % ${#frames[@]} ))
    sleep 0.08
  done

  # Clear spinner line and restore cursor.
  printf '\r\033[2K\033[?25h'
}

build() {
  local start_time
  local end_time
  local elapsed_time
  local finished_at
  local pandoc_pid
  local pandoc_log

  # In watch mode, return to the saved position and clear the old build.
  if [[ "${WATCH_MODE:-0}" == "1" && -t 1 ]]; then
    printf '\033[u\033[J'
  fi

  start_time="$(date +%s.%N)"
  pandoc_log="$(mktemp)"

  printf "\n${BOLD}${BLUE}▶ Building document${RESET}\n"
  printf "${DIM}  Source: doc.md → doc.pdf${RESET}\n\n"

  pandoc "$SCRIPT_DIR/doc.md" \
    --pdf-engine=xelatex \
    -f markdown+mark-implicit_figures \
    --lua-filter="$SCRIPT_DIR/filters/annex-sheet.lua" \
    --template="$SCRIPT_DIR/template.tex" \
    -o "$SCRIPT_DIR/doc.pdf" \
    >"$pandoc_log" 2>&1 &

  pandoc_pid=$!

  spinner "$pandoc_pid"

  if wait "$pandoc_pid"; then
    end_time="$(date +%s.%N)"
    elapsed_time="$(awk "BEGIN {
      printf \"%.2f\", $end_time - $start_time
    }")"
    finished_at="$(date '+%d/%m/%Y at %H:%M:%S')"

    rm -f "$pandoc_log"

    printf "${BOLD}${GREEN}✓ Build completed${RESET}\n"
    printf "  ${GREEN}Output:${RESET}   doc.pdf\n"
    printf "  ${GREEN}Duration:${RESET} %s seconds\n" "$elapsed_time"
    printf "  ${GREEN}Finished:${RESET} %s\n" "$finished_at"
  else
    printf "${BOLD}${RED}✗ Build failed${RESET}\n\n" >&2
    printf "${RED}Pandoc output:${RESET}\n" >&2
    sed 's/^/  /' "$pandoc_log" >&2
    rm -f "$pandoc_log"
    return 1
  fi
}

watch() {
  printf "${BOLD}${YELLOW}● Watching for changes…${RESET}\n"
  printf "${DIM}  Markdown, LaTeX and image files${RESET}\n"
  printf "${DIM}  Press Ctrl+C to stop.${RESET}\n"

  # Save the cursor position immediately after the permanent watch header.
  if [[ -t 1 ]]; then
    printf '\033[s'
  fi

  # Perform the first build immediately.
  WATCH_MODE=1 "$0" build

  find "$SCRIPT_DIR" \
    -type f \
    \( \
      -name "*.md" \
      -o -name "*.tex" \
      -o -name "*.lua" \
      -o -name "*.png" \
      -o -name "*.jpg" \
      -o -name "*.jpeg" \
      -o -name "*.svg" \
    \) \
    | WATCH_MODE=1 entr -r "$0" build
}

case "${1:-}" in
  build)
    build
    ;;
  watch)
    watch
    ;;
  *)
    printf "${BOLD}Usage:${RESET} %s {build|watch}\n" "$0"
    exit 1
    ;;
esac
