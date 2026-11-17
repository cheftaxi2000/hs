#import "lib.typ": *
#set heading(numbering: none)
= Anhang: Formelsammlung

#let fs(title, body) = block(width: 100%, breakable: false, spacing: 1.2em,
  [#text(font: sans, size: 10pt, weight: "bold", title) #v(-4pt) #line(length: 100%, stroke: 0.4pt) #v(-2pt) #body])

#fs[Folgen und Reihen (Kap. 1, 5)][
  $ sum_(k=1)^n k = (n(n+1))/2, quad sum_(k=1)^n k^2 = (n(n+1)(2n+1))/6, $
  $ sum_(k=0)^(n-1) q^k = (1 - q^n)/(1 - q), quad sum_(k=0)^oo q^k = 1/(1-q) quad (|q| < 1) $
  $ (1 + 1/n)^n -> e, quad root(n, n) -> 1, quad q^n -> 0 quad (|q| < 1), quad ln n << n^a << q^n << n! << n^n $
  $ sum 1/k^p "konvergiert" <=> p > 1, quad "Quotient/Wurzel:" L < 1 "konv.", L > 1 "div." $
  $ "Leibniz:" b_k arrow.br 0 => sum (-1)^k b_k "konv." $
]

#fs[Grenzwerte (Kap. 1, 2)][
  $ lim_(x -> 0) (sin x)/x = 1, quad lim_(x -> 0) (1 - cos x)/x^2 = 1/2, quad lim_(x -> 0) (e^x - 1)/x = 1, quad lim_(x -> 0) (ln(1 + x))/x = 1, quad lim_(x -> 0^+) x ln x = 0 $
  $ "l'Hôpital bei" 0/0, oo/oo: lim f/g = lim f'/g'. quad f^g = e^(g ln f). $
]

#fs[Trigonometrie und Hyperbelfunktionen][
  $ sin^2 x + cos^2 x = 1, quad sin 2x = 2 sin x cos x, quad cos 2x = cos^2 x - sin^2 x $
  $ cos^2 x = (1 + cos 2x)/2, quad sin^2 x = (1 - cos 2x)/2 $
  $ sin(x plus.minus y) = sin x cos y plus.minus cos x sin y, quad cos(x plus.minus y) = cos x cos y minus.plus sin x sin y $
  $ cosh^2 x - sinh^2 x = 1, quad arsinh x = ln(x + sqrt(x^2 + 1)), quad arcosh x = ln(x + sqrt(x^2 - 1)) $
]

#fs[Ableitungen (Kap. 2)][
  $ (f g)' = f' g + f g', quad (f/g)' = (f' g - f g')/g^2, quad (f(g))' = f'(g) g', quad (f^(-1))' = 1/(f'(f^(-1))) $
  $ (tan x)' = 1/(cos^2 x), quad (arcsin x)' = 1/sqrt(1 - x^2), quad (arctan x)' = 1/(1 + x^2) $
  $ (a^x)' = a^x ln a, quad (x^x)' = x^x (ln x + 1) $
  $ "Tangente:" t(x) = f(x_0) + f'(x_0)(x - x_0) quad "Mittelwertsatz:" f'(xi) = (f(b) - f(a))/(b - a) $
]

#fs[Ebene Kurven (Kap. 2)][
  $ "Tangente" dot(vr) = (dot(x), dot(y)), quad "Normale" (-dot(y), dot(x)), quad m = dot(y)/dot(x) $
  $ k = (dot(x) dot.double(y) - dot.double(x) dot(y))/(dot(x)^2 + dot(y)^2)^(3\/2) quad (k > 0: "links"), quad k = f''/(1 + f'^2)^(3\/2) $
  $ "Krümmungskreis:" rho = 1/|k|, quad vec(M) = vr + 1/k hat(vn), quad hat(vn) = 1/sqrt(dot(x)^2 + dot(y)^2) (-dot(y), dot(x)) $
]

#fs[Komplexe Zahlen (Kap. 3)][
  $ z = x + i y = r e^(i phi), quad r = sqrt(x^2 + y^2), quad tan phi = y/x "(Quadrant!)" $
  $ e^(i phi) = cos phi + i sin phi, quad overline(z) = x - i y, quad z overline(z) = |z|^2 $
  $ z_1 z_2 = r_1 r_2 e^(i(phi_1 + phi_2)), quad z_1/z_2 = r_1/r_2 e^(i(phi_1 - phi_2)) $
  $ z^n = r^n e^(i n phi), quad root(n, z) = root(n, r) e^(i(phi + 2 pi k)\/n), k = 0, dots, n-1 $
]

#fs[Integrale (Kap. 4)][
  $ integral_a^b f = F(b) - F(a), quad dif/(dif x) integral_(h(x))^(g(x)) f(t) dif t = f(g) g' - f(h) h' $
  $ integral u' v = u v - integral u v', quad integral f(g) g' = integral f(u) dif u $
  $ integral x^n = x^(n+1)/(n+1), quad integral 1/x = ln|x|, quad integral (f')/f = ln|f| $
  $ integral 1/(1 + x^2) = arctan x, quad integral 1/sqrt(1 - x^2) = arcsin x, quad integral ln x = x ln x - x $
  $ integral 1/(a^2 + x^2) dif x = 1/a arctan(x/a), quad integral 1/(a^2 - x^2) dif x = 1/a artanh(x/a), quad integral tan x = -ln|cos x| $
]

#fs[Anwendungen der Integralrechnung (Kap. 4)][
  $ A = integral y dot(x) dif t, quad A_"Sektor" = 1/2 integral (x dot(y) - dot(x) y) dif t = 1/2 integral r^2 dif phi $
  $ L = integral sqrt(dot(x)^2 + dot(y)^2) dif t = integral sqrt(1 + f'^2) dif x = integral sqrt(r^2 + dot(r)^2) dif phi $
  $ V_x = pi integral f^2 dif x, quad V_y = 2 pi integral x f dif x, quad O_x = 2 pi integral f sqrt(1 + f'^2) dif x, quad V = integral F(z) dif z $
  $ x_S = 1/A integral x H(x) dif x, quad y_S = 1/(2A) integral f^2 dif x, quad I_x = integral y^2 B(y) dif y, quad Theta_x = (pi rho)/2 integral f^4 dif x $
  $ integral_1^oo x^(-p) dif x < oo <=> p > 1, quad integral_0^1 x^(-p) dif x < oo <=> p < 1 $
]

#fs[Potenz- und Taylorreihen (Kap. 5)][
  $ rho = lim |a_k/a_(k+1)| = 1/(lim root(k, |a_k|)), quad f(x) = sum (f^((k))(x_0))/k! (x - x_0)^k, quad R_n = (f^((n+1))(xi))/(n+1)! (x - x_0)^(n+1) $
  $ e^x = sum x^k/k!, quad sin x = sum (-1)^k x^(2k+1)/(2k+1)!, quad cos x = sum (-1)^k x^(2k)/(2k)! $
  $ ln(1+x) = sum_(k>=1) (-1)^(k+1) x^k/k $
  $ arctan x = sum (-1)^k x^(2k+1)/(2k+1), quad (1 + x)^alpha = sum binom(alpha, k) x^k, quad tan x = x + x^3/3 + (2x^5)/15 + dots $
]
