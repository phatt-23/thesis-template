#import "/lib/global.typ": *
#import "/lib/utils.typ" 
#import physica: *

#load-bib(main: false)

= OFDM - Orthogonal Frequency Division Multiplexing
// #lorem(10)

// Just to make the LSP shut up.
#set heading(numbering: "1.1")

== Introduction <intro>
In @intro, we see how to turn
Sections into Chapters. And
in @intro[kapitole], it is done
manually.

$
  <= +-
$

#lorem(10) @editors.
#lorem(10) @barb.

$
  sum_(i = 1)^n i = 1 + 2 + 3 + ... + n
$

Code snippet in C programming langauge:

#figure(
  sourcecode[
  ```c
  #include <stdio.h>

  int main() {
    printf("hello, world!\n");
    return 0;
  }
  ```],
  caption: [Computer program in C language]
)

More simple langauge, for example SQL:

#figure(
  sourcecode(
  ```sql
  SELECT 
    c.customer_id, 
    c.fname,
    c.lname,
    c.email
  FROM customer c
  WHERE EXISTS (
    SELECT *
    FROM purchase p
    WHERE p.customer_id = c.customer_id 
  )
  ```),
  caption: [Simple SQL query]
)

== Subheading Level 2

#lorem(20) @drill

$
  imat(3, delim: "[", fill: *)
$

#lorem(30)

== Prokázání netranzitivity

První úkolem je ukázat, že vztahy mezi kostkami nejsou tranzitivní, 
to znamená, že vztahy mezi kostkami jsou tzv. cyklické
#footnote[
  Wikipedia, _Intransitivity_:
  #link("https://en.wikipedia.org/wiki/Intransitivity")
]
Tvrdíme totiž, že platí $B > A$, $C > B$ a současně $A > C$.
To znamená, že žádná kostka není "nejlepší" ve všech případech. 

Pro každou dvojici kostek vypočítáme pravděpodobnost vítězství jedné 
kostky nad druhou, konkrétně $P(B>A)$, $P(C>B)$ a $P(A>C)$, a ověříme, 
že všechny tyto pravděpodobnosti jsou větší než $1/2$.

#lorem(40)

== Subheading Level 2

#lorem(20)

#sourcecode[```typ
#show "ArtosFlow": name => box[
  #box(image(
    "logo.svg",
    height: 0.7em,
  ))
  #name
]

This report is embedded in the
ArtosFlow project. ArtosFlow is a
project of the Artos Institute.
```]


=== Subheading Level 3

#lorem(50)

#figure(
  [
    #let rng = suiji.gen-rng(33)
    #let (rng, x) = suiji.uniform(rng, size: 20)
    #let (rng, y) = suiji.uniform(rng, size: 20)
    #let (rng, colors) = suiji.uniform(rng, size: 20)
    #let (rng, sizes) = suiji.uniform(rng, size: 20)

    #lilaq.diagram(
      lilaq.scatter(
        x, y,
        size: sizes.map(size => 200 * size),
        color: colors,
        map: color.map.magma
      )
    )
  ],
  caption: [Some random data visualisation]
)

#lorem(30)


