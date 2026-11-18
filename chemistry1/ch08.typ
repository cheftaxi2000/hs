#import "lib.typ": *

= Intermolecular Forces, Liquids and Phase Changes

#lecture[Lecture 8 · Brown 11.1–11.6. Chapter 7 was about the strong bonds *inside* molecules. This chapter is about the much weaker forces *between* molecules. They decide whether a substance is a gas, a liquid or a solid at room temperature, how viscous an oil is, why water climbs up a thin tube, why a pressure cooker cooks faster and why Gore-Tex keeps you dry. Engineers need to understand these forces to control and exploit them.]

== Gases, liquids and solids

#table(columns: (1fr, auto, auto, auto),
  [*property*], [*gas*], [*liquid*], [*solid*],
  [fills its container?], [yes], [no], [no],
  [takes the shape of its container?], [yes], [yes], [no],
  [flows?], [yes], [yes], [no],
  [molecules close together?], [no], [yes], [yes],
  [molecules ordered?], [no], [no], [yes],
  [compressible?], [yes], [no], [no],
  [$E_k$ versus $E_"int"$], [$E_k >> |E_"int"|$], [$E_k approx |E_"int"|$], [$E_k << |E_"int"|$])

All of these differences come from one competition:

#intu[*Thermal motion versus attraction.* Every molecule carries kinetic energy of order $k_B T$ per molecule ($R T$ per mole, about 2.5 kJ/mol at room temperature). This is the "thermal energy" that tries to tear molecules apart. At the same time, molecules attract each other with an interaction energy $E_"int" < 0$ that depends on their type and distance. If thermal energy wins by far, we have a gas. If attraction wins by far, a solid. If they are comparable, a liquid: the molecules stay together but slide past each other. Cooling a gas shifts the balance towards attraction and gives liquid, then solid. (Entropy also plays its role, see Chapter 5.)]

== Intermolecular forces

#defn[Intermolecular forces][Attractive (and at very short range repulsive) forces *between* molecules, as opposed to *intramolecular* bonds within a molecule. They are much weaker than covalent bonds: a C–H bond is 413 kJ/mol, intermolecular attractions are typically 1–50 kJ/mol.]

For *neutral* molecules there are three types.

=== A. Dispersion forces (London forces)

#fg("c08_dispersion", [Origin of dispersion forces. A momentary fluctuation of the electron cloud creates a temporary dipole, which induces a dipole in the neighbouring molecule. The two dipoles attract.], w: 90%)

The electron cloud of any atom or molecule fluctuates. At one instant the electrons may be slightly more on one side: a temporary dipole. It pushes the electrons of a neighbouring molecule away and creates an *induced dipole*. The two dipoles attract (*induced-dipole–induced-dipole attraction*). Dispersion forces act between *all* molecules, even noble-gas atoms; they are attractive only at short distances.

- They *increase with molecular size* (more electrons, more easily distorted, i.e. more *polarisable*): #ce("F2") boils at −188 °C, #ce("Cl2") at −34 °C, #ce("Br2") at 59 °C, #ce("I2") is a solid.
- They depend on *shape*: elongated molecules have more contact area than compact ones.

#ex[Shape matters: pentane isomers][
  Pentane and dimethylpropane are both #ce("C5H12") (same molar mass). Linear pentane boils at 309 K, the compact, nearly spherical dimethylpropane at 282 K. Long molecules can lie side by side like spaghetti and touch along their whole length; balls touch only at one point.
]

=== B. Dipole–dipole forces

Polar bonds give dipole moments (Chapter 7). A molecule has an *overall* dipole moment if the vector sum of its bond dipoles does not cancel. This depends on the *shape* (VSEPR):
- #ce("CO2"): two strongly polar C=O bonds, but linear, so they cancel: *nonpolar*.
- #ce("H2O"): bent, the bond dipoles add up: *polar* ($mu = 1.85$ D).
- #ce("CCl4") tetrahedral: nonpolar. #ce("CHCl3"): polar.

Polar molecules attract each other by aligning their dipoles $delta^+ dots delta^-$. Together, dispersion and dipole–dipole forces are called *van der Waals forces* (after Johannes van der Waals, whose equation for real gases in Chapter 2 contains them in the parameter $a$). They are always present and always attractive at the usual distances.

=== C. Hydrogen bonds

#defn[Hydrogen bond][A particularly strong dipole–dipole attraction between an H atom bonded to a very electronegative atom (*N, O or F*) and a lone pair on another nearby N, O or F atom: $ce("O-H") dots ce(":O")$.]

#grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [#micro[N, O and F pull the electrons of the N–H, O–H or F–H bond strongly towards themselves. The H nucleus, a bare proton with almost no electron cloud of its own, is left with a large $delta^+$. Because H is so small, it can get *very close* to a lone pair on a neighbouring molecule, and the attraction ($prop 1\/r$) is large. Each water molecule can form up to four hydrogen bonds: two through its H atoms, two through its lone pairs.]],
  figure(image("figs/c08_hbond.svg"), caption: [Hydrogen bonds around a water molecule.]))

#fg("c08_hydrides", [Boiling points of the hydrides of groups 14–17. Normally the boiling point increases with size (dispersion). #ce("H2O"), HF and #ce("NH3") are far off the trend because of hydrogen bonding. Without it, water would boil at about −80 °C.], w: 66%)

Hydrogen bonds explain the unusual properties of water: high boiling point, high heat capacity and heat of vaporisation, high surface tension, and ice floating on water. They also hold together the two strands of DNA and give proteins their shape.

=== Ion–dipole forces

An ion attracts the oppositely charged end of polar molecules. This is the force that *hydrates* ions in water (Chapter 3): polar molecules orient themselves to solvate both cations and anions. That is why *polar liquids are good solvents for ions* (water, but also methanol or liquid ammonia). More in Chapter 9.

=== Relative strengths

#table(columns: (auto, auto, auto, 1fr),
  [*interaction*], [*typical energy*], [*present between*], [*example*],
  [covalent bond (for comparison)], [≈ 400 kJ/mol], [atoms in a molecule], [C–H 413 kJ/mol],
  [ion–dipole], [≈ 50 kJ/mol], [ions and polar molecules], [#ce("Na^+") in water],
  [hydrogen bond], [≈ 25 kJ/mol], [H on N/O/F and N/O/F], [water, alcohols, DNA],
  [dipole–dipole], [≈ 10 kJ/mol], [polar molecules], [HCl, acetone],
  [dispersion], [≈ 0.1–10+ kJ/mol], [all molecules], [noble gases, hydrocarbons])

The effects are *additive*: a large molecule can have more total dispersion attraction than a small polar molecule. And if two molecules come too close, their electron clouds overlap and they *repel* strongly; this sets the size of molecules in liquids and solids.

#recipe[which forces act, which substance boils higher?][
  + Ions present? → ion–ion / ion–dipole (strongest).
  + Polar molecule (polar bonds *and* asymmetric shape)? → dipole–dipole.
  + H bonded to N, O or F? → hydrogen bonds.
  + Always: dispersion; grows with size (molar mass) and elongated shape.
  Compare: first the strongest type present, then, within the same type, the size.]

== Properties of liquids

- *Viscosity* is the resistance of a liquid to flow. Strong intermolecular forces (and long, entangled molecules) slow the flow: honey and engine oil versus water. Viscosity decreases strongly with temperature, as molecules gain enough energy to slip past each other. Multigrade oils (e.g. 5W-30) are engineered to reduce this temperature dependence.
- *Surface tension* is the energy needed to increase the surface area of a liquid (J/m²). A molecule inside the liquid is attracted from all sides; a molecule at the surface misses the attraction from above. The liquid minimises its surface area: drops are round, water "balls up" on a waxed surface. Water has a very high surface tension because of hydrogen bonds.

#everyday[*Surface tension and wetting at work.* Water striders walk on water; soap bubbles exist; water rises in thin capillaries (which helps trees transport water and lets paper towels soak). Whether a liquid *wets* a surface depends on whether it is more attracted to the surface (adhesion) or to itself (cohesion): water wets clean glass but beads up on wax. *Gore-Tex* exploits this: its PTFE membrane has pores about 20 000 times smaller than a water drop, which cannot enter them because PTFE is not wetted by water, but 700 times larger than a water molecule, so water vapour (sweat) can escape. Lubrication, coating, painting, inkjet printing and 3D printing are all applied surface science.]

=== Vapour pressure

#grid(columns: (1fr, 6.0cm), column-gutter: 12pt, align: horizon,
  [In a liquid, molecules have a *distribution* of kinetic energies (Chapter 2). A few fast molecules at the surface have enough energy to overcome the attraction of their neighbours and escape into the gas phase. At higher temperature, a larger fraction can escape. If the attractions are strong, only a tiny fraction gets out.],
  figure(image("figs/c08_escape.svg"), caption: [Fraction of molecules able to escape (shaded) grows with temperature.]))

#defn[Vapour pressure][In a closed container at fixed temperature, molecules leave the liquid and return to it until both rates are equal: a *dynamic equilibrium*. The pressure of the vapour at this equilibrium is the *vapour pressure* $P_"vap"$ of the liquid at that temperature.
- Weak intermolecular forces → high vapour pressure → *volatile* liquid (ether, petrol).
- Vapour pressure increases rapidly with temperature.]

#fg("c08_vapP", [Vapour pressure of three liquids. The temperature at which $P_"vap"$ reaches 1 atm is the *normal boiling point*.], w: 62%)

If the temperature changes, the equilibrium shifts: on heating, more molecules leave; on cooling, excess vapour molecules condense (dew, fog, condensation on a cold bottle).

#law[Boiling][A liquid *boils* when its vapour pressure equals the external pressure: bubbles of vapour can then form inside the liquid. The *normal boiling point* is the temperature at which $P_"vap" = 1$ atm.]

#everyday[*Pressure cookers and mountain cooking.* At 1500 m altitude water boils at about 95 °C, at 3000 m at about 90 °C, and food cooks noticeably more slowly. A pressure cooker raises the pressure to about 2 atm, so water boils only at about 120 °C, and cooking is about three times faster. Conversely you can make water boil at room temperature by pumping the air away (a nice demo). Engineers must avoid exactly this in pumps and ship propellers: where the local pressure drops below $P_"vap"$, vapour bubbles form and collapse violently (*cavitation*), eroding the metal.]

=== The Clausius–Clapeyron equation

#formula[Clausius–Clapeyron equation][
  $ ln P_"vap" = -(Delta H_"vap")/(R T) + C quad <=> quad ln (P_2/P_1) = -(Delta H_"vap")/R (1/T_2 - 1/T_1). $
  $T$ absolute temperature, $R = 8.314 "J mol"^(-1) "K"^(-1)$, $C$ a constant.]

#grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [Plotting $ln P_"vap"$ against $1\/T$ gives a *straight line* with slope $-Delta H_"vap"\/R$. Measuring the vapour pressure at two temperatures therefore gives the heat of vaporisation, and knowing $Delta H_"vap"$ and one point you can predict the vapour pressure at any temperature. The exponential form, $P_"vap" prop e^(-Delta H_"vap"\/R T)$, shows the "Boltzmann factor": the fraction of molecules energetic enough to escape.],
  figure(image("figs/c08_cc.svg"), caption: [Clausius–Clapeyron plot ($1\/T$ in $10^(-3)$ K#super[−1]).]))

== Phase changes

#defn[Phase changes and their enthalpies][
  - Melting (fusion) solid → liquid: $Delta H_"fus" > 0$.
  - Vaporisation liquid → gas: $Delta H_"vap" > 0$.
  - Sublimation solid → gas: $Delta H_"sub" = Delta H_"fus" + Delta H_"vap" > 0$ (Hess's law).
  - The reverse processes (freezing, condensation, deposition) release the same amounts: $Delta H < 0$.]

Always $Delta H_"vap" > Delta H_"fus"$ (water: 40.7 vs 6.0 kJ/mol). Makes sense: melting only loosens the intermolecular contacts, while vaporisation breaks them all.

=== Heating curves

#ex[Heating 1 mol of ice from −25 °C to 125 °C at 1 atm][
  Molar heat capacities: ice 38.1, water 75.3, steam 37.5 $"J mol"^(-1) "K"^(-1)$; $Delta H_"fus" = 6.01$ kJ/mol, $Delta H_"vap" = 40.6$ kJ/mol.

  #table(columns: (auto, 1fr, auto),
    [*step*], [*calculation*], [*heat*],
    [A→B: warm ice], [$1 times 38.1 times 25$], [0.953 kJ],
    [B→C: melt at 0 °C], [$1 times 6.01$], [6.01 kJ],
    [C→D: warm water], [$1 times 75.3 times 100$], [7.53 kJ],
    [D→E: boil at 100 °C], [$1 times 40.6$], [40.6 kJ],
    [E→F: warm steam], [$1 times 37.5 times 25$], [0.938 kJ],
    [*total*], [], [*56.0 kJ*])
  #fg("c08_heating", [Heating curve of water. During melting and boiling the temperature stays constant: all heat goes into breaking intermolecular contacts.])
  Notice how the curve is dominated by vaporisation: boiling the water takes more than five times as much heat as warming it from 0 to 100 °C.
]

#mistake[During a phase change the temperature does *not* rise, so $q = n C Delta T$ gives zero. You must add $n Delta H_"fus"$ or $n Delta H_"vap"$ separately. And use the correct heat capacity for each phase.]

== Phase diagrams

Transition temperatures depend on pressure. A *phase diagram* shows, in a $P$–$T$ plane, which phase is stable.

#fgs(("c08_pd_h2o", "c08_pd_co2"), [Phase diagrams of water (left) and carbon dioxide (right), not to scale. Lines: two phases coexist. Triple point: all three coexist. Beyond the critical point there is no distinction between liquid and gas.])

- *Lines* mark phase changes: along them two phases coexist in equilibrium. The liquid–gas line is the vapour-pressure curve; it ends at the critical point.
- At the *triple point* (TP), solid, liquid and gas coexist.
- Beyond the *critical point* (C) there is no distinct liquid phase: a *supercritical fluid*. Going around the critical point you can turn a liquid into a gas without ever boiling it.
- Melting and boiling temperatures normally increase with pressure.

#remember[*Water is an exception:* its solid–liquid line has a *negative slope*. Ice is less dense than liquid water (the hydrogen-bonded ice lattice is open), so pressure favours the liquid: the melting point decreases with increasing pressure. Lakes freeze from the top, and the ice layer insulates the water below, so fish survive the winter.

*#ce("CO2") has its triple point above 1 atm* (5.1 atm, −57 °C). At 1 atm liquid #ce("CO2") cannot exist: dry ice *sublimes* directly at −78 °C. Its critical point (31 °C, 73 atm) is at mild conditions.]

#everyday[*Supercritical #ce("CO2") at work.* Because #ce("CO2") becomes supercritical so easily, it is used to decaffeinate coffee, extract hop flavours, dry-clean clothes and as a "green" solvent replacing chlorinated ones. *Critical point drying* produces aerogels, the lightest solids known (99.8 % air): the solvent is removed by going around the critical point, so no liquid surface and no surface tension ever pull the delicate structure apart. Aerogels insulate Mars rovers and high-end building facades. Freeze-drying (instant coffee, vaccines) uses the other side of the diagram: ice sublimes at low pressure without passing through the liquid.]

#problems()

#prob[Intermolecular forces][
  Name all intermolecular forces in (a) #ce("CH4"), (b) HCl, (c) #ce("CH3OH"), (d) #ce("CO2"), (e) #ce("NH3").
][
  (a) dispersion only (nonpolar). (b) dispersion + dipole–dipole. (c) dispersion + dipole–dipole + hydrogen bonds (O–H). (d) dispersion only: polar bonds, but linear molecule, no net dipole. (e) dispersion + dipole–dipole + hydrogen bonds.
]

#prob[Ranking boiling points][
  Rank by increasing boiling point and justify: #ce("C2H6"), #ce("CH3OH"), Ar, #ce("C3H8"), #ce("H2O").
][
  Ar (−186 °C, dispersion, small) < #ce("C2H6") (−89 °C, dispersion, larger) < #ce("C3H8") (−42 °C, still larger) < #ce("CH3OH") (65 °C, one O–H group, hydrogen bonds) < #ce("H2O") (100 °C, up to four H-bonds per molecule).
]

#prob[Heating curve][
  How much heat is needed to turn 100 g of ice at −10 °C into steam at 110 °C? (Use specific heats ice 2.09, water 4.18, steam 2.01 $"J g"^(-1) "K"^(-1)$; $Delta H_"fus" = 334$ J/g, $Delta H_"vap" = 2260$ J/g.)
][
  Ice: $100 times 2.09 times 10 = 2.09$ kJ. Melting: $33.4$ kJ. Water: $100 times 4.18 times 100 = 41.8$ kJ. Boiling: $226$ kJ. Steam: $100 times 2.01 times 10 = 2.01$ kJ. Total: $305$ kJ, of which 74 % is the vaporisation step.
]

#prob[Clausius–Clapeyron][
  Water has $Delta H_"vap" = 40.7$ kJ/mol and boils at 100 °C at 101.3 kPa. (a) At what temperature does water boil at the top of Mont Blanc (about 55 kPa)? (b) What is the vapour pressure of water at 120 °C?
][
  (a) $1\/T_2 = 1\/T_1 - (R\/Delta H_"vap") ln(P_2\/P_1) = 1\/373.15 - (8.314\/40 700) ln(55\/101.3) = 2.680 times 10^(-3) + 1.248 times 10^(-4) = 2.805 times 10^(-3)$ K#super[−1]. $T_2 = 357$ K $approx 84$ °C.
  (b) $ln(P_2\/101.3) = -(40 700\/8.314)(1\/393.15 - 1\/373.15) = 0.667$, so $P_2 = 101.3 times e^(0.667) = 197$ kPa ≈ 2 atm. This is the pressure inside a pressure cooker.
]

#prob[Phase diagrams][
  (a) Why does ice skating work better near 0 °C than at −30 °C? (b) What happens to dry ice in a sealed container that is slowly warmed, if the pressure inside rises above 5.1 atm?
][
  (a) A thin liquid-like layer at the ice surface (and pressure/friction heating) provides lubrication; close to 0 °C a little energy or pressure suffices to produce it, at −30 °C much less liquid forms. (The pressure effect alone is small, but its direction follows from the negative slope of the solid–liquid line.)
  (b) Above the triple-point pressure, warming crosses the solid–liquid line: dry ice *melts* to liquid #ce("CO2") instead of subliming. (This is how #ce("CO2") fire extinguishers contain liquid #ce("CO2") at about 60 atm.)
]

#summary[
  - State of matter = competition between thermal energy ($approx R T$) and intermolecular attraction.
  - Dispersion (all molecules; grows with size and elongation), dipole–dipole (polar molecules; shape decides polarity), hydrogen bonds (H on N, O, F; strongest of the neutral forces), ion–dipole (solvation of ions).
  - Liquids: viscosity, surface tension, vapour pressure all grow (or fall) with intermolecular forces.
  - Vapour pressure: dynamic equilibrium; rises steeply with $T$. Boiling when $P_"vap" = P_"ext"$.
  - Clausius–Clapeyron: $ln P_"vap" = -Delta H_"vap"\/(R T) + C$.
  - $Delta H_"sub" = Delta H_"fus" + Delta H_"vap"$; $Delta H_"vap" > Delta H_"fus"$. Constant temperature during phase changes.
  - Phase diagram: lines (coexistence), triple point, critical point. Water: negative solid–liquid slope; #ce("CO2"): sublimes at 1 atm.
]
