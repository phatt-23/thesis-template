// Pages that are "reusable", e.g title, abstract, conclusion, bibliography, appendix...

#import "global.typ": *
#import "utils.typ"

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
  document
) = context [
  #let main-title = if text.lang == "en" {title.en} else {title.cs}
  #let sub-title =  if text.lang == "en" {title.cs} else {title.en}
  #let logo-path = if text.lang == "en" {"assets/logo_fei_en.svg"} else {"assets/logo_fei_cs.svg"}
  
  #box(
    move(
      dx: -2em,
      image(
        logo-path, 
        height: 8.5em,
      )
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
  #text(
    size: 1.5em,
  )[
    #sub-title
  ]

  #v(1em)

  // Authors
  #let authors-str-repr = authors.map(str).join(", ", last: " " + linguify("and") + " ")

  #text(
    size: 1.8em,
  )[
    #authors-str-repr
  ]

  #align(bottom)[
    #text(size: 1.5em)[
      #utils.match((
        (thesis-type == "bachelor", linguify("bachelor-thesis")),
        (thesis-type == "master", linguify("master-thesis")),
        (thesis-type == "phd", linguify("phd-thesis")),
        (true, text(fill: red)[The thesis type is not recognized])
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
  document
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
  keywords: (en: [], cs: []),
  document
) = context [
  #let f-abs-title = if text.lang == "en" {abstract-title.en} else {abstract-title.cs}
  #let f-abs-body = if text.lang == "en" {abstract-body.en} else {abstract-body.cs}
  #let l-abs-title = if text.lang != "en" {abstract-title.en} else {abstract-title.cs}
  #let l-abs-body = if text.lang != "en" {abstract-body.en} else {abstract-body.cs}

  #let f-key-title = if text.lang == "en" {keywords-title.en} else {keywords-title.cs}
  #let f-keys = if text.lang == "en" {keywords.en} else {keywords.cs}
  #let l-key-title = if text.lang != "en" {keywords-title.en} else {keywords-title.cs}
  #let l-keys = if text.lang != "en" {keywords.en} else {keywords.cs}

  #pagebreak(weak: true)

  #align(horizon)[
    #heading(outlined: false, bookmarked: false)[
      #text(size: heading-size)[
        #f-abs-title
      ]
    ]

    #f-abs-body

    #block[
      *#f-key-title:* #f-keys.join(", ")
    ]

    #v(10em)

    #heading(outlined: false, bookmarked: false)[
      #text(size: heading-size)[
        #l-abs-title
      ]
    ]

    #l-abs-body

    #block[
      *#l-key-title:* #l-keys.join(", ")
    ]
  ]
  
  #document
]

#let list-of-symbols(
  title: none,
  symbols: (),
  document
) = [
  #show: utils.remove-show-rules.with(<main-list-of-symbols>, title: title)

  #let keys = symbols.map(x => x.at(0))
  #let values = symbols.map(x => x.at(1))

  #let table-content = ()
  #for (k,v) in symbols {
    table-content.push([#k])
    table-content.push([--])
    table-content.push([#v])
  }


  #pagebreak(weak: true)

  #heading(outlined: false)[#title] <main-list-of-symbols>

  #table(
    columns: (10em, 1em, auto),
    stroke: none,
    ..table-content
  )

  #document
]

#let outline-page(
  title: none,
  document
) = [
  #show: utils.remove-show-rules.with(<main-content>, title: title)

  #pagebreak(weak: true)

  #heading(outlined: false)[#title] <main-content>
  
  #show outline.entry: outrageous.show-entry.with(
    ..outrageous.presets.typst,
    fill: (
      none,
      line(length: 100%, stroke: gray + .5pt),
    ),
  )

  #show outline.entry.where(level: 1): it => {
    v(1.5em, weak: true)
    strong(it)
  }

  #v(2.5em)

  #outline(
    indent: auto,
    title: none,
  )

  #document
]

#let conclusion-page(
  title: none,
  body: none,
  document
) = [
  #show: utils.remove-show-rules.with(<main-conclusion>, title: title)

  #pagebreak(weak: true)

  = #title <main-conclusion>

  #body

  #document
]

#let bibliography-page(
  title: none,
  bib-sources: (),
  bib-params: (
    style: "ieee", 
  ),
  document
) = [
  #show: utils.remove-show-rules.with(<main-bib>, title: title)

  #pagebreak(weak: true)

  = #title <main-bib>

  // Inject bibliography.
  #utils.load-bib(
    main: true, 
    bib-sources: bib-sources,
    bib-params: bib-params,
  )

  #document
]

#let thanks-page(
  body,
  title: none,
  document
) = [
  #show: utils.remove-show-rules.with(<main-acknowledgements>, title: title)

  #pagebreak(weak: true)

  #align(bottom)[
    #if title != none [
      #heading(outlined: false)[#title] <main-acknowledgements>
    ]

    #body  
  ]

  #document
]

#let intro-page(
  title: none,
  body: [],
  document
) = [
  #show: utils.remove-show-rules.with(<main-intro>, title: title)

  #pagebreak(weak: true)

  = #title <main-intro>

  #body

  #document
]

