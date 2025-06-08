#import "../global.typ": *
#import "../utils.typ"

#utils.load-bib(main: false)

= Heading Level 1

#lorem(20)

== Subheading Level 2

#lorem(50)

#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [My cool algorithm],

  pseudocode-list(
    title: smallcaps[Fancy-Algorithm],
  )[
    + do something
    + do something else
    + *while* still something to do *do*
      + do even more
      + *if* not done yet *then*
        + wait a bit
        + resume working
      + *else*
        + go home
      + *end*
    + *end*
  ]
)

#lorem(20)

== Subheading Level 2

#lorem(100)

== Subheading Level 2

#lorem(50)

== Subheading Level 2

#lorem(100)

