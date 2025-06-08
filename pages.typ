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

#let bibliography-page(
  document
) = [
  // Remove show rules and styles.
  #set page(header: context {
    if here().page() != query(<main-bib>).first().location().page() [
      #utils.header-stack([
        #linguify("bibliography")
      ])
    ] 
  })
  #show heading: it => {it.body}

  // Inject bibliography.
  #utils.load-bib(main: true)

  #document
]
