#import "/config.typ": sizing, document

// Returns the current heading of specified level 
// that is the first one AFTER the call. 
// If no were found then return the closest one BEFORE the call.
#let current-heading(
  level: 1
) = { 
  // Queries all headings of specified level that are located AFTER the call.
  let headings = query(
    selector(
      heading.where(level: level)
    ).after(here())
  )
  
  // Are there any headings after the call?
  // If the first heading after is on the same page, 
  // then return this heading.
  // Otherwise get the closest one before the call.
  if headings.len() != 0 and headings.first().location().page() == here().page() {
    let heading = headings.first()
    return [#heading]
  } else {
    headings = query(
      selector(
        heading.where(level: level)
      ).before(here())
    )

    if headings.len() != 0 {
      return [#headings.last()] 
    }
  }
  
  // If there are no headings of this level anywhere then panic.
  panic(
    "There are no heading after or before this point with heading level of " 
    + str(level) + ". Remove this call from page " + str(here().page()) 
  )
}

#let current-numbering(p-heading) = {
  return [
    #numbering(
      p-heading.numbering, 
      ..counter(heading).at(p-heading.location())
    )
  ]
}

#let ignore-first-line-indent(doc) = context {
  set par(first-line-indent: (amount: 0em))
  doc
}

#let show-page-borders(doc) = context {
  set page(
    background: rect(
      width: 100%,
      height: 100%,
    )
  )
  doc
}

#let match(patterns) = {
  for (expr, value) in patterns {
    if expr == true {
      return value
    }
  }

  panic("No default case in the match pattern.")
}

#let or-default(this, default) = {
  if this == none {
    return default
  }

  return this
}



#let hline = line(
  // This is a dirty way of disabling horizontal line.
  // Switch between true and false.
  length: 100% * if false {0} else {1},
  stroke: 0.5pt + black
)


#let header-stack(content, numbering: none) = stack(
  spacing: 0.8em,
  stack(
    dir: ltr,
    if numbering != none [
      #smallcaps(numbering)
    ],
    h(1fr),
    align(right)[
      #smallcaps(content)
    ],
  ),
  hline
)

// Page header options.
#let page-header = (
  "numbering": context [
    #let heading-1 = current-heading(level: 1)

    #if heading-1.location().page() != here().page() [
      #header-stack(
        heading-1.body, 
        numbering: current-numbering(heading-1)
      )
    ]
  ],
  "no-numbering": context [
    #let heading-1 = current-heading(level: 1)

    #if heading-1.location().page() != here().page() [
      #header-stack(
        heading-1.body
      )
    ] 
  ],
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

// Counter settings.
#let footer-counter = (
  out-of: () => counter(page).display("1/1", both: true),
  just-number: () => counter(page).display("1", both: false),
)

#let page-footer = (
  "number-single": context [
    #align(center)[
      #(footer-counter.just-number)()
    ] 
  ],
  "number-both": context [
    #align(center)[
      #(footer-counter.out-of)()
    ]
  ],
  "titled-single": context [
    #titled-footer-content(footer-counter.just-number)
  ],
  "titled-both": context [
    #titled-footer-content(footer-counter.out-of)
  ],
)

#let page-heading-normal-impl(
  heading, 
  numbering: true, 
  // Is the page the actual body of work?
  // Or is it formal fluff around the work?
  formal-fluff: false
) = [
  #show: ignore-first-line-indent.with()
  #let current-heading = current-heading(level: heading.level)
  
  // Wrapped into block so it isn't treated as a paragraph
  // messing up the non-indent of the first line.
  #block(
    above: sizing.heading-block.t-pad,
    below: sizing.heading-block.b-pad,
  )[
    #text(size: if formal-fluff {sizing.heading-1-size} else {sizing.heading-size})[
      #if numbering [
        #current-numbering(current-heading)
        #h(0.5em)
      ]
      #heading.body
    ]
  ]
]

#let page-heading-chapter-impl(heading) = [
  #show: ignore-first-line-indent.with()
  #let current-heading = current-heading(level: heading.level)

  // Wrapped into block so it isn't treated as a paragraph
  // messing up the non-indent of the first line.
  #block(
    above: sizing.heading-1-block.t-pad,
    below: sizing.heading-1-block.b-pad,
  )[
    #text(size: sizing.heading-1-suplement-size)[
      #heading.supplement 
      #current-numbering(current-heading)
    ]

    #text(size: sizing.heading-1-size)[
      #current-heading.body
    ]
  ] 
]

#let page-heading-appendix-impl(heading) = [
  #show: ignore-first-line-indent.with()
  #let current-heading = current-heading(level: heading.level)

  // Wrapped into block so it isn't treated as a paragraph
  // messing up the non-indent of the first line.
  #block(
    above: sizing.heading-block.t-pad,
    below: sizing.heading-block.b-pad,
  )[
    #current-numbering(current-heading)
    #h(0.5em)
    #heading.body
  ] 
]

#let page-heading = (
  // Normal heading with numbering.
  // You can apply this to headings of all levels.
  //   1.1  Some topic
  "numbered": (heading, fluff: false) => [
    #page-heading-normal-impl(heading, formal-fluff: fluff)
  ],
  "numbered-br": (heading, fluff: false) => [
    #pagebreak(weak: true)
    #page-heading-normal-impl(heading, formal-fluff: fluff)
  ],
  //  Some topic
  "not-numbered": (heading, fluff: false) => [
    #page-heading-normal-impl(heading, numbering: false, formal-fluff: fluff)
  ],
  //  Some topic
  "not-numbered-br": (heading, fluff: false) => [
    #pagebreak(weak: true)
    #v(document.heading.v-space-after-br)
    #page-heading-normal-impl(heading, numbering: false, formal-fluff: fluff)
  ],
  // Has "Chapter <number>" and then under it is the title of the chapter
  // Ideal for headings of level 1.
  //   Chapter 1
  //   Some topic 
  "chaptered": heading => [
    #page-heading-chapter-impl(heading)
  ],
  "chaptered-br": heading => [
    #pagebreak(weak: true)
    #v(document.heading.v-space-after-br)
    #page-heading-chapter-impl(heading)
  ],
  "appendix": heading => [
    // #pagebreak(weak: true)
    #page-heading-appendix-impl(heading)
  ]
)

// Apply show rules for almost all non chapter pages.
#let apply-non-chapter-show-rule(document) = [
  // Remove show rules with numbering.
  #show heading: it => (page-heading.not-numbered-br)(it, fluff: true)

  // Set header.
  #set page(header: page-header.no-numbering)

  #document
]

// Loads bibliography so citation can be referenced
// but doesn't print out the bibliography. Only if the 
// `main` is set to true does it render the bibliography out.
//
// Only one call can have the main set to true.
#let load-bib-impl(
  main: false, 
  // By default expects bib.yml to exist.
  bib-sources: (),
  bib-params: (
    style: "ieee", 
  ),
) = context [
  #counter("bibs").step()

  // #if main and query(bibliography) != () [
  //   #panic(
  //     "Bibliography is already loaded somewhere in the document. Remove it so the main bib can be loaded.", 
  //     query(bibliography)
  //   ) 
  // ] else if main and query(<main-bib>) != () [
  //   #panic(
  //     "Reserved label <main-bib> already exists somewhere in the document. Remove it so the main bib can laoded.", 
  //     query(bibliography)
  //   ) 
  // ] else 
  #if main [
    // Main bib is loaded
    #bibliography(
      bib-sources, 
      ..bib-params,
      title: none,
      // Only for DEBUG is full set to true
      full: true,
    ) <main-bib>
  ] else if query(<main-bib>) == () [
    // Wanted to load bibliography but 
    // there is no `main` bibliography.
 
    #panic("There is no main bibliography. Put the main bibliography for example at the end of the document.")
  ] 
] 
