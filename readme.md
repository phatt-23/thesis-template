# VSB-FEI Thesis Template

The template is written in [Typst](https://github.com/typst/typst).

It supports these types of theses:
- `bachelor`
- `master`
- `phd` 

# File Structure

- **`main.typ`** - main entrypoint (compile this file), includes all pages and chapters
- **`config.typ`** - personal configuration and styling
- **`bib.yml`** - bibliography in YAML
- **`lib/`** - here lives the code that does stuff
    - **`global.typ`** - import this in every chapter, provides libraries and load-bib
    - **`utils.typ`** - helper functions and variables
    - **`pages.typ`** - basic pages that appear in theses
- **`assets/`** - put all the assets like images, diagrams, source code in here 
    - **`lang-database.toml`** - provides translations of string appearing in the document
    - **`iso690-numeric-brackets-cs.csl`** - citation standard in CSL language
    - **`logo_fei_cs.svg`** - czech version of VSB FEI logo
    - **`logo_fei_en.svg`** - english version of VSB FEI logo
- **`chapters/`** - segment your chapters here
    - **`preliminary-and-concluding.typ`** - content for preliminary (abstract, thanks, intro...) and concluding pages (conclusion, appendices, ...)
    - **`chapter-1.typ`**
    - **`chapter-2.typ`**
    - ...
    - **`chapter-n.typ`**

# Run

In the directory with `main.typ` file run:
```bash
typst watch main.typ
```

View the compiled `main.pdf` in any PDF viewer. 
For example in [zathura](https://github.com/pwmt/zathura).
```bash
zathura main.pdf
```

# TODO

- [ ] Create a documentation. Maybe use [tidy](https://typst.app/universe/package/tidy/).
- [x] Clean up the `main.typ` - show only the actual pages and the actual body of text, remove show rules and stuff.


