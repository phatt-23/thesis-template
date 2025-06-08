#import "global.typ": *

#let math-shorthands = (
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
  ($<=$, math.arrow.l.double), 
)

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

// Loads bibliography so citation can be referenced
// but doesn't print out the bibliography. Only if the 
// `main` is set to true does it render the bibliography out.
//
// Only one call can have the main set to true.
//
// Source: https://forum.typst.app/t/how-to-share-bibliography-in-a-multi-file-setup/1605/8
#let load-bib(
  main: false, 
  // By default expects bib.yml to exist.
  bib-sources: ("bib.yml"),
  bib-params: (
    style: "ieee", 
  ),
) = context {
  counter("bibs").step()
  
  context if main {
    [ 
      #bibliography(
        bib-sources, 
        ..bib-params,
        title: none,
        full: true,
      )
    ]
  } else if query(<main-bib>) == () and counter("bibs").get().first() == 1 {
    // This is the first bibliography, 
    // and there is no main bibliography.
    bibliography(bib-sources, style: "ieee")
  }
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

#let vspace-before-chapter = v(2em)

#let remove-show-rules(
  // Page with this label won't have a header.
  // For example: <main-conclusion>, <main-bib>
  p-label,
  title: none,
  document
) = [
  // Remove show rules with numbering.
  #show heading: it => [
    // Wrapped into block so it isn't treated as a paragraph
    // messing up the non-indent of the first line.
    #block(
      above: heading-1-block-ypad,
      below: heading-1-block-ypad,
    )[
      #vspace-before-chapter
      #text(size: heading-1-suplement-size)[
        #it.body
      ]
    ]
  ]

  // Set header.
  #set page(header: context {
    if here().page() != query(p-label).first().location().page() [
      #header-stack(
        [#title]
      )
    ] 
  })

  #document
]

