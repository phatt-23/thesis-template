#import "/lib/global.typ": *

// Just to make the LSP shut up.
#set math.equation(numbering: config.document.math-equation.numbering)

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
    [Circle], $pi r^2$,
    [Square], $a^2$,
    [Rectangle], $a b$,
  ), 
  caption: [A simple table]
)

#lorem(100)

We define:
$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

With @ratio, we get:
$ F_n = floor(1 / sqrt(5) phi.alt^n) $

#lorem(100)

$ E &= sqrt(m_0^2 + p^2) \
    &approx 125 "GeV" $ 

#lorem(20)

$ E &= m c^2 #<short> \
    &= sqrt(p^2 c^2 + m^2 c^4) #<long> 
$

== Subheading Level 2

#lorem(50)

== Subheading Level 2

The dot product of two vectors $arrow(a)$ and $arrow(b)$ can
be calculated as shown in @dot-product.

$
  angle.l a, b angle.r &= arrow(a) dot arrow(b) \
                       &= a_1 b_1 + a_2 b_2 + ... a_n b_n \
                       &= sum_(i=1)^n a_i b_i. #<sum>
$ <dot-product>

The sum notation in @sum is a useful way to express the dot
product of two vectors.

#lorem(100)

