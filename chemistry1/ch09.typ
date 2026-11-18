#import "lib.typ": *

= Properties of Solutions

#lecture[Lecture 9 · Brown 13.1–13.5. In Chapter 3 we met solutions, focusing on water as solvent. Three questions remained open: *When* does a substance dissolve? *How much* dissolves? And how does a dissolved substance change the *properties* of the solvent? With thermodynamics (Chapters 4, 5) and intermolecular forces (Chapter 8) we can now answer all three.]

== Thermodynamics of solution formation

#defn[Solution process][solvent + solute → solution, i.e. mixing the solute uniformly into the solvent. At constant $T$ and $P$ it happens spontaneously, i.e. the solute dissolves, if
$ Delta G_"soln" = Delta H_"soln" - T Delta S_"soln" < 0. $]

*Entropy* almost always helps: mixing two substances increases the number of possible arrangements (more microstates, Chapter 5), so typically $Delta S_"soln" > 0$. *Enthalpy* can go either way. It depends on how the intermolecular interactions compare: *solute–solute*, *solvent–solvent* and *solute–solvent*.

=== The enthalpy of solution in three steps

Hess's law lets us split the process into three imaginary steps:

#table(columns: (auto, 1fr, auto),
  [*step*], [*process*], [*sign*],
  [(i)], [separate the solvent molecules (make room for the solute)], [$Delta H_1 > 0$],
  [(ii)], [separate the solute particles (e.g. break up the crystal lattice)], [$Delta H_2 > 0$],
  [(iii)], [mix separated solvent and solute: new solute–solvent attractions form], [$Delta H_"mix" < 0$])

$ Delta H_"soln" = Delta H_1 + Delta H_2 + Delta H_"mix". $

#fgs(("c09_solv_exo", "c09_solv_endo"), [Enthalpy diagrams for solution formation. Left: solute–solvent attraction is strong, $Delta H_"mix"$ outweighs the two separation steps. Right: it is weaker, and the overall process absorbs heat.])

#intu[Dissolving is a *partner swap at a dance*. Solvent molecules must let go of each other (i), solute particles must let go of each other (ii), and then solvent and solute pair up (iii). If the new pairs hold each other more tightly than the old ones, heat is released ($Delta H_"soln" < 0$). If not, heat is absorbed, but the process can still happen because entropy (the larger number of ways to mix) pays the bill.]

- If $Delta H_"soln" < 0$: $Delta G_"soln" < 0$ for any concentration. The solute is typically *completely miscible* (e.g. ethanol in water).
- If $Delta H_"soln" > 0$: $-T Delta S_"soln"$ must be sufficiently negative to make $Delta G_"soln" < 0$. Otherwise the substance is *insoluble*. Dissolving becomes more favourable at *higher temperature*.

#everyday[*Instant cold packs* contain solid ammonium nitrate and a pouch of water. When you squeeze the pack, #ce("NH4NO3") dissolves with $Delta H_"soln" = +26$ kJ/mol: the process is endothermic, yet spontaneous because of the large entropy gain, and the pack cools to about 0 °C. *Hot packs* use #ce("CaCl2") or #ce("MgSO4"), whose dissolution is strongly exothermic. Dissolving concentrated sulfuric acid in water releases so much heat that the water can boil and spatter: "always add acid to water, never water to acid".]

== How much dissolves? Solubility

#defn[Solubility, saturated solution][The *solubility* is the maximum amount of solute that dissolves in a given amount of solvent at a given temperature. A *saturated* solution contains this maximum amount; any additional solute stays undissolved. Liquids that mix in all proportions are *miscible*; those that do not mix are *immiscible* (oil and water).]

In a saturated solution a *dynamic equilibrium* is established:
#rxn("solute + solvent <=> solution", note: [dissolve ⇌ crystallise])
Particles keep dissolving, but just as many crystallise again; for the dissolution process $Delta G_"soln" = 0$. If the conditions change, solute dissolves or crystallises until a new equilibrium is reached. (Carefully cooled solutions can temporarily hold more than the equilibrium amount: they are *supersaturated*, and a seed crystal makes the excess crystallise suddenly. Reusable hand warmers with sodium acetate work this way.)

=== Factors affecting solubility

*1. Solute–solvent interactions: "like dissolves like".* Substances with similar intermolecular forces tend to dissolve in each other.
- Ionic solids dissolve best in *polar* solvents (ion–dipole forces).
- Polar liquids mix with polar solvents; nonpolar liquids (hexane, oil) mix with nonpolar ones and are immiscible with water.
- Alcohols with a short carbon chain (methanol, ethanol) are miscible with water thanks to the O–H group; long-chain alcohols become more and more "oily" and insoluble.

#everyday[*Soap and detergents* are molecules with a polar (ionic) head and a long nonpolar tail. The tails dissolve in grease, the heads in water, so the grease is carried away in tiny droplets (micelles). *Vitamins A, D, E, K* are nonpolar and fat-soluble (stored in body fat); vitamins B and C are polar and water-soluble (excreted, must be eaten regularly). Engineers choose solvents for paints, adhesives and cleaning agents with exactly this rule.]

*2. Pressure (gases).* The solubility of a gas in a liquid is proportional to its partial pressure above the liquid:

#law[Henry's law][
  $ S_g = k_H P_g $
  $S_g$ = solubility of the gas (usually in mol/L), $P_g$ = partial pressure of the gas above the solution, $k_H$ = Henry's law constant (depends on gas, solvent and temperature).]

#micro[At higher pressure more gas molecules hit the liquid surface per second, so more enter the solution, until the escape rate catches up. Equilibrium is reached at a higher dissolved concentration.]

#everyday[*Carbonated drinks* are bottled under several atmospheres of #ce("CO2"). Opening the bottle drops $P_(ce("CO2"))$ to the tiny value in air; the dissolved gas is suddenly far above its solubility and escapes as bubbles. *Decompression sickness* in divers is the same thing in blood: at 30 m depth (4 atm) much more #ce("N2") dissolves in the blood; ascending too fast releases it as bubbles in tissues and joints. Divers ascend slowly or breathe helium mixtures (He is less soluble).]

*3. Temperature.*
- Most *solid* (ionic) solutes become *more soluble* at higher $T$ (endothermic dissolution).
- *Gases* become *less soluble* at higher $T$ (gas dissolution is exothermic, and the dissolved gas gains entropy by escaping).

#fgs(("c09_solT", "c09_O2T"), [Left: solubility of three salts versus temperature; #ce("KNO3") is strongly temperature dependent, NaCl hardly at all. Right: solubility of #ce("O2") from air in water decreases with temperature.])

#everyday[*Thermal pollution.* Power plants and factories that return warm cooling water to rivers lower the dissolved oxygen, and fish can suffocate. In summer heat waves, fish die in warm, slow rivers for the same reason. A warm soda goes flat faster than a cold one. *Recrystallisation*, the standard purification method for solids in the chemical industry, uses the steep temperature dependence of solubility: dissolve hot, cool down, the pure product crystallises while impurities stay in solution.]

== Expressing concentration

Qualitatively we say "dilute" or "concentrated". Quantitatively there are several measures, each useful in different situations:

#table(columns: (auto, auto, 1fr),
  [*measure*], [*definition*], [*remarks*],
  [mole fraction], [$X_A = (n_A)/(n_"tot")$], [dimensionless; used for gases and Raoult's law],
  [molarity], [$c = (n_"solute")/(V_"solution" "in L")$], [mol/L = M; depends on $T$ (volume expands)],
  [molality], [$m = (n_"solute")/(m_"solvent" "in kg")$], [mol/kg; independent of $T$; used for colligative properties],
  [mass percent], [$("mass solute")/("total mass") times 100 %$], [everyday use],
  [ppm, ppb], [$("mass solute")/("total mass") times 10^6, 10^9$], [trace amounts: pollutants, impurities])

#mistake[*Molarity* is per litre of *solution*, *molality* per kilogram of *solvent*. For dilute aqueous solutions they are nearly equal (1 L of solution ≈ 1 kg of water), but not for concentrated ones. 1 ppm in water corresponds to 1 mg per kg, i.e. about 1 mg/L.]

#ex[Converting concentrations][
  A solution contains 25.0 g of ethylene glycol #ce("C2H6O2") ($M = 62.07$ g/mol) in 75.0 g of water. Mass percent: $25.0\/100 = 25.0 %$. Molality: $n = 0.403$ mol, $m = 0.403\/0.0750 = 5.37$ mol/kg. Mole fraction: $n_(ce("H2O")) = 75.0\/18.02 = 4.16$ mol, $X_"glycol" = 0.403\/4.57 = 0.088$.
]

== Colligative properties

#defn[Colligative property][A property of a solution that depends only on the *number* (concentration) of dissolved solute particles, not on their chemical identity.]

There are four: vapour-pressure lowering, boiling-point elevation, freezing-point depression and osmotic pressure. For electrolytes each ion counts as a separate particle:

#defn[Van 't Hoff factor $i$][The number of particles produced per formula unit of solute: $i = 1$ for nonelectrolytes (sugar, glycol), $i = 2$ for NaCl (#ce("Na^+ + Cl^-")), $i = 3$ for #ce("CaCl2"). (Real values are slightly smaller because some ions pair up in solution.)]

=== A. Vapour-pressure lowering: Raoult's law

Consider a volatile solvent with a *nonvolatile* solute (e.g. sugar in water).

#law[Raoult's law (ideal solution)][
  $ P_"solution" = X_"solvent" dot P_"solvent"^degree $
  The vapour pressure of the solution equals the mole fraction of the solvent times the vapour pressure of the pure solvent.]

#micro[Solute particles occupy part of the surface, and fewer solvent molecules are available to escape per unit area. Equivalently, the solution is a more "mixed", higher-entropy state than the pure solvent, so the solvent has less tendency to leave it.]

#grid(columns: (1fr, 5.2cm), column-gutter: 12pt, align: horizon,
  [
    #defn[Ideal solution][A solution that obeys Raoult's law. The assumption: *all intermolecular interactions are identical*: solute–solute = solvent–solvent = solute–solvent. Compare: an ideal gas assumes *no* interactions at all.]
    If solute–solvent attraction is *stronger* than the average of the others, molecules are held more tightly in the solution: $P_"vap"$ is *lower* than ideal. If it is *weaker*, $P_"vap"$ is *higher* than ideal.
  ],
  figure(image("figs/c09_raoult.svg"), caption: [Raoult's law and deviations.]))

=== B. Boiling-point elevation and C. freezing-point depression

#fg("c09_colligPD", [Phase diagram of a pure solvent (solid lines) and of a solution (dashed). The lower vapour pressure shifts the liquid–gas line down: the solution boils at a higher temperature and freezes at a lower one.], w: 62%)

A liquid boils when its vapour pressure reaches the external pressure. Since the solute lowers the vapour pressure, the solution must be heated to a *higher* temperature to boil. At the other end, the liquid region expands into lower temperatures: the solution *freezes* at a lower temperature (the solid that forms is usually pure solvent).

#formula[Boiling-point elevation and freezing-point depression (dilute solutions)][
  $ Delta T_b = T_b^"soln" - T_b^"solvent" = i K_b m, quad quad Delta T_f = T_f^"soln" - T_f^"solvent" = -i K_f m. $
  $m$ = molality of solute, $i$ = van 't Hoff factor, $K_b$, $K_f$ = molal boiling-point elevation and freezing-point depression constants of the solvent. For water: $K_b = 0.51$ °C kg/mol, $K_f = 1.86$ °C kg/mol.]

#ex[Antifreeze][
  25 % ethylene glycol in water ($m = 5.37$ mol/kg, $i = 1$, from the example above):
  $ Delta T_f = -1 times 1.86 times 5.37 = -10 "°C". $
  The coolant freezes only at −10 °C (and boils at $100 + 0.51 times 5.37 approx 103$ °C). Real car coolant uses about 50 % glycol, reaching about −37 °C (at such concentrations the simple formula is only approximate).
]

#everyday[*Road salt.* Spreading NaCl on icy roads: dissolved in the thin water film on the ice, the salt ($i = 2$) lowers the freezing point, and the ice melts down to about −10 °C (for NaCl practically down to −21 °C at saturation). In colder climates #ce("CaCl2") ($i = 3$) is used. Making *ice cream* the old-fashioned way uses ice + salt to reach temperatures well below 0 °C.

*Antifreeze proteins* allow some fish, insects and plants to survive below the freezing point of water. Unlike glycol, they do *not* work colligatively: at concentrations 300–500 times lower they bind to tiny ice crystals and block their growth, i.e. they act through *kinetics* rather than thermodynamics (the topic of Chapter 10). Their low concentration has almost no effect on osmotic pressure, which the organism could not tolerate.]

=== D. Osmosis and osmotic pressure

#fg("c09_osmosis", [Osmosis. Solvent flows through the semipermeable membrane into the solution until the extra hydrostatic pressure of the higher column, the osmotic pressure $Pi$, stops the net flow.], w: 86%)

#defn[Osmosis][A *semipermeable membrane* lets solvent molecules pass, but not solute particles. If it separates a solution from pure solvent (or two solutions of different concentration), there is a net flow of solvent *into the more concentrated solution*. This is *osmosis*. The *osmotic pressure* $Pi$ is the pressure that must be applied to the solution to stop it.]

#intu[Osmosis is less magical than it sounds. Solvent molecules cross the membrane in both directions. On the solution side, some of the surface of the membrane is "blocked" by solute particles, and the solvent there is diluted, so fewer solvent molecules cross from that side per second. The net flow goes towards the solution, tending to equalise the concentrations, until the rising pressure on the solution side pushes back hard enough.]

#formula[Osmotic pressure (van 't Hoff)][
  $ Pi V = i n R T quad <=> quad Pi = i c R T $
  with $c = n\/V$ the molarity. The formula looks exactly like the ideal gas law: solute particles in a solvent behave like gas particles in a vacuum.]

- Two solutions with the same $Pi$ are *isotonic*. A solution with higher $Pi$ than a reference is *hypertonic*, with lower $Pi$ *hypotonic*.
- Osmotic pressures are large: 0.1 M glucose at 25 °C gives $Pi = 0.1 times 10^3 times 8.314 times 298 "Pa" = 2.5$ bar, the pressure of a 25 m water column.

#everyday[*Reverse osmosis (RO)* is the main technology for seawater desalination: applying more than the osmotic pressure of seawater (about 27 bar; real plants use 55–80 bar) pushes water *backwards* through the membrane, leaving the salt behind. In medicine, *IV drips* must be isotonic with blood (0.9 % NaCl, "physiological saline"): red blood cells swell and burst in pure water (hypotonic) and shrivel in concentrated salt solution (hypertonic). Salting or sugaring food (ham, jam) preserves it because bacteria lose their water by osmosis.]

*Determining molar masses.* Because $Pi$ is large even for tiny concentrations, osmometry is a standard lab method to determine the molar mass of large molecules such as proteins and polymers.

#ex[Molar mass of an enzyme][
  A solution containing 0.150 g of an enzyme in 210.0 mL of solution has an osmotic pressure of 0.127 kPa at 25 °C. What is the molar mass?

  #step[Moles.] $ n = (Pi V)/(R T) = (127 "Pa" times 2.100 times 10^(-4) "m"^3)/(8.314 times 298.15) = 1.076 times 10^(-5) "mol". $
  #step[Molar mass.] $M = 0.150 "g" \/ 1.076 times 10^(-5) "mol" = 1.39 times 10^4$ g/mol.
  #step[Compare.] The freezing-point depression of the same solution would be only about $1.86 times 5 times 10^(-5) approx 10^(-4)$ °C, impossible to measure. The osmotic pressure (1.3 cm of water column) is easy to measure.
]

#problems()

#prob[Like dissolves like][
  Which is more soluble in water, and why? (a) #ce("CCl4") or NaCl; (b) hexane #ce("C6H14") or glycerol #ce("C3H5(OH)3"); (c) ethanol or 1-octanol #ce("C8H17OH").
][
  (a) NaCl (ionic, strong ion–dipole forces); #ce("CCl4") is nonpolar. (b) Glycerol: three O–H groups form hydrogen bonds with water; hexane is nonpolar. (c) Ethanol (miscible); in octanol the long nonpolar chain dominates, solubility only about 0.5 g/L.
]

#prob[Henry's law][
  At 25 °C, $k_H$ for #ce("CO2") in water is $3.4 times 10^(-2)$ mol L#super[−1] atm#super[−1]. (a) What is the #ce("CO2") concentration in a soda bottled under 4.0 atm #ce("CO2")? (b) After opening, in equilibrium with air ($P_(ce("CO2")) = 4 times 10^(-4)$ atm)?
][
  (a) $S = 3.4 times 10^(-2) times 4.0 = 0.14$ M. (b) $S = 3.4 times 10^(-2) times 4 times 10^(-4) = 1.4 times 10^(-5)$ M, 10 000 times less. Practically all the #ce("CO2") will eventually leave the opened bottle.
]

#prob[Raoult's law][
  180 g of glucose #ce("C6H12O6") are dissolved in 1.00 kg of water at 25 °C ($P_(ce("H2O"))^degree = 3.17$ kPa). What is the vapour pressure of the solution?
][
  $n_"glu" = 180\/180 = 1.00$ mol, $n_(ce("H2O")) = 1000\/18.02 = 55.5$ mol. $X_(ce("H2O")) = 55.5\/56.5 = 0.982$. $P = 0.982 times 3.17 = 3.11$ kPa, a lowering of 0.056 kPa (1.8 %).
]

#prob[Freezing and boiling points][
  Calculate the freezing and boiling points of a solution of 58.4 g NaCl in 1.00 kg of water (assume $i = 2$).
][
  $n = 58.4\/58.44 = 1.00$ mol, $m = 1.00$ mol/kg.
  $Delta T_f = -2 times 1.86 times 1.00 = -3.72$ °C: freezing point −3.7 °C.
  $Delta T_b = 2 times 0.51 times 1.00 = 1.02$ °C: boiling point 101.0 °C. (Salting pasta water raises its boiling point by far less than 1 °C; the salt is for taste.)
]

#prob[Which lowers the freezing point most?][
  Rank aqueous solutions by freezing point (lowest first): 0.10 m glucose, 0.10 m NaCl, 0.10 m #ce("CaCl2"), 0.15 m sucrose.
][
  Particle concentrations $i m$: glucose 0.10, NaCl 0.20, #ce("CaCl2") 0.30, sucrose 0.15. Lowest freezing point = most particles: #ce("CaCl2") < NaCl < sucrose < glucose.
]

#prob[Desalination][
  Seawater is roughly 0.55 M NaCl. (a) Estimate its osmotic pressure at 20 °C. (b) What minimum pressure must a reverse-osmosis plant apply?
][
  (a) $Pi = i c R T = 2 times 550 "mol/m"^3 times 8.314 times 293 = 2.68 times 10^6$ Pa ≈ 27 bar.
  (b) More than 27 bar. As fresh water is removed, the remaining brine becomes more concentrated and its osmotic pressure rises, so real plants work at 55–80 bar.
]

#summary[
  - Dissolution: $Delta G_"soln" = Delta H_"soln" - T Delta S_"soln" < 0$. $Delta S_"soln" > 0$ usually; $Delta H_"soln" = Delta H_1 + Delta H_2 + Delta H_"mix"$ (separate solvent, separate solute, mix).
  - Saturated solution = dynamic equilibrium. "Like dissolves like".
  - Henry: $S_g = k_H P_g$. Gases less soluble at high $T$; most salts more soluble at high $T$.
  - Concentrations: $X$, molarity (per L solution), molality (per kg solvent), mass %, ppm.
  - Colligative properties depend only on particle number ($i$ = particles per formula unit).
  - Raoult: $P = X_"solvent" P^degree$ (ideal solution: all interactions equal).
  - $Delta T_b = i K_b m$, $Delta T_f = -i K_f m$; water $K_b = 0.51$, $K_f = 1.86$ °C kg/mol.
  - Osmosis: solvent flows into the more concentrated solution; $Pi = i c R T$. Reverse osmosis desalinates water.
]
