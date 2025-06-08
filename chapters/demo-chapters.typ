#import "../global.typ": *
#import "../utils.typ"

#utils.load-bib(main: false)

= Heading Level

QQ _hello_ ja fi diofjosdfodsjodslsdlsdlkjflskdjkffffffffffffffffffffffffffff
kldkjfksdfjlsdfljjjjj.j..jjl jsem k a v o. 

$ f(x) = y $

$
  mat(
    1, 2, ..., 10;
    2, 2, ..., 10;
    dots.v, dots.v, dots.down, dots.v;
    10, 10, ..., 10;
  ) 
$

#lorem(40)

== Heading Level 2

#lorem(20)

$
  Omega = lr({
    &(2,1), (2,1), (5,1), (5,1), \
    &(2,4), (2,4), (5,4), (5,4), \
    &(2,4), (2,4), (5,4), (5,4), \
    &(2,4), (2,4), (5,4), (5,4)
  }, size: #150%) \
$

Velikost pravděpodobnostního prostoru je $|Omega| = 16$. 
Z rozepsané $Omega$ vidíme, že
počet případů, kdy kostka $B$ vyhraje 
nad $A$ je vyšší (10) než počet, kdy prohraje (6).
Pravděpodobnost vypočteme jako:

$
  P(B > A) = (2 + 4 dot 2)/(|Omega|) 
           = 10/16 = underline(underline(0.625))
$


= Heading Level 1

#lorem(100)

== Subheading Level 2

#lorem(100)

== Subheading Level 2

#lorem(100)

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

= Heading Level 1

== Heading Level 2

#lorem(40)

#lorem(40)

#lorem(40)

== Heading Level 2

#lorem(100)

#lorem(200)

= Heading Level 1

#lorem(40)

== Heading Level 2

#lorem(40)


=== Heading Level 2

#lorem(40)

#lorem(40)

== Heading Level 3

#lorem(40)

Term: hello @editors[p. 358] 
Secon term: #lorem(30) 
Halting: it is something @wwdc-network[p. 23]

