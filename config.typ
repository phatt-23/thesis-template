// Basic thesis config.
#let thesis = (
  // Langauge the thesis is written in. 
  // Options: "cs", "en"
  lang: "cs", 
  authors: (
    "Phat Tran Dai",
    // "Jan Novak",
    // "Emil Macha",
  ),
  supervisor: "Bořivoj Guláš",
  publish-location: "Ostrava",
  publish-year: "2025",
  // Recognized thesis types: "bachelor", "master", "phd"
  type: "bachelor",
  // Was this topic assigned with a PDF?
  assigned: false,
  // Do want to use the standard title page according to VSB-FEI guidelines?
  vsb-fei-comliant-title-page: false,
)

// Paths to various assets.
#let assets = (
  bib-sources: "/bib.yml",
  bib-style: "/assets/iso690-numeric-brackets-cs.csl",
  assignment: "/assets/thesis-assignment.pdf",
  logo-en: "/assets/logo_fei_en.svg",
  logo-cs: "/assets/logo_fei_cs.svg",
  lang-database: "/assets/lang-database.toml",
)

// Fonts.
#let fonts = (
  // Reading fonts for normal text.
  normal: (
    // Free palatino (https://www.gust.org.pl/projects/e-foundry/tex-gyre/index_html).
    pagella: (font: "TeX Gyre Pagella", size: 11pt),
    // Normal Latin Modern. Too thin and hard to read.
    lm: (font: "Latin Modern Roman", size: 11pt),     
    mcr: (font: "New Computer Modern", size: 11pt),
  ),
  // Math fonts.
  math: (
    lm: (font: "Latin Modern Math"),
    pagella: (font: "TeX Gyre Pagella Math"),
  ),
  // Raw fonts for code and hyperlinks.
  raw: (
    // Bookish look.
    lm: (font: "Latin Modern Mono 12", size: 11pt),
    courier: (font: "Courier Prime", size: 9pt),
    // Thin. Similar to Courier.
    cursor: (font: "TeX Gyre Cursor", size: 10pt, weight: "regular"),
  )
)

// Document config.
#let document = (
  // Use `auto` if you don't have these fonts downloaded.
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
    // Recommended margin for all sides is 2.5cm which is about 1in.
    margin: (
      left: 1.2in, 
      right: 1.2in,
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

  // The looks of hyperlinks.
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
    //    numbered
    //    numbered-br
    //    not-numbered
    //    not-numbered-br
    //    chaptered
    //    chaptered-br
    //    appendix
    // Applied to headings of all levels.
    h-all: "numbered",
    // Applied to heading of level 1.
    h-1: "chaptered-br",
    // When the header option is ...-br
    // then the heading will be pushed down by this size
    // leaving empty space before the heading.
    v-space-after-br: 5em,
    // Varioues sizings, margins and stuff....
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
  ),

  list: (
    // Markers for different levels.
    marker: (
      [--], 
    ),
  ),

  // Raw blocks and inlines
  raw: (
    // Theme in TextMate format.
    theme: "/assets/my-raw-theme.tmTheme",
    // You can browse themes like this.
    /*
    theme: {
      // These were stolen from: https://github.com/filmgirl/TextMate-Themes
      // I like: Notepad2, Dawn, ryan-light
      import "/assets/raw-themes/themes.typ": best-themes 
      "/assets/raw-themes/" + best-themes.at(0)
    }
    */
  ),
  // Equation block config.
  math-equation: (
    numbering: "(1.1)",
  ),
  
  reference: (
    // Options: 
    //   default 
    //      - no modification
    //   math-eq-fix 
    //      - fixes some issues of references to math equation
    //        because I'm using @preview/equate:0.3.2
    //        
    show-rule: "math-eq-fix", 
  ),

  // Source code listing defaults. Using @preview/codelst:2.0.2.
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

  // The looks of algorithms written using @preview/lovelace:0.3.0.
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
  
  // The looks of algorithms written using @preview/algorithmic:1.0.0.
  algorithmic-style: (it) => {
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

// Shorthands you can define and use in math blocks.
#let math-shorthands = (
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
)

