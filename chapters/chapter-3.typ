#import "/lib/global.typ": *
#import "/czech-declension/out.typ": inflected as inf

// Just to make the LSP shut up.
#load-bib()
#set heading(numbering: config.document.heading.numbering)
#set math.equation(numbering: config.document.math-equation.numbering)


= Odkazy na objekty

Zde jsou demonstrace odkazů, `ref` v Typst, na různé objekty v dokumentu.
   
== Odkazy na kapitoly <some-chpater>

In @some-chpater, we see how to turn
Sections into Chapters @barb.
And in @some-chpater[kapitole], it is done
manually @editors.

== Odkazy na tabulky

Něco je znázorněno v @long-table[#inf.tab.sg.loc].
Tady jsme před @long-table[#inf.tab.sg.ins].

#figure(
  table-with-header(
    columns: (auto, auto),
    table.header(
      [*Index*], [*Value*],
    ),
    ..(
        [1], [10],
        [2], [11],
        [3], [12],
        [4], [13],
    ) * 3 
  ), 
  caption: [A long table]
) <long-table>


A tu jsme za @long-table[#inf.tab.sg.ins].


Zde je @simple-table[#inf.tab.sg.nom].
Prohlídnutím @simple-table[#inf.tab.sg.gen] si můžete všimnout něco.

#figure(
  table-with-header(
    columns: 2,
    table.header(
      [*Shape*], [*Area*],
    ),
    [Circle], $pi r^2$,
    [Square], $a^2$,
    [Rectangle], $a b$,
  ), 
  caption: [A simple table]
) <simple-table>


== Odkazy na rovnice

Nechť:

$ 
  phi.alt := (1 + sqrt(5)) / 2 
$ <ratio>

Pomocí @ratio[#inf.equ.sg.gen], dostaneme:

$ 
  F_n = floor(1 / sqrt(5) phi.alt^n) 
$

Takto se dělají vnitřní jmenovky (`label`) v `$ ... $` blocích, na které lze potom odkazovat.

$ 
  E &= m c^2 #<short> \
    &= sqrt(p^2 c^2 + m^2 c^4) #<long> 
$

=== Příklad odkazování na vnitřní jmenovky

Skalární součin dvou vektrorů $arrow(a)$ a $arrow(b)$ 
je znázorněn @dot-product[#inf.equ.sg.ins].

$
  angle.l a, b angle.r &= arrow(a) dot arrow(b) \
                       &= a_1 b_1 + a_2 b_2 + ... a_n b_n \
                       &= sum_(i=1)^n a_i b_i. #<sum>
$ <dot-product>

Notace sumy v @sum[#inf.equ.sg.loc] je užitečný způsob zápisu 
skalárního součinu dvou vektorů.


== Odkazy na obrázky

Na @data-visualisation[#inf.fig.sg.loc] je zobrazeno bla bla.

#figure(
  [
    #let rng = suiji.gen-rng(33)
    #let (rng, x) = suiji.uniform(rng, size: 20)
    #let (rng, y) = suiji.uniform(rng, size: 20)
    #let (rng, colors) = suiji.uniform(rng, size: 20)
    #let (rng, sizes) = suiji.uniform(rng, size: 20)

    #lilaq.diagram(
      lilaq.scatter(
        x, y,
        size: sizes.map(size => 200 * size),
        color: colors,
        map: color.map.magma
      )
    )
  ],
  caption: [Some random data visualisation]
) <data-visualisation>

