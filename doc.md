--- 
title: "Archi Logicielle"
author: "Jérome Lesne"
school: "CESI"
school-logo: "./images/logo_cesi.jpg"
date: "Mai 2026"
toc: true
numbersections: true
geometry: 
- top=2cm
- bottom=2cm
- left=2cm
- right=2cm
toc-depth: 3
toc-title: "Sommaire"
fontsize: 12pt
mainfont: "FreeSans"
---

# Introduction

This repository provides a simple workflow for writing documents in Markdown and exporting them to professionally formatted PDF files using Pandoc and LaTeX.

The goal is to keep the writing process simple while still providing access to advanced PDF formatting when needed.

A typical workflow is:

```text
Markdown → Pandoc → LaTeX → XeLaTeX → PDF
```

A blank line starts a new paragraph.

This is a second paragraph.

A line ending with two spaces
creates a manual line break.

# Supported Features

This document acts as a showcase for the features provided by the template.

* [x] Markdown formatting
* [x] Section numbering
* [x] Table of contents
* [x] Images
* [x] Code blocks
* [x] Syntax highlighting
* [x] Mathematics
* [x] Markdown tables
* [x] Pandoc tables
* [x] Definition lists
* [x] Task lists
* [x] Footnotes
* [x] Block quotes
* [x] Raw LaTeX
* [x] Custom warning boxes
* [x] Custom title page
* [x] Custom fonts
* [x] Automatic PDF rebuilding with `entr`

# Headings

The template supports multiple heading levels.

## Level Two

This is a level-two heading.

### Level Three

This is a level-three heading.

#### Level Four

This is a level-four heading.

Only the configured heading depth is displayed in the table of contents.

# Text Formatting

## Basic formatting

*Italic text*

*Italic text*

**Bold text**

**Bold text**

***Bold italic text***

~~Strikethrough text~~

==Highlighted text==

## Superscript and subscript

Water can be written as H~2~O.

Einstein's equation is E=mc^2^.

# Lists

## Unordered List

* First item
* Second item

  * Sub-item
  * Another sub-item

    * Nested item
    * Another nested item
* Final item

## Ordered List

1. First step
2. Second step
3. Third step

## Task List

- [x] Completed task
- [ ] Pending task
- [ ] Another task

## Definition List

Monolith First
: An architectural pattern where a system is built as a single unit initially.

Holacracy
: A decentralized management system.

Pandoc
: A universal document converter used to transform Markdown into many other formats.

# Links

A normal clickable link:

[Visit example.com](https://example.com)

An internal link to another section:

[Jump to the tables section](#tables)

# Block Quotes

> Any sufficiently advanced technology is indistinguishable from magic.
>
> — Arthur C. Clarke

# Images

Images are stored in the `images/` directory.

![Example image](./images/des.jpg){width=90%}

Use a `figure-block` to keep an image and its caption on the same page:

```markdown
::: figure-block
![Example image](./images/des.jpg){width=90%}
:::
```

::: figure-block
![Example image kept with its caption](./images/des.jpg){width=50%}
:::

The width can be changed:

```markdown
![Example image](./images/des.jpg){width=50%}
```

# Mathematics

## Inline mathematics

The famous equation is $E = mc^2$.

## Displayed mathematics

$$
E = mc^2
$$

More complex equations are also supported:

$$
\int_{-\infty}^{+\infty} e^{-x^2} , dx = \sqrt{\pi}
$$

# Code

## TypeScript

```typescript
const logger = (logtype, msg) => {
  return console.log(logtype, ": ", msg);
};

logger("INFO", "Hello world");
```

## Bash

```bash
#!/usr/bin/env bash

echo "Hello world"
```

## Java

```java
public class Example {

    public static void main(String[] args) {
        System.out.println("Hello world");
    }
}
```

## Plain code block

Without a language name, the block is still displayed inside a styled box:

```
plain text without syntax highlighting
```

Code blocks are automatically displayed inside styled boxes.

# Tables

## Markdown table

Markdown tables are convenient for simple one-line cells.

| Name   | Value | Description      |
| ------ | ----: | ---------------- |
| First  |    10 | Simple content   |
| Second |    20 | **Bold content** |
| Third  |    30 | More content     |

A bold paragraph directly before a table becomes its caption:

**Example labeled table**

| Name   | Value |
| ------ | ----: |
| First  |    10 |
| Second |    20 |

## Pandoc table

Pandoc tables are useful when cells contain multiple lines or more complex content.

+---------------+---------------+-----------------------+
| Fruit         | Price         | Advantages            |
+===============+===============+=======================+
| Bananas       | $1.34         | built-in wrapper\break|
|               |               | bright color          |
+---------------+---------------+-----------------------+
| Oranges       | $2.10         | - cures scurvy        |
|               |               | - tasty               |
+---------------+---------------+-----------------------+
| Apples        | $1.70         | - cures scurvy        |
|               |               | - tasty               |
+---------------+---------------+-----------------------+

# Warning Boxes

The template provides a custom `warning` environment.

\begin{warning}
This is an example of a warning box.

It can contain multiple paragraphs and can span pages.
\end{warning}

This can be useful for:

* Security warnings
* Important notes
* Constraints
* Things that require special attention

# Annex Sheets

An `annex-sheet` renders its content as a compact sheet on its own page:

```markdown
::: annex-sheet
### My annex

Content of the annex.
:::
```

::: annex-sheet
### Example annex sheet

This content is rendered inside a compact annex sheet.

* Smaller text
* Tighter tables and spacing
* Useful for appendices
:::

# Page Breaks

A raw LaTeX command can be used when precise page control is required.

For example:

```latex
\clearpage
```

The following section starts on a new page.

\clearpage

# Raw LaTeX

Markdown should be preferred whenever possible, but raw LaTeX is available for advanced formatting.

For example:

```latex
\clearpage
```

Or a custom box:

```latex
\begin{tcolorbox}
This is a normal tcolorbox.
\end{tcolorbox}
```

\begin{tcolorbox}
This is a normal tcolorbox.
\end{tcolorbox}

# Footnotes

Pandoc supports footnotes.[^1]

Footnotes are useful when additional information is needed without interrupting the main text.[^2]

[^1]: This is an example of a footnote.

[^2]: Footnotes are automatically handled by Pandoc and LaTeX.

# Conclusion

This template provides a simple Markdown-based writing workflow while retaining the power of LaTeX for advanced formatting.

The recommended workflow is:

```text
Write Markdown
      ↓
Save
      ↓
entr detects the change
      ↓
Pandoc
      ↓
XeLaTeX
      ↓
PDF regenerated
      ↓
Zathura reloads the PDF
```

For a normal build:

```bash
./build.sh build
```

For live rebuilding:

```bash
./build.sh watch
```

For viewing the result:

```bash
zathura doc.pdf
```

The repository can now be cloned to start a new document while keeping the same build system and PDF styling.
