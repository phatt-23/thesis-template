// Here you put all imports you want to use throughout chapters.
// Also all variables and functions that should be global are here.


// Simple code listings.
#import "@preview/codelst:2.0.2" 

// For data visualisation.
#import "@preview/lilaq:0.3.0"

// Randomiser.
#import "@preview/suiji:0.3.0" 

// For shorthands in math blocks to make them more readable.
// You can define your own 'macros'.
#import "@preview/quick-maths:0.2.1"

// For writing pseudocode. Straighforward writing like a list.
#import "@preview/lovelace:0.3.0" 

// For writing pseudocode. Classic. More cumbersome to write.
#import "@preview/algorithmic:1.0.0"
#import algorithmic: algorithm-figure

// For automatic choosing of the correct string in the 
// global database (TOML config file) based on the set text.lang.
#import "@preview/linguify:0.4.2" as linguify-plug: linguify

// For more convenient math notation.
#import "@preview/physica:0.9.5"

// Allows inserting pdf files into the document.
#import "@preview/muchpdf:0.1.0": muchpdf

// Outline.
#import "@preview/outrageous:0.4.0"

// For math equations. Apply numbering to only those that are labeled.
#import "@preview/equate:0.3.2"

// My files.
#import "/lib/lib.typ"
#import "/config.typ"

// Loads bibliography but doesn't duplicate it. You can reference bibliography
// even when the bibliography isn't visible in the file. This seems like a
// Typst issue though, but for now this works fine.
#let load-bib(main: false) = lib.load-bib-impl(
  bib-sources: config.assets.bib-sources,
  bib-params: (
    style: config.assets.bib-style,
  ),
  main: main,
)

// Writing pseudocode.
// Lower level inteface. Isn't written like a list. Have to write indent()
// manually and wrap the text in [].
#let pseudocode = lovelace.pseudocode.with(..config.document.lovelace-defaults)
// Just like a nested list.
#let pseudocode-list = lovelace.pseudocode-list.with(..config.document.lovelace-defaults)

// Source code listing. Just wrap the raw string in this.
#let sourcecode = codelst.sourcecode.with(..config.document.sourcecode-defaults)

// Table with a decapitated header (there's a small gap).
#let table-with-header = table.with(
  // Space between the header and the body of the table.
  row-gutter: (2pt, auto),
)

