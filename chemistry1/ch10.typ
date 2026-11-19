#import "lib.typ": *

= Chemical Kinetics

#lec(10, [Chemical kinetics], [14.1–14.4])

#lecture[Thermodynamics tells us whether a "driving force" exists for a reaction: does it lower the Gibbs free energy? But it says nothing about *how fast* it goes. Diamond should turn into graphite, but it takes billions of years. A mixture of hydrogen and oxygen can sit unchanged for years, or explode in a millisecond. Chemical kinetics describes the speed of reactions, and through it, *how* a reaction actually happens.]

== Why kinetics?

#idea[*Thermodynamics:* is the reaction possible ($Delta G < 0$)? *Kinetics:* how fast is it? Both matter for every process an engineer designs. Too slow: the reactor would have to be the size of a city. Too fast: it explodes. The key parameters that control the speed are *concentration*, *time*, *temperature* (and catalysts, which come later).

Kinetics also gives information about *how* a reaction occurs: the sequence of molecular steps, called the *reaction mechanism*. Knowing it, we can optimise a process or use a reaction in a new way.]

== Reaction rates

#defn[Reaction rate][The change in concentration of a reactant or product per unit time,
$ "rate" = ("change in concentration")/("time interval"), quad ["rate"] = "M/s" = "mol L"^(-1) "s"^(-1). $
By convention rates are *positive*. For the generic reaction A → B:
$ "rate" = (Delta [B])/(Delta t) = -(Delta [A])/(Delta t). $
Square brackets denote molar concentrations.]

The minus sign for the reactant compensates for $Delta [A] < 0$: A disappears at the same rate at which B appears.

=== Average and instantaneous rates

#grid(columns: (1fr, 6.6cm), column-gutter: 12pt, align: horizon,
  [
    The *average rate* over an interval $t_1$ to $t_2$ is the slope of the secant:
    $ overline("rate") = ([B]_(t_2) - [B]_(t_1))/(t_2 - t_1). $
    Letting $Delta t -> 0$ gives the *instantaneous rate*, the slope of the tangent, i.e. the derivative:
    $ "rate"(t) = (d [B])/(d t) = -(d [A])/(d t). $
    In general, average and instantaneous rates are not the same. Here the rate is fast at first and slows down as A is used up: with less A, less product forms per second.
  ],
  figure(image("figs/c10_rates.svg"), caption: [Concentrations versus time for A → B.]))

*Terminology:* "rate" without qualification means the instantaneous rate at time $t$. The *initial rate* is the instantaneous rate at $t = 0$.

#grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [
    *But the curve shape depends on the reaction.* For another reaction C → D, the concentration of D might grow *linearly* with time. Then the local slope is constant: the average rate equals the instantaneous rate at all times, and the rate *does not depend on [C]*. Clearly, this tells us something about the reaction. That is why we look at such plots.
  ],
  figure(image("figs/c10_zero.svg"), caption: [A reaction whose rate does not depend on the reactant.]))

#intu[*The cookie factory.* Think of a reaction as a black box: supplies (C) go in, cookies (D) come out. How can cookie production not depend on the amount of supplies? If the factory works at its *full capacity*: it has only so many ovens, and piling more flour at the door does not speed anything up. Reactions on a catalyst surface or in an enzyme often behave like this. Rate measurements are our window into the black box.]

=== Stoichiometry and rates

For a general reaction $a A + b B -> c C + d D$ the concentrations change at different speeds. To have *one* rate for the reaction, we divide by the coefficients:

#formula[Rate of a reaction][
  $ "rate" = -1/a (d [A])/(d t) = -1/b (d [B])/(d t) = +1/c (d [C])/(d t) = +1/d (d [D])/(d t). $]

#ex[Decomposition of ozone][
  #rxn("2 O3(g) -> 3 O2(g)")
  $ "rate" = -1/2 (d[ce("O3")])/(d t) = +1/3 (d[ce("O2")])/(d t). $
  If ozone disappears at $6.0 times 10^(-5)$ M/s, oxygen appears at $9.0 times 10^(-5)$ M/s, and the reaction rate is $3.0 times 10^(-5)$ M/s.
]

(This only holds if no significant amounts of intermediates build up during the reaction.)

== Rate laws

#defn[Rate law][An expression that gives the rate as a function of reactant concentrations. For $a A + b B -> c C + d D$:
$ "rate" = k [A]^alpha [B]^beta $
- $k$ is the *rate constant* (depends on temperature, not on concentration);
- $alpha, beta$ are the *reaction orders* with respect to A and B; they can be $0, 1/2, 1, 2, dots$;
- the *overall order* is $alpha + beta + dots$ (the sum of the exponents).]

#remember[The reaction orders $alpha, beta$ are *not* in general equal to the stoichiometric coefficients $a, b$. *They must be determined by experiment.* They reflect the mechanism (the actual molecular steps), not the overall balanced equation.]

=== Units of the rate constant

Since the rate always has units M/s, the units of $k$ depend on the overall order $n$: $[k] = "M"^(1 - n) "s"^(-1)$.

#table(columns: (auto, auto, auto, auto, auto),
  [*overall order*], [0], [1], [2], [3],
  [*units of $k$*], [$"M s"^(-1)$], [$"s"^(-1)$], [$"M"^(-1) "s"^(-1)$], [$"M"^(-2) "s"^(-1)$])

#trick[the order from the units][If a problem gives you $k$ with units, you immediately know the overall order: "s#super[−1]" means first order, "M#super[−1] s#super[−1]" second order.]

=== Determining rate laws: the method of initial rates

#recipe[method of initial rates][
  + Run several experiments in which only *one* concentration is changed at a time (one variable at a time again!).
  + Divide the rate laws of two such experiments: $k$ and all unchanged concentrations cancel.
  + Solve for the exponent: if doubling [A] multiplies the rate by $2^alpha$, then 2× → order 0 if the rate is unchanged, order 1 if it doubles, order 2 if it quadruples.
  + Insert the orders in any experiment to calculate $k$.]

#ex[A + B → C][
  #table(columns: (auto, auto, auto, auto),
    [*exp.*], [*[A] (M)*], [*[B] (M)*], [*initial rate (M/s)*],
    [1], [0.100], [0.100], [$4.0 times 10^(-5)$],
    [2], [0.100], [0.200], [$4.0 times 10^(-5)$],
    [3], [0.200], [0.100], [$16.0 times 10^(-5)$])
  #step[B (exp. 2 vs 1).] $ ("rate"_2)/("rate"_1) = (k (0.1)^alpha (0.2)^beta)/(k (0.1)^alpha (0.1)^beta) = 2^beta = 1 => beta = 0. $
  #step[A (exp. 3 vs 1).] $2^alpha = 16.0\/4.0 = 4 => alpha = 2$.
  #step[Rate law.] $"rate" = k [A]^2 [B]^0 = k [A]^2$, second order overall.
  #step[Rate constant.] $k = 4.0 times 10^(-5) \/ (0.100)^2 = 4.0 times 10^(-3) "M"^(-1) "s"^(-1)$.
  Adding more B does nothing: B must enter the mechanism only after the slow step.
]

== Integrated rate laws: concentration versus time

The rate law is a *differential equation* for $[A](t)$. Solving it tells us how concentrations evolve, the information needed to size a reactor or predict a shelf life. Consider A → products with rate $= -d[A]\/d t = k [A]^n$.

=== First-order reactions

#why[derivation][
  $ -(d [A])/(d t) = k [A] quad => quad (d [A])/[A] = -k d t quad => quad integral_([A]_0)^([A]_t) (d [A])/[A] = -k integral_0^t d tau $
  $ ln [A]_t - ln [A]_0 = -k t. $]

#formula[First order][
  $ ln [A]_t = -k t + ln [A]_0 quad <=> quad [A]_t = [A]_0 e^(-k t). $]

*Exponential decay*: in each equal time interval, the *same fraction* of the remaining A reacts. The first form is a straight line, $y = m x + b$ with $y = ln[A]_t$, $x = t$, slope $m = -k$ and intercept $ln[A]_0$. If a plot of $ln[A]$ versus $t$ is linear, the reaction is first order.

=== Second-order reactions

#why[derivation][
  $ -(d [A])/(d t) = k [A]^2 quad => quad -(d [A])/[A]^2 = k d t quad => quad 1/[A]_t - 1/[A]_0 = k t. $]

#formula[Second order][
  $ 1/[A]_t = k t + 1/[A]_0. $
  A plot of $1\/[A]$ versus $t$ is a straight line with slope $+k$.]

=== Zero-order reactions

#formula[Zero order][
  $ -(d[A])/(d t) = k quad => quad [A]_t = -k t + [A]_0. $
  $[A]$ itself decreases linearly with slope $-k$ (until A is used up).]

#fgs(("c10_lin0", "c10_lin1", "c10_lin2"), [How to identify the order from data: plot $[A]$, $ln[A]$ and $1\/[A]$ against $t$. The one that gives a straight line reveals the order, and its slope gives $k$.])

#fg("c10_orders", [Concentration versus time for zeroth-, first- and second-order reactions with the same initial rate. Zero order runs at constant speed until A is gone; second order slows down most strongly as A is depleted.], w: 62%)

== Half-life

#defn[Half-life $t_(1\/2)$][The time needed for the concentration of a reactant to fall to half of its initial value: $[A]_(t_(1\/2)) = 1/2 [A]_0$.]

Inserting $[A]_t = [A]_0\/2$ in the integrated rate laws:

#table(columns: (auto, auto, auto, auto),
  [], [*zeroth order*], [*first order*], [*second order*],
  [integrated law], [$[A]_t = -k t + [A]_0$], [$ln [A]_t = -k t + ln[A]_0$], [$1\/[A]_t = k t + 1\/[A]_0$],
  [linear plot], [$[A]$ vs $t$], [$ln[A]$ vs $t$], [$1\/[A]$ vs $t$],
  [half-life], [$t_(1\/2) = [A]_0 \/ (2k)$], [$t_(1\/2) = (ln 2)\/k = 0.693\/k$], [$t_(1\/2) = 1\/(k [A]_0)$],
  [dependence on $[A]_0$], [proportional], [*independent*], [inversely proportional])

For first order, e.g.: $ln(1/2) = -k t_(1\/2) => t_(1\/2) = ln 2 \/ k$.

#fg("c10_halflife", [First-order decay: every half-life halves the remaining amount, no matter how much is left.], w: 64%)

#remember[In all cases the half-life is inversely proportional to $k$: a bigger rate constant means a faster reaction and a shorter half-life. Only for *first order* is the half-life a constant property of the reaction, independent of how much you start with. This is why it is the natural "clock" of radioactive decay.]

#everyday[*Kinetics in daily life and engineering.*
- *Radioactive decay* is strictly first order. #super[14]C ($t_(1\/2) = 5730$ a) dates archaeological finds; #super[131]I ($t_(1\/2) = 8$ days) from a reactor accident is dangerous for weeks, #super[137]Cs (30 years) for centuries.
- *Drugs* are usually eliminated from the body by first-order kinetics. A half-life of 4 h means: after 4 h half, after 8 h a quarter is left. Dosing schedules are designed from $t_(1\/2)$.
- *Alcohol* is a famous exception: the liver enzyme is saturated already at low blood alcohol (the cookie factory at full capacity), so ethanol is removed by *zero-order* kinetics, at a constant 0.1–0.2 ‰ per hour regardless of how much you drank. Coffee does not speed it up.
- *Shelf lives* of food, batteries, polymers and lubricants are predicted from rate laws measured in accelerated tests.]

== Open questions: what does temperature do?

The rate law raises questions that this lecture does not yet answer:
- Given rate $= k [A]^alpha [B]^beta$, what do the exponents *mean* at the molecular level?
- Two reactions can both be spontaneous ($Delta G < 0$). Why is one fast and the other slow?
- Why do we so often *heat* reactions? What role does temperature play?

#everyday[*The speed of ants.* Ants are cold-blooded: their body temperature follows the surroundings. A classic experiment (H. Shapley, 1920) measured their running speed at different temperatures and found that it *doubles for every 10 °C* of warming. The same rule of thumb holds for many chemical reactions, and it is the reason we keep food in the fridge (spoilage reactions slow down by a factor of 4 to 8) and why a fever speeds up your metabolism. The explanation, activation energies and the Arrhenius equation, follows in the next lecture.]

#problems()

#prob[Rates and stoichiometry][
  For #ce("N2(g) + 3 H2(g) -> 2 NH3(g)") ammonia forms at $0.040$ M/s. How fast are #ce("N2") and #ce("H2") consumed? What is the reaction rate?
][
  Rate $= 1/2 d[ce("NH3")]\/d t = 0.020$ M/s. $-d[ce("N2")]\/d t = 0.020$ M/s, $-d[ce("H2")]\/d t = 3 times 0.020 = 0.060$ M/s.
]

#prob[Units of $k$][
  A rate constant is $3.2 times 10^(-2) "M"^(-1) "s"^(-1)$. (a) What is the overall order? (b) For a first-order reaction with $k = 3.2 times 10^(-2) "min"^(-1)$, express $k$ in s#super[−1].
][
  (a) $[k] = "M"^(1 - n) "s"^(-1) = "M"^(-1) "s"^(-1) => n = 2$. (b) $3.2 times 10^(-2) \/ 60 = 5.3 times 10^(-4) "s"^(-1)$.
]

#prob[Initial rates][
  For #ce("2 NO(g) + O2(g) -> 2 NO2(g)") the following initial rates were measured:
  #table(columns: (auto, auto, auto, auto),
    [*exp.*], [*[NO] (M)*], [*[#ce("O2")] (M)*], [*rate (M/s)*],
    [1], [0.010], [0.010], [$2.5 times 10^(-5)$],
    [2], [0.020], [0.010], [$1.0 times 10^(-4)$],
    [3], [0.010], [0.020], [$5.0 times 10^(-5)$])
  Find the rate law and $k$.
][
  Exp. 2/1: [NO] doubled, rate ×4: order 2 in NO. Exp. 3/1: [#ce("O2")] doubled, rate ×2: order 1 in #ce("O2"). Rate $= k [ce("NO")]^2 [ce("O2")]$, third order overall.
  $k = 2.5 times 10^(-5) \/ ((0.010)^2 times 0.010) = 25 "M"^(-2) "s"^(-1)$.
  (Here the orders happen to equal the coefficients, but this could not have been known without the experiment.)
]

#prob[First-order decomposition][
  #ce("N2O5") decomposes in a first-order reaction with $k = 6.2 times 10^(-4) "s"^(-1)$ at 45 °C. Starting at 0.50 M: (a) What is the half-life? (b) What is [#ce("N2O5")] after 30 min? (c) How long until 90 % has decomposed?
][
  (a) $t_(1\/2) = 0.693\/6.2 times 10^(-4) = 1.1 times 10^3$ s ≈ 19 min.
  (b) $[A] = 0.50 e^(-6.2 times 10^(-4) times 1800) = 0.50 e^(-1.116) = 0.16$ M.
  (c) $[A]\/[A]_0 = 0.10$: $t = ln 10 \/ k = 2.303\/6.2 times 10^(-4) = 3.7 times 10^3$ s ≈ 62 min (≈ 3.3 half-lives).
]

#prob[Which order?][
  For the decomposition of #ce("NO2"), these data were measured: $t = 0, 50, 100, 200$ s; $[ce("NO2")] = 0.0100, 0.0079, 0.0065, 0.0048$ M. Determine the order and $k$.
][
  $ln[A]$: $-4.61, -4.84, -5.04, -5.34$; differences per 50 s: $-0.23, -0.20, -0.15$ per 50 s: not constant, so not first order.
  $1\/[A]$: $100, 127, 154, 208$ M#super[−1]; increase per 50 s: 27, 27, 27: constant. Second order, $k = 27\/50 = 0.54 "M"^(-1) "s"^(-1)$.
]

#prob[Half-lives of different orders][
  For a second-order reaction with $k = 0.20 "M"^(-1) "s"^(-1)$: what is the half-life at $[A]_0 = 1.0$ M and at $0.10$ M? Compare with a first-order reaction.
][
  $t_(1\/2) = 1\/(k [A]_0)$: 5.0 s at 1.0 M, 50 s at 0.10 M. Each successive half-life of a second-order reaction is twice as long as the previous one, because $[A]_0$ for it is halved. For first order all half-lives would be equal.
]

#prob[Blood alcohol][
  After a party, a person has 0.8 ‰ blood alcohol. Elimination is zero order with $k = 0.15$ ‰/h. When is the level below 0.5 ‰ (legal driving limit in Switzerland)? When is it zero?
][
  $[A]_t = [A]_0 - k t$. Below 0.5 ‰: $t = (0.8 - 0.5)\/0.15 = 2$ h. Zero: $t = 0.8\/0.15 = 5.3$ h. Note the zero-order "half-life" $[A]_0\/(2k) = 2.7$ h depends on the starting level.
]

#summary[
  - Kinetics: how fast; thermodynamics: whether. Rate in M/s, positive; rate $= -1/a d[A]\/d t = 1/c d[C]\/d t$.
  - Average rate (secant) vs instantaneous rate (tangent, derivative); initial rate at $t = 0$.
  - Rate law $"rate" = k [A]^alpha [B]^beta$; orders from *experiment*, not from coefficients; overall order = sum; $[k] = "M"^(1-n) "s"^(-1)$.
  - Method of initial rates: change one concentration at a time, compare rates.
  - Integrated: zero $[A] = [A]_0 - k t$; first $ln[A] = ln[A]_0 - k t$; second $1\/[A] = 1\/[A]_0 + k t$. The linear plot identifies the order.
  - Half-life: zero $[A]_0\/(2k)$; first $0.693\/k$ (constant!); second $1\/(k[A]_0)$.
  - Temperature strongly accelerates reactions (≈ ×2 per 10 °C): next lecture.
]
