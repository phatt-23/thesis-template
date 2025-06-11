<?php

// Generates a Typst dict of inflected $words.

require_once __DIR__ . '/Inflection.php';

$inflection = new Inflection();

$words = [
    "rovnice",
    "kapitola",
    "obrázek",
    "výpis",
    "algoritmus",
    "tabulka",
];

print '#let inflected = (' . PHP_EOL;

// foreach ($words as $k => $w) {
//     $inf = $inflection->inflect($w);
//     print '  "' . $w . '": (' . PHP_EOL;
//     print '     nom: (sg: "' . $inf[1] . '", pl: "' . $inf[1 + 7] . '"),' . PHP_EOL;
//     print '     gen: (sg: "' . $inf[2] . '", pl: "' . $inf[2 + 7] . '"),' . PHP_EOL;
//     print '     dat: (sg: "' . $inf[3] . '", pl: "' . $inf[3 + 7] . '"),' . PHP_EOL;
//     print '     acc: (sg: "' . $inf[4] . '", pl: "' . $inf[4 + 7] . '"),' . PHP_EOL;
//     print '     voc: (sg: "' . $inf[5] . '", pl: "' . $inf[5 + 7] . '"),' . PHP_EOL;
//     print '     loc: (sg: "' . $inf[6] . '", pl: "' . $inf[6 + 7] . '"),' . PHP_EOL;
//     print '     ins: (sg: "' . $inf[7] . '", pl: "' . $inf[7 + 7] . '"),' . PHP_EOL;
//     print '  ),'. PHP_EOL;
// }

foreach ($words as $k => $w) {
    $inf = $inflection->inflect($w);
    print '  "' . $w . '": (' . PHP_EOL;
    print '    sg: (' . PHP_EOL;
    print '      nom: "' . $inf[1] . '",' . PHP_EOL;
    print '      gen: "' . $inf[2] . '",' . PHP_EOL;
    print '      dat: "' . $inf[3] . '",' . PHP_EOL;
    print '      acc: "' . $inf[4] . '",' . PHP_EOL;
    print '      voc: "' . $inf[5] . '",' . PHP_EOL;
    print '      loc: "' . $inf[6] . '",' . PHP_EOL;
    print '      ins: "' . $inf[7] . '",' . PHP_EOL;
    print '    ),'. PHP_EOL;
    print '    pl: (' . PHP_EOL;
    print '      nom: "' . $inf[1 + 7] . '",' . PHP_EOL;
    print '      gen: "' . $inf[2 + 7] . '",' . PHP_EOL;
    print '      dat: "' . $inf[3 + 7] . '",' . PHP_EOL;
    print '      acc: "' . $inf[4 + 7] . '",' . PHP_EOL;
    print '      voc: "' . $inf[5 + 7] . '",' . PHP_EOL;
    print '      loc: "' . $inf[6 + 7] . '",' . PHP_EOL;
    print '      ins: "' . $inf[7 + 7] . '",' . PHP_EOL;
    print '    ),'. PHP_EOL;
    print '  ),'. PHP_EOL;
}

print ')' . PHP_EOL;
