# Markdown → PDF Document Template

Write documents in **Markdown**, get a professionally formatted **PDF** via **Pandoc + XeLaTeX**.

```text
doc.md → Pandoc → XeLaTeX → doc.pdf
```

`doc.md` is a live example / cheatsheet — build it to see what the template can do.

## Quick start

1. Install dependencies (see below).
2. Build once:
   ```bash
   ./build.sh build
   ```
3. Start live rebuild, open the PDF, then edit and save:
   ```bash
   ./build.sh watch
   ```
   ```bash
   zathura doc.pdf
   ```
   ```text
   edit doc.md → save → PDF rebuilds → viewer reloads
   ```

Stop the watcher with `Ctrl+C`.

## Prerequisites

Required to build: `git`, `pandoc`, `xelatex` (TeX Live), `FreeSans` font.
Required for live rebuild: `entr`.
Recommended viewer: `zathura` (auto-reloads on rebuild).

### Arch Linux

```bash
sudo pacman -Syu
sudo pacman -S git pandoc-cli texlive-latex texlive-latexrecommended texlive-latexextra texlive-xetex gnu-free-fonts entr zathura
```

Verify:

```bash
pandoc --version && xelatex --version && entr -V && zathura --version
fc-match FreeSans
```

### Windows / macOS

Install `Git`, `Pandoc`, `TeX Live` (recommended), `FreeSans`, and `entr`. Zathura if available. Then verify with the same commands above. `watch` works best on Linux / Unix-like environments.

## Project structure

```text
.
├── doc.md               # ← write here
├── template.tex         # PDF layout (change rarely)
├── build.sh             # build / watch commands
├── filters/             # Pandoc Lua filters
├── images/              # put your images here
└── doc.pdf              # generated output (ignored by git)
```

For a new document: clone, edit `doc.md`, replace `images/`, update the metadata header.

```bash
git clone <repository-url> my-document
cd my-document
```

## Writing

All content goes in `doc.md` (Pandoc Markdown: headings, lists, tables, images, code, math, footnotes).

Minimal header at the top of `doc.md`:

```yaml
---
title: "My Document"
author: "Your Name"
date: "August 2026"
toc: true
numbersections: true
mainfont: "FreeSans"
---
```

Common patterns:

```markdown
![Caption](./images/my-image.png){width=90%}

| Name  | Role      |
|-------|-----------|
| Alice | Developer |

```bash
echo "hello"
```

$E = mc^2$
```

See `doc.md` / `doc.pdf` for the full showcase. Keep image paths relative to `doc.md`.

## Commands

| Command            | What it does                              |
|--------------------|-------------------------------------------|
| `./build.sh build` | Build `doc.pdf` once                      |
| `./build.sh watch` | Rebuild automatically on save (`.md`, `.tex`, `.lua`, images) |

`watch` does an initial build, then stays running while you write.

## Customizing

`template.tex` controls margins, fonts, title page, tables, code boxes, and warning boxes:

```latex
\begin{warning}
Important note.
\end{warning}
```

Prefer Markdown over raw LaTeX. Edit the template only to change the style of all documents.

`doc.pdf` is git-ignored by default — it can always be regenerated. Commit `doc.md`, `images/`, `template.tex`, and `build.sh`.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `pandoc: command not found` | Install `pandoc-cli` (Arch) / `pandoc` (other OS) |
| `xelatex: command not found` | Install `texlive-xetex`, check `xelatex --version` |
| `File 'xxx.sty' not found` | Install `texlive-latex texlive-latexrecommended texlive-latexextra` |
| `FreeSans cannot be found` | Install `gnu-free-fonts`, run `fc-match FreeSans`, `fc-cache -fv` if needed |
| `entr: command not found` | Install `entr` |
| Image not found | Check `ls images/`, use `./images/name.png` relative to `doc.md` |
