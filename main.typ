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
#let config-database = toml("config.toml")
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

// Raw fonts for code and other placese where a monospace font is required.
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

// Title page is here because I don't want any 
// later rules to affect it.
#show: pages.title-page.with(
  title: (
    cs: linguify("title", lang: "cs"),
    en: linguify("title", lang: "en"),
  ),
  authors: config-database.conf.authors,
  supervisor: config-database.conf.supervisor,
  thesis-type: "master",
  publish-location: "Ostrava",
  publish-year: datetime.today().year()
)

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

// Heading settings.

// I want heading be called 'Chapter'
// not 'Section' as it is by default.
#set heading(
  supplement: linguify("section-suplement")
)

// Headings settings for all headings levels.
#let heading-size = 1.25em
#let heading-block-ypad = 1.5em

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
#let heading-1-size = 1.5em
#let heading-1-block-ypad = 2.5em

#show heading.where(level: 1): it => [
  #show: utils.ignore-first-line-indent.with()
  #let current-heading = utils.current-heading(level: 1)

  #pagebreak(weak: true)
  #v(2em)

  // Wrapped into block so it isn't treated as a paragraph
  // messing up the non-indent of the first line.
  #block(
    above: heading-1-block-ypad,
    below: heading-1-block-ypad,
  )[
    #text(size: heading-size)[
      #it.supplement 
      #utils.current-numbering(current-heading)
    ]

    #text(size: heading-1-size)[
      #current-heading.body
    ]
  ] 
]

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

#let footer-title-box-settings = (
  // stroke: red, 
  width: 90% 
)

#let titled-footer-content(
  counter-fn
) = stack(
  spacing: 0.8em,
  hline,
  [
    #box(..footer-title-box-settings)[
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

// Make links blue and be underlined.
#show link: set text(fill: rgb(0, 0, 100)); 
#show link: underline; 

// Chapters
#include "chapters/chapter-2.typ"
#include "chapters/demo-chapters.typ"

// Bibliograhy
#show: pages.bibliography-page

// Appendix

