#import "/lib/global.typ": *

= Heading Level 1

#lorem(20)

== Subheading Level 2

#lorem(50)

// #figure(
//   kind: "algorithm",
//   supplement: [Algorithm],
//   caption: [My cool algorithm],
//
//   pseudocode-list(
//     title: smallcaps[Fancy-Algorithm],
//   )[
//     + do something
//     + do something else
//     + *while* still something to do *do*
//       + do even more
//       + *if* not done yet *then*
//         + wait a bit
//         + resume working
//       + *else*
//         + go home
//       + *end*
//     + *end*
//   ]
// )

#figure(
  table-with-header(
    columns: (auto, auto),
    table.header(
      [*Index*], [*Value*],
    ),
    ..(
        [1], [10],
        [2], [11],
        [3], [12],
        [4], [13],
    ) * 10
  ), 
  caption: [A looong table]
)

#lorem(20)

== Subheading Level 2

#lorem(100)

#figure(
  table-with-header(
    columns: 2,
    table.header(
      [*Shape*], [*Area*],
    ),
    [Circle], $ pi r^2 $,
    [Square], $ a^2 $,
    [Rectangle], $ a b $,
  ), 
  caption: [A simple table]
)

#lorem(100)

== Subheading Level 2

#lorem(50)

== Subheading Level 2

#lorem(100)

