#import "/lib/global.typ": *
#import "/lib/utils.typ"

#load-bib(main: false)

= Heading Level 1

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
  }) \
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

#lorem(200)
