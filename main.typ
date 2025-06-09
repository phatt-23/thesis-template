// Import the global imports and other stuff.
#import "/lib/global.typ": *

// My utils - functions, variables.
#import "/lib/utils.typ" as utils: hline

// Pages that are always required like:
// title, abstract, outline, conclusion, literature, apendix etc.
// These are injected into the template in their correct spots.
// Don't move them around, otherwise they may pick-up undesired show rules.
#import "/lib/pages.typ"

// User controlled configuration file.
#import "/config.typ": sizing, assets, thesis, document, math-shorthands

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

// Raw code blocks.
// Wrap code in #zebraw() to apply these settings.
#show: zebraw-init.with(..document.zebraw-block)

// Disables single letter word to be at the end of the line
// which this is typographically desired. For debugging you
// can color the affected red with text(fill: red)[#it.text.first()~].
#show regex("\b\w\b\s"): it => [#it.text.first()~]

#set page(
  paper: document.page.paper,
  margin: document.page.margin,
)

#import algorithmic: algorithm-figure, style-algorithm
#show: style-algorithm.with(

)

// BEGIN
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

// BEGIN
//////////////////////////////////////////////////////////////////////////

// Assignment PDF.
#show: pages.thesis-assignment.with(
  path: if false {assets.assignment} else {auto}
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
      ..lorem(20).split(" "),
    ),
    cs: (
      ..lorem(20).split(" "),
    ),
  ),
)

// Thanks.
#show: pages.thanks-page.with(
  [
    #lorem(30)
  ],
  title: linguify("acknowledgements"),
)

// List of symbols and abbrevs.
#show: pages.list-of-symbols.with(
  symbols: (
    ([WTF], [What the fuck]),
    ([DPC], [Do $x^2$ pice]),
    ([KDPC], [Kurva do pice $->$ aaaah]),
  ),
  title: linguify("list-of-symbols"),
)

// END
//////////////////////////////////////////////////////////////////////////

#set page(
  footer-descent: document.page.footer-descent,
  footer: utils.page-footer.at(document.page.footer),
)

// BEGIN
//////////////////////////////////////////////////////////////////////////

#show: pages.outline-page.with(
  outline-title: linguify("outline"),
  list-of-figures: linguify("list-of-figures"),
  list-of-tables: linguify("list-of-tables"),
  list-of-algorithms: linguify("list-of-algorithms"),
)

#show: pages.intro-page.with(
  title: linguify("intro"),
  body: [
    #lorem(40)

    #lorem(40)

    #lorem(80)

    #lorem(160)

    #lorem(320)
  ],
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
#show link: underline.with(stroke: document.link.underline-stroke)

// BEGIN
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
  ],
)

// #show: pages.dummy-page.with()

// Bibliograhy
#show: pages.bibliography-page.with(title: linguify("bibliography"))

// Appendix
// Attachments, source code, diagrams...
#show: pages.appendices-page.with(
  appendices-title: linguify("appendices"),
  appendices: (
    ([Qsort implementation], [
      Implementation is in Haskell.

      #zebraw(```hs
      quicksort [] = []
      quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
        where
          lesser = filter (< p) xs
          greater = filter (>= p) xs 
      ```)

      Yes. Very cool.

      #algorithm-figure(
        "Binary Search",
        vstroke: 4.5pt + luma(200),
        {
          import algorithmic: *
          Procedure(
            "Binary-Search",
            ("A", "n", "v"),
            {
              Comment[Initialize the search range]
              Assign[$l$][$1$]
              Assign[$r$][$n$]
              LineBreak
              While($l <= r$, {
                Assign([mid], FnInline[floor][$(l + r) / 2$])
                IfElseChain(
                  $A ["mid"] < v$, {
                    Assign[$l$][$m + 1$]
                  }, [$A ["mid"] > v$], {
                    Assign[$r$][$m - 1$]
                  },
                  Return[$m$],
                )
              })
              Return[*null*]
            },
          )
        }
      )

    ]),
    ([Shit table], [
      #table(columns: (auto, auto), 
        [A], [B],
        [B], [C],
        [C], [D],
      )

      #algorithm-figure("Variable Assignment", {
        import algorithmic: *
        Assign[$x$][$y$]
      })
    ]),
  )
)

// END
//////////////////////////////////////////////////////////////////////////
