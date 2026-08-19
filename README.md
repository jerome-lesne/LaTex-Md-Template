# Markdown → PDF Document Template

A simple template for writing documents in **Markdown** and exporting them to a professionally formatted **PDF** using **Pandoc + LaTeX**.

The repository is designed to be cloned whenever you start a new document.

The recommended workflow uses:

* **Markdown** → write the document
* **Pandoc** → convert Markdown to LaTeX
* **XeLaTeX** → generate the PDF
* **entr** → automatically rebuild the PDF when source files change
* **Zathura** → view the PDF and automatically reload it

---

# 📁 Project structure

```text
.
├── build.sh           # Build and live-watch script
├── doc.md             # Main document written in Markdown
├── doc.pdf            # Generated PDF
├── images/            # Images used by the document
│   ├── des.jpg
│   └── logo_cesi.jpg
├── README.md          # This documentation
└── template.tex       # Custom LaTeX template used by Pandoc
```

### Files you normally need to modify

For a new document, you will mainly work with:

* `doc.md` → write your document here.
* `images/` → put your images here.
* `template.tex` → modify only if you want to change the PDF layout or LaTeX behaviour.

You normally **do not edit `doc.pdf` manually**. It is generated from `doc.md`.

---

# 🛠️ Installation

This project requires:

1. **Git** — to clone and manage the project.
2. **Pandoc** — converts Markdown into LaTeX.
3. **TeX Live** — provides LaTeX and the required packages.
4. **XeLaTeX** — generates the PDF and handles system fonts.
5. **FreeSans** — the font used by the template.
6. **entr** — automatically rebuilds the PDF when source files change.
7. **Zathura** — recommended PDF viewer.

The first five are required to build the PDF.

`entr` is required for the `watch` command.

Zathura is optional, but highly recommended for the live-writing workflow.

---

# 🐧 Arch Linux installation

On Arch Linux, install the complete toolchain with:

```bash
sudo pacman -Syu
sudo pacman -S git pandoc-cli texlive-latex texlive-latexrecommended texlive-latexextra texlive-xetex gnu-free-fonts entr zathura
```

Then verify the installation:

```bash
git --version
pandoc --version
xelatex --version
entr -V
zathura --version
```

Check that FreeSans is available:

```bash
fc-match FreeSans
```

It should return a result corresponding to **FreeSans**.

### Why these packages?

| Package                    | Purpose                                          |
| -------------------------- | ------------------------------------------------ |
| `git`                      | Clone and manage the project                     |
| `pandoc-cli`               | Convert Markdown to LaTeX                        |
| `texlive-latex`            | Core LaTeX packages                              |
| `texlive-latexrecommended` | Recommended LaTeX packages                       |
| `texlive-latexextra`       | Additional packages used by the template         |
| `texlive-xetex`            | Provides XeLaTeX                                 |
| `gnu-free-fonts`           | Provides the `FreeSans` font                     |
| `entr`                     | Watches files and runs commands when they change |
| `zathura`                  | Lightweight PDF viewer                           |

---

# 🪟 Windows

Install:

* Git
* Pandoc
* TeX Live or MiKTeX
* FreeSans
* `entr`
* Zathura, if available in your chosen environment

For the most reproducible setup, **TeX Live** is recommended.

After installation, verify:

```text
git --version
pandoc --version
xelatex --version
```

The `watch` functionality relies on `entr`, which is primarily intended for Unix-like environments.

---

# 🍎 macOS

Using Homebrew:

```bash
brew install pandoc
brew install entr
brew install --cask mactex
```

Then verify:

```bash
pandoc --version
xelatex --version
entr -V
```

FreeSans must also be installed and available to the system.

Zathura can be installed with:

```bash
brew install --cask zathura
```

---

# 🚀 Creating a new document

Clone the repository:

```bash
git clone <repository-url> my-document
cd my-document
```

Remove the example PDF if necessary:

```bash
rm -f doc.pdf
```

Then open `doc.md` and replace the example content with your own document.

---

# ✍️ Writing the document

The main document is:

```text
doc.md
```

It uses **Pandoc Markdown**, which extends standard Markdown with features useful for technical and professional documents.

Pandoc supports:

* Headings
* Lists
* Tables
* Images
* Links
* Code blocks
* Mathematics
* Definition lists
* Task lists
* Superscripts/subscripts
* Strikeout
* Raw LaTeX

---

# 📑 Document metadata

At the beginning of `doc.md`, use YAML metadata:

```yaml
---
title: "My Document"
author: "Your Name"
school: "My School"
date: "August 2026"
toc: true
numbersections: true
geometry:
  - top=2cm
  - bottom=2cm
  - left=2cm
  - right=2cm
toc-depth: 3
toc-title: "Table of Contents"
fontsize: 12pt
mainfont: "FreeSans"
---
```

Important fields:

| Field            | Purpose                                    |
| ---------------- | ------------------------------------------ |
| `title`          | Document title                             |
| `author`         | Author name                                |
| `date`           | Document date                              |
| `toc`            | Enables the table of contents              |
| `numbersections` | Numbers sections                           |
| `toc-depth`      | Maximum heading level displayed in the TOC |
| `fontsize`       | Main document font size                    |
| `mainfont`       | Main document font                         |
| `geometry`       | Page margins                               |

---

# 📚 Headings

Use Markdown headings:

```markdown
# Main section

## Subsection

### Sub-subsection
```

With:

```yaml
numbersections: true
```

the sections are automatically numbered in the PDF.

---

# 🖼️ Images

Put images inside the `images/` directory:

```text
images/
├── architecture.png
├── diagram.jpg
└── logo.png
```

Reference them from Markdown:

```markdown
![Architecture diagram](./images/architecture.png){width=90%}
```

You can change the width:

```markdown
![Architecture diagram](./images/architecture.png){width=50%}
```

The current build script uses:

```text
markdown+mark-implicit_figures
```

This enables Pandoc's implicit figure handling.

Keep image paths **relative to `doc.md`**.

> **Note:** The current `watch` command only monitors `.md` and `.tex` files. If you modify an existing image, the PDF will not automatically rebuild. Run `./build.sh build` manually, or update the `watch` function if you want image changes to trigger a rebuild.

---

# 💻 Code blocks

Use fenced Markdown code blocks:

````markdown
```typescript
const hello = "world";

console.log(hello);
```
````

Specify the programming language after the opening backticks:

````markdown
```bash
sudo pacman -Syu
```
````

````markdown
```java
public class Example {
    public static void main(String[] args) {
        System.out.println("Hello");
    }
}
```
````

The custom `template.tex` automatically places code blocks inside styled boxes.

---

# 📊 Tables

For simple tables, use normal Markdown:

```markdown
| Name | Age | Role |
|------|-----|------|
| Alice | 30 | Developer |
| Bob | 35 | Manager |
```

For more complex tables, Pandoc's table syntax can be used.

The LaTeX template contains additional configuration to improve table appearance and support tables spanning multiple pages.

---

# 🧮 Mathematics

Inline mathematics:

```markdown
The famous equation is $E = mc^2$.
```

Displayed mathematics:

```markdown
$$
E = mc^2
$$
```

Pandoc converts mathematical expressions into LaTeX before generating the PDF.

---

# ⚙️ Raw LaTeX

Because Pandoc ultimately generates a LaTeX document, LaTeX can be used directly when Markdown is not sufficient.

For example:

```latex
\clearpage
```

or:

```latex
\begin{tcolorbox}
Important information.
\end{tcolorbox}
```

The template already loads `tcolorbox`, so custom boxes can be created directly in the Markdown document.

Raw LaTeX is powerful, but use normal Markdown whenever possible to keep the document easier to maintain.

---

# 🔨 Building the PDF

The `build.sh` script provides two commands:

```text
build.sh build
build.sh watch
```

## One-time build

To generate the PDF once:

```bash
./build.sh build
```

The script runs Pandoc with:

* **XeLaTeX** as the PDF engine
* `markdown+mark-implicit_figures` as the Markdown format
* `template.tex` as the custom LaTeX template
* `doc.pdf` as the output file

The resulting PDF is:

```text
doc.pdf
```

The script also prints the time at which the build finished:

```text
Building document
Done at 19/08/2026-16:30:42
----------------
```

---

# ⚡ Live rebuilding with `entr`

For writing long documents, the recommended approach is to use the `watch` command.

`entr` watches files and executes a command whenever one of them changes.

You **do not need to write the `entr` command yourself**. It is already integrated into `build.sh`.

Simply run:

```bash
./build.sh watch
```

The script internally runs:

```bash
find . -name "*.md" -o -name "*.tex" | entr -r "$0" build
```

This means that changes to Markdown or LaTeX files automatically trigger:

```bash
./build.sh build
```

The workflow becomes:

```text
Edit doc.md
    │
    ▼
Save
    │
    ▼
entr detects the change
    │
    ▼
build.sh build
    │
    ▼
Pandoc + XeLaTeX
    │
    ▼
doc.pdf regenerated
```

### Why use `entr`?

Without `entr`, you would repeatedly need to do:

```bash
./build.sh build
```

With `entr`:

```bash
./build.sh watch
```

and then you can simply write and save your document.

Leave the `watch` command running while you work.

---

# 📖 Recommended PDF viewer: Zathura

**Zathura** is recommended for viewing the generated PDF.

Install it on Arch Linux:

```bash
sudo pacman -S zathura
```

Open the PDF:

```bash
zathura doc.pdf
```

Zathura is particularly convenient for this workflow because it can reload the PDF when the file is regenerated.

This means you can have:

```text
┌──────────────────────────────┐
│          Editor              │
│                              │
│          doc.md              │
└──────────────────────────────┘

             +

┌──────────────────────────────┐
│          Zathura             │
│                              │
│          doc.pdf             │
└──────────────────────────────┘

             +

┌──────────────────────────────┐
│        build.sh watch        │
│                              │
│       Watching files...      │
└──────────────────────────────┘
```

Your writing loop becomes:

```text
Write
  ↓
Save
  ↓
entr detects change
  ↓
PDF rebuilt
  ↓
Zathura reloads PDF
  ↓
See the result
```

---

# 🚀 Recommended writing workflow

Once everything is installed, open two terminals.

### Terminal 1 — live builder

From the project directory:

```bash
./build.sh watch
```

Leave this command running.

### Terminal 2 — PDF viewer

```bash
zathura doc.pdf
```

Then open `doc.md` in your editor and start writing.

Every time you save a `.md` or `.tex` file, the PDF will automatically be rebuilt.

---

# 🧠 Understanding `build.sh`

The script is intentionally simple.

## `build`

The `build` function:

```bash
build() {
  echo "Building document"
  pandoc doc.md \
    --pdf-engine=xelatex \
    -f markdown+mark-implicit_figures \
    --template=template.tex \
    -o doc.pdf

  current_date_time="`date +%d/%m/%Y-%H:%M:%S`"
  echo "Done at $current_date_time"
  echo "----------------"
}
```

It converts:

```text
doc.md
  ↓
Pandoc
  ↓
template.tex
  ↓
XeLaTeX
  ↓
doc.pdf
```

## `watch`

The `watch` function:

```bash
watch() {
  find . -name "*.md" -o -name "*.tex" \
    | entr -r "$0" build
}
```

It finds Markdown and LaTeX files and asks `entr` to run the build whenever one changes.

The `-r` option tells `entr` to restart the running process when a file changes.

---

# 🐛 Troubleshooting

## `pandoc: command not found`

Pandoc is not installed or is not in your `PATH`.

Check:

```bash
which pandoc
```

Install Pandoc using your distribution's package manager.

---

## `xelatex: command not found`

XeLaTeX is missing.

On Arch Linux:

```bash
sudo pacman -S texlive-xetex
```

Then:

```bash
xelatex --version
```

---

## `entr: command not found`

Install `entr`.

On Arch Linux:

```bash
sudo pacman -S entr
```

Then:

```bash
entr -V
```

---

## `zathura: command not found`

Install Zathura:

```bash
sudo pacman -S zathura
```

Then:

```bash
zathura --version
```

---

## `FreeSans` cannot be found

Check:

```bash
fc-match FreeSans
```

If it is missing:

```bash
sudo pacman -S gnu-free-fonts
```

Then refresh the font cache if necessary:

```bash
fc-cache -fv
```

---

## `File 'xxx.sty' not found`

A LaTeX package required by the template is missing.

The template uses packages including:

* `tcolorbox`
* `soul`
* `longtable`
* `booktabs`
* `array`
* `xcolor`
* `geometry`
* `amsmath`
* `amssymb`
* `xparse`

On Arch Linux, install the relevant TeX Live collections:

```bash
sudo pacman -S texlive-latex texlive-latexrecommended texlive-latexextra
```

---

## Images are not found

Check that the image exists:

```bash
ls images/
```

Then make sure the path is relative to `doc.md`:

```markdown
![Image](./images/my-image.png)
```

---

## `watch` does not rebuild when I change an image

This is expected with the current script.

The current `watch` function watches:

```text
*.md
*.tex
```

It does **not** watch:

```text
*.jpg
*.jpeg
*.png
```

Therefore, if you replace or modify an image, rebuild manually:

```bash
./build.sh build
```

Alternatively, you can modify the `watch` function to include image files.

For example:

```bash
watch() {
  find . \( \
    -name "*.md" \
    -o -name "*.tex" \
    -o -name "*.jpg" \
    -o -name "*.jpeg" \
    -o -name "*.png" \
  \) | entr -r "$0" build
}
```

This is optional.

---

## `watch` seems to run the build repeatedly

The script uses:

```bash
entr -r "$0" build
```

The `-r` option restarts the process when files change.

If the build itself modifies a watched file, this can potentially cause another rebuild.

Normally this project should be fine because `doc.pdf` is not one of the watched files.

---

# 🧹 Rebuilding manually

If you are not using the live watcher, simply run:

```bash
./build.sh build
```

You can also stop the watcher with:

```text
Ctrl+C
```

---

# 📦 Git workflow

This template is intended to be used as the starting point of a Git repository.

After cloning it, you can create a new repository for your document:

```bash
cd my-document
git remote remove origin
git remote add origin <new-repository-url>
```

Then:

```bash
git add .
git commit -m "Initial document"
git push -u origin main
```

A typical workflow is:

```text
Edit Markdown
     │
     ▼
   Save
     │
     ▼
   entr
     │
     ▼
 build.sh
     │
     ▼
  Check PDF
     │
     ▼
 Git commit
```

---

# 📝 What should be committed?

Normally commit:

```text
doc.md
template.tex
build.sh
images/
README.md
```

The generated PDF can either be committed or ignored.

If you don't want to store it in Git:

```gitignore
doc.pdf
```

This is often preferable because the PDF can always be regenerated from the source files.

---

# 🎨 Customizing the template

The file:

```text
template.tex
```

controls the final LaTeX/PDF layout.

It currently handles:

* Page margins
* Font configuration
* Section numbering
* Table of contents
* Title page
* Code blocks
* Warning boxes
* Tables
* Highlighted text
* Images
* Mathematics
* LaTeX-specific formatting

Most documents should not need modifications to this file.

If you want to change the visual appearance of **all future documents**, modify `template.tex` rather than adding lots of formatting directly to `doc.md`.

---

# 🔄 Starting another document

The intended workflow is:

```bash
git clone <repository-url> my-new-document
cd my-new-document
```

Then:

1. Replace the example content in `doc.md`.
2. Remove or replace the example images.
3. Update the document metadata.
4. Run `./build.sh build` once to generate the initial PDF.
5. Run `./build.sh watch`.
6. Open `doc.pdf` with Zathura.
7. Start writing.

You can keep these files unchanged:

```text
build.sh
template.tex
README.md
```

---

# ⚡ Quick start

Once everything is installed:

```bash
git clone <repository-url> my-document
cd my-document
```

Generate the PDF once:

```bash
./build.sh build
```

Start the live builder:

```bash
./build.sh watch
```

In another terminal:

```bash
zathura doc.pdf
```

Then edit:

```text
doc.md
```

and save.

The PDF will automatically rebuild whenever `doc.md` or `template.tex` changes, and Zathura will reload the updated PDF.

---

# 🧰 Complete toolchain

```text
                 ┌─────────────┐
                 │   doc.md    │
                 │  Markdown   │
                 └──────┬──────┘
                        │
                      save
                        │
                        ▼
                 ┌─────────────┐
                 │    entr     │
                 │ file watcher│
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │  build.sh   │
                 │    build    │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │   Pandoc    │
                 │ MD → LaTeX  │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │  XeLaTeX    │
                 │ LaTeX → PDF │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │   doc.pdf   │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │   Zathura   │
                 │ PDF viewer  │
                 └─────────────┘
```

The result is a simple, reproducible writing environment:

**Markdown → save → automatic build → automatic PDF reload.**
