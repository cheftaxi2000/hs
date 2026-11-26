#import "lib.typ": *

= Entropy, Free Energy and the Second Law

#lec(5, [Entropy and free energy], [19.1–19.6])

#lecture[The first law says energy is conserved, but it does not say *which way* things go. A hot coffee cools down in a cold room; it never spontaneously heats up, although that would not violate energy conservation. This chapter introduces the quantity that decides the direction of all natural processes, entropy, and combines it with enthalpy into the single most useful criterion of chemistry, the Gibbs free energy.]

== Spontaneous processes

#defn[Spontaneous process][A *spontaneous* process is one that occurs by itself, without continuous outside assistance, once started.]

A first guess: maybe processes are spontaneous when they lower the energy, i.e. at constant pressure, when they are exothermic ($Delta H < 0$)? Many spontaneous processes are indeed exothermic: combustion, rusting, a ball rolling downhill. But *ice melts spontaneously at room temperature*, with $Delta H = +6.0$ kJ/mol. Endothermic and still spontaneous. Something is missing.

Before we find it, some important characteristics:

- If a process is spontaneous, the *reverse* process is nonspontaneous. A ball does not roll uphill by itself.
- *Conditions matter.* Ice melts at +1 °C but not at −1 °C.
- *Spontaneous does not mean fast.* Diamond turning into graphite is spontaneous at room conditions, but takes billions of years. *How fast* is the topic of kinetics (Chapter 10).
- *Nonspontaneous does not mean impossible.* It only means it will not happen without our help: water can be split into #ce("H2") and #ce("O2") if we supply electrical energy.

== Reversible and irreversible processes

#defn[Reversible and irreversible][A *reversible* process can be reversed with *no change* to the surroundings: system and surroundings both return to their original states. A process is reversible if an *infinitesimal* change in a property of the system reverses its direction. An *irreversible* process cannot be undone without leaving a change in the surroundings.]

*Heat transfer.* We know from daily life that heat flows spontaneously from hot to cold. If the system is at $T$ and the surroundings at $T + d T$, heat flows in very slowly. Lower the surroundings to $T - d T$ and the flow reverses, without any lasting change: this is (in the limit) reversible. If the temperature difference is finite, as with a hot coffee in a cold room, the process is irreversible.

*Expansion of a gas.* Let an ideal gas expand into a vacuum at constant temperature.

#fg("c05_expansion", [Free expansion of a gas into vacuum: spontaneous and irreversible. To put the gas back, the surroundings must do work to compress it.], w: 85%)

The gas never goes back into the left flask by itself. To return it, the surroundings must push it back, i.e. do work on it, so the surroundings are changed. Alternatively, let the gas expand slowly against a piston whose pressure is always only $d P$ lower than the gas pressure. Increasing the outside pressure by $d P$ at any moment reverses the motion: a reversible expansion.

#remember[Reversible processes are *idealisations*, infinitely slow and always infinitely close to equilibrium. *All real processes are irreversible*, and therefore *all spontaneous processes are irreversible*. During a spontaneous process energy is conserved (first law), but it *spreads out* and becomes *less useful*: part of it can no longer be used to do work.]

== Entropy

Reversible processes are nevertheless very useful to define a new state function that quantifies this tendency of energy to spread out.

#defn[Entropy $S$][*Entropy* is a measure of the tendency of energy to spread, which reduces a system's ability to do work. It is also related to the *randomness* or *disorder* of a system. $S$ is a state function. For an *isothermal* process (constant $T$):
$ Delta S = q_"rev"/T $
where $q_"rev"$ is the heat exchanged along a *reversible* path and $T$ is the absolute temperature.]

#why[can we use $q_"rev"$ even for irreversible processes?][Because $S$ is a state function, $Delta S$ only depends on the initial and final states. We can always imagine a reversible path between them, calculate $Delta S$ along it, and that value holds for *any* path, including the real irreversible one. ($q$ itself is path-dependent, but $q_"rev"$ belongs to one unique path.)]

=== Entropy of phase changes

Melting at the melting point and boiling at the boiling point are isothermal and can be done reversibly (infinitely slowly, at $T_"mp"$). At constant pressure $q_"rev" = Delta H$, so

#formula[Entropy of a phase change][
  $ Delta S_"fus" = (Delta H_"fus")/T_"mp", quad quad Delta S_"vap" = (Delta H_"vap")/T_"bp". $]

#ex[Melting ice][
  Ice melts at 0 °C and 101.3 kPa with $Delta H_"fus" = 6.0 times 10^3$ J/mol.
  $ Delta S = (6.0 times 10^3 "J/mol")/(273 "K") = +22 "J mol"^(-1) "K"^(-1). $
  Always in kelvin: dividing by 0 °C would be meaningless.
]

== The second law of thermodynamics

Is entropy conserved, like energy? Consider an ice cube melting in your hand (37 °C). This is a real, irreversible process.

- *System* (ice at 0 °C): it gains $6.0$ kJ/mol: $Delta S_"sys" = +6000\/273 = +22.0 "J mol"^(-1) "K"^(-1)$.
- *Surroundings* (hand at 310 K): it loses the same heat: $Delta S_"surr" = -6000\/310 = -19.4 "J mol"^(-1) "K"^(-1)$.
- *Universe:* $Delta S_"univ" = +22.0 - 19.4 = +2.6 "J mol"^(-1) "K"^(-1) > 0$.

The same heat counts for *more* entropy when it is transferred at a *lower* temperature. Heat flowing from hot to cold therefore always increases the total entropy. Entropy is *not* conserved.

#law[Second law of thermodynamics][
  - Reversible process: $Delta S_"univ" = Delta S_"sys" + Delta S_"surr" = 0$.
  - Irreversible process: $Delta S_"univ" = Delta S_"sys" + Delta S_"surr" > 0$.
  Since all real processes are irreversible: *the entropy of the universe increases in every spontaneous process.*]

Entropy of the *system* can decrease (water freezing in a freezer), but only if the entropy of the surroundings increases by more (the freezer releases heat into the kitchen).

#everyday[*Engineers are entropy warriors.* An engineer spends large amounts of energy to fight the second law: we make highly ordered, useful things (purified silicon, steel beams, sorted waste streams, desalinated water, a cold fridge). The second law allows this locally, but only if we create *more* disorder somewhere else: a power plant releasing heat and #ce("CO2"), a fridge warming the kitchen. The second law also limits every heat engine: no engine can convert heat completely into work (Carnot efficiency $1 - T_"cold"\/T_"hot"$). You will meet this again in thermodynamics.]

== Molecular interpretation of entropy

The kinetic theory (Chapter 2) explained why a gas expands into vacuum. *Statistical thermodynamics* connects the macroscopic state (described by $P, V, T$) with the microscopic arrangements of the molecules.

#defn[Microstate][A *microstate* is one particular arrangement of all molecules (their positions and energies) that is consistent with a given macroscopic state.]

#law[Boltzmann's equation][
  $ S = k_B ln W $
  $W$ = number of microstates consistent with the macroscopic state, $k_B = 1.38 times 10^(-23)$ J/K (Boltzmann constant). A change:
  $ Delta S = k_B ln W_"final" - k_B ln W_"initial" = k_B ln (W_"final")/(W_"initial"). $]

#fg("c05_microstates", [Ten molecules distributed between the two flasks of Fig. 5.1. There is exactly one microstate with all molecules on the left, but 252 with an even split. For a mole of gas ($6 times 10^(23)$ molecules) the chance of all being on one side is $(1\/2)^(6 times 10^(23))$, effectively zero.], w: 66%)

#intu[*Entropy counts possibilities.* The gas does not "want" to spread out; there are simply astronomically more ways to be spread out than to be concentrated. The system wanders randomly through its microstates and is practically always found in the overwhelming majority of them. A shuffled deck of cards becomes disordered for the same reason: there are many more disordered than ordered sequences. The second law is a law of large numbers.]

#ex[Entropy of free expansion][
  One mole of ideal gas doubles its volume. Each molecule now has twice as many possible positions, so $W_"final"\/W_"initial" = 2^(N_A)$:
  $ Delta S = k_B ln 2^(N_A) = N_A k_B ln 2 = R ln 2 = 5.76 "J mol"^(-1) "K"^(-1). $
]

=== What increases entropy?

In general, $S$ increases with:
- *temperature* (more energy, more ways to distribute it among the molecules),
- *volume* (more possible positions),
- *number of molecules*, in particular the number of *gas* molecules,
- *complexity* of molecules (more atoms means more ways to vibrate and rotate, i.e. more *degrees of freedom*),
- *melting* of solids and, especially, *vaporisation* of liquids.

#check[Predict the sign of $Delta S_"sys"$: (a) #ce("CaCO3(s) -> CaO(s) + CO2(g)"); (b) #ce("N2(g) + 3 H2(g) -> 2 NH3(g)"); (c) dissolving sugar in water.][(a) $Delta S > 0$: a gas is formed from a solid. (b) $Delta S < 0$: 4 mol gas become 2 mol gas. (c) $Delta S > 0$: the ordered crystal disperses into the solution.]

== The third law and absolute entropies

As we cool a system, it has less energy, fewer accessible degrees of freedom and fewer microstates.

#law[Third law of thermodynamics][The entropy of a pure, perfect crystalline substance at $T = 0$ K is zero: $S = 0$, since there is only one microstate ($W = 1$, $ln 1 = 0$).]

#fg("c05_entropyT", [Entropy of a substance versus temperature. It rises gradually on heating and jumps at the melting and, much more, at the boiling point.], w: 62%)

Unlike $H$, entropy therefore has an *absolute zero*. *Standard molar entropies* $S^degree$ (in $"J mol"^(-1) "K"^(-1)$, at 1 atm and 298 K) are tabulated for every substance (Brown, Appendix C). Note: $S^degree$ of elements is *not* zero at 298 K.

#formula[Entropy change of a reaction][
  $ Delta S_"rxn"^degree = sum_"products" b_j S_j^degree - sum_"reactants" a_i S_i^degree. $]

#ex[Ammonia synthesis][
  #rxn("N2(g) + 3 H2(g) -> 2 NH3(g)")
  With $S^degree$: #ce("NH3") 193, #ce("N2") 192, #ce("H2") 131 $"J mol"^(-1) "K"^(-1)$:
  $ Delta S^degree = 2(193) - [192 + 3(131)] = -199 "J mol"^(-1) "K"^(-1). $
  Negative, as predicted: 4 gas molecules become 2, fewer microstates.
]

Does this mean ammonia synthesis is not spontaneous? No, we must also look at the surroundings. The reaction is exothermic ($Delta H^degree = -92.4$ kJ), and that heat goes into the surroundings at 298 K:
$ Delta S_"surr" = q_"surr"/T = (-Delta H_"sys")/T = (92.4 times 10^3)/298 = +310 "J mol"^(-1) "K"^(-1). $
$ Delta S_"univ" = -199 + 310 = +111 "J mol"^(-1) "K"^(-1) > 0 quad => quad "spontaneous". $

Correct, but complicated: we had to analyse system *and* surroundings. Is there a criterion that only uses properties of the system?

== Gibbs free energy

#why[a new state function][At constant $T$ and $P$, the heat given to the surroundings is $-Delta H_"sys"$, so $Delta S_"surr" = -Delta H_"sys"\/T$. Then
$ Delta S_"univ" = Delta S_"sys" - (Delta H_"sys")/T. $
Multiply by $-T$:
$ -T Delta S_"univ" = Delta H_"sys" - T Delta S_"sys". $
The right-hand side only contains properties of the system. Define it as a new state function $Delta G$. The second law ($Delta S_"univ" > 0$) then becomes $Delta G < 0$.]

#defn[Gibbs free energy][
  $ G = H - T S, quad quad Delta G = Delta H - T Delta S quad "(constant" T")". $]

#law[Criterion for spontaneity (constant $T$ and $P$)][
  - $Delta G < 0$: the process is *spontaneous* (irreversible).
  - $Delta G = 0$: the system is at *equilibrium* (reversible).
  - $Delta G > 0$: the process is *nonspontaneous*; the reverse process is spontaneous.]

#intu[$Delta G = Delta H - T Delta S$ is a *competition between energy and entropy*. Nature likes to lower the enthalpy ($Delta H < 0$) and to increase the entropy ($Delta S > 0$). The temperature sets the exchange rate: at low $T$ enthalpy dominates, at high $T$ entropy dominates. Ice: melting costs enthalpy but gains entropy; below 0 °C enthalpy wins (it freezes), above 0 °C entropy wins (it melts), at exactly 0 °C they balance ($Delta G = 0$, ice and water coexist).]

*Why "free" energy?* One can show that $-Delta G$ is the *maximum useful work* (other than $P V$ work) that can be extracted from a process at constant $T$ and $P$: $w_"max" = Delta G$. Not all of $Delta H$ is available; the part $T Delta S$ is "bound" to the entropy change. A fuel cell, for example, converts at most $Delta G$ of the hydrogen–oxygen reaction into electrical work.

=== Standard free energies of formation

#defn[Standard free energy of formation][$Delta G_f^degree$ is the free energy change to form 1 mol of a substance from its elements in their standard states (1 atm, 25 °C). $Delta G_f^degree = 0$ for elements in their standard state. Values in Brown, Appendix C.]

#formula[Summary: standard reaction quantities][
  $ Delta H_"rxn"^degree = sum b_j Delta H_(f,j)^degree - sum a_i Delta H_(f,i)^degree $
  $ Delta S_"rxn"^degree = sum b_j S_j^degree - sum a_i S_i^degree $
  $ Delta G_"rxn"^degree = sum b_j Delta G_(f,j)^degree - sum a_i Delta G_(f,i)^degree quad "or" quad Delta G^degree = Delta H^degree - T Delta S^degree. $]

#mistake[*Units!* $Delta H$ is usually given in kJ, $Delta S$ in J/K. In $Delta G = Delta H - T Delta S$, convert one of them first. Forgetting this factor 1000 is the single most common error in this chapter.]

== The role of temperature

$Delta H$ and $Delta S$ change only little with temperature, so $Delta G(T) approx Delta H - T Delta S$ is approximately a straight line in $T$ with slope $-Delta S$. Four cases:

#table(columns: (auto, auto, auto, 1fr, auto),
  [*case*], [$Delta H$], [$Delta S$], [*spontaneous?*], [*example*],
  [1], [$-$], [$+$], [always (favoured by both)], [#ce("2 O3(g) -> 3 O2(g)")],
  [2], [$+$], [$-$], [never (favoured by neither)], [#ce("3 O2(g) -> 2 O3(g)")],
  [3], [$-$], [$-$], [at low $T$ (only enthalpy helps)], [#ce("H2O(l) -> H2O(s)")],
  [4], [$+$], [$+$], [at high $T$ (only entropy helps)], [#ce("H2O(s) -> H2O(l)")])

#fg("c05_dGT", [$Delta G$ as a function of temperature for the four cases. A process is spontaneous where its line is below the $T$-axis. Cases 3 and 4 change sign at $T = Delta H \/ Delta S$.], w: 70%)

#formula[Crossover temperature][For cases 3 and 4, $Delta G = 0$ at
$ T^* = (Delta H)/(Delta S). $
For a phase change this is the melting or boiling point.]

#ex[Boiling point from thermodynamic data][
  For #ce("H2O(l) -> H2O(g)"): $Delta H^degree = +44.0$ kJ/mol, $Delta S^degree = +118.8 "J mol"^(-1) "K"^(-1)$.
  $ T^* = (44 000 "J/mol")/(118.8 "J mol"^(-1) "K"^(-1)) = 370 "K" approx 97 "°C". $
  Close to the real 100 °C (the small error comes from using 25 °C values for $Delta H$ and $Delta S$).
]

#everyday[*Lime kilns and steel mills.* #ce("CaCO3 -> CaO + CO2") has $Delta H^degree = +178$ kJ and $Delta S^degree = +161$ J/K (a gas is formed): case 4. It only becomes spontaneous above $T^* = 178 000\/161 approx 1100$ K, which is why cement kilns run at about 900–1450 °C. Similarly, iron ore is reduced with carbon only at the high temperatures of a blast furnace, where the entropy gained by forming CO gas wins over the enthalpy cost. Plotting $Delta G^degree$ against $T$ for metal oxides (the *Ellingham diagram*) is the standard tool of metallurgists.]

// ALLTAG-BEGIN
== More from everyday life and the professions

#everyday[*Why ice melts above $0 degree "C"$.* For $"H"_2 "O"(s) -> "H"_2 "O"(l)$ the enthalpy is $Delta H = +6.01$ kJ/mol and the entropy $Delta S = +22.0$ J/(mol K). Melting is favourable when $Delta G = Delta H - T Delta S < 0$, so above $T = Delta H slash Delta S = 6010 slash 22.0 = 273$ K. The melting point is not a property that has to be remembered: it follows from two numbers, and it is exactly the temperature at which entropy beats enthalpy.]

#everyday[*The heat pump.* A heat pump heats a house with about one unit of electrical energy and takes about two to three units from the outside air or the ground: the coefficient of performance is typically $3$ to $4$. This is no violation of the first law: the energy is moved, not created, and the second law explains why moving heat «uphill» costs work. In Switzerland, heat pumps are the standard for new houses, and the efficiency depends on the temperature difference, which is why they work best with floor heating at low temperature.]
// ALLTAG-END

#problems()

#prob[Sign of $Delta S$][
  Predict the sign of $Delta S_"sys"$: (a) #ce("H2O(g) -> H2O(l)"); (b) #ce("2 KClO3(s) -> 2 KCl(s) + 3 O2(g)"); (c) #ce("C(graphite) + O2(g) -> CO2(g)"); (d) heating #ce("N2") from 300 K to 500 K.
][
  (a) negative (gas → liquid). (b) positive (gas formed from solid). (c) about zero, slightly positive: 1 mol gas → 1 mol gas (actual: +3 J/K). (d) positive (higher $T$).
]

#prob[Entropy of vaporisation][
  Ethanol boils at 78.3 °C with $Delta H_"vap" = 38.6$ kJ/mol. Calculate $Delta S_"vap"$ and $Delta S$ of the surroundings during reversible boiling.
][
  $Delta S_"vap" = 38 600\/351.5 = +110 "J mol"^(-1) "K"^(-1)$. Reversible: $Delta S_"surr" = -110 "J mol"^(-1) "K"^(-1)$, so $Delta S_"univ" = 0$. (Many liquids have $Delta S_"vap" approx 85$–$110 "J mol"^(-1) "K"^(-1)$: *Trouton's rule*.)
]

#prob[Boltzmann][
  A system goes from $W_1$ to $W_2 = 1000 W_1$ microstates. What is $Delta S$ per molecule and per mole of such systems?
][
  $Delta S = k_B ln 1000 = 1.38 times 10^(-23) times 6.91 = 9.5 times 10^(-23)$ J/K per molecule; times $N_A$: $57.4 "J mol"^(-1) "K"^(-1)$.
]

#prob[Is it spontaneous?][
  For #ce("2 SO2(g) + O2(g) -> 2 SO3(g)"): $Delta H^degree = -198$ kJ, $Delta S^degree = -187 "J/K"$. (a) Is the reaction spontaneous at 298 K? (b) Above which temperature does it stop being spontaneous?
][
  (a) $Delta G^degree = -198 "kJ" - 298 "K" times (-0.187 "kJ/K") = -198 + 55.7 = -142$ kJ < 0: spontaneous.
  (b) Case 3. $T^* = Delta H\/Delta S = 198\/0.187 = 1060$ K. Above about 1060 K the reaction is no longer spontaneous under standard conditions. (In the sulfuric acid industry, one therefore works at moderate temperatures with a catalyst.)
]

#prob[$Delta G^degree$ from formation data][
  Calculate $Delta G^degree$ for #ce("CH4(g) + 2 O2(g) -> CO2(g) + 2 H2O(l)") with $Delta G_f^degree$: #ce("CH4") $-50.8$, #ce("CO2") $-394.4$, #ce("H2O(l)") $-237.1$ kJ/mol. What is the maximum electrical work a methane fuel cell could deliver per mole?
][
  $Delta G^degree = [-394.4 + 2(-237.1)] - [-50.8] = -817.8$ kJ. Maximum work: 817.8 kJ/mol. Compare with $Delta H^degree = -890$ kJ: at most 92 % of the heat of combustion is available as work.
]

#prob[Ammonia at high temperature][
  For ammonia synthesis $Delta H^degree = -92.4$ kJ and $Delta S^degree = -199$ J/K. (a) Calculate $Delta G^degree$ at 298 K and at 700 K. (b) Why does industry nevertheless run the Haber–Bosch process at about 700 K?
][
  (a) 298 K: $-92.4 + 298 times 0.199 = -33.1$ kJ (spontaneous). 700 K: $-92.4 + 700 times 0.199 = +46.9$ kJ (not spontaneous under standard conditions).
  (b) At 298 K the reaction is thermodynamically favoured but extremely slow (Chapter 10). Higher $T$ makes it fast; to keep it favourable anyway, industry uses very high pressures (200 bar, which favours fewer gas molecules) and an iron catalyst. A classic engineering compromise between thermodynamics and kinetics.
]

#summary[
  - Spontaneous ≠ fast; nonspontaneous ≠ impossible. All real (spontaneous) processes are irreversible.
  - Entropy: $Delta S = q_"rev"\/T$ (isothermal); for phase changes $Delta S = Delta H\/T$.
  - Second law: $Delta S_"univ" > 0$ for every spontaneous process ($= 0$ if reversible).
  - Boltzmann: $S = k_B ln W$. Entropy grows with $T$, $V$, number of gas molecules, molecular complexity, melting and boiling.
  - Third law: $S = 0$ for a perfect crystal at 0 K. $Delta S^degree = sum b S^degree - sum a S^degree$.
  - Gibbs free energy $G = H - T S$, $Delta G = Delta H - T Delta S$. At constant $T, P$: $Delta G < 0$ spontaneous, $= 0$ equilibrium, $> 0$ nonspontaneous. $-Delta G$ = maximum useful work.
  - Four sign cases; crossover at $T^* = Delta H\/Delta S$. Watch kJ vs J!
]
