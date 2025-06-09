// Thesis
#let thesis = (
  // options: "cs", "en"
  lang: "cs",
  authors: (
    "Phat Tran Dai",
    // "Jan Novak",
    // "Emil Macha",
  ),
  supervisor: "Borivoj Gulas",
  publish-location: "Ostrava",
  publish-year: "2025",
  type: "bachelor",
  assigned: true,
)

// Assets.
#let assets = (
  bib-sources: "/bib.yml",
  bib-style: "/assets/iso690-numeric-brackets-cs.csl",
  assignment: "/assets/thesis-assignment.pdf",
  logo-en: "/assets/logo_fei_en.svg",
  logo-cs: "/assets/logo_fei_cs.svg",
  linguify-database: "/assets/linguify-database.toml",
)

// Sizing.
#let sizing = (
  heading-size: 1.2em,
  heading-1-suplement-size: 1.15em,
  heading-1-size: 1.55em,
  heading-block: (
    t-pad: 2.5em,
    b-pad: 1.5em,
  ),
  heading-1-block: (
    t-pad: 3.5em,
    b-pad: 2.5em,
  ),
)

// Fonts.
#let fonts = (
  // Reading fonts for normal text.
  normal: (
    // Free palatino. 
    // https://www.gust.org.pl/projects/e-foundry/tex-gyre/index_html
    pagella: (font: "TeX Gyre Pagella"),
    // Normal LM, too thin and hard to read.
    lm: (font: "Latin Modern Roman"),     
    // CMR. Classic.
    mcr: (font: "New Computer Modern"),
  ),
  // Math fonts.
  math: (
    lm: (font: "Latin Modern Math"),
    pagella: (font: "TeX Gyre Pagella Math"),
  ),
  // Raw fonts for code and other placese where 
  // a monospace font is required.
  raw: (
    sourcecode: (font: "SauceCodePro NF", size: 10pt),
    lm: (font: "Latin Modern Mono 12", size: 11pt),
  )
)

// Document config.
#let document = (
  page: (
    // Standard page in Europe.
    paper: "a4",
    // Recommended margin is 2.5cm which is about 1in
    // so I'm gonna stick with inches.
    margin: (
      left: 1in, 
      right: 1in,
      top: 1.2in,
      bottom: 1.1in,
    ),
    // Header with chapter of level 1.
    // - possible options:
    //    numbering
    //    no-numbering
    header: "numbering",    
    header-ascent: 30%,
    // Footer with a counter.
    // Having the title on the left and counter on the right
    // would be nice. Don't know if it's possible.
    // - possible choices:
    //    titled-both,
    //    titled-single,
    //    number-single,
    //    number-both,
    footer: "number-single",
    footer-descent: 30%,
  ),

  fonts: (
    normal: fonts.normal.pagella,
    math: fonts.math.pagella,
    raw: fonts.raw.lm,
  ),

  link: (
    fill: rgb(0, 0, 100),
    underline-stroke: 0.5pt,
  ),
  
  paragraph: (
    // Space between each line. 
    // Should be up to the font's adjustments. 
    // But you're free to adjust it yourself.
    leading: 0.65em,
    // Space between each paragraph.
    spacing: 1.4em, 
    // Justify, allow linebreaks.
    justify: true,
    linebreaks: "optimized",
    // Indent first line.
    first-line-indent: (
      amount: 1.5em,
      all: false,
    )
  ),

  heading: (
    numbering: "1.1",
    appendix-numbering: "A",
    // Heading options:
    //    normal,
    //    chaptered 
    h-all: "numbered",
    h-1: "chaptered-br",
    v-space-after-br: 5em,
  ),

  // Raw block settings.
  zebraw-block: (
    numbering: true,
    numbering-separator: false,
    // Language badge at the top right corner
    lang: true,
    // Langauge badge background color.
    lang-color: luma(255 - 24),
    // How the langauge badge looks like.
    lang-font-args: (
      weight: "bold",
      fill: black,
    ),
    // How many levels will have indentation vertical lines?
    indentation: 0,
    // Inset of the number line.
    inset: (
      left: 0.2em,
      right: 0.6em
    ),
    // I want more subtle background.
    background-color: luma(255 - 4),
  ),

  // Pseudocode settings.
  lovelace-defaults: (
    // Indentation size and stroke.
    indentation: 1.4em,
    stroke: 0.75pt + luma(120),
    // Hooked indent lines.
    hooks: 0.25em,
    // Booktabs are the vert lines at the start and end.
    booktabs: true,
    booktabs-stroke: 1pt + black,
    // Line numbering format.
    line-numbering: "1",
  ),
)

#let math-shorthands = (
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
  ($<=$, math.arrow.l.double), 
)

