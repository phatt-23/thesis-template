// Import the global imports and other stuff.
#import "/lib/global.typ": *

// Pages that are always required like:
// title, abstract, outline, conclusion, literature, apendix etc.
// These are injected into the template in their correct spots.
// Don't move them around, otherwise they may pick-up undesired show rules.
#import "/lib/pages.typ"

// User controlled configuration file.
#import "/config.typ": assets, thesis, document, math-shorthands

// Centralised basic configuration - metadata of the document.
#linguify-plug.set-database(toml(assets.lang-database))

// Apply the math shorthands.
#show: quick-maths.shorthands.with(..math-shorthands)

// For debugging in zathura (pdf viewer).
// Make the page border visible.
#show: utils.show-page-borders.with()

// Text settings.
#set text(lang: thesis.lang, ..document.fonts.normal)
#show math.equation: set text(..document.fonts.math)
#show raw: set text(..document.fonts.raw)

// Disables single letter word to be at the end of the line
// which this is typographically desired. For debugging you
// can color the affected red with text(fill: red)[#it.text.first()~].
#show regex("\b\w\b\s"): it => [#it.text.first()~]

// Page settings that apply to all pages.
#set page(
  paper: document.page.paper,
  margin: document.page.margin,
)

// Make figures breakable if they are too long.
// It allows breaking into other pages.
#show figure: set block(breakable: true)

// Algorithmic styling.
#show: document.algorithmic-style

// Table style.
#set table(
  // Make the lines thiner.
  stroke: 0.5pt,
  // Align the content in the cells to horizon.
  align: horizon,
)

// Content for preliminary and concluding pages.
#import "/chapters/preliminary-and-concluding.typ" as PAC

// BEGIN: title
//////////////////////////////////////////////////////////////////////////

// Title page is here because I don't want any
// later rules to affect it.
#show: pages.title-page.with(
  title: (
    cs: linguify("title", lang: "cs"),
    en: linguify("title", lang: "en"),
  ),
  authors: thesis.authors,
  supervisor: thesis.supervisor,
  thesis-type: thesis.type,
  publish-location: thesis.publish-location,
  publish-year: thesis.publish-year,
)

// END
//////////////////////////////////////////////////////////////////////////

#set par(..document.paragraph)

// BEGIN: assignment PDF, abstract and keywords, thanks, list of symbols
//////////////////////////////////////////////////////////////////////////

// Assignment PDF.
#show: pages.thesis-assignment.with(path: if thesis.assigned { assets.assignment } else { auto })

// Abstract and keywords.
#show: pages.abstract-and-keywords.with(
  abstract-title: (
    en: linguify("abstract", lang: "en"),
    cs: linguify("abstract", lang: "cs"),
  ),
  abstract-body: (
    en: PAC.abstract.en,
    cs: PAC.abstract.cs,
  ),
  keywords-title: (
    en: linguify("keywords", lang: "en"),
    cs: linguify("keywords", lang: "cs"),
  ),
  keywords: (
    en: PAC.keywords.en,
    cs: PAC.keywords.cs,
  ),
)

// Thanks.
#show: pages.thanks-page.with(
  body: PAC.thanks.body,
  want-to-include: PAC.thanks.want-to-include,
  title: linguify("acknowledgements"),
)

// List of symbols and abbrevs.
#show: pages.list-of-symbols.with(
  symbols: PAC.symbols-and-abbrevs,
  title: linguify("list-of-symbols"),
)

// END
//////////////////////////////////////////////////////////////////////////

#set page(
  footer-descent: document.page.footer-descent,
  footer: utils.page-footer.at(document.page.footer),
)

// BEGIN: outline, intro
//////////////////////////////////////////////////////////////////////////

#show: pages.outline-page.with(
  outline-title: linguify("outline"),
  list-of-figures: linguify("list-of-figures"),
  list-of-tables: linguify("list-of-tables"),
  list-of-algorithms: linguify("list-of-algorithms"),
)

#show: pages.intro-page.with(
  title: linguify("intro"),
  body: PAC.intro,
)

// END
//////////////////////////////////////////////////////////////////////////

// The rest of the page settings.
#set page(
  header: utils.page-header.at(document.page.header),
  header-ascent: document.page.header-ascent,
)

// Heading settings.

// I want heading be called 'Chapter' not 'Section' as it is by default.
#set heading(
  supplement: linguify("section-suplement"),
  numbering: document.heading.numbering,
)

#show heading: utils.page-heading.at(document.heading.h-all)
#show heading.where(level: 1): utils.page-heading.at(document.heading.h-1)

#show link: set text(fill: document.link.fill, ..document.fonts.raw)
#show link: underline.with(stroke: document.link.underline-stroke, offset: document.link.underline-offset)

// BEGIN: chapters, conclusion, bibliography, appendices
//////////////////////////////////////////////////////////////////////////

// Chapters
#include "./chapters/chapter-1.typ"
#include "./chapters/chapter-2.typ"
#include "./chapters/chapter-3.typ"
#include "./chapters/chapter-4.typ"


// Conclusion
#show: pages.conclusion-page.with(
  title: linguify("conclusion"),
  body: PAC.conclusion,
)

// Bibliograhy
#show: pages.bibliography-page.with(title: linguify("bibliography"))

// Appendices
// Attachments, source code, diagrams...
#show: pages.appendices-page.with(
  appendices-title: linguify("appendices"),
  appendices: PAC.appendices,
)

// END
//////////////////////////////////////////////////////////////////////////

