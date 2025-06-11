// Pages that are "reusable", e.g title, abstract, conclusion, bibliography, appendix...

#import "global.typ": *
#import "utils.typ": apply-non-chapter-show-rule, match, page-heading
#import "/config.typ": assets, sizing

#let title-page(
  // Title of the work in Czech and English.
  title: (
    cs: none,
    en: none,
  ),
  authors: (),
  supervisor: none,
  // Recognized thesis types:
  //  "bachelor", "master", "phd"
  thesis-type: "bachelor",
  // Set it to Ostrava or whichever city/town.
  publish-location: none,
  // Set this to the current year or whatever year.
  publish-year: none,
  document,
) = context [
  #let main-title = if text.lang == "en" { title.en } else { title.cs }
  #let sub-title = if text.lang == "en" { title.cs } else { title.en }
  #let logo-path = if text.lang == "en" { assets.logo-en } else { assets.logo-cs }

  #box(
    move(
      dx: -2em,
      image(
        logo-path,
        height: 8.5em,
      ),
    ),
    // stroke: red,
  )

  #v(2em)

  // Main title in the set langauge.
  #text(
    size: 2em,
    weight: "bold",
  )[
    #main-title
  ]

  #v(1em)

  // Sub title in the other language.
  #text(size: 1.5em)[
    #sub-title
  ]

  #v(1em)

  // Authors
  #text(size: 1.8em)[
    #authors.map((author) => {
      let nomen = array(author.split(" "))
      let temp = array(nomen.slice(0, nomen.len() - 1).map(n => [#n~]))
      temp.push(nomen.last())
      return temp
    }).map((x) => x.join()).join(", ", last: [ #linguify("and") ])
  ]

  #align(bottom)[
    #text(size: 1.5em)[
      #match((
        (thesis-type == "bachelor", linguify("bachelor-thesis")),
        (thesis-type == "master", linguify("master-thesis")),
        (thesis-type == "phd", linguify("phd-thesis")),
        (true, text(fill: red)[The thesis type is not recognized]),
      ))

      #if supervisor != none [
        #linguify("supervisor"): #supervisor
      ]

      #publish-location#if publish-location != none and publish-year != none [,] #publish-year
    ]
  ]

  #document
]

#let thesis-assignment(
  path: none,
  document,
) = [
  #if path != none [
    #muchpdf(
      read(path, encoding: none),
    )
  ]

  #document
]

#let abstract-and-keywords(
  abstract-title: (en: [], cs: []),
  abstract-body: (en: [], cs: []),
  keywords-title: (en: [], cs: []),
  keywords: (en: (), cs: ()),
  document,
) = context [
  #let f-abs-title = if text.lang == "en" { abstract-title.en } else { abstract-title.cs }
  #let f-abs-body = if text.lang == "en" { abstract-body.en } else { abstract-body.cs }
  #let l-abs-title = if text.lang != "en" { abstract-title.en } else { abstract-title.cs }
  #let l-abs-body = if text.lang != "en" { abstract-body.en } else { abstract-body.cs }

  #let f-key-title = if text.lang == "en" { keywords-title.en } else { keywords-title.cs }
  #let f-keys = if text.lang == "en" { keywords.en } else { keywords.cs }
  #let l-key-title = if text.lang != "en" { keywords-title.en } else { keywords-title.cs }
  #let l-keys = if text.lang != "en" { keywords.en } else { keywords.cs }

  #show: apply-non-chapter-show-rule
  #show heading: it => (page-heading.not-numbered)(it, fluff: true)

  #pagebreak(weak: true)

  #align(horizon)[
    #heading(outlined: false)[ #f-abs-title ]

    #f-abs-body

    #if f-keys != () [
      #block[
        *#f-key-title:* #f-keys.join(", ")
      ]
    ]

    #v(10em)

    #heading(outlined: false)[ #l-abs-title ]

    #l-abs-body

    #if l-keys != () [
      #block[
        *#l-key-title:* #l-keys.join(", ")
      ]
    ]
  ]

  #document
]

#let list-of-symbols(
  title: none,
  symbols: (),
  document,
) = [
  #if symbols != () [
    #show: apply-non-chapter-show-rule

    #let keys = symbols.map(x => x.at(0))
    #let values = symbols.map(x => x.at(1))

    #let table-content = ()
    #for (k, v) in symbols {
      table-content.push([#k])
      table-content.push([--])
      table-content.push([#v])
    }

    #heading(outlined: false)[#title]

    #table(
      columns: (10em, 1em, auto),
      stroke: none,
      ..table-content
    )
  ]

  #document
]

#let outline-page(
  outline-title: none,
  list-of-figures: none,
  list-of-tables: none,
  list-of-algorithms: none,
  list-of-listings: none,
  document,
) = context [
  #let figures-exist(kind) = query(selector(figure.where(kind: kind))) != ()

  #show: apply-non-chapter-show-rule

  #show outline.entry: outrageous.show-entry.with(
    ..outrageous.presets.typst,
    fill: (
      none, 
      align(right, repeat(gap: 6pt)[.])
    ),
    fill-right-pad: .4cm,
  )

  #show outline.entry.where(level: 1): it => block(above: 1.2em)[
    #strong(it)
  ] 

  #set outline(
    indent: 2em,
  )

  #outline(title: outline-title)

  #show outline.entry: outrageous.show-entry.with(
    ..outrageous.presets.outrageous-figures,
    fill: (
      align(right, repeat(gap: 6pt)[.]),
    ),
  )

  #if figures-exist(image) [
    #outline(
      title: list-of-figures,
      target: figure.where(kind: image),
    )
  ]
  
  #if figures-exist(table) [
    #outline(
      title: list-of-tables,
      target: figure.where(kind: table),
    )
  ]

  #if figures-exist("algorithm") [
    #outline(
      title: list-of-algorithms,
      target: figure.where(kind: "algorithm"),
    )
  ]

  #if figures-exist(raw) [
    #outline(
      title: list-of-listings,
      target: figure.where(kind: raw),
    )
  ]

  #document
]

#let conclusion-page(
  title: none,
  body: none,
  document,
) = [
  #show: apply-non-chapter-show-rule

  #pagebreak(weak: true)

  = #title

  #body

  #document
]

#let bibliography-page(
  title: none,
  document,
) = [
  #show: apply-non-chapter-show-rule

  #pagebreak(weak: true)

  = #title 

  // Inject bibliography.
  #load-bib(main: true)

  #document
]

#let appendices-page(
  // Array of pairs of contents
  //  key : value
  //  [qsort implementation], [fragement of source code]
  appendices: (),
  appendices-title: none,
  document,
) = [
  #if appendices == () { return }

  #show: page.with(header: utils.header-stack( appendices-title ))

  // Reset the heading counter and change the numbering.
  #counter(heading).update(0)
  #show heading: it => (utils.page-heading.appendix)(it)
  #set heading(numbering: config.document.heading.appendix-numbering)

  // Set the header. 

  #for (key, value) in appendices [
    = #key
      
    #value

    #pagebreak(weak: true)
  ]

  #document
]

#let thanks-page(
  body: [],
  title: none,
  want-to-include: true,
  document,
) = [
  #if want-to-include [
    #show: apply-non-chapter-show-rule

    #pagebreak(weak: true)

    #align(bottom)[
      #if title != none [
        #heading(outlined: false)[#title]
      ]

      #body
    ]
  ]

  #document
]

#let intro-page(
  title: none,
  body: [],
  document,
) = [
  #show: apply-non-chapter-show-rule

  #pagebreak(weak: true)

  = #title

  #body

  #document
]

