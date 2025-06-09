# VSB-FEI Thesis Template

The template is written in [Typst](https://github.com/typst/typst).

# File Structure

- main.typ - main entrypoint, compile this file
- config.typ - personal configuration
- bib.yml - bibliography in YAML
- lib/
    - global.typ - import this in every chapter, provides libraries and load-bib
    - utils.typ - helper functions and variables
    - pages.typ - basic pages that appear in theses
- assets/ 
    - lang-database.toml - provides translations of string appearing in the document
    - iso690-numeric-brackets-cs.csl - citation standard in CSL language
    - logo_fei_cs.svg - czech version of VSB FEI logo
    - logo_fei_en.svg - english version of VSB FEI logo
- chapters/ - segment your chapters here, or just in main (not advisable)
    - chapter-1.typ
    - chapter-2.typ
    - ...
    - chapter-n.typ


