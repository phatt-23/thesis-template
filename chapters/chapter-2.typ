#import "/lib/global.typ": *
#import physica: *

#load-bib(main: false)

#set heading(numbering: "1.1")

= Raw Code Listing

== Listing 

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

== Listing in a Figure

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

