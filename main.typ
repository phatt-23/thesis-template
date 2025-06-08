// Import the global imports and other stuff.
#import "global.typ": *

// My utils - functions, variables.
#import "utils.typ" as utils: hline

// Pages that are always required like:
// title, abstract, outline, conclusion, literature, apendix etc.
// These are injected into the template in their correct spots.
// Don't move them around, otherwise they may pick-up undesired show rules.
#import "pages.typ"


// Centralised basic configuration - metadata of the document.
#let config-database = toml("./config.toml")
#linguify-plug.set-database(config-database)


// For debugging. 
// Make the page border visible.
#show: utils.show-page-borders.with()

#show: quick-maths.shorthands.with(
  ..utils.math-shorthands
)

// Reading fonts for normal text.
#let fonts = (
  // Free palatino. 
  // https://www.gust.org.pl/projects/e-foundry/tex-gyre/index_html
  pagella: (font: "TeX Gyre Pagella"),
  // Normal LM, too thin and hard to read.
  lm: (font: "Latin Modern Roman"),     
  // CMR. Classic.
  mcr: (font: "New Computer Modern"),
)

#set text(
  lang: config-database.conf.lang,
  size: 11pt,
  // ..fonts.mcr,
  ..fonts.pagella,
)

// Math fonts.
#let math-fonts = (
  lm: (font: "Latin Modern Math"),
  pagella: (font: "TeX Gyre Pagella Math"),
)

#show math.equation: set text(
  // ..math-fonts.lm,
  ..math-fonts.pagella,
)

// Raw fonts for code and other placese where 
// a monospace font is required.
#let raw-fonts = (
  sourcecode: (font: "SauceCodePro NF", size: 10pt),
  lm: (font: "Latin Modern Mono 12", size: 11pt),
)

#show raw: set text(
  // ..raw-fonts.sourcecode,
  ..raw-fonts.lm,
)

// Wrap code in #zebraw() to apply these settings.
#show: zebraw-init.with(
  numbering-separator: true,
  // Language badge at the top right corner
  lang: true,
  // todo: replace with VSB color
  lang-color: eastern, 
  // How the langauge badge looks like.
  lang-font-args: (
    weight: "bold",
    fill: white
  ),
  // How many levels will have indentation vertical lines?
  indentation: 0,
  // Inset of the number line.
  inset: (left: 0.20em),
  // I want more subtle background.
  background-color: luma(255 - 6),
)

// Pseudocode settings.
#let my-lovelace-defaults = (
  // Indentation size and stroke.
  indentation: 1.4em,
  stroke: 0.75pt + luma(120),
  // Hooked indent lines.
  hooks: 0.25em,
  // Booktabs are the vert lines at the start and end.
  booktabs: true,
  booktabs-stroke: 1pt + black,
  // Line numbering format.
  line-numbering: "1",
)

// Lower level inteface. Isn't written like a list.
// Have to write indent() manually and wrap the text in [].
#let pseudocode = pseudocode.with(..my-lovelace-defaults)
// Just like a nested list.
#let pseudocode-list = pseudocode-list.with(..my-lovelace-defaults)

// Disables single letter word to be at the end of the line
// which this is typographically desired. For debugging you 
// can color the affected red with text(fill: red)[#it.text.first()~].
#show regex("\b\w\b\s"): it => [#it.text.first()~]

#set page(
  // Standard page in Europe.
  paper: "a4",
  // Recommended margin is 2.5cm which is about 1in
  // so I'm gonna stick with inches.
  margin: (
    left: 1in, 
    right: 1in,
    top: 1.2in,
    bottom: 1.1in,
  ),
)

//////////////////////////////////////////////////////////////////////////

// Title page is here because I don't want any 
// later rules to affect it.
#show: pages.title-page.with(
  title: (
    cs: linguify("title", lang: "cs"),
    en: linguify("title", lang: "en"),
  ),
  authors: config-database.thesis.authors,
  supervisor: config-database.thesis.supervisor,
  thesis-type: config-database.thesis.type,
  publish-location: config-database.thesis.publish-location,
  publish-year: config-database.thesis.publish-year,
)

//////////////////////////////////////////////////////////////////////////

// Space between each line. 
// Should be up to the font's adjustments. 
// But you're free to adjust it yourself.
#set par(leading: 0.65em)
// Space between each paragraph.
#set par(
  spacing: 1.4em, 
  justify: true,
  linebreaks: "optimized",
  first-line-indent: (
    amount: 1.5em,
    all: false,
  )
) 

//////////////////////////////////////////////////////////////////////////

// Assignment PDF.
#show: pages.thesis-assignment.with(
  ..(
    (if config-database.thesis.assigned {(path: config-database.thesis.assignment)}),
  ).join()
)

// Abstract and keywords.
#show: pages.abstract-and-keywords.with(
  abstract-title: (
    en: linguify("abstract", lang: "en"),
    cs: linguify("abstract", lang: "cs"),
  ),
  abstract-body: (
    en: [
      #lorem(20)
      #lorem(40)
    ],
    cs: [
      #lorem(20)
      #lorem(40)
    ],
  ),
  keywords-title: (
    en: linguify("keywords", lang: "en"),
    cs: linguify("keywords", lang: "cs"),
  ), 
  keywords: (
    en: (
      ..lorem(20).split(" ")
    ),
    cs: (
      ..lorem(20).split(" ")
    ),
  )
)

// Thanks.
#show: pages.thanks-page.with([
  #lorem(30)
], title: linguify("acknowledgements"))

// List of symbols and abbrevs.
#show: pages.list-of-symbols.with(
  title: linguify("list-of-symbols"),
  symbols: (
    ([WTF], [What the fuck]),
    ([DPC], [Do $x^2$ pice]),
    ([KDPC], [Kurva do pice $->$ aaaah]),
  ) 
)

//////////////////////////////////////////////////////////////////////////

// Counter settings.
#let footer-counter = (
  out-of: () => counter(page).display(
    "1 / 1", 
    both: true
  ),
  just-number: () => counter(page).display(
    "1", 
    both: false
  ),
)

#let titled-footer-content(
  counter-fn
) = stack(
  spacing: 0.8em,
  hline,
  [
    #box(width: 90%)[
      #text(size: 0.9em)[#smallcaps[#linguify("title")]]
    ] 
    #h(1fr) 
    #(counter-fn)()
  ]
)

#let page-footer = (
  number-single: context [
    #align(center)[
      #(footer-counter.just-number)()
    ] 
  ],
  number-both: context [
    #align(center)[
      #(footer-counter.out-of)()
    ]
  ],
  titled-single: context [
    #titled-footer-content(footer-counter.just-number)
  ],
  titled-both: context [
    #titled-footer-content(footer-counter.out-of)
  ],
)

#set page(
  // Footer with a counter.
  // Having the title on the left and counter on the right
  // would be nice. Don't know if it's possible.
  footer-descent: 30%,
  footer: context [
    #stack(
      spacing: 0.8em,
      // page-footer.titled-both,
      // page-footer.titled-single,
      page-footer.number-single,
      // page-footer.number-both,
    )
  ],
)

//////////////////////////////////////////////////////////////////////////

#show: pages.outline-page.with(
  title: linguify("outline")
)

#show: pages.intro-page.with(
  title: linguify("intro"),
  body: [
    #lorem(40)

    #lorem(40)

    #lorem(80)

    #lorem(160)

    #lorem(320)
  ]
)

//////////////////////////////////////////////////////////////////////////

// The rest of the page settings.
#set page(
  // Header with chapter of level 1.
  header-ascent: 30%,
  header: context [
    #let heading-1 = utils.current-heading(level: 1)

    #if heading-1.location().page() != here().page() [
      #utils.header-stack(
        heading-1.body, 
        numbering: utils.current-numbering(heading-1)
      )
    ]
  ],
)

// Heading settings.

// I want heading be called 'Chapter'
// not 'Section' as it is by default.
#set heading(
  supplement: linguify("section-suplement")
)

// Headings settings for all headings levels.
#set heading(numbering: "1.1")
#show heading: it => [
  #show: utils.ignore-first-line-indent.with()
  #let current-heading = utils.current-heading(level: it.level)
  
  // Wrapped into block so it isn't treated as a paragraph
  // messing up the non-indent of the first line.
  #block(
    above: heading-block-ypad,
    below: heading-block-ypad,
  )[
    #v(1em)
    #text(size: heading-size)[
      #utils.current-numbering(current-heading)
      #h(0.5em)
      #it.body
    ]
  ]
]

// The first level should be special and have its own:
//    Chapter {number}
//    Title
// thing.
#show heading.where(level: 1): it => [
  #show: utils.ignore-first-line-indent.with()
  #let current-heading = utils.current-heading(level: 1)

  #pagebreak(weak: true)
  #utils.vspace-before-chapter

  // Wrapped into block so it isn't treated as a paragraph
  // messing up the non-indent of the first line.
  #block(
    above: heading-1-block-ypad,
    below: heading-1-block-ypad,
  )[
    #text(size: heading-1-suplement-size)[
      #it.supplement 
      #utils.current-numbering(current-heading)
    ]

    #text(size: heading-1-size)[
      #current-heading.body
    ]
  ] 
]

// Make links blue, underlined and use different font.
#show link: set text(
  fill: rgb(0, 0, 100),
  ..raw-fonts.lm
)
#show link: underline.with(
  stroke: 0.5pt
)

//////////////////////////////////////////////////////////////////////////

// Chapters
#include "./chapters/chapter-1.typ"
#include "./chapters/chapter-2.typ"
#include "./chapters/chapter-3.typ"
#include "./chapters/demo-chapters.typ"

// Conclusion
#show: pages.conclusion-page.with(
  title: linguify("conclusion"),
  body: [
    #lorem(20)

    #lorem(40)

    #lorem(80) 

    #lorem(160) 

    #lorem(320) 
  ]
)

// Bibliograhy
#show: pages.bibliography-page.with(
  title: linguify("bibliography"),
  bib-sources: (
    "./bib.yml"
  ),
  bib-params: (
    style: "./assets/iso690-numeric-brackets-cs.csl",
  )
)

// Appendix
// Attachments, source code, diagrams...

//////////////////////////////////////////////////////////////////////////
