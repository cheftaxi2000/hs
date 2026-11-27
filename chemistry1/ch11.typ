#import "lib.typ": *

= Temperature, Mechanisms and Catalysis

#lec(11, [Activation energy, mechanisms, catalysis], [14.5–14.7])

#lecture[Chapter 10 described *how fast* a reaction runs with the rate law $"rate" = k [A]^alpha [B]^beta$, but left three questions open. Why does the rate constant $k$ grow so steeply with temperature? What do the exponents mean at the molecular level? And how can a catalyst speed a reaction up without being used up? All three answers come from one picture: the *energy profile* of a reaction.]

== The collision model

#idea[For two molecules to react, three things must happen at the same time:
+ they must *collide* (no contact, no reaction);
+ they must collide with the right *orientation* (the atoms that are to form the new bond must meet);
+ the collision must bring at least a minimum energy, the *activation energy* $E_a$, to stretch and break the old bonds.
Only a tiny fraction of all collisions meets conditions 2 and 3. That is why most reactions are far slower than the collision rate itself: in a gas at room temperature every molecule collides several billion times per second.]

#defn[Activation energy $E_a$][The minimum energy that colliding reactant molecules must have for the reaction to take place. It is given *per mole*, in J/mol or kJ/mol. In the Arrhenius model $E_a$ is a constant of the reaction; to a good approximation it does not depend on the temperature.]

== Reading an energy profile

#fg("c11_profile", [Energy profile of an exothermic one-step reaction A + BC → AB + C. Bottom: what the atoms are doing at the three marked points. Following the curve from left to right *is* the reaction.])

The diagram, element by element:
- *Horizontal axis: reaction progress* (reaction coordinate). It is *not* time. It measures how far the atoms have moved from the arrangement of the reactants towards that of the products: here the distance B–C grows while the distance A–B shrinks.
- *Vertical axis: potential energy* $E_"pot"$ of the whole group of atoms, the energy stored in their bonds and in their mutual attraction and repulsion. Kinetic energy is not plotted: it is the "fuel" with which the molecules climb the curve.
- *(1) Reactants:* a flat valley on the left. A and BC are still far apart and do not feel each other.
- *(2) Transition state* (activated complex): the *maximum* of the curve. The bond B–C is half broken, the bond A–B half formed (dashed lines in the snapshot). This arrangement is not a molecule that could be isolated: it lasts about one molecular vibration (about $10^(-13)$ s) and then falls apart, to one side or the other.
- *(3) Products:* the valley on the right.
- *$E_a$ (red arrow)* is measured from the *reactant level* up to the *transition state*: the height of the hill that must be climbed.
- *$Delta E$ (blue arrow)* is measured from the *reactant level* to the *product level*: $Delta E = E_"products" - E_"reactants"$. Here the products lie lower, $Delta E < 0$: the reaction is exothermic and the difference is released as heat.

#remember[*$E_a$ and $Delta E$ are independent of each other.* $Delta E$ (thermodynamics) says whether energy is released; it is the same for every path from the reactants to the products. $E_a$ (kinetics) says how high the hill on the path is; it depends on the path. A strongly exothermic reaction can still be immeasurably slow: a mixture of #ce("H2") and #ce("O2") keeps for years, until a spark supplies the activation energy.]

=== Exothermic and endothermic reactions

#fgs(("c11_exo", "c11_endo"), [Left: exothermic, the products lie below the reactants. Right: endothermic, the products lie above. In both cases $E_a$ is measured upwards from the reactants, and $Delta E$ from the reactants to the products.])

- *Exothermic* ($Delta E < 0$): the blue arrow points *down*. On the way down from the summit more energy is released than was needed to climb up.
- *Endothermic* ($Delta E > 0$): the blue arrow points *up*. The transition state can never lie below the products, so the hill is at least as high as the energy difference: $E_a >= Delta E$ for every endothermic reaction.

#mistake[
- In hand sketches $Delta E$ is often drawn as a double-headed arrow. That hides the sign. Always read it *from the reactants to the products*: an arrow pointing down means $Delta E < 0$, pointing up $Delta E > 0$.
- $E_a$ always starts at the *reactant* level: not at the product level and not at the axis.]

=== The reverse reaction

Every elementary reaction can also run backwards, over the *same* transition state. Seen from the products, the hill has a different height:

#fg("c11_reverse", [One mountain, two sides. Forward (A → B) the climb is $E_a^"fwd"$, starting from the level of A. Reverse (B → A) the climb is $E_a^"rev"$, starting from the level of B. Both arrows end at the same transition state.], w: 64%)

#why[the formula for the reverse barrier][
The summit has one energy, whichever side we start from:
$ E_"TS" = E_A + E_a^"fwd" $
$ E_"TS" = E_B + E_a^"rev" $
Setting both equal:
$ E_B + E_a^"rev" = E_A + E_a^"fwd" $
$ E_a^"rev" = E_a^"fwd" - (E_B - E_A) $
$ E_a^"rev" = E_a^"fwd" - Delta E $
Here $Delta E = E_B - E_A$ is the energy change of the *forward* reaction.]

#formula[Activation energy of the reverse reaction][
$ E_a^"rev" = E_a^"fwd" - Delta E $
Exothermic forward reaction ($Delta E < 0$): $E_a^"rev" > E_a^"fwd"$, the reverse reaction is slower. Endothermic forward reaction ($Delta E > 0$): $E_a^"rev" < E_a^"fwd"$.]

#check[A reaction has $E_a = 75$ kJ/mol and $Delta E = -20$ kJ/mol. What is the activation energy of the reverse reaction?][$E_a^"rev" = 75 - (-20) = 95$ kJ/mol. The reverse reaction starts in the deeper product valley, so its hill is $20$ kJ/mol higher.]

== Temperature and the Arrhenius equation

=== Why temperature matters so much: the energy distribution

The molecules of a sample do not all have the same kinetic energy. Their energies follow the Maxwell–Boltzmann distribution: many molecules have energies near the most probable value, a few have very high energies.

#fg("c11_boltz", [Distribution of the kinetic energies at two temperatures. Only the molecules to the right of $E_a$ (shaded) are able to react. Heating shifts and flattens the curve; the tail beyond $E_a$ grows far more than the average energy.], w: 64%)

The diagram, element by element:
- *Horizontal axis:* kinetic energy $E$ of a molecule. *Vertical axis:* fraction of molecules per energy interval. The *area* under a curve between two energies is the fraction of molecules in that range; the total area under each curve is $1$ (all molecules).
- *At the higher temperature $T_2$* the maximum moves to the right and becomes lower: the same area spread over a wider range of energies.
- *The shaded tails* are the molecules with $E >= E_a$. The red tail ($T_2$) is much larger than the blue one ($T_1$): a moderate rise in temperature multiplies the number of molecules that can react.

#formula[Fraction of molecules with $E >= E_a$][
$ f = e^(-E_a \/ (R T)) $
in percent: $f = 100 % dot e^(-E_a\/(R T))$. Units: $R = 8.314 "J" thin "mol"^(-1) thin "K"^(-1)$, $T$ in K, $E_a$ in J/mol (convert kJ to J).]

#ex[Fraction of energetic molecules (Exercise 11, problem 5)][
  Calculate the fraction of molecules in a sample of nitrogen gas at $300$ K that has an energy of $10.0$ kJ/mol or greater.

  #step[Exponent.]
  $ E_a/(R T) = (10.0 times 10^3 "J/mol")/(8.314 "J" thin "mol"^(-1) thin "K"^(-1) dot 300 "K") $
  $ E_a/(R T) = (10 thin 000)/(2494.2) = 4.009 $
  #step[Fraction.]
  $ f = e^(-4.009) $
  $ f = 0.0181 = 1.81 % $
  About one molecule in 55 has at least $10$ kJ/mol.]

#why[a fine point: molecules or collisions?][Strictly, $e^(-E_a\/(R T))$ is the result of collision theory for the fraction of *collisions* in which the kinetic energy of the relative motion along the line of impact is at least $E_a$; that is the quantity which matters for the rate. Integrating the full three-dimensional Maxwell–Boltzmann distribution of the kinetic energies of single molecules gives a somewhat larger number (here about $4.6 %$). In exercises and exams use $f = e^(-E_a\/(R T))$, as the textbook does.]

The formula shows how sensitive the fraction is to temperature (values for 25 °C and 35 °C):

#align(center, table(columns: 4, align: center,
  [*$E_a$ (kJ/mol)*], [*$f$ at 298 K*], [*$f$ at 308 K*], [*ratio*],
  [10], [$1.8 times 10^(-2)$], [$2.0 times 10^(-2)$], [1.14],
  [50], [$1.7 times 10^(-9)$], [$3.3 times 10^(-9)$], [1.92],
  [100], [$3.0 times 10^(-18)$], [$1.1 times 10^(-17)$], [3.70]))

The higher the barrier, the smaller the fraction of molecules that can cross it, and the more strongly that fraction reacts to a change in temperature.

=== The frequency factor $A$

#fg("c11_orient", [Orientation matters. Top: the green atom hits the end of the molecule to which it is to bond, and the reaction happens. Bottom: it hits the wrong end and bounces off. No reaction, however fast it was.])

The rate constant collects all three conditions of the collision model:
$ k = underbrace(Z, "collisions" \ "per time") dot underbrace(p, "fraction properly" \ "oriented") dot underbrace(e^(-E_a\/(R T)), "fraction with" \ E >= E_a) = A dot e^(-E_a\/(R T)) $

#defn[Frequency factor $A$][$A = Z p$, also called the *pre-exponential factor* or collision factor. It is proportional to the number of collisions per unit time and to the fraction of collisions with a suitable orientation. Its *units are those of $k$*: $"s"^(-1)$ for a first-order reaction, $"M"^(-1) thin "s"^(-1)$ for a second-order reaction.]

- $A$ increases slightly with $T$: faster molecules collide more often, roughly $Z prop sqrt(T)$. Compared with the exponential factor this is negligible, and $A$ is treated as a constant.
- The orientation factor $p$ is close to 1 when two atoms react, and can be far below 1 for large molecules with one small reactive site.

#mistake[
- *$A$ is not dimensionless.* $[A] = [k]$, because $e^(-E_a\/(R T))$ is a pure number. Writing $[A] = 1$ is wrong.
- *$E_a$ is in J/mol, not in J.* Only then is $E_a\/(R T)$ dimensionless: $("J" thin "mol"^(-1))\/("J" thin "mol"^(-1) thin "K"^(-1) dot "K") = 1$.
- *The frequency factor $A$ is not the reactant A* or its concentration $[A]$ in a rate law. Same letter, completely different meaning: in "increase $A$" (frequency factor) nothing is added to the flask.
- $T$ always in kelvin.]

=== The Arrhenius equation

#formula[Arrhenius equation][
  $ k = A dot e^(-E_a \/ (R T)) $
  #table(columns: 3, stroke: none, inset: (x: 5pt, y: 2pt),
    [$k$], [rate constant], [units depend on the order],
    [$A$], [frequency factor], [same units as $k$],
    [$E_a$], [activation energy], [J/mol],
    [$R$], [gas constant], [$8.314 "J" thin "mol"^(-1) thin "K"^(-1)$],
    [$T$], [absolute temperature], [K])]

#ex[What makes $k$ larger? (Exercise 11, problem 1)][
  #align(center, table(columns: 3, align: center,
    [*increase …*], [*effect on $k$*], [*reaction*],
    [$A$], [larger (proportional)], [faster],
    [$T$], [larger (exponential)], [faster],
    [$E_a$], [smaller (exponential)], [slower]))
  Reasoning from $k = A e^(-E_a\/(R T))$: $A$ is a prefactor, $k$ grows in proportion. A larger $T$ makes $E_a\/(R T)$ smaller, the exponent becomes less negative and the exponential grows. A larger $E_a$ makes the exponent more negative and the exponential shrinks.]

=== The Arrhenius plot

Taking the logarithm turns the exponential function into a straight line:
$ ln k = ln(A dot e^(-E_a\/(R T))) $
$ ln k = ln A + ln e^(-E_a\/(R T)) $
$ ln k = ln A - E_a/R dot 1/T $
Compare with $y = b + m x$: $y = ln k$, $x = 1\/T$, slope $m = -E_a\/R$, intercept $b = ln A$.

#fg("c11_arrh", [Arrhenius plot: $ln k$ against $1\/T$. The measured points lie on a straight line. Its slope gives $E_a$; its extrapolated intercept gives $ln A$.], w: 64%)

The diagram, element by element:
- The horizontal axis is $1\/T$, so *high temperatures are on the left* and low temperatures on the right. Moving to the right (cooling), $ln k$ falls: the reaction gets slower.
- The *slope* $m = -E_a\/R$ is always negative. *A steeper line means a larger $E_a$*, i.e. a stronger temperature dependence. From the slope: $E_a = -m R$.
- The *intercept* at $1\/T = 0$ is $ln A$. It corresponds to $T -> infinity$ and is never measured: it is found by extending the line (dashed).
- At a given temperature and for equal $A$, the larger $E_a$ means the smaller $k$: a larger activation energy means a slower reaction.

#recipe[$E_a$ and $A$ from measured rate constants][
  + For each measurement compute $x = 1\/T$ (with $T$ in K) and $y = ln k$.
  + Plot $y$ against $x$, draw the best straight line, and take two points on it that lie far apart.
  + Slope: $m = (y_2 - y_1)\/(x_2 - x_1)$, then $E_a = -m R$.
  + Intercept: $ln A = y_1 - m x_1$, then $A = e^(ln A)$, in the units of $k$.]

#ex[Activation energy from an Arrhenius plot][
  For a first-order reaction the following rate constants were measured:
  #align(center, table(columns: 5, align: center,
    [$T$ (K)], [300], [320], [340], [360],
    [$k$ ($"s"^(-1)$)], [$8.73 times 10^(-3)$], [$5.72 times 10^(-2)$], [$0.300$], [$1.31$],
    [$1\/T$ ($10^(-3) thin "K"^(-1)$)], [3.3333], [3.1250], [2.9412], [2.7778],
    [$ln k$], [$-4.741$], [$-2.861$], [$-1.204$], [$0.270$]))
  #step[Slope] (first and last point):
  $ m = (0.270 - (-4.741))/((2.7778 - 3.3333) times 10^(-3) thin "K"^(-1)) $
  $ m = (5.011)/(-0.5555 times 10^(-3) thin "K"^(-1)) $
  $ m = -9.02 times 10^3 "K" $
  #step[Activation energy.]
  $ E_a = -m R = 9.02 times 10^3 "K" dot 8.314 "J" thin "mol"^(-1) thin "K"^(-1) $
  $ E_a = 7.50 times 10^4 "J/mol" = 75.0 "kJ/mol" $
  #step[Frequency factor.]
  $ ln A = ln k_1 - m dot 1/T_1 $
  $ ln A = -4.741 + 9.02 times 10^3 "K" dot 3.3333 times 10^(-3) thin "K"^(-1) = 25.33 $
  $ A = e^(25.33) = 1.0 times 10^(11) thin "s"^(-1) $
  The two middle points lie on the same line (check it). With real, scattered data, use the best-fit line through all points instead of two single measurements.]

=== Two temperatures, or two reactions

Often only two rate constants are known. Write the logarithmic form for both and subtract: the unknown $ln A$ drops out.

#why[same reaction at two temperatures][
  $ ln k_1 = ln A - E_a/(R T_1) $
  $ ln k_2 = ln A - E_a/(R T_2) $
  Subtract:
  $ ln k_1 - ln k_2 = -E_a/(R T_1) + E_a/(R T_2) $
  $ ln(k_1/k_2) = E_a/R (1/T_2 - 1/T_1) $]

#why[two reactions at the same temperature, with the same $A$][
  $ ln k_1 = ln A - E_(a,1)/(R T) $
  $ ln k_2 = ln A - E_(a,2)/(R T) $
  Subtract:
  $ ln(k_1/k_2) = (E_(a,2) - E_(a,1))/(R T) $]

#formula[Two-point forms of the Arrhenius equation][
  *Same reaction, two temperatures:*
  $ ln(k_1/k_2) = E_a/R (1/T_2 - 1/T_1) $
  *Two reactions, same temperature, equal $A$:*
  $ ln(k_1/k_2) = (E_(a,2) - E_(a,1))/(R T) $]

#trick[check the sign][Test every such formula with common sense before using it. Right: if reaction 1 has the *lower* barrier, $E_(a,1) < E_(a,2)$, it must be the faster one, $k_1 > k_2$, so $ln(k_1\/k_2) > 0$; and indeed $E_(a,2) - E_(a,1) > 0$. Writing $E_(a,1) - E_(a,2)$ in the numerator, an easy slip, gives the wrong sign. Left: if $T_1 > T_2$, then $1\/T_2 - 1\/T_1 > 0$ and $k_1 > k_2$, as it must be.]

#why[the rule "twice as fast per 10 K"][
  Which $E_a$ makes a reaction exactly twice as fast between 25 °C and 35 °C? With $k_2 = 2 k_1$, $T_1 = 298.15$ K, $T_2 = 308.15$ K:
  $ ln(k_2/k_1) = E_a/R (1/T_1 - 1/T_2) $
  $ ln 2 = E_a/(8.314 "J" thin "mol"^(-1) thin "K"^(-1)) dot (1/(298.15 "K") - 1/(308.15 "K")) $
  $ 0.6931 = E_a/(8.314 "J" thin "mol"^(-1) thin "K"^(-1)) dot 1.0884 times 10^(-4) thin "K"^(-1) $
  $ E_a = (0.6931 dot 8.314)/(1.0884 times 10^(-4)) "J/mol" $
  $ E_a = 5.29 times 10^4 "J/mol" approx 53 "kJ/mol" $
  The rule of thumb therefore holds only for activation energies around $50$ kJ/mol, which is typical for many reactions near room temperature. A reaction with $E_a = 100$ kJ/mol becomes almost 4 times faster per 10 K (see the table above).]

== Reaction mechanisms

#idea[A balanced equation states only the beginning and the end. The *reaction mechanism* is the sequence of molecular events in between. Most reactions run in several steps, and the rate law is the window through which we can look at these steps.]

=== Intermediates and elementary reactions

Example: the decomposition of ozone,
#rxn("2 O3(g) -> 3 O2(g)")
runs in two steps:
#rxn("O3 -> O2 + O", note: [step 1])
#rxn("O3 + O -> 2 O2", note: [step 2])
Adding the two steps gives #ce("2 O3 + O -> 3 O2 + O"). The O atom appears on both sides and cancels: what remains is the overall equation.

#defn[Elementary reaction, intermediate][
  - An *elementary reaction* (elementary step) occurs exactly as written, in a single molecular event. It cannot be split into smaller steps.
  - An *intermediate* is formed in one step and consumed in a later one (here the O atom). It does not appear in the overall equation.]

#remember[*An intermediate is not a transition state.* An intermediate sits in a *valley* of the energy profile, between two humps: it lives for a finite time and can sometimes be detected or even isolated. A transition state sits on a *summit* and can never be isolated.]

=== Molecularity

#defn[Molecularity][The number of particles (molecules, atoms, ions) that react in an *elementary* step: *unimolecular* (one), *bimolecular* (two), *termolecular* (three).]

Termolecular steps are rare: three particles must meet at the same instant, with the right orientation and enough energy. Steps with four or more particles practically never occur. In the ozone mechanism, step 1 is unimolecular and step 2 bimolecular.

=== Rate laws of elementary reactions

For an *elementary* step the rate law follows directly from the equation. The rate is proportional to how often the reacting particles meet, and that is proportional to the product of their concentrations.

#formula[Rate law of an elementary step][
  For an elementary step $alpha A + beta B -> "products"$:
  $ "rate" = k [A]^alpha [B]^beta $
  The orders are equal to the stoichiometric coefficients.
  #align(center, table(columns: 3, align: center,
    [*molecularity*], [*elementary step*], [*rate law*],
    [unimolecular], [A → P], [$k [A]$],
    [bimolecular], [A + A → P], [$k [A]^2$],
    [bimolecular], [A + B → P], [$k [A][B]$],
    [termolecular], [A + A + B → P], [$k [A]^2 [B]$],
    [termolecular], [A + B + C → P], [$k [A][B][C]$]))]

For the ozone steps: $"rate"_1 = k_1 [ce("O3")]$ and $"rate"_2 = k_2 [ce("O3")][ce("O")]$.

#mistake[This rule holds *only for elementary steps*. For an overall reaction the orders must be measured (Chapter 10). The overall reaction #ce("2 O3 -> 3 O2") does *not* have the rate law $k [ce("O3")]^2$; its measured rate law is $k [ce("O3")]^2 \/ [ce("O2")]$ (derived below). Write a rate law from the coefficients only if the step is known to be elementary.]

=== The rate-determining step

#intu[*The slowest station sets the pace.* Picture a car wash with three stations: pre-wash 1 min, wash 10 min, drying 1 min. However quick the other two stations are, no more than 6 cars per hour leave the line. In a mechanism, the slowest elementary step is this bottleneck. It is called the *rate-determining* (rate-limiting) step, and the overall rate equals its rate.]

In the energy profile each step has its own hump. The rate-determining step is the one with the *highest transition state*, measured from the level of the reactants.

#fgs(("c11_mech_a", "c11_mech_b"), [Two-step mechanisms. Left: the first step is slow (its hump is the highest), the intermediate reacts on at once. Right: the first step is fast and reversible, the second step is slow. In both cases the overall activation energy $E_a$ reaches from the reactants up to the *highest* transition state.])

#ex[Slow first step: #ce("NO2 + CO -> NO + CO2")][
  Experiment (below about 225 °C): $"rate" = k [ce("NO2")]^2$, independent of [CO]. Proposed mechanism:
  #rxn("NO2 + NO2 -> NO3 + NO", note: [slow])
  #rxn("NO3 + CO -> NO2 + CO2", note: [fast])
  #step[Sum of the steps.] #ce("2 NO2 + NO3 + CO -> NO3 + NO + NO2 + CO2"). Cancel #ce("NO3") and one #ce("NO2"): #ce("NO2 + CO -> NO + CO2"), the overall equation. #ce("NO3") is the intermediate.
  #step[Rate law.] The slow step is elementary and bimolecular in #ce("NO2"):
  $ "rate" = k_1 [ce("NO2")]^2 $
  in agreement with the experiment. CO only enters *after* the bottleneck, so adding CO does not speed up the reaction. This is exactly the situation of the initial-rates example in Chapter 10, where the order in B was zero.]

#ex[Fast pre-equilibrium: the decomposition of ozone][
  Experiment: $"rate" = k [ce("O3")]^2 \/ [ce("O2")]$; the product #ce("O2") *slows the reaction down*. Mechanism:
  #rxn("O3 <=> O2 + O", note: [fast, equilibrium])
  #rxn("O + O3 -> 2 O2", note: [slow])
  #step[Rate of the slow step.]
  $ "rate" = k_2 [ce("O")][ce("O3")] $
  This contains the intermediate O, whose concentration is not known. It must be eliminated.
  #step[Equilibrium of step 1.] The forward and the reverse step are equally fast:
  $ k_1 [ce("O3")] = k_(-1) [ce("O2")][ce("O")] $
  $ [ce("O")] = (k_1 [ce("O3")])/(k_(-1) [ce("O2")]) $
  #step[Insert.]
  $ "rate" = k_2 dot (k_1 [ce("O3")])/(k_(-1) [ce("O2")]) dot [ce("O3")] $
  $ "rate" = (k_1 k_2)/k_(-1) dot [ce("O3")]^2/[ce("O2")] $
  This agrees with the experiment, with $k = k_1 k_2 \/ k_(-1)$. The negative order in #ce("O2") is the fingerprint of the pre-equilibrium: more #ce("O2") pushes step 1 back and lowers the concentration of O atoms.]

#recipe[checking a proposed mechanism][
  + The elementary steps must add up to the overall equation; the intermediates cancel.
  + Write the rate law of the slow step from its coefficients (it is elementary).
  + If it contains an intermediate, eliminate it with the equilibrium of the fast step before it.
  + Compare with the experimental rate law. If they disagree, the mechanism is wrong. If they agree, it is plausible, but not proven: another mechanism might give the same rate law.]

== Catalysis

#defn[Catalyst][A substance that increases the rate of a reaction without being consumed. It *does take part* in the mechanism (it forms an intermediate with a reactant), but it is regenerated in a later step. Therefore it does not appear in the overall equation.]

The short version "a catalyst does not take part in the reaction" means: not in the *overall* reaction. In the mechanism it is essential.

#fg("c11_cat", [The catalyst opens a different path (green) whose highest hump is lower than that of the uncatalysed path (dashed). The valley in between is an intermediate containing the catalyst. The start and end levels are the same, so $Delta E$ does not change.], w: 66%)

The diagram, element by element:
- *Dashed:* the original, uncatalysed path with the barrier $E_a^"uncat"$.
- *Green:* the catalysed path. It consists of two steps (reactant + catalyst → intermediate; intermediate → product + catalyst). Its highest hump is lower: $E_a^"cat" < E_a^"uncat"$.
- *Reactant and product levels are unchanged:* the catalyst changes the *path*, not the start and the end. $Delta E$ (and also $Delta H$ and $Delta G$) stay the same.

A catalyst increases $k = A e^(-E_a\/(R T))$
+ mainly by *lowering $E_a$*, through a new mechanism with a lower barrier. Because $E_a$ stands in the exponent, even a moderate reduction has a huge effect;
+ sometimes also by *increasing $A$*, for instance by holding the reactants next to each other in the right orientation (on a surface, in an enzyme).

#remember[*A catalyst does not shift the equilibrium.* It lowers the forward and the reverse barrier by the *same* amount ($E_a^"rev" = E_a^"fwd" - Delta E$ with unchanged $Delta E$), so it speeds up both directions equally. Equilibrium is reached faster, but its position stays the same.]

=== Homogeneous, heterogeneous, enzymes

- *Homogeneous catalyst:* in the same phase as the reactants, e.g. dissolved #ce("H^+") ions that catalyse the hydrolysis of an ester in water.
- *Heterogeneous catalyst:* in a different phase, usually a solid on whose surface gas or liquid molecules adsorb; the surface weakens their bonds. Examples: Pt, Pd, Rh in the catalytic converter, Fe in the Haber–Bosch synthesis of ammonia.
- *Enzymes:* proteins that catalyse biochemical reactions. The reactant (substrate) binds in the *active site* in exactly the right orientation. Enzymes can accelerate reactions by factors of $10^(10)$ and more.

#ex[How much does an enzyme lower $E_a$? (Exercise 11, problem 6)][
  A certain enzyme catalyses a biochemical reaction. In water, without the enzyme, the rate constant is $k_u = 6.50 times 10^(-4) thin "min"^(-1)$ at 37 °C. With the enzyme it is $k_c = 1.67 times 10^4 thin "min"^(-1)$ at 37 °C. Assuming the collision factor is the same in both cases, calculate the difference in activation energies (index u: uncatalysed, c: catalysed).

  #step[Same $A$, same $T$.]
  $ k_u = A e^(-E_(a,u)\/(R T)), quad k_c = A e^(-E_(a,c)\/(R T)) $
  Divide, $A$ cancels:
  $ k_c/k_u = e^((E_(a,u) - E_(a,c))\/(R T)) $
  $ E_(a,u) - E_(a,c) = R T ln(k_c/k_u) $
  #step[Numbers] ($T = 37 + 273 = 310$ K; the units of $k$ cancel in the ratio):
  $ E_(a,u) - E_(a,c) = 8.314 "J" thin "mol"^(-1) thin "K"^(-1) dot 310 "K" dot ln((1.67 times 10^4)/(6.50 times 10^(-4))) $
  $ E_(a,u) - E_(a,c) = 2577 "J/mol" dot ln(2.57 times 10^7) $
  $ E_(a,u) - E_(a,c) = 2577 "J/mol" dot 17.06 $
  $ E_(a,u) - E_(a,c) = 4.40 times 10^4 "J/mol" = 44.0 "kJ/mol" $
  The enzyme lowers the activation energy by $44.0$ kJ/mol, and this alone makes the reaction $2.6 times 10^7$ times faster.
  #step[Sign check.] With the ratio the other way round, $R T ln(k_u\/k_c) = E_(a,c) - E_(a,u) = -44.0$ kJ/mol: negative, because the catalysed barrier is the *lower* one. Only the magnitude, $44.0$ kJ/mol, is "the difference".]

#everyday[*Catalysts at work.*
- *Haber–Bosch process:* #ce("N2") and #ce("H2") react to ammonia on an iron catalyst at about 450 °C and 200 bar. Without the catalyst, the reaction would be uselessly slow at any temperature at which the equilibrium is still favourable. About half of the nitrogen in the proteins of all humans has passed through such an iron catalyst as fertiliser.
- *Washing powder* contains enzymes (proteases, lipases, amylases) that break down protein, fat and starch stains at 30–40 °C, where without them 90 °C would be needed: an energy saving thanks to a lower $E_a$.
- *Your body* runs at 37 °C. Practically every reaction of the metabolism is catalysed by its own enzyme; without them, digesting a meal would take years.]

#problems()

#prob(fig: "c11_ex0", fw: 5.2cm)[Labelling a reaction profile (Exercise 11, problem 0)][
  The diagram shows a reaction profile. Label the components indicated by the boxes (1) to (4) and by the circle (5).
][
  (1) *Reactants*: the energy level before the reaction. (2) *Activation energy* $E_a$: from the reactant level up to the summit. (3) $Delta E$, the energy difference between products and reactants; here negative, the reaction is exothermic. (4) *Products*: the energy level after the reaction. (5) *Transition state* (activated complex): the maximum of the curve.
]

#prob(fig: "c11_ex2", fw: 5.2cm)[Two paths (Exercise 11, problem 2)][
  The graph shows two different reaction paths for the same overall reaction at the same temperature. True or false? (a) The rate is faster for the red path than for the blue path. (b) For both paths, the rate of the reverse reaction is slower than the rate of the forward reaction. (c) The energy change $Delta E$ is the same for both paths.
][
  (a) *False.* The blue path has the lower barrier, so (with equal $A$) it is the faster one. (b) *True.* Both paths are exothermic (products lower than reactants), so $E_a^"rev" = E_a^"fwd" - Delta E > E_a^"fwd"$: the reverse climb starts from the deeper valley and is higher. (c) *True.* $Delta E$ depends only on the start and end levels, not on the path. (The blue path could be the catalysed version of the red one.)
]

#prob[Ranking by activation energy (Exercise 11, problem 3)][
  Based on their activation energies and energy changes, and assuming that all collision factors are the same, rank the reactions from slowest to fastest: (a) $E_a = 75$ kJ/mol, $Delta E = -20$ kJ/mol; (b) $E_a = 100$ kJ/mol, $Delta E = +30$ kJ/mol; (c) $E_a = 85$ kJ/mol, $Delta E = -50$ kJ/mol. Then rank the reverse reactions.
][
  *Forward.* With equal $A$ and the same $T$ only $E_a$ counts; $Delta E$ does not enter $k$. Higher barrier, slower reaction:
  slowest (b) $100$ < (c) $85$ < (a) $75$ fastest.

  *Reverse.* $E_a^"rev" = E_a^"fwd" - Delta E$:
  $ "(a)" quad E_a^"rev" = 75 - (-20) = 95 "kJ/mol" $
  $ "(b)" quad E_a^"rev" = 100 - 30 = 70 "kJ/mol" $
  $ "(c)" quad E_a^"rev" = 85 - (-50) = 135 "kJ/mol" $
  Slowest (c) $135$ < (a) $95$ < (b) $70$ fastest. Reaction (b) is endothermic, so its reverse reaction has the smallest barrier.
]

#prob(fig: "c11_ex4", fw: 5.2cm)[Reading Arrhenius plots (Exercise 11, problem 4)][
  The graph shows $ln k$ against $1\/T$ for two different reactions, extrapolated to the $y$-axis. Which reaction (red or blue) has (a) the larger value of $E_a$, (b) the larger frequency factor $A$?
][
  Use $ln k = ln A - (E_a\/R) dot (1\/T)$.
  (a) The slope is $-E_a\/R$. The blue line is steeper:
  $ abs(m_"blue") > abs(m_"red") $
  $ E_(a,"blue")/R > E_(a,"red")/R $
  $ E_(a,"blue") > E_(a,"red") $
  *Blue* has the larger activation energy.
  (b) The intercept is $ln A$. The red intercept is higher:
  $ ln A_"red" > ln A_"blue" $
  $ A_"red" > A_"blue" $
  ($ln$ is increasing.) *Red* has the larger frequency factor. Over the whole range shown, red is the faster reaction; blue reacts more sensitively to temperature.
]

#prob[Molecularity and rate laws (Exercise 11, problem 7)][
  What is the molecularity of each of the following elementary reactions? Write the rate law for each.
  #block(inset: (left: 8pt))[(a) #ce("H2O(l) + CN^-(aq) -> HCN(aq) + OH^-(aq)") \
  (b) #ce("CH3Cl(solv) + OH^-(solv) -> CH3OH(solv) + Cl^-(solv)") \
  (c) #ce("N2O4(g) -> 2 NO2(g)")]
][
  The reactions are elementary: count the reacting particles; the orders equal the coefficients.
  (a) Bimolecular: $"rate" = k [ce("H2O")][ce("CN^-")]$. Water is the solvent and its concentration (about $55.5$ M) stays practically constant, so in practice one measures $"rate" = k' [ce("CN^-")]$ with $k' = k [ce("H2O")]$ ("pseudo-first order").
  (b) Bimolecular: $"rate" = k [ce("CH3Cl")][ce("OH^-")]$.
  (c) Unimolecular: $"rate" = k [ce("N2O4")]$.
]

#prob[Two temperatures][
  A reaction has $E_a = 50.0$ kJ/mol and $k = 1.0 times 10^(-3) thin "s"^(-1)$ at 25 °C. (a) Calculate $k$ at 50 °C. (b) What fraction of the molecules has $E >= E_a$ at 25 °C?
][
  (a) Same reaction, two temperatures ($T_1 = 298.15$ K, $T_2 = 323.15$ K):
  $ ln(k_2/k_1) = E_a/R (1/T_1 - 1/T_2) $
  $ ln(k_2/k_1) = (50.0 times 10^3)/(8.314) "K" dot (1/(298.15) - 1/(323.15)) thin "K"^(-1) $
  $ ln(k_2/k_1) = 6014 dot 2.595 times 10^(-4) = 1.560 $
  $ k_2/k_1 = e^(1.560) = 4.76 $
  $ k_2 = 4.76 dot 1.0 times 10^(-3) thin "s"^(-1) = 4.8 times 10^(-3) thin "s"^(-1) $
  (b)
  $ f = e^(-E_a\/(R T)) = e^(-50.0 times 10^3 \/ (8.314 dot 298.15)) $
  $ f = e^(-20.17) = 1.7 times 10^(-9) $
  Fewer than two molecules in a billion, and yet the reaction runs, because there are so many collisions.
]

#prob[Same temperature, different barriers][
  Two reactions with the same frequency factor are run at 25 °C. Reaction 1 is 100 times faster than reaction 2. By how much do the activation energies differ?
][
  Different reactions, same $T$:
  $ ln(k_1/k_2) = (E_(a,2) - E_(a,1))/(R T) $
  $ E_(a,2) - E_(a,1) = R T ln(k_1/k_2) $
  $ E_(a,2) - E_(a,1) = 8.314 dot 298.15 "J/mol" dot ln 100 $
  $ E_(a,2) - E_(a,1) = 2479 "J/mol" dot 4.605 = 1.14 times 10^4 "J/mol" $
  The faster reaction 1 has the barrier that is lower by $11.4$ kJ/mol. (Sign check: $k_1 > k_2$ must go with $E_(a,1) < E_(a,2)$. It does.)
]

#prob[Is the mechanism consistent?][
  For #ce("2 NO(g) + Br2(g) -> 2 NOBr(g)") the measured rate law is $"rate" = k [ce("NO")]^2 [ce("Br2")]$. Proposed mechanism:
  #rxn("NO + Br2 <=> NOBr2", note: [fast, equilibrium])
  #rxn("NOBr2 + NO -> 2 NOBr", note: [slow])
  Is it consistent with the rate law?
][
  #step[Sum.] #ce("NO + Br2 + NOBr2 + NO -> NOBr2 + 2 NOBr"), giving #ce("2 NO + Br2 -> 2 NOBr") ✓ (intermediate #ce("NOBr2")).
  #step[Slow step.] $"rate" = k_2 [ce("NOBr2")][ce("NO")]$.
  #step[Eliminate the intermediate] with the pre-equilibrium:
  $ k_1 [ce("NO")][ce("Br2")] = k_(-1) [ce("NOBr2")] $
  $ [ce("NOBr2")] = k_1/k_(-1) [ce("NO")][ce("Br2")] $
  $ "rate" = (k_1 k_2)/k_(-1) [ce("NO")]^2 [ce("Br2")] $
  Consistent ✓. A single termolecular step NO + NO + #ce("Br2") would give the same rate law, but three-body collisions are very rare: the two-step mechanism is more plausible.
]

#summary[
  - Collision model: reaction needs a collision, the right orientation and an energy of at least $E_a$ (in J/mol).
  - Energy profile: $E_a$ from the reactants up to the transition state (maximum); $Delta E$ from reactants to products ($< 0$ exothermic). $E_a$ depends on the path, $Delta E$ does not. Endothermic: $E_a >= Delta E$.
  - Reverse reaction: $E_a^"rev" = E_a^"fwd" - Delta E$.
  - Fraction of molecules with $E >= E_a$: $f = e^(-E_a\/(R T))$; it rises steeply with $T$.
  - Arrhenius: $k = A e^(-E_a\/(R T))$; $A$ = collision frequency × orientation factor, same units as $k$.
  - Arrhenius plot: $ln k = ln A - (E_a\/R)(1\/T)$; slope $-E_a\/R$, intercept $ln A$.
  - Two points: $ln(k_1\/k_2) = (E_a\/R)(1\/T_2 - 1\/T_1)$; equal $A$, same $T$: $ln(k_1\/k_2) = (E_(a,2) - E_(a,1))\/(R T)$. Check the sign.
  - "×2 per 10 K" corresponds to $E_a approx 53$ kJ/mol.
  - Mechanism: elementary steps, intermediates (valleys, not summits); molecularity 1, 2, rarely 3. Only for elementary steps do the orders equal the coefficients.
  - The slowest step (highest transition state) determines the rate; intermediates are eliminated via a fast pre-equilibrium.
  - Catalyst: takes part in the mechanism but is regenerated; lowers $E_a$ (sometimes raises $A$); $Delta E$ and the equilibrium position stay the same. Homogeneous / heterogeneous / enzymes.
]
