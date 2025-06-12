<?php

// Generates a Typst dict of inflected $words.

require_once __DIR__ . '/Inflection.php';

$inflection = new Inflection();

$inflected = [
    "equ" => "rovnice",
    "chp" => "kapitola",
    "fig" => "obrázek",
    "lst" => "výpis",
    "alg" => "algoritmus",
    "tab" => "tabulka",
];

print '#let inflected = (' . PHP_EOL;

foreach ($inflected as $key => $word) {
    $cs = $inflection->inflect($word);

    print '  "' . $key . '": (' . PHP_EOL;
    print '    sg: (' . PHP_EOL;
    print '      nom: "' . $cs[1] . '",' . PHP_EOL;
    print '      gen: "' . $cs[2] . '",' . PHP_EOL;
    print '      dat: "' . $cs[3] . '",' . PHP_EOL;
    print '      acc: "' . $cs[4] . '",' . PHP_EOL;
    print '      voc: "' . $cs[5] . '",' . PHP_EOL;
    print '      loc: "' . $cs[6] . '",' . PHP_EOL;
    print '      ins: "' . $cs[7] . '",' . PHP_EOL;
    print '    ),'. PHP_EOL;
    print '    pl: (' . PHP_EOL;
    print '      nom: "' . $cs[1 + 7] . '",' . PHP_EOL;
    print '      gen: "' . $cs[2 + 7] . '",' . PHP_EOL;
    print '      dat: "' . $cs[3 + 7] . '",' . PHP_EOL;
    print '      acc: "' . $cs[4 + 7] . '",' . PHP_EOL;
    print '      voc: "' . $cs[5 + 7] . '",' . PHP_EOL;
    print '      loc: "' . $cs[6 + 7] . '",' . PHP_EOL;
    print '      ins: "' . $cs[7 + 7] . '",' . PHP_EOL;
    print '    ),'. PHP_EOL;
    print '  ),'. PHP_EOL;
}

print ')' . PHP_EOL;
