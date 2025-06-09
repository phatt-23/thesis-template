// Here you put all imports you want to use throughout chapters.
// Also all variables and functions that should be global are here.


// For modern-looking code listings.
#import "@preview/zebraw:0.5.5": zebraw, zebraw-init

// For data visualisation.
#import "@preview/lilaq:0.3.0"

// Randomiser.
#import "@preview/suiji:0.3.0" 

// For shorthands in math blocks to make them more readable.
// You can define your own 'macros'.
#import "@preview/quick-maths:0.2.1"

// For writing pseudocode.
#import "@preview/lovelace:0.3.0" 

// For writing pseudocode. Classic.
#import "@preview/algorithmic:1.0.0" 

// For automatic choosing of the correct string in the 
// global database (TOML config file) based on the set text.lang.
#import "@preview/linguify:0.4.2" as linguify-plug: linguify

// For multiple bibliography entries withing a single document.
// #import "@preview/alexandria:0.2.0": *

// For more convenient math notation.
#import "@preview/physica:0.9.5" as ps: *

// Allows inserting pdf files into the document.
#import "@preview/muchpdf:0.1.0": muchpdf

// Outline.
#import "@preview/outrageous:0.4.0"

#import "/lib/utils.typ"
#import "/config.typ"

// Lower level inteface. Isn't written like a list.
// Have to write indent() manually and wrap the text in [].
#let pseudocode = lovelace.pseudocode.with(..config.document.lovelace-defaults)
// Just like a nested list.
#let pseudocode-list = lovelace.pseudocode-list.with(..config.document.lovelace-defaults)

#let load-bib(main: false) = utils.load-bib-impl(
  bib-sources: config.assets.bib-sources,
  bib-params: (
    style: config.assets.bib-style,
  ),
  main: main,
)
