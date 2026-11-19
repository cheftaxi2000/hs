#import "lib.typ": *

= Gases

#lec(2, [Types of reactions, gases], [3.2, 10.1–10.8])

#lecture[Gases are the simplest state of matter: almost empty space, filled with molecules flying around at hundreds of metres per second. Because the molecules hardly interact, *all* gases obey the same simple law, $P V = n R T$. For engineers this is one of the most-used equations of the whole curriculum (engines, turbines, HVAC, process plants).]

== Warm-up: types of chemical reactions

Lecture 2 started by completing Chapter 1 with three patterns of reactivity. They cover a large part of what you will meet:

- *Combination:* two or more substances form one product. #ce("N2(g) + 3 H2(g) -> 2 NH3(g)") (fixation of nitrogen, the basis of all fertiliser).
- *Decomposition:* one substance breaks into two or more. #ce("CaCO3(s) -> CaO(s) + CO2(g)") (limestone to lime, the first step of cement making); #ce("2 H2O(l) -> 2 H2(g) + O2(g)") (electrolysis of water).
- *Combustion:* rapid reaction with #ce("O2"), producing a flame. Hydrocarbons burn to #ce("CO2") and #ce("H2O"): #ce("CH4 + 2 O2 -> CO2 + 2 H2O") (natural gas). Coal: #ce("C(s) + O2(g) -> CO2(g)").

#everyday[*Cement and the climate.* Concrete is the second most used substance on Earth after water. Its production starts with the decomposition #ce("CaCO3 -> CaO + CO2"), which releases #ce("CO2") _chemically_, independently of the fuel used to heat the kiln. Together with the fuel, cement production causes roughly 8 % of global #ce("CO2") emissions. Stoichiometry tells you exactly how much: 100 g of #ce("CaCO3") give 44 g of #ce("CO2"). No better burner can avoid that part; only different chemistry can.]

#photo(("kiln",), [Rotary kilns of a cement plant. Inside these slowly turning steel tubes, limestone is heated to about 1450 °C and decomposes, #ce("CaCO3 -> CaO + CO2"). #credit[Dylan Moore, CC BY-SA 2.0, Wikimedia Commons (geograph.org.uk)]], ht: 4.6cm)

== What makes a gas a gas?

Matter comes in three states: solid, liquid and gas (vapour). Water shows all three in everyday life. Gases are special because they have similar *physical* properties even when their *chemical* properties are completely different:

- they *expand* to fill their container,
- they are highly *compressible*,
- they always form *homogeneous* mixtures with each other,
- their molecules occupy only a tiny fraction (about 0.1 % at room conditions) of the volume.

#micro[In air at room temperature, the average distance between molecules is about 3.5 nm, roughly ten times the size of a molecule. Imagine tennis balls spaced about a metre apart in every direction, all flying around at the speed of a jet plane. Because they are so far apart, they almost never feel each other, and the chemical identity of the molecule hardly matters. This is why one law fits all gases.]

=== The four variables

A simple gas is completely described by four quantities:

#table(columns: (auto, auto, auto, 1fr),
  [*quantity*], [*symbol*], [*SI unit*], [*type*],
  [volume], [$V$], [$"m"^3$ (also L)], [extensive (depends on sample size)],
  [amount], [$n$], [mol], [extensive],
  [temperature], [$T$], [K], [intensive (independent of sample size)],
  [pressure], [$P$], [Pa = $"N/m"^2$], [intensive])

Density $rho = m\/V$ is another intensive property: half a balloon of air has half the mass but the same density.

== Pressure

#defn[Pressure][Pressure is force per unit area,
$ P = F/A, quad [P] = "N"/"m"^2 = "Pa" quad "(pascal)". $]

*Where does gas pressure come from?* Molecules move randomly and constantly hit every surface. Each impact transfers momentum, i.e. a tiny force. Billions of impacts per second per square millimetre add up to a steady force per area.

#ex[Estimating atmospheric pressure][
  The atmosphere is pulled towards the Earth by gravity. A column of air above 1 $"m"^2$ of ground has a mass of about $10 000$ kg. Its weight is
  $ F = m g approx 10^4 "kg" times 9.8 "m/s"^2 approx 1 times 10^5 "N", quad P_"atm" = F/A approx 1 times 10^5 "Pa" = 100 "kPa" approx 1 "bar". $
]

=== Barometers and manometers

#fg("c02_baro", [Left: Torricelli's barometer. The air pushing on the open dish holds up a 760 mm column of mercury. Right: an open-end manometer measures a gas pressure relative to the atmosphere.], w: 92%)

In a *barometer* the weight of the mercury column balances the atmospheric pressure. For a column of height $h$, density $rho$ and cross-section $A$:
$ P = F/A = (m g)/A = (rho A h g)/A = rho g h quad "(hydrostatic pressure)". $
At sea level $h = 760$ mm Hg ($rho_"Hg" = 13.5 "g/cm"^3$). This defines the common pressure units:
$ P_"atm" = 760 "mm Hg" = 760 "torr" = 1 "atm" = 101.325 "kPa" = 1.01325 "bar". $

A *manometer* measures the pressure of an enclosed gas relative to the atmosphere: $P_"gas" = P_"atm" + rho g h$ (with $h > 0$ if the liquid is pushed up on the open side).

#everyday[*Blood pressure* "120 over 80" means 120 mm Hg (systolic, heart contracting) and 80 mm Hg (diastolic, heart relaxing) *above* atmospheric pressure. Your *car tyre* gauge (e.g. 2.2 bar) also shows overpressure. Absolute pressure in the tyre is about 3.2 bar. For gas laws you must always use *absolute* pressure.]

== The empirical gas laws

How do the four variables $P, V, T, n$ depend on each other? The trick (first used systematically by Robert Boyle) is to keep two of them fixed, change a third and watch the fourth. This *one variable at a time* approach is a key idea in all of science and engineering.

#grid(columns: (1fr, 1fr), column-gutter: 10pt,
  figure(image("figs/c02_boyle.svg"), caption: [Boyle's law: $P prop 1\/V$ at fixed $n, T$.]),
  figure(image("figs/c02_charles.svg"), caption: [Charles's law: $V$ is linear in $T$ and extrapolates to zero at $-273.15$ °C.]))

#law[Boyle's law ($n$, $T$ constant)][
  $ P V = "const" quad <=> quad P_1 V_1 = P_2 V_2. $
  Halve the volume and the pressure doubles.]

#law[Charles's law ($n$, $P$ constant)][
  $ V/T = "const" quad <=> quad V_1/T_1 = V_2/T_2 quad (T "in kelvin"). $]

Measured in °C, the volume of every gas is a straight line which extrapolates to zero volume at $-273.15$ °C. This is the natural zero of temperature. The *Kelvin scale* shifts the origin there: $T("K") = T("°C") + 273.15$, and a step of 1 °C equals a step of 1 K.

#law[Avogadro's law ($P$, $T$ constant)][
  $ V/n = "const". $
  And the constant is (almost) the same for *all* gases: *equal volumes of different gases at the same $P$ and $T$ contain the same number of molecules*.]

#intu[Avogadro's law is stunning at first sight: one litre of hydrogen (tiny, light molecules) and one litre of sulfur hexafluoride (large and 70 times heavier) contain the same number of molecules. It only makes sense because the molecules themselves take up almost no space. The volume is "owned" by the empty space between them, and the pressure comes from the number of impacts, not from the size of the molecules.]

#everyday[*Breathing is Boyle's law.* Your diaphragm moves down, the lung volume increases, the pressure inside drops below $P_"atm"$, and air flows in. A *diver* who holds their breath at 10 m depth (2 atm) and ascends to the surface would see the air in the lungs double in volume, which is why divers must never hold their breath while ascending. The same law sets the compression ratio of a *diesel engine*.]

== The ideal gas law

=== Combining the three laws

#formula[Ideal gas law (IGL)][
  $ P V = n R T $
  with the *gas constant*
  $ R = 8.314 "J"/("mol K") = 8.314 ("m"^3 "Pa")/("mol K") = 0.08206 ("L atm")/("mol K") = 62.36 ("L torr")/("mol K"). $]

#why[does this follow?][Boyle: $V prop 1\/P$; Charles: $V prop T$; Avogadro: $V prop n$. All three at once: $V prop n T\/P$. Calling the proportionality constant $R$ gives $V = n R T \/ P$.]

The IGL is exact for a hypothetical *ideal gas* whose molecules (1) do not interact and (2) occupy no volume. Real gases at ordinary conditions come very close.

#defn[Standard temperature and pressure (STP)][$T = 0 "°C" = 273.15 "K"$ and $P = 1 "atm" = 101.325 "kPa"$. One mole of any ideal gas at STP occupies
$ V_m = (R T)/P = (8.314 times 273.15)/(101 325) "m"^3 = 22.41 "L". $]

#mistake[
  - *Temperature in °C.* The gas laws only make sense in kelvin. Doubling from 10 °C to 20 °C does *not* double the volume; going from 283 K to 293 K increases it by 3.5 %.
  - *Units of $R$.* Pick $R$ to match your units. Safest: SI throughout (Pa, $"m"^3$, K, mol), then $R = 8.314$. Remember $1 "L" = 10^(-3) "m"^3$.
  - *Gauge pressure.* Use absolute pressure.
  - *Moles of gas only.* $n$ counts gas particles. For #ce("A(g) -> B(g) + C(g)") the number of moles doubles, so at constant $V, T$ the pressure doubles.]

=== Using the ideal gas law

Exam problems come in three types.

#recipe[ideal gas problems][
  + *Three variables given, find the fourth:* solve $P V = n R T$ for the unknown, e.g. $V = n R T \/ P$.
  + *Two variables change, two are fixed:* write the IGL so that the fixed ones are on one side, e.g. $n, T$ fixed: $P_1 V_1 = P_2 V_2$; $n, P$ fixed: $V_1\/T_1 = V_2\/T_2$.
  + *Three variables change, $n$ fixed:* use the *combined gas law*
  $ (P_1 V_1)/T_1 = (P_2 V_2)/T_2 quad (= n R). $]

#ex[Weather balloon][
  A balloon of $V_1 = 6.0$ L at $P_1 = 101.3$ kPa and $22$ °C rises until $P_2 = 45.6$ kPa, while the temperature falls to $-21$ °C. Final volume?

  #step[Knowns.] $n$ fixed. $T_1 = 295$ K, $T_2 = 252$ K.
  #step[Solve.] $ V_2 = V_1 dot P_1/P_2 dot T_2/T_1 = 6.0 "L" dot 101.3/45.6 dot 252/295 = 11 "L". $
  #step[Check.] Pressure drops by a factor of 2.2 (volume up), temperature drops by 15 % (volume down a little). Net: about doubled. ✓
]

=== Density and molar mass

With $n = m\/M$ the IGL becomes $P V = (m\/M) R T$, hence

#formula[Gas density and molar mass][
  $ rho = m/V = (P M)/(R T), quad quad M = (rho R T)/P. $]

At the same $P$ and $T$ the density of a gas is proportional to its molar mass. Air has $M approx 29$ g/mol. Gases with $M < 29$ (He 4, #ce("H2") 2, #ce("CH4") 16) rise; gases with $M > 29$ (#ce("CO2") 44, propane 44) sink and can collect in basements and pits.

#everyday[*Hot-air balloons* use the $1\/T$ in $rho = P M\/(R T)$: heating the air inside from 20 °C to 100 °C lowers its density by about 21 %, and the difference in weight to the surrounding air gives the lift. *#ce("CO2") in wine cellars* and propane leaks in boats are dangerous because these heavy gases flow downwards like water and displace the oxygen.]

== Gas mixtures and partial pressures

Because the IGL does not care about the type of molecule, in a mixture only the *total* number of moles counts:
$ P_"tot" = n_"tot" (R T)/V = (n_1 + n_2 + dots) (R T)/V = P_1 + P_2 + dots $

#law[Dalton's law of partial pressures][
  $ P_"tot" = P_1 + P_2 + dots + P_n, quad P_i = n_i (R T)/V. $
  The *partial pressure* $P_i$ is the pressure gas $i$ would exert if it were alone in the container.]

#defn[Mole fraction][
  $ X_i = n_i / n_"tot", quad sum_i X_i = 1, quad P_i = X_i P_"tot". $]

#ex[Oxygen at altitude][
  Air is 21 % #ce("O2") by moles. At sea level $P_(ce("O2")) = 0.21 times 101 "kPa" = 21$ kPa. On the summit of Mount Everest $P_"tot" approx 34$ kPa and $P_(ce("O2")) = 0.21 times 34 = 7.1$ kPa, only a third. The fraction of oxygen is the same; what your lungs feel is the partial pressure.
]

== The kinetic-molecular theory

The gas laws are empirical. *Why* do gases behave this way? The answer comes from a simple molecular model.

#law[Kinetic-molecular theory: assumptions][
  + Gas molecules are in constant, random motion.
  + Their own volume is negligible compared with the container.
  + They collide with each other and with the walls, but there are no attractive or repulsive forces between them otherwise. Collisions are elastic.
  + The average kinetic energy $E_k = 1/2 m u^2$ of the molecules depends *only* on the absolute temperature.]

From these assumptions one can derive $P V = n R T$. Two key consequences:

- *Pressure* is caused by collisions with the walls. It depends on how often and how hard the molecules hit.
- *Temperature* is a measure of the average kinetic energy: $ overline(E)_k = 3/2 k_B T quad "per molecule", quad k_B = R/N_A = 1.38 times 10^(-23) "J/K". $ If $T$ (in K) doubles, the average kinetic energy doubles, and so does the pressure at fixed volume. The average kinetic energy does *not* depend on the type of molecule.

=== Velocity distributions

Not all molecules move equally fast. Collisions continuously exchange energy, so at any moment there is a broad *distribution* of speeds (Maxwell–Boltzmann distribution).

#fgs(("c02_mb_T", "c02_mb_M"), [Speed distributions. Left: higher temperature shifts the distribution to higher speeds and broadens it. Right: at equal temperature, light molecules move much faster than heavy ones.])

Several "typical" speeds can be defined:

#fg("c02_speeds", [The most probable speed $u_"mp"$ (peak), the average speed $u_"av"$ and the root-mean-square speed $u_"rms"$. Because the distribution has a long tail to the right, the averages lie to the right of the peak.], w: 62%)

#formula[Root-mean-square speed][
  $ u_"rms" = sqrt(overline(u^2)) = sqrt((3 R T)/M) quad (M "in kg/mol!"). $]

#why[from $E_k$][Per mole: $1/2 M overline(u^2) = 3/2 R T$, so $overline(u^2) = 3 R T \/ M$. $u_"rms"$ belongs to the molecule with the *average kinetic energy*. Because $E_k prop u^2$, fast molecules weigh more in this average, which is why $u_"rms"$ lies to the right of the peak.]

#ex[How fast are air molecules?][
  #ce("N2") at 25 °C, $M = 0.028 "kg/mol"$: $ u_"rms" = sqrt((3 times 8.314 times 298)/0.028) = 515 "m/s" approx 1850 "km/h". $
  Faster than the speed of sound (343 m/s), which is not a coincidence: sound is carried by the molecules.
]

#everyday[*Why the Earth has no hydrogen in its atmosphere.* The escape velocity of the Earth is 11.2 km/s. For #ce("H2") and He at the hot top of the atmosphere, the high-speed tail of the distribution reaches this velocity, and these light gases slowly leak into space. Heavy #ce("N2") and #ce("O2") stay. The Moon, with a lower escape velocity, has lost its atmosphere completely.]

== Effusion and diffusion

*Effusion* is the escape of gas through a tiny hole; *diffusion* is the spreading of one gas through another. Both are faster for light molecules (*Graham's law*): $r_1 \/ r_2 = sqrt(M_2 \/ M_1)$.

If molecules move at about 500 m/s, why does it take several seconds or minutes before you smell perfume opened at the other side of the room? Because molecules do not fly straight.

#defn[Mean free path][The *mean free path* is the average distance a molecule travels between two collisions. For air at sea level (1 atm) it is only about *60 nm*; each molecule collides about $10^(10)$ times per second. At 100 km altitude, where the gas is far thinner, it is about 10 cm.]

#grid(columns: (1fr, 5.2cm), column-gutter: 12pt, align: horizon,
  [Each collision randomises the direction, so the molecule performs a *random walk*. After $N$ steps of length $lambda$ it has travelled $N lambda$ but is only about $sqrt(N) lambda$ away from its start. This is why diffusion through air is so much slower than the molecular speed. (In a real room, air currents usually carry the perfume faster than diffusion does.)],
  figure(image("figs/c02_randomwalk.svg"), caption: [A random walk: long path, small net displacement.]))

#everyday[*Uranium enrichment* exploited Graham's law: gaseous #ce("UF6") effuses through porous barriers, and #super[235]#ce("UF6") (349 g/mol) is only 0.4 % faster than #super[238]#ce("UF6") (352 g/mol), since $sqrt(352\/349) = 1.004$. Over 1000 stages in series were needed. *Vacuum technology* (semiconductor fabs, electron microscopes) is designed around the mean free path: once it exceeds the size of the chamber, molecules fly ballistically from wall to wall.]

== Real gases: deviations from ideal behaviour

The IGL is extremely useful, but real gases are not ideal. For an ideal gas $P V \/ (n R T) = 1$ always.

#fg("c02_realgas", [The compressibility factor $P V\/(n R T)$ of real gases at high pressure. Below 1: attractions dominate. Above 1: the volume of the molecules dominates.], w: 60%)

Two effects cause deviations:

- *High pressure:* the molecules are squeezed together, and their own volume is no longer negligible. The free volume available for motion is smaller than $V$, so the real pressure is *higher* than ideal.
- *Low temperature:* molecules move slowly and start to feel their mutual *attraction*. They "stick" to each other a little, hit the walls less hard, and the pressure is *lower* than ideal.

#formula[Van der Waals equation][
  $ (P + (a n^2)/V^2)(V - n b) = n R T. $
  - $b$ (L/mol): the volume excluded by one mole of molecules. $V - n b$ is the free volume.
  - $a$ (L² atm/mol²): strength of the attraction. The measured pressure is lower than the "ideal" pressure by $a n^2 \/ V^2$ because molecules near the wall are pulled back by their neighbours. The correction scales with $n^2\/V^2$ since it depends on pairs of molecules.]

#intu[Gases are most ideal at *high temperature and low pressure*: molecules far apart (volume negligible) and fast (attractions negligible). Large, polar molecules with strong attractions (e.g. water vapour, $a = 5.5$) deviate much more than small nonpolar ones (He, $a = 0.034$). Chapter 8 explains these attractions.]

#problems()

#prob[Pressure units][
  A weather report gives 985 hPa. Express this in atm, torr and bar.
][
  $985 "hPa" = 98.5 "kPa"$. $98.5\/101.325 = 0.972$ atm $= 0.972 times 760 = 739$ torr $= 0.985$ bar.
]

#prob[Gas cylinder][
  A 50.0 L steel cylinder contains 8.00 kg of #ce("O2") at 20 °C. (a) What is the pressure (ideal)? (b) The cylinder is safe up to 200 bar. Up to which temperature may it be heated?
][
  (a) $n = 8000\/32.00 = 250$ mol. $ P = (n R T)/V = (250 times 8.314 times 293.15)/(50.0 times 10^(-3)) "Pa" = 1.22 times 10^7 "Pa" = 122 "bar". $
  (b) $n, V$ fixed: $P\/T = "const"$. $T_2 = T_1 P_2\/P_1 = 293.15 times 200\/122 = 481$ K $= 208$ °C. (In reality, a safety margin is required.)
]

#prob[Molar mass of an unknown gas][
  An unknown gas has a density of 1.25 g/L at STP. What is its molar mass, and which gas could it be?
][
  $ M = (rho R T)/P = (1.25 "g/L" times 0.08206 times 273.15)/(1 "atm") = 28.0 "g/mol". $
  Candidates: #ce("N2") (28.0), CO (28.0) or #ce("C2H4") (28.1). Density alone cannot distinguish them.
]

#prob[Partial pressures][
  A 10.0 L flask at 25 °C contains 0.200 mol #ce("N2"), 0.100 mol #ce("O2") and 0.050 mol Ar. Find the mole fractions, partial pressures and the total pressure.
][
  $n_"tot" = 0.350$ mol. $X_(ce("N2")) = 0.571$, $X_(ce("O2")) = 0.286$, $X_"Ar" = 0.143$.
  $P_"tot" = n R T\/V = 0.350 times 8.314 times 298.15 \/ 0.0100 = 86.8$ kPa.
  $P_(ce("N2")) = 49.6$ kPa, $P_(ce("O2")) = 24.8$ kPa, $P_"Ar" = 12.4$ kPa. Sum: 86.8 kPa. ✓
]

#prob[Gas stoichiometry: airbag][
  An airbag needs 65.0 L of #ce("N2") at 25 °C and 1.10 atm. How many grams of sodium azide are needed? #ce("2 NaN3(s) -> 2 Na(s) + 3 N2(g)").
][
  $n(ce("N2")) = P V\/(R T) = 1.10 times 65.0 \/ (0.08206 times 298.15) = 2.92$ mol.
  $n(ce("NaN3")) = 2\/3 times 2.92 = 1.95$ mol, $m = 1.95 times 65.01 = 127$ g.
]

#prob[Molecular speeds][
  (a) Compute $u_"rms"$ for He and #ce("CO2") at 25 °C. (b) By what factor must the temperature of He be changed so that its $u_"rms"$ equals that of #ce("CO2") at 25 °C?
][
  (a) He: $sqrt(3 times 8.314 times 298 \/ 0.004) = 1360$ m/s. #ce("CO2"): $sqrt(3 times 8.314 times 298 \/ 0.044) = 411$ m/s.
  (b) $u_"rms" prop sqrt(T\/M)$; equal speeds need $T_"He"\/4 = 298\/44$, so $T_"He" = 27$ K, a factor $4\/44 = 1\/11$.
]

#prob[Van der Waals vs ideal][
  1.000 mol #ce("CO2") is in 0.500 L at 300 K. Compare the ideal pressure with the van der Waals pressure ($a = 3.59 "L"^2 "atm/mol"^2$, $b = 0.0427$ L/mol).
][
  Ideal: $P = 0.08206 times 300 \/ 0.500 = 49.2$ atm.
  Van der Waals: $ P = (n R T)/(V - n b) - (a n^2)/V^2 = 24.62/0.4573 - 3.59/0.250 = 53.8 - 14.4 = 39.5 "atm". $
  The real pressure is 20 % lower: at this high density the attractions (the $a$ term) dominate over the excluded volume.
]

#summary[
  - A gas is described by $P, V, T, n$. Pressure = force/area from molecular impacts. $1 "atm" = 760 "torr" = 101.325 "kPa"$.
  - Boyle $P V = "const"$, Charles $V\/T = "const"$, Avogadro $V\/n = "const"$ → $P V = n R T$, $R = 8.314 "J mol"^(-1) "K"^(-1)$. *Always kelvin, absolute pressure.*
  - STP: 0 °C, 1 atm, $V_m = 22.41$ L/mol. $rho = P M \/(R T)$.
  - Dalton: $P_"tot" = sum P_i$, $P_i = X_i P_"tot"$.
  - Kinetic theory: $T$ measures average kinetic energy; $u_"rms" = sqrt(3 R T \/ M)$; light molecules are fast; broad speed distribution.
  - Mean free path in air ≈ 60 nm → diffusion is a slow random walk.
  - Real gases deviate at high $P$ (own volume, $b$) and low $T$ (attractions, $a$): van der Waals equation.
]
