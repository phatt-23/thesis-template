= Heading 5

Jelikož základ nehomogenní funkce je roven jedné, 
počet výskytů (násobnost) tohoto základu v 
multimnožině kořenu charakteristické 
rovnice je roven jedné
a největší exponent $n$-ka nehomogenní 
funkce je taktéž roven jedné,
je tvar obecného partikulárního řešení 
rekurentí rovnice $p_n$ roven:
$
  p_n^((p)) &=n^1 (beta_1 n^1 + beta_0) 1^n
            space = space n (beta_1 n + beta_0)
            space = space beta_1 n^2 + beta_0 n \
  p_n^((p)) &= phi n^2 + gamma n #h(10em) (gamma = beta_0, phi = beta_1).
$  

Neznámé $gamma$ a $phi$ nalezneme 
substitucí členů $p_n$ 
v původní rekurentní rovnici:
$ 
  p_n = 3p_(n-1) - 2p_(n-2) - 10n. 
$
partikulárním řešením $p_n^((p))$
a vyřesíme soustavu dvou rovnic 
(dvě kvůli dvěma neznámým), 
kde si za $n$ zvolíme jakékoliv čísla z $NN_0$. 

$p_n <- p_n^((p))": "$
$
  p_n^((p)) = 3p_(n-1)^((p)) - 2p_(n-2)^((p)) - 10n \
$
$
  phi n^2 + gamma n 
        = &3(phi (n-1)^2 + gamma (n-1)) \
        - &2(phi (n-2)^2 + gamma (n-2)) - 10n \
  
  phi n^2 + gamma n 
        = &3(phi (n^2 - 2n + 1) + gamma n - gamma) \
        - &2(phi (n^2 - 4n + 4) + gamma n - 2gamma) - 10n \

  phi n^2 + gamma n 
        = &3(phi n^2 - 2 phi n + phi + gamma n - gamma) \
        - &2(phi n^2 - 4phi n + 4phi + gamma n - 2gamma) - 10n \

  phi n^2 + gamma n 
        = &3phi n^2 - 6phi n + 3phi + 3gamma n - 3gamma \
        - &2phi n^2 + 8phi n - 8phi - 2gamma n + 4gamma - 10n \
$
$
  phi n^2 + gamma n &= phi n^2 + 2phi n - 5phi + gamma n + gamma - 10n \
  0 &= 2phi n - 5phi + gamma - 10n \
$

Nyní si za $n$ zvolíme například nulu a jedničku.
$
  n = 0": " quad 0 &= 2phi dot 0 - 5phi + gamma - 10 dot 0 \
  n = 1": " quad 0 &= 2phi dot 1 - 5phi + gamma - 10 dot 1
$
$
  cases(
    0 &= - 5phi + gamma,
    0 &= 2phi - 5phi + gamma - 10
  )\
  cases(
    0 &= gamma - 5phi,
    10 &= gamma - 3phi
  )\
  mat(augment: #2,
    1, -5, 0;
    1, -3, 10;
  )
  tilde.op^(R_2 <- R_2 - R_1)
  mat(augment: #2,
    1, -5, 0;
    0, 2, 10;
  )
  tilde.op^(R_2 <- 1/2 R_2)
  mat(augment: #2,
    1, -5, 0;
    0, 1, 5;
  )\
  phi = 5 \
  gamma - 5 dot phi = 0 <=> gamma = 25
$

Tudíž řešení partikulární rovnice $p_n^((p))$ je:
$
  p_n^((p)) = phi n^2 + gamma n \
  underline(
    p_n^((p)) = 5n^2 + 25n
  ).
$
