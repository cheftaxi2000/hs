#import "lib.typ": *
#set heading(numbering: none)
#set par(justify: false)
= Appendix: Constants and Formula Sheet
#nolec

#let fs(title, body) = block(width: 100%, breakable: false, spacing: 1.2em,
  [#text(font: sans, size: 10pt, weight: "bold", title) #v(-4pt) #line(length: 100%, stroke: 0.4pt) #v(-2pt) #body])

#fs[Constants and conversions][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 3pt),
    [Avogadro: $N_A = 6.022 times 10^(23) "mol"^(-1)$], [Gas constant: $R = 8.314 "J mol"^(-1) "K"^(-1) = 0.08206 "L atm mol"^(-1) "K"^(-1)$],
    [Boltzmann: $k_B = R\/N_A = 1.381 times 10^(-23) "J/K"$], [Planck: $h = 6.626 times 10^(-34) "J s"$],
    [Speed of light: $c = 2.998 times 10^8 "m/s"$], [Elementary charge: $e = 1.602 times 10^(-19) "C"$],
    [Atomic mass unit: $1 "u" = 1.6605 times 10^(-27) "kg"$], [$1 "atm" = 760 "torr" = 101.325 "kPa" = 1.01325 "bar"$],
    [$T("K") = T("°C") + 273.15$], [$1 "cal" = 4.184 "J"$, $1 "L" = 10^(-3) "m"^3$, $1 "eV" = 1.602 times 10^(-19) "J"$],
    [Water: $c_s = 4.18 "J g"^(-1) "K"^(-1)$], [Water: $K_b = 0.51$, $K_f = 1.86$ °C kg/mol])
]

#fs[Atoms, moles, stoichiometry (Ch. 1)][
  $ n = m/M, quad N = n N_A, quad "atomic weight" = sum ("abundance" times "isotope mass"), quad "mass number" A = Z + N_"neutrons" $
  grams A $->$ (÷ $M_A$) moles A $->$ (× coefficient ratio) moles B $->$ (× $M_B$) grams B. Limiting reactant: smallest $n\/"coefficient"$.
]

#fs[Gases (Ch. 2)][
  $ P V = n R T, quad (P_1 V_1)/T_1 = (P_2 V_2)/T_2, quad rho = (P M)/(R T), quad V_m("STP") = 22.41 "L/mol" $
  $ P_"tot" = sum P_i, quad P_i = X_i P_"tot", quad u_"rms" = sqrt((3 R T)/M), quad overline(E)_k = 3/2 k_B T, quad (P + (a n^2)/V^2)(V - n b) = n R T $
]

#fs[Solutions and reactions in water (Ch. 3, 9)][
  $ c = n/V_"soln", quad c_1 V_1 = c_2 V_2, quad m = n_"solute"/m_"solvent"("kg"), quad S_g = k_H P_g, quad P_"soln" = X_"solvent" P^degree $
  $ Delta T_b = i K_b m, quad Delta T_f = -i K_f m, quad Pi = i c R T $
  Oxidation = loss of $e^-$ (oxidation number ↑), reduction = gain. Net ionic equation: cancel spectator ions.
]

#fs[First law, enthalpy (Ch. 4)][
  $ Delta E = q + w, quad w = -P Delta V, quad H = E + P V, quad Delta H = q_P, quad Delta E = q_V, quad q = m c_s Delta T = n C_m Delta T $
  $ Delta H_"rxn"^degree = sum b_j Delta H_(f,j)^degree - sum a_i Delta H_(f,i)^degree, quad Delta H_"rxn" approx sum D_"broken" - sum D_"formed" $
  Signs: $q, w > 0$ means energy *into* the system. Elements in standard state: $Delta H_f^degree = Delta G_f^degree = 0$.
]

#fs[Second law, free energy (Ch. 5)][
  $ Delta S = q_"rev"/T, quad Delta S_"trans" = (Delta H_"trans")/T_"trans", quad S = k_B ln W, quad Delta S_"univ" = Delta S_"sys" + Delta S_"surr" > 0 "(spontaneous)" $
  $ G = H - T S, quad Delta G = Delta H - T Delta S, quad Delta S^degree = sum b_j S_j^degree - sum a_i S_i^degree, quad T^* = (Delta H)/(Delta S) $
  $Delta G < 0$ spontaneous, $= 0$ equilibrium, $> 0$ nonspontaneous. Watch kJ vs J.
]

#fs[Electronic structure (Ch. 6)][
  $ c = lambda nu, quad E = h nu = (h c)/lambda, quad E_n = -(2.18 times 10^(-18) "J")/n^2, quad Delta x dot Delta(m v) >= h/(4 pi), quad lambda = h/(m v) $
  $n = 1, 2, dots$; $ell = 0 dots n-1$ (s, p, d, f); $m_ell = -ell dots +ell$; $m_s = plus.minus 1/2$. Capacity: s 2, p 6, d 10, f 14. Radius ↓ across, ↑ down; $I_1$ and $chi$ ↑ across, ↓ down.
]

#fs[Bonding and shape (Ch. 7)][
  $ "formal charge" = "v.e." - 1/2 ("bonding " e^-) - ("non-bonding " e^-), quad mu = Q r, quad 1 "D" = 3.34 times 10^(-30) "C m" $
  VSEPR: 2 linear 180°, 3 trigonal planar 120°, 4 tetrahedral 109.5°, 5 trigonal bipyramidal 90°/120°, 6 octahedral 90°.
]

#fs[Phases (Ch. 8)][
  $ ln P_"vap" = -(Delta H_"vap")/(R T) + C, quad ln(P_2/P_1) = -(Delta H_"vap")/R (1/T_2 - 1/T_1), quad Delta H_"sub" = Delta H_"fus" + Delta H_"vap" $
]

#fs[Kinetics (Ch. 10)][
  $ "rate" = -1/a (d[A])/(d t) = k [A]^alpha [B]^beta, quad [k] = "M"^(1-n) "s"^(-1) $
  #table(columns: (auto, 1fr, 1fr, 1fr), stroke: none, inset: (x: 4pt, y: 3pt),
    [], [*zeroth*], [*first*], [*second*],
    [integrated], [$[A] = [A]_0 - k t$], [$ln[A] = ln[A]_0 - k t$], [$1\/[A] = 1\/[A]_0 + k t$],
    [half-life], [$[A]_0\/(2k)$], [$0.693\/k$], [$1\/(k[A]_0)$])
]
