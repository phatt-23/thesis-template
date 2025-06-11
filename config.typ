// Thesis
#let thesis = (
  lang: "cs", // options: "cs", "en"
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
  lang-database: "/assets/lang-database.toml",
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
    pagella: (font: "TeX Gyre Pagella", size: 11pt),
    // Normal LM, too thin and hard to read.
    lm: (font: "Latin Modern Roman", size: 11pt),     
    // CMR. Classic.
    mcr: (font: "New Computer Modern", size: 11pt),
  ),
  // Math fonts.
  math: (
    lm: (font: "Latin Modern Math"),
    pagella: (font: "TeX Gyre Pagella Math"),
  ),
  // Raw fonts for code and other placese where 
  // a monospace font is required.
  raw: (
    // Thin
    cursor: (font: "TeX Gyre Cursor", size: 10pt, weight: "regular"),
    // Bookish look.
    courier: (font: "Courier Prime", size: 9pt),
    lm: (font: "Latin Modern Mono 12", size: 11pt),
    // This is nice.
    sourcecode: (font: "SauceCodePro NF", size: 9pt),
    inconsolata: (font: "Inconsolata", size: 10pt),
  )
)

// Document config.
#let document = (
  fonts: (
    normal: fonts.normal.pagella,
    math: fonts.math.pagella,
    raw: fonts.raw.courier,
  ),

  text: (
    fill: black,
  ),

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

  link: (
    fill: rgb(0, 0, 100),
    // In printed documents, links shouldn't be underlined.
    underline-stroke: 0.0pt, // 0.5pt,
    underline-offset: 1pt,
  ),
  
  paragraph: (
    // Space between each line. 
    // Should be up to the font's adjustments. 
    // But you're free to adjust it yourself.
    leading: 0.65em,
    // Space between each paragraph.
    spacing: 0.65em, // 1.4em, 
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

  // Raw blocks and inlines
  raw: (
    // Theme in TextMate format.
    theme: "/assets/my-raw-theme.tmTheme",
    // {
      // These were stolen from: https://github.com/filmgirl/TextMate-Themes
      // import "/assets/raw-themes/themes.typ": best-themes 
      // I like: 
      //    "Notepad2.tmTheme", 
      //    "Dawn.tmTheme", 
      //    "ryan-light.tmTheme"
      // "/assets/raw-themes/" + best-themes.at(0)
    // }
  ),
  
  math-equation: (
    numbering: "(1.1)",
  ),

  // Source code listing defaults.
  sourcecode-defaults: (
    frame: block.with(
      fill: luma(255),
      stroke: (
        top: 0.5pt + luma(160),
        bottom: 0.5pt + luma(160)
      ),
      inset: (x: .2em, y: .8em),
      breakable: true,
      width: 100%,
    ),
    numbers-style: lno => text(.8em, luma(160), raw(lno)),
    numbers-align: top+right,
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
  algorithmic-style: it => {
    show figure.where(kind: "algorithm"): it => {
      set align(left)
      table(
        columns: 1,
        stroke: none,
        table.hline(stroke: 0.5pt + luma(0)),
        strong(it.caption),
        table.hline(stroke: 0.5pt + luma(0)),
        it.body,
        table.hline(stroke: 0.5pt + luma(0)),
      )
    }
    it
  }
)

#let math-shorthands = (
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
)

