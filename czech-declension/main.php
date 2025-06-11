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

foreach ($words as $k => $w) {
    print '  "' . $w . '": (' . PHP_EOL;

    $inf = $inflection->inflect($w);
    
    print '    s: (' . PHP_EOL;
    for ($i = 1; $i <= 7; $i++) { 
        print '      "' . $i .'": "' . $inf[$i] . '",' . PHP_EOL;
    }
    print '    ),' . PHP_EOL;

    print '    p: (' . PHP_EOL;
    for ($i = 1; $i <= 7; $i++) { 
        print '      "' . $i .'": "' . $inf[$i + 7] . '",' . PHP_EOL;
    }
    print '    ),' . PHP_EOL;

    print '  ),'. PHP_EOL;
}

print ')' . PHP_EOL;
