#import "lib.typ": *

= Thermochemistry and the First Law

#lec(4, [Thermochemistry, first law], [5.1–5.7])

#lecture[When hydrogen burns in a turbine, how much heat do we get? How much work? Can we calculate it without doing the experiment? Thermodynamics is the study of energy and its transformations. It connects heat, work and chemical reactions. This chapter covers its first half: energy is conserved. Chapter 5 adds the second half: why some processes happen and others do not.]

== Energy, system and surroundings

=== Kinetic and potential energy

Energy comes in two basic forms:
- *kinetic energy* $E_k = 1/2 m v^2$, the energy of motion (molecules flying, vibrating, rotating);
- *potential energy*, stored energy due to position or configuration. In chemistry the most important potential energy is the *electrostatic* energy of charges: electrons and nuclei in atoms and molecules. This energy is *stored in chemical bonds*.

The SI unit of energy is the joule, $1 "J" = 1 "kg m"^2"/s"^2$. Older unit: $1 "cal" = 4.184 "J"$ (the heat that warms 1 g of water by 1 °C). Food labels give "Calories" with a capital C, which are kilocalories.

#law[First law of thermodynamics][*Energy is conserved.* It can be converted from one form into another, but it cannot be created or destroyed.]

=== System and surroundings

To apply the first law we must say *what* we are looking at.

#defn[System and surroundings][The *system* is the part of the universe we study, typically the reactants and products of a reaction. The *surroundings* are everything else.
- *Open system:* matter and energy can be exchanged with the surroundings (a pot of boiling water without a lid).
- *Closed system:* energy can be exchanged, but not matter (a sealed piston).
- *Isolated system:* neither matter nor energy is exchanged (an ideal thermally insulated, sealed container).]

== Internal energy and the first law

#defn[Internal energy][The *internal energy* $E$ of a system is the sum of all kinetic and potential energies of its components. We do not know its absolute value, and we do not need it. We only ever care about *changes*:
$ Delta E = E_"final" - E_"initial". $
For a reaction: $E_"final"$ refers to the products, $E_"initial"$ to the reactants.]

- $Delta E > 0$: the system has *gained* energy from the surroundings.
- $Delta E < 0$: the system has *lost* energy to the surroundings.

#fg("c04_energydiag", [Energy diagram for the combustion of hydrogen. The products lie lower in energy than the reactants; the difference is released to the surroundings.], w: 58%)

Since energy cannot vanish, the energy change of the system must be exchanged with the surroundings, either as *heat* $q$ or as *work* $w$:

#formula[First law, quantitative form][
  $ Delta E = q + w $
  $q$ = heat *added to* the system, $w$ = work done *on* the system.]

#fg("c04_signs", [Sign convention (as in Brown, used throughout this course). Everything is counted from the system's point of view.], w: 88%)

#mistake[*Sign conventions differ between courses and books.* In many engineering thermodynamics courses, $W$ is the work done *by* the system and the first law reads $Delta U = Q - W$. Here (as in Brown) $w$ is work done *on* the system. Both describe the same physics; just never mix them in one calculation. When in doubt, ask: does the system's energy go up? Then the term is positive.]

#defn[Endothermic and exothermic][A process with $q > 0$ (heat absorbed by the system) is *endothermic*: e.g. ice melting, a cold pack. A process with $q < 0$ (heat released) is *exothermic*: e.g. combustion of hydrogen, a hand warmer.]

== State functions

#defn[State function][A *state function* is a property whose value depends only on the *current state* of the system (specified by $T, P$, amount, …), not on the path by which that state was reached.]

#intu[Your *altitude* on a mountain is a state function: whether you took the cable car or the long hiking trail, the change in altitude between the valley and the summit is the same. The *distance walked* and the *sweat produced* depend on the path; they are not state functions.]

$E$ is a state function. Heat $q$ and work $w$ are *not*: they depend on the path. Example: burn 2 mol of #ce("H2") with #ce("O2") to liquid water.
- *Path 1*, in an open burner: all energy leaves as heat, $Delta E = q$.
- *Path 2*, in a piston engine: part of the energy leaves as work, $Delta E = q + w$.
$Delta E$ is the same in both cases, but $q$ and $w$ differ. In some sense, thermodynamics is all about defining *useful state functions*. Here is the next one.

== Enthalpy

=== Pressure–volume work

#fg("c04_piston", [A gas expanding against a constant external pressure does work on its surroundings.], w: 78%)

Consider a gas in a cylinder with a massless piston of area $A$, pushing against a constant pressure $P$. If the piston moves by $Delta x$, the work done *on* the gas is
$ w = -F Delta x = -P A Delta x = -P Delta V. $
On expansion ($Delta V > 0$) the gas does work on the surroundings, so $w < 0$: it loses energy. On compression $w > 0$.

=== Definition of enthalpy

#defn[Enthalpy][
  $ H = E + P V. $
  Since $E$, $P$ and $V$ are state functions, so is $H$.]

#why[is enthalpy so useful?][At constant pressure, and if only $P V$-work is done:
$ Delta H = Delta E + P Delta V = (q_P + w) + P Delta V = q_P - P Delta V + P Delta V = q_P. $
*The change in enthalpy equals the heat exchanged at constant pressure.* Most chemistry happens at constant (atmospheric) pressure, and heat is easy to measure. So $Delta H$ is the quantity we can measure and tabulate for reactions.

Similarly, at constant volume ($Delta V = 0$, no work): $Delta E = q_V$.]

#remember[
  - $Delta H = q_P$ (constant pressure), $Delta E = q_V$ (constant volume).
  - $Delta H < 0$: exothermic, heat flows *to* the surroundings. $Delta H > 0$: endothermic, heat flows *from* the surroundings.
  - "$H$ is a state function but $q$ is not?" No contradiction: $q_P$ is the heat along one *specific* path (constant $P$, only $P V$ work).]

#intu[Why the extra $P V$ term? A reaction that produces gas at constant pressure must push the atmosphere back to make room: it does work $P Delta V$. Enthalpy includes this "rent for the space". For reactions involving only solids and liquids, $Delta V$ is tiny and $Delta H approx Delta E$. With gases: $Delta H = Delta E + Delta n_"gas" R T$. For #ce("2 H2(g) + O2(g) -> 2 H2O(l)"), $Delta n_"gas" = -3$, and $Delta n R T = -7.4$ kJ, about 1 % of $Delta H$.]

== Enthalpies of reaction

#defn[Enthalpy of reaction][
  $ Delta H_"rxn" = H_"products" - H_"reactants". $
  Also called the *heat of reaction*. A *thermochemical equation* gives the balanced equation together with $Delta H$:]

#rxn("2 H2(g) + O2(g) -> 2 H2O(g)", note: $Delta H = -483.6 "kJ"$)

#law[Rules for thermochemical equations][
  + *Enthalpy is extensive:* doubling all coefficients doubles $Delta H$. $Delta H$ refers to the amounts in the equation as written ("per mole of reaction").
  + *Reversing* the reaction changes the sign: $Delta H_"reverse" = -Delta H_"forward"$.
  + $Delta H$ *depends on the states* of reactants and products. Forming liquid water releases more heat than forming water vapour, because condensation itself releases heat.]

#ex[Heat from burning hydrogen][
  How much heat is released when 1.00 kg of #ce("H2") burns to water vapour?
  $n(ce("H2")) = 1000\/2.016 = 496$ mol. The equation releases 483.6 kJ per 2 mol #ce("H2"):
  $ q = 496 "mol" times (-483.6 "kJ")/(2 "mol") = -1.20 times 10^5 "kJ" = -120 "MJ". $
  Compare: 1 kg of methane gives about 50 MJ, 1 kg of petrol about 44 MJ. Per kilogram, hydrogen is an excellent fuel (per litre, as a gas, it is poor, which is the storage problem of the hydrogen economy).
]

== Calorimetry

How do we measure $Delta H$? By letting heat flow into a substance and measuring its temperature change.

#defn[Heat capacity][The *heat capacity* $C$ of an object is the heat needed to raise its temperature by 1 K. Per mole or per gram:
$ q = n C_m Delta T quad "(molar heat capacity" C_m ", J mol"^(-1)"K"^(-1)")", $
$ q = m c_s Delta T quad "(specific heat capacity" c_s ", J g"^(-1)"K"^(-1)")". $
Sign check: if $Delta T > 0$ the substance warmed up, so $q > 0$: heat was absorbed.]

Water has an unusually high specific heat capacity, $c_s = 4.18 "J g"^(-1) "K"^(-1)$, about five times that of rock or sand and nine times that of iron.

#everyday[*Why water cools engines and climates.* Because of its large $c_s$, water absorbs a lot of heat with little temperature rise. That makes it the standard coolant in car engines, power plants and data centres, and the working fluid in central heating. On a planetary scale, the oceans store enormous amounts of heat and moderate the climate: coastal cities have milder winters and cooler summers than continental ones. Imagine climate change without the oceans buffering it.]

#grid(columns: (1fr, 4.2cm), column-gutter: 12pt, align: horizon,
  [
    *Constant-pressure ("coffee-cup") calorimeter.* The reaction runs in solution in an insulated cup open to the atmosphere. No heat escapes, so all heat released by the reaction goes into the solution:
    $ q_"rxn" = -q_"soln" = -m_"soln" c_s Delta T, quad Delta H = q_"rxn". $
    Exothermic reaction: the solution warms up. Endothermic: it cools down.

    *Constant-volume ("bomb") calorimeter.* A sealed steel "bomb" with a sample and #ce("O2") under pressure sits in water and is ignited electrically. Since $V$ is constant, it measures $q_V = Delta E$. This is how the energy content of food and fuels is determined.
  ],
  figure(image("figs/c04_calorimeter.svg"), caption: [Coffee-cup calorimeter.]))

#ex[Neutralisation in a coffee cup][
  50.0 mL of 1.0 M HCl and 50.0 mL of 1.0 M NaOH, both at 22.0 °C, are mixed. The temperature rises to 28.7 °C. Find $Delta H$ per mole of water formed (assume $rho = 1.0$ g/mL, $c_s = 4.18 "J g"^(-1) "K"^(-1)$).

  #step[Heat absorbed by the solution.] $q_"soln" = 100 "g" times 4.18 times 6.7 "K" = 2.8 times 10^3 "J"$.
  #step[Heat of reaction.] $q_"rxn" = -2.8$ kJ for $0.050$ mol water.
  #step[Per mole.] $Delta H = -2.8 "kJ" \/ 0.050 "mol" = -56 "kJ/mol"$.
  (Same value for every strong acid + strong base, because the net reaction is always #ce("H^+ + OH^- -> H2O"), see Chapter 3.)
]

== Hess's law

Thousands of $Delta H$ values have been tabulated, but not for every reaction. Because $H$ is a state function, we can combine known reactions.

#law[Hess's law][If a reaction can be written as a sequence of steps, its enthalpy change is the sum of the enthalpy changes of the steps:
$ Delta H_"rxn" = Delta H_1 + Delta H_2 + Delta H_3 + dots $]

#grid(columns: (1fr, 6.0cm), column-gutter: 12pt, align: horizon,
  [
    #ex[Liquid water from the elements][
      Known:
      #rxn("2 H2(g) + O2(g) -> 2 H2O(g)", note: $-483.6 "kJ"$)
      #rxn("2 H2O(g) -> 2 H2O(l)", note: $-88 "kJ"$)
      Adding the two equations, #ce("2 H2O(g)") cancels:
      #rxn("2 H2(g) + O2(g) -> 2 H2O(l)", note: $-572 "kJ"$)
    ]
  ],
  figure(image("figs/c04_hess.svg"), caption: [Enthalpy diagram for the two-step path.]))

#recipe[Hess's law problems][
  + Look at the *target* equation. For each substance, find a given equation that contains it.
  + Reverse equations as needed (flip the sign of $Delta H$) so each substance is on the correct side.
  + Multiply equations as needed (multiply $Delta H$ by the same factor) so the amounts match.
  + Add the equations; cancel species appearing on both sides; add the $Delta H$ values.]

== Enthalpies of formation

A clever choice of reference makes Hess's law systematic.

#defn[Standard enthalpy of formation $Delta H_f^degree$][The enthalpy change when *1 mol* of a substance is formed from its *elements in their standard states* (most stable form at 1 atm and 25 °C):
$ ce("3 C(graphite) + 4 H2(g) -> C3H8(g)"), quad Delta H_f^degree = -103.9 "kJ/mol". $
By definition, $Delta H_f^degree = 0$ for every element in its standard state (#ce("O2(g)"), #ce("H2(g)"), C(graphite), Fe(s), #ce("Br2(l)"), …).]

#formula[Enthalpy of reaction from formation enthalpies][
  For $a_1 R_1 + a_2 R_2 + dots -> b_1 P_1 + b_2 P_2 + dots$:
  $ Delta H_"rxn"^degree = sum_"products" b_j Delta H_(f,j)^degree - sum_"reactants" a_i Delta H_(f,i)^degree. $
  "Products minus reactants", each weighted by its coefficient.]

#why[does this work?][Imagine the reaction in two steps via the elements (Hess's law). First, "unform" the reactants into their elements, costing $-sum a_i Delta H_(f,i)^degree$. Then form the products from those elements, giving $sum b_j Delta H_(f,j)^degree$. Since $H$ is a state function, the detour through the elements gives the same $Delta H$ as the direct reaction.]

#fg("c04_propane", [Combustion of propane, calculated by the detour through the elements.], w: 80%)

#ex[Combustion of propane][
  #rxn("C3H8(g) + 5 O2(g) -> 3 CO2(g) + 4 H2O(l)")
  With $Delta H_f^degree$ (kJ/mol): #ce("C3H8(g)") $-103.9$, #ce("CO2(g)") $-393.5$, #ce("H2O(l)") $-285.8$, #ce("O2(g)") 0:
  $ Delta H_"rxn"^degree = [3(-393.5) + 4(-285.8)] - [(-103.9) + 5(0)] = -2220 "kJ". $
  This is the heat a propane barbecue gives per mole of fuel (44 g).
]

#mistake[
  - Forgetting the coefficients, or forgetting that elements have $Delta H_f^degree = 0$ (and not something else).
  - Using #ce("H2O(g)") instead of #ce("H2O(l)"): the values differ by 44 kJ/mol.
  - "Reactants minus products": the sign comes out wrong. Always *products minus reactants*.]

=== Phase changes

Enthalpy changes also accompany phase changes, with no reaction at all:
- $Delta H_"fus"$, *heat of fusion* (melting, solid → liquid), $> 0$; for ice 6.01 kJ/mol.
- $Delta H_"vap"$, *heat of vaporisation* (liquid → gas), $> 0$; for water 40.7 kJ/mol at 100 °C.
The reverse processes (freezing, condensation) have the opposite sign. Chapter 8 explains them in terms of intermolecular forces.

#everyday[*Sweating and steam burns.* Evaporating 1 g of sweat takes about 2.4 kJ from your skin, the body's air conditioning. The other way round, steam at 100 °C burns much worse than water at 100 °C because condensing on your skin first releases the full heat of vaporisation. *Cold packs* contain ammonium nitrate, which dissolves endothermically; *hand warmers* oxidise iron powder exothermically (#ce("4 Fe + 3 O2 -> 2 Fe2O3"), $Delta H = -1648$ kJ).]

#idea[So far we have only asked *how much* energy is involved ($Delta E$, $Delta H$). But energy alone does not tell us *whether* a process will happen: ice melts spontaneously at 25 °C even though melting is endothermic. The missing ingredient is entropy and the second law (Chapter 5).]

// ALLTAG-BEGIN
== More from everyday life and the professions

#everyday[*The food label.* The energy on a package is measured by burning the food in a calorimeter, exactly the experiment of this chapter. A chocolate bar with $250$ kcal contains $250 dot 4.184 approx 1050$ kJ. The body does not burn it in a flame, but the enthalpy of the overall reaction is the same, because $Delta H$ does not depend on the path (Hess's law). A fat gives about $37$ kJ/g, a carbohydrate or protein about $17$ kJ/g, which is why fat is the most energy-dense food.]

#everyday[*Hand warmers.* The little bag you open in winter contains iron powder, salt, water and activated carbon. When air gets in, the iron slowly rusts: $4 "Fe" + 3 "O"_2 -> 2 "Fe"_2 "O"_3$ with $Delta H approx -1648$ kJ per $2$ mol $"Fe"_2 "O"_3$. The same rusting that destroys a bridge in decades is, in finely powdered form with salt as a catalyst, done in an hour or two and heats your pocket. It is a good reminder that the enthalpy tells how much heat, not how fast.]
// ALLTAG-END

#problems()

#prob[First law][
  A gas absorbs 150 J of heat and is compressed by the surroundings, which do 80 J of work on it. (a) What is $Delta E$? (b) What if instead it absorbs 150 J and expands, doing 80 J of work?
][
  (a) $q = +150$ J, $w = +80$ J: $Delta E = +230$ J.
  (b) $q = +150$ J, $w = -80$ J: $Delta E = +70$ J.
]

#prob[Expansion work][
  A reaction at constant pressure 1.00 atm produces gas, and the volume increases from 2.0 L to 12.0 L. How much work is done (in J)? What sign?
][
  $w = -P Delta V = -101 325 "Pa" times 10.0 times 10^(-3) "m"^3 = -1.01 times 10^3$ J. Negative: the system does work on the surroundings (it pushes back the atmosphere).
]

#prob[Specific heat][
  How much heat is needed to warm 2.00 L of water from 15 °C to 100 °C in a kettle? How long does a 2.0 kW kettle need (no losses)?
][
  $m = 2000$ g. $q = 2000 times 4.18 times 85 = 7.1 times 10^5$ J $= 710$ kJ. Time: $7.1 times 10^5 "J" \/ 2000 "W" = 355$ s ≈ 6 min.
]

#prob[Coffee-cup calorimetry][
  5.00 g of #ce("NH4NO3") are dissolved in 100.0 g of water at 23.0 °C. The temperature drops to 19.6 °C. Calculate $Delta H_"soln"$ in kJ per mole of #ce("NH4NO3") ($c_s = 4.18 "J g"^(-1) "K"^(-1)$ for the solution, total mass 105 g).
][
  $q_"soln" = 105 times 4.18 times (-3.4) = -1.49$ kJ (the solution lost heat). $q_"rxn" = +1.49$ kJ. $n = 5.00\/80.04 = 0.0625$ mol. $Delta H_"soln" = +1.49\/0.0625 = +23.9$ kJ/mol, endothermic (this is the cold pack).
]

#prob[Hess's law][
  Calculate $Delta H$ for #ce("C(graphite) + 1/2 O2(g) -> CO(g)") from
  #rxn("C(graphite) + O2(g) -> CO2(g)", note: $-393.5 "kJ"$)
  #rxn("CO(g) + 1/2 O2(g) -> CO2(g)", note: $-283.0 "kJ"$)
][
  Keep the first equation; reverse the second (#ce("CO2 -> CO + 1/2 O2"), $+283.0$ kJ). Adding: #ce("C + O2 + CO2 -> CO2 + CO + 1/2 O2"), i.e. #ce("C + 1/2 O2 -> CO"):
  $ Delta H = -393.5 + 283.0 = -110.5 "kJ". $
  This $Delta H$ cannot be measured directly, because burning carbon with limited oxygen always gives a mixture of CO and #ce("CO2"). Hess's law makes it accessible.
]

#prob[Formation enthalpies: methane][
  Calculate $Delta H_"rxn"^degree$ for #ce("CH4(g) + 2 O2(g) -> CO2(g) + 2 H2O(l)") with $Delta H_f^degree$: #ce("CH4") $-74.8$, #ce("CO2") $-393.5$, #ce("H2O(l)") $-285.8$ kJ/mol. How much heat per kilogram of methane?
][
  $ Delta H^degree = [-393.5 + 2(-285.8)] - [-74.8 + 0] = -890.3 "kJ". $
  Per kg: $1000\/16.04 = 62.3$ mol, $62.3 times 890.3 = 55.5$ MJ/kg (higher heating value).
]

#prob[Fuel comparison][
  Using the results above, compare the heat released per mole of #ce("CO2") produced for methane and propane. Which is the "cleaner" fuel in terms of #ce("CO2")?
][
  Methane: 890 kJ per 1 mol #ce("CO2"). Propane: 2220 kJ per 3 mol #ce("CO2") = 740 kJ/mol #ce("CO2"). Methane gives about 20 % more heat per #ce("CO2"), because it has the highest H:C ratio (H burns to water, not #ce("CO2")). Hydrogen is the limiting case: 0 #ce("CO2").
]

#summary[
  - First law: $Delta E = q + w$; $q > 0$ heat into the system, $w > 0$ work done on the system.
  - Endothermic: $q > 0$; exothermic: $q < 0$.
  - State functions ($E$, $H$, $P$, $V$, $T$) depend only on the state; $q$ and $w$ depend on the path.
  - $P V$ work: $w = -P Delta V$. Enthalpy $H = E + P V$; $Delta H = q_P$, $Delta E = q_V$.
  - $Delta H$ is extensive, changes sign on reversal, depends on physical states.
  - Calorimetry: $q = m c_s Delta T$; water $c_s = 4.18 "J g"^(-1) "K"^(-1)$.
  - Hess's law: $Delta H$ of a sum of steps = sum of $Delta H$.
  - $Delta H_"rxn"^degree = sum b_j Delta H_(f,j)^degree - sum a_i Delta H_(f,i)^degree$; elements in standard state: 0.
]
