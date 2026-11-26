#import "lib.typ": *

= Atoms, Molecules, Ions and Stoichiometry

#lec(1, [Atoms, molecules, ions, stoichiometry], [1.1–1.3, 2.1–2.8, 3.1–3.6])

#lecture[Like any subject, chemistry has its own language. This chapter teaches the alphabet (atoms and elements), the words (molecules, ions, compounds) and the sentences (chemical reactions). It also introduces the most-used tool of the whole course: the mole.]

== The language of chemistry

#idea[Chemistry is the study of the *properties and behaviour of matter*. A mechanical engineer asks "how strong is this beam?", a chemist asks "what is the beam made of, and why does it rust?". To answer such questions we need words for the building blocks of matter and for the ways they change into one another.]

A useful analogy, used throughout the lecture:

#table(columns: (auto, auto, 1fr),
  [*Language*], [*Chemistry*], [*Meaning*],
  [letters], [atoms], [smallest unit of an element],
  [alphabet], [elements], [substances made of only one type of atom (118 known)],
  [words], [molecules], [two or more atoms held together],
  [words], [compounds], [molecules or solids with _different_ types of atoms],
  [sentences], [reactions], [describe chemical changes: one substance becomes another])

With only 118 letters, nature writes millions of different words. Just as you can read any English word if you know the alphabet and spelling rules, you will be able to make sense of most substances once you know the elements and the rules by which they bond (Chapters 6 and 7).

=== Pure substances and mixtures

#defn[Pure substance and mixture][
  A *pure substance* has a fixed composition that does not change from sample to sample, and therefore distinct, reproducible properties. Elements and compounds are pure substances.

  A *mixture* contains two or more pure substances. If its composition, properties and appearance are the same everywhere, it is *homogeneous* (also called a *solution*). Otherwise it is *heterogeneous*.]

#fg("c01_matter", [Classification of matter. Mixtures can be separated by physical means (filtering, distilling); compounds only by chemical reactions.], w: 92%)

#ex[Water, mineral water, milk][
  - *Pure water* is a pure substance (a compound, #ce("H2O")). Every drop has the same composition.
  - *Mineral water* is a homogeneous mixture: water plus dissolved ions such as #ce("Ca^2+"), #ce("Mg^2+") and #ce("HCO3^-"). You cannot see the ions, and every sip tastes the same, but the composition differs from brand to brand.
  - *Milk* is a heterogeneous mixture: fat droplets suspended in water. Under a microscope you see the droplets, and if milk stands long enough the cream separates.
]

#check[Is air a pure substance?][No. Air is a homogeneous mixture of mainly #ce("N2") (78 %), #ce("O2") (21 %) and Ar (1 %). Its composition can vary (e.g. humidity, #ce("CO2") in a crowded lecture hall).]

=== Physical versus chemical properties

A *physical change* changes the form of a substance but not its identity: ice melting, water boiling, sugar dissolving. A *chemical change* (a reaction) turns substances into new substances with different composition: iron rusting, wood burning, hydrogen and oxygen forming water. A good test: after a physical change you get the same substance back by reversing the conditions (cool the steam). After a chemical change the original substances are gone.

== Atoms and atomic structure

=== Dalton's atomic theory

Today everybody "knows" that matter is made of atoms, but this was not obvious at all. John Dalton (1803–1807) collected the evidence into a theory:

+ Each element is composed of extremely small particles, *atoms*.
+ All atoms of a given element are chemically identical; atoms of different elements are different.
+ Atoms are not changed, created or destroyed by chemical reactions. Reactions only *rearrange* them.
+ Compounds are combinations of atoms of two or more elements in fixed ratios.

This theory immediately explains three experimental laws:

#law[Three laws explained by atoms][
  - *Law of constant composition:* in a given compound, the relative numbers and kinds of atoms are fixed. Water is always 11.2 % H and 88.8 % O by mass, wherever it comes from.
  - *Law of conservation of mass:* the total mass does not change in a chemical reaction, because the atoms are only regrouped.
  - *Law of multiple proportions:* if two elements form more than one compound, the masses of one element that combine with a fixed mass of the other are in ratios of small whole numbers.]

#ex[Multiple proportions in CO and #ce("CO2")][
  In carbon monoxide, 12 g of carbon combine with 16 g of oxygen. In carbon dioxide, 12 g of carbon combine with 32 g of oxygen. The ratio of oxygen masses is $32 : 16 = 2 : 1$, a small whole-number ratio. With atoms this is obvious: one molecule contains one O atom per C atom, the other two.
]

=== Electrons, protons and neutrons

We now know that atoms are themselves built from even smaller *subatomic particles*:

#table(columns: (auto, auto, auto, auto),
  [*particle*], [*charge*], [*mass*], [*where?*],
  [electron], [$-e$], [$9.11 times 10^(-31)$ kg], [electron cloud],
  [proton], [$+e$], [$1.67 times 10^(-27)$ kg], [nucleus],
  [neutron], [$0$], [$1.67 times 10^(-27)$ kg], [nucleus])

with the elementary charge $e = 1.60 times 10^(-19)$ C. Two facts to note: a neutral atom has *equal numbers of protons and electrons*, and protons and neutrons are about *1836 times heavier* than electrons. Almost all the mass of an atom sits in the nucleus.

#intu[*How empty is an atom?* The nucleus has a diameter of about $10^(-4)$ Å, the electron cloud about 1–5 Å ($1 "Å" = 10^(-10)$ m). If the electron cloud were a football pitch, the nucleus would be a grain of about 1 mm in the centre. Nuclear matter is incredibly dense, about $10^(14) "g/cm"^3$: a matchbox filled with it would weigh 2.6 billion tonnes. Everything you touch is mostly empty space, held "solid" by the electrons repelling each other.]

=== Atomic number, mass number and isotopes

#defn[Atomic number $Z$][The *atomic number* is the number of protons in the nucleus. It defines the element: every carbon atom in the universe has $Z = 6$, every oxygen atom $Z = 8$. In a neutral atom, $Z$ is also the number of electrons.]

#remember[The *chemical* properties of an atom are determined by its *electrons*. The nucleus only fixes how many electrons there are. This is why the whole of chemistry is really the science of electrons (Chapters 6 and 7).]

The number of *neutrons* in atoms of one element can vary.

#defn[Isotopes, mass number][*Isotopes* are atoms of the same element (same $Z$) with different numbers of neutrons. The *mass number* $A$ is the number of protons plus neutrons. Isotopes have different masses but (almost) identical chemistry.

Notation: mass number top left, atomic number bottom left,
$ attach("C", tl: 12, bl: 6) quad "(6 protons, 6 neutrons)", quad attach("C", tl: 14, bl: 6) quad "(6 protons, 8 neutrons)". $
The atomic number is redundant once the symbol is given, so one usually writes just #super[12]C or carbon-12.]

Many isotopes are stable, but some are unstable and decay by emitting particles and energy (*radioactivity*). Natural uranium is 99.28 % #super[238]U and only 0.71 % #super[235]U, and it is the rare #super[235]U that nuclear reactors need.

#everyday[*Radiocarbon dating.* Living organisms take up carbon from #ce("CO2"), including a tiny, constant fraction of radioactive #super[14]C. After death no new carbon comes in and the #super[14]C decays with a half-life of 5730 years (a first-order process, Chapter 10). Measuring the remaining fraction tells archaeologists how old a bone or a piece of wood is. *Isotope enrichment* (increasing the #super[235]U fraction from 0.7 % to 3–5 %) is one of the most energy-intensive industrial processes in nuclear engineering, precisely because isotopes are chemically almost identical and must be separated by their tiny mass difference.]

=== Atomic mass and atomic weight

Kilograms are a terrible unit for atoms. We define a new mass scale:

#defn[Atomic mass unit][The *atomic mass unit* (u or amu) is defined such that one atom of #super[12]C has a mass of exactly 12 u:
$ 1 "u" = 1.66054 times 10^(-27) "kg". $
On this scale $m_p = 1.0073$ u, $m_n = 1.0087$ u, $m_e = 5.486 times 10^(-4)$ u.]

#defn[Atomic weight][The *atomic weight* of an element is the average atomic mass of its naturally occurring isotopes, weighted by their relative abundance:
$ "atomic weight" = sum_("isotopes") ("fractional abundance") times ("isotope mass"). $
This is the number printed in the periodic table.]

#ex[Atomic weight of carbon][
  Natural carbon is 98.93 % #super[12]C (12 u exactly) and 1.07 % #super[13]C (13.0035 u), plus a trace of #super[14]C:
  $ (0.9893 times 12 "u") + (0.0107 times 13.0035 "u") = 12.01 "u". $
  This is why the periodic table lists 12.01 and not 12 for carbon. No single carbon atom has a mass of 12.01 u. It is an average, like "1.6 children per family".
]

== The periodic table

In 1869 Dmitri Mendeleev arranged the known elements by increasing mass and noticed that chemical properties repeat periodically. The modern table orders all 118 known elements by atomic number.

#fg("c01_ptable", [The periodic table. Columns are *groups* (chemically similar elements), rows are *periods*. The colours mark metals, metalloids and nonmetals. Lu and Lr are counted with the lanthanides and actinides.])

- *Groups* (columns, 1–18): elements in the same group behave similarly. Group 1 (alkali metals) all react violently with water, group 17 (halogens) are all reactive nonmetals, group 18 (noble gases) are all inert.
- *Periods* (rows, 1–7): properties change systematically along a row.
- *Metals* (left and centre, the vast majority): shiny, conduct heat and electricity, ductile, tend to *lose* electrons.
- *Nonmetals* (top right): often gases or brittle solids, poor conductors, tend to *gain* electrons.
- *Metalloids* (along the boundary: B, Si, Ge, As, Sb, Te): in between. Silicon, a semiconductor, is the most famous.

Common names to know: *alkali metals* (group 1), *alkaline earth metals* (group 2), *transition metals* (groups 3–12), *chalcogens* (group 16), *halogens* (group 17), *noble gases* (group 18), *lanthanides* (rare earths) and *actinides*.

#why[the table has this shape][The shape is not arbitrary: it is the shape of quantum mechanics. Each block (s, p, d, f) corresponds to one type of electron orbital being filled. The widths 2, 6, 10 and 14 are the numbers of electrons that fit into s, p, d and f subshells. We will see this in Chapter 6.]

== Molecules and their representations

Only the noble gases exist as isolated atoms. Most matter consists of *molecules* or *ions*.

#defn[Molecule, chemical formula][A *molecule* is an assembly of two or more atoms tightly bound together. Its *molecular formula* gives the actual number of each kind of atom (#ce("H2O"), #ce("C6H6")). The *empirical formula* gives only the smallest whole-number ratio (#ce("CH") for benzene #ce("C6H6")).]

A formula does not tell you how the atoms are connected or what the molecule looks like in 3D. Chemists use several representations, each with its own strengths:

#fg("c01_methane", [Five ways to represent methane. The structural formula shows connectivity but not shape. The perspective drawing shows 3D shape (solid wedge: towards you, hashed wedge: away from you). Ball-and-stick shows bond angles; space-filling shows the true size of the electron clouds.])

== Ions and ionic compounds

#defn[Ion][An *ion* is an electrically charged atom or molecule.
- *Cation:* positive charge, electrons have been *removed* (#ce("Na^+"), #ce("Ca^2+")).
- *Anion:* negative charge, electrons have been *added* (#ce("Cl^-"), #ce("O^2-")).
We write the charge as a multiple of $e$ with the sign after the number: #ce("Fe^3+"), #ce("SO4^2-").]

Atoms at the edges of the periodic table tend to gain or lose electrons until they have the *same number of electrons as the nearest noble gas*. This lets you predict the charge of many ions just from the group:

#table(columns: (auto, auto, auto, auto, auto, auto),
  [*group*], [1], [2], [13], [16], [17],
  [*typical ion*], [#ce("M^+")], [#ce("M^2+")], [#ce("M^3+")], [#ce("X^2-")], [#ce("X^-")],
  [*examples*], [#ce("Na^+"), #ce("K^+")], [#ce("Mg^2+"), #ce("Ca^2+")], [#ce("Al^3+")], [#ce("O^2-"), #ce("S^2-")], [#ce("F^-"), #ce("Cl^-")])

#micro[Sodium has 11 electrons, one more than neon. Losing that one electron gives #ce("Na^+") with neon's 10 electrons. Chlorine has 17 electrons, one less than argon. Gaining one gives #ce("Cl^-") with argon's 18. Note that the *size* changes too: a cation is smaller than its atom (an outer electron is gone and the rest is pulled in more tightly), an anion is larger.]

*Polyatomic ions* are groups of atoms carrying a net charge, e.g. ammonium #ce("NH4^+"), hydroxide #ce("OH^-"), nitrate #ce("NO3^-"), carbonate #ce("CO3^2-"), sulfate #ce("SO4^2-"), phosphate #ce("PO4^3-"), acetate #ce("CH3COO^-"). Learn the most common ones by heart; they appear everywhere.

=== Ionic compounds

#defn[Ionic compound][An *ionic compound* is formed between cations and anions, typically between a *metal* and a *nonmetal*. Electrons are transferred from the metal to the nonmetal; the oppositely charged ions then attract each other and form a 3D lattice. Ionic compounds are *electrically neutral* overall.]

Because an ionic solid is a huge 3D lattice and not a discrete molecule, we always write its *empirical formula*: NaCl means "Na and Cl in a 1:1 ratio", not a molecule of two atoms.

#photo(("halite",), [Rock salt (halite, NaCl). The crystals are cubes because the ions are stacked in a cubic lattice: every #ce("Na^+") is surrounded by six #ce("Cl^-") and vice versa. The shape you can see with your eyes reflects the arrangement of the ions. #credit[James St. John, CC BY 2.0, Wikimedia Commons]], ht: 4.4cm)

#recipe[writing the formula of an ionic compound][
  + Write the cation and the anion with their charges.
  + Choose the smallest whole-number subscripts that make the total charge zero. A quick way: the charge number of one ion becomes the subscript of the other ("crossing over"), then reduce.
  + Polyatomic ions that need a subscript get brackets.
  Examples: #ce("Ca^2+") + #ce("Cl^-") → #ce("CaCl2"). #ce("Al^3+") + #ce("O^2-") → #ce("Al2O3"). #ce("Ca^2+") + #ce("PO4^3-") → #ce("Ca3(PO4)2"). #ce("Mg^2+") + #ce("O^2-") → #ce("Mg2O2") → reduce → MgO.]

=== Naming inorganic compounds (Brown 2.8, in brief)

- *Cations* keep the element name: sodium ion, calcium ion. For metals with several charges, give the charge in Roman numerals: iron(II) #ce("Fe^2+"), iron(III) #ce("Fe^3+").
- *Monatomic anions* end in _-ide_: chloride #ce("Cl^-"), oxide #ce("O^2-"), sulfide #ce("S^2-"). Also hydroxide #ce("OH^-") and cyanide #ce("CN^-").
- *Oxyanions:* the one with more oxygen ends in _-ate_, the one with less in _-ite_: nitrate #ce("NO3^-") / nitrite #ce("NO2^-"), sulfate #ce("SO4^2-") / sulfite #ce("SO3^2-").
- *Ionic compounds:* cation name, then anion name: sodium chloride, iron(III) oxide #ce("Fe2O3"), ammonium nitrate #ce("NH4NO3").
- *Acids:* _-ide_ → hydro…_-ic_ acid (HCl hydrochloric acid); _-ate_ → _-ic_ acid (#ce("H2SO4") sulfuric acid); _-ite_ → _-ous_ acid (#ce("H2SO3") sulfurous acid).
- *Binary molecular compounds* (two nonmetals) use Greek prefixes: carbon *di*oxide #ce("CO2"), *di*nitrogen *tetr*oxide #ce("N2O4"), sulfur *hexa*fluoride #ce("SF6").

== Chemical reactions and balancing equations

#defn[Chemical reaction][A *chemical reaction* changes one or more substances (*reactants*) into new substances (*products*). It is described by a *chemical equation*
$ "reactants" quad -> quad "products". $
Rules: atoms are neither created nor destroyed; energy may be needed to start a reaction; energy may be released or absorbed.]

#fg("c01_h2o2", [Two hydrogen molecules and one oxygen molecule become two water molecules. Bonds are broken and new ones formed, but every atom is still there.], w: 80%)

Since atoms are conserved, *each type of atom must appear the same number of times on both sides*. The equation #ce("H2 + O2 -> H2O") is wrong: it has 2 O on the left and 1 O on the right. We fix it by placing *coefficients* in front of the formulas:
#rxn("2 H2(g) + O2(g) -> 2 H2O(l)")
The letters in brackets give the state: (s) solid, (l) liquid, (g) gas, (aq) dissolved in water.

#mistake[*Never change subscripts to balance an equation.* Writing #ce("H2O2") instead of #ce("H2O") balances the oxygen, but #ce("H2O2") is hydrogen peroxide, a completely different substance (a bleach!). Subscripts define *what* the substance is; coefficients say *how many* of them react.]

#recipe[balancing an equation][
  + *Inspection* (usually enough): start with the element that appears in the fewest formulas; balance H and O last; treat polyatomic ions that survive unchanged as one unit.
  + *Systematic method* (for hard cases): write unknown coefficients $a, b, c, dots$, write one equation per element, set one coefficient to 1 and solve. Multiply by the common denominator to get integers.
  + *Check:* count every element on both sides.]

#ex[Systematic balancing][
  #step[Set up.] $a ce("H2") + b ce("O2") -> c ce("H2O")$.

  #step[One equation per element.] H: $2a = 2c$, so $a = c$. O: $2b = c$.

  #step[Solve.] Set $a = 1$: then $c = 1$ and $b = 1/2$. Multiplying everything by 2 gives integers: $a = 2$, $b = 1$, $c = 2$.
]

#ex[Combustion of propane][
  Balance #ce("C3H8 + O2 -> CO2 + H2O").

  #step[C first.] 3 C on the left, so 3 #ce("CO2").
  #step[H next.] 8 H on the left, so 4 #ce("H2O").
  #step[O last.] Right side: $3 dot 2 + 4 dot 1 = 10$ O atoms, so 5 #ce("O2").
  #rxn("C3H8(g) + 5 O2(g) -> 3 CO2(g) + 4 H2O(l)")
  #step[Check.] C: 3 = 3, H: 8 = 8, O: 10 = 10. ✓
]

== Formula weight, the mole and molar mass

=== Formula weight

#defn[Formula weight][The *formula weight* (FW) is the sum of the atomic weights of all atoms in the formula. For a molecular substance it is also called the *molecular weight* $M_w$. For ionic solids it refers to the empirical formula.

Example: #ce("H2O"): $"FW" = 2 times 1.0 "u" + 1 times 16.0 "u" = 18.0 "u"$, the mass of one water molecule.]

=== Why we need the mole

#ex[The hard way: grams of #ce("O2") that react with 2.00 g of #ce("H2")][
  The reaction is #ce("2 H2 + O2 -> 2 H2O"). FW(#ce("H2")) = 2.00 u, FW(#ce("O2")) = 32.0 u. We convert step by step (dimensional analysis):
  $ 2.00 "g H"_2 dot (1 "kg")/(1000 "g") dot (1 "u")/(1.66 times 10^(-27) "kg") dot (1 "molecule H"_2)/(2.00 "u") = 6.02 times 10^(23) "molecules H"_2 $
  The equation says 2 #ce("H2") react with 1 #ce("O2"), so we need $3.01 times 10^(23)$ molecules of #ce("O2"):
  $ 3.01 times 10^(23) dot (32.0 "u")/(1 "molecule") dot (1.66 times 10^(-27) "kg")/(1 "u") dot (1000 "g")/(1 "kg") = 16.0 "g O"_2. $
  Two lessons: (1) the answer is *not* 1.00 g, because the molecules react in a 2:1 ratio *by number* and have very different masses; (2) this is tedious. There must be an easier way.
]

Notice the strange number $6.02 times 10^(23)$ that appeared when we converted 2.00 g of #ce("H2") (FW 2.00 u). It would appear for *any* substance if we take its formula weight in grams. That is the idea of the mole.

#defn[Mole, Avogadro's number][One *mole* (mol) is the amount of substance that contains
$ N_A = 6.022 times 10^(23) $
particles (atoms, molecules, ions, electrons, …). $N_A$ is *Avogadro's number*. The number is chosen such that the mass of one mole of a substance in grams equals its formula weight in u.]

#defn[Molar mass][The *molar mass* $M$ of a substance is the mass of one mole, in g/mol. Numerically it equals the formula weight:
$ M(ce("H2O")) = 18.0 "g/mol", quad M(ce("K")) = 39.10 "g/mol", quad M(ce("NaCl")) = 58.44 "g/mol". $]

#intu[A mole is a counting unit like a *dozen* (12) or a *gross* (144), just much bigger. Chemists need such a huge unit because atoms are so tiny: a mole of water is only 18 g, a large sip. $N_A$ is hard to imagine: $6 times 10^(23)$ marbles would cover the whole surface of the Earth in a layer about 5 km thick.]

#fg("c01_molemap", [The mole is the hub of every calculation. Masses (what you weigh) and particle numbers (what reacts) are both converted through the amount $n$ in mol.], w: 88%)

#formula[The three conversions][
  $ n = m/M, quad quad N = n dot N_A, quad quad m = n dot M. $]

=== Percent composition and empirical formulas

The *mass percent* of an element in a compound is
$ "mass % of X" = ("(number of X atoms)" times "(atomic weight of X)")/("formula weight of compound") times 100 %. $

#ex[Empirical formula from a combustion analysis][
  A compound contains 40.0 % C, 6.7 % H and 53.3 % O by mass. Find its empirical formula.

  #step[Assume 100 g.] Then we have 40.0 g C, 6.7 g H, 53.3 g O.
  #step[Convert to moles.] C: $40.0\/12.01 = 3.33$ mol; H: $6.7\/1.008 = 6.65$ mol; O: $53.3\/16.00 = 3.33$ mol.
  #step[Divide by the smallest.] C : H : O = 1 : 2.00 : 1.
  #step[Result.] Empirical formula #ce("CH2O"). If the molar mass is measured as 180 g/mol, the molecular formula is $(ce("CH2O"))_6 = ce("C6H12O6")$ (glucose), since $180\/30 = 6$.
]

== Reaction stoichiometry

#defn[Stoichiometry][*Stoichiometry* is the quantitative relationship between the amounts of reactants consumed and products formed. Its key is the balanced equation: the *coefficients give mole ratios*.]

For #ce("2 H2 + O2 -> 2 H2O"): 2 mol #ce("H2") react with 1 mol #ce("O2") and give 2 mol #ce("H2O"). The coefficients do *not* give mass ratios.

#fg("c01_stoichmap", [The road map for every stoichiometry problem. You can never go directly from grams of A to grams of B.], w: 92%)

#ex[The same problem, the easy way][
  How many grams of #ce("O2") react with 2.00 g of #ce("H2")?
  $ n(ce("H2")) = (2.00 "g")/(2.016 "g/mol") = 0.992 "mol", quad n(ce("O2")) = 1/2 n(ce("H2")) = 0.496 "mol", $
  $ m(ce("O2")) = 0.496 "mol" times 32.00 "g/mol" = 15.9 "g". $
  Three lines instead of a page. Mass is conserved: 2.00 g + 15.9 g = 17.9 g of water.
]

=== Limiting reactant and yield

In practice the reactants are rarely mixed in exactly the stoichiometric ratio. The reactant that runs out first is the *limiting reactant*; it determines how much product can form. The others are *in excess*.

#intu[Making sandwiches: one sandwich needs 2 slices of bread and 1 slice of cheese. With 10 slices of bread and 7 slices of cheese you can make 5 sandwiches. Bread is the limiting reactant, 2 slices of cheese are left over. It does not matter that you have "more" cheese in some other sense; what matters is the ratio set by the recipe.]

#recipe[limiting reactant][
  + Convert every reactant to moles.
  + Divide each by its coefficient. The smallest result identifies the limiting reactant.
  + Calculate all products from the limiting reactant (this is the *theoretical yield*).
  + *Percent yield* = actual yield / theoretical yield × 100 %.]

#ex[Ammonia synthesis][
  3.0 mol #ce("N2") and 6.0 mol #ce("H2") react: #ce("N2 + 3 H2 -> 2 NH3"). Divide by the coefficients: #ce("N2"): $3.0\/1 = 3.0$; #ce("H2"): $6.0\/3 = 2.0$. Hydrogen is limiting. It gives $6.0 times 2\/3 = 4.0$ mol #ce("NH3") and consumes $2.0$ mol #ce("N2"); 1.0 mol #ce("N2") is left over.
]

#everyday[*The hydrogen economy (research at D-MAVT).* Excess electricity from wind, hydro or solar can split water by electrolysis, #ce("2 H2O(l) -> 2 H2(g) + O2(g)"). The hydrogen is stored and later burned in a high-efficiency gas turbine, #ce("2 H2(g) + O2(g) -> 2 H2O(g)"), to produce electricity at peak demand. The result is a carbon-neutral cycle. Stoichiometry tells the engineer, for example, that 1 kg of #ce("H2") needs 8 kg of #ce("O2") (taken from air) and produces 9 kg of water vapour. The same bookkeeping applies to car airbags (#ce("2 NaN3 -> 2 Na + 3 N2"): 65 g of sodium azide give about 34 L of nitrogen gas in 30 ms) and to rocket propellants.]

// ALLTAG-BEGIN
== More from everyday life and the professions

#everyday[*The airbag is a stoichiometry problem.* In a collision a sensor ignites sodium azide: $2 thin "NaN"_3 -> 2 thin "Na" + 3 thin "N"_2$. Three moles of nitrogen gas form from every two moles of azide, and that gas inflates the bag in about $30$ ms. Engineers choose the mass of azide so that exactly the right volume of gas forms (about $60$ L for a driver bag). Too little and the bag is soft; too much and it injures the occupant. The sodium is then converted into harmless compounds by other ingredients.]

#everyday[*The pharmacist counts in moles.* A tablet of $500$ mg aspirin ($M = 180.16$ g/mol) contains $0.500 slash 180.16 = 2.78$ mmol. Dosing, blood concentrations and drug interactions are all given per mole or per litre, because molecules, not grams, are what meet in the body. In a hospital laboratory, a blood glucose of $5$ mmol/L is normal; the same value in older units is $90$ mg/dL. The moles are the common language.]
// ALLTAG-END

#problems()

#prob[Subatomic particles][
  How many protons, neutrons and electrons are in (a) #super[56]Fe, (b) #super[56]#ce("Fe^3+"), (c) #super[37]#ce("Cl^-")?
][
  Fe has $Z = 26$, Cl has $Z = 17$.
  (a) 26 p, $56 - 26 = 30$ n, 26 e. (b) 26 p, 30 n, $26 - 3 = 23$ e (three electrons removed). (c) 17 p, $37 - 17 = 20$ n, $17 + 1 = 18$ e.
]

#prob[Atomic weight of chlorine][
  Chlorine has two stable isotopes: #super[35]Cl (34.969 u, 75.78 %) and #super[37]Cl (36.966 u, 24.22 %). Calculate the atomic weight.
][
  $ 0.7578 times 34.969 "u" + 0.2422 times 36.966 "u" = 26.50 + 8.953 = 35.45 "u". $
  Exactly the value in the periodic table. The average lies closer to 35 because #super[35]Cl is three times more abundant.
]

#prob[Formulas and names][
  (a) Write the formulas of aluminium sulfate, iron(III) hydroxide and ammonium phosphate. (b) Name #ce("Cu(NO3)2"), #ce("K2CO3") and #ce("N2O5").
][
  (a) #ce("Al^3+") and #ce("SO4^2-"): #ce("Al2(SO4)3"). #ce("Fe^3+") and #ce("OH^-"): #ce("Fe(OH)3"). #ce("NH4^+") and #ce("PO4^3-"): #ce("(NH4)3PO4").
  (b) Copper(II) nitrate (#ce("NO3^-") has charge $-1$, two of them, so Cu is $+2$). Potassium carbonate. Dinitrogen pentoxide (two nonmetals, Greek prefixes).
]

#prob[Balancing][
  Balance (a) #ce("Fe + O2 -> Fe2O3"), (b) #ce("C2H6 + O2 -> CO2 + H2O"), (c) #ce("Al + HCl -> AlCl3 + H2").
][
  (a) O: 2 and 3, so 3 #ce("O2") and 2 #ce("Fe2O3"); then 4 Fe: #ce("4 Fe + 3 O2 -> 2 Fe2O3").

  (b) C: 2 #ce("CO2"); H: 3 #ce("H2O"); O on the right: $4 + 3 = 7$, so $7\/2$ #ce("O2"). Multiply by 2: #ce("2 C2H6 + 7 O2 -> 4 CO2 + 6 H2O").

  (c) Cl: 3 HCl per #ce("AlCl3"); H then 3 H, i.e. $3\/2$ #ce("H2"). Multiply by 2: #ce("2 Al + 6 HCl -> 2 AlCl3 + 3 H2").
]

#prob[Moles and particles][
  A drop of water has a volume of 0.050 mL (density 1.00 g/mL). How many molecules and how many hydrogen atoms does it contain?
][
  $m = 0.050$ g, $n = 0.050\/18.02 = 2.77 times 10^(-3)$ mol.
  $N = n N_A = 2.77 times 10^(-3) times 6.022 times 10^(23) = 1.67 times 10^(21)$ molecules, and twice as many H atoms: $3.3 times 10^(21)$. A single drop holds more molecules than there are grains of sand on all the beaches of the Earth (about $10^(19)$).
]

#prob[Limiting reactant and yield][
  10.0 g of #ce("H2") and 64.0 g of #ce("O2") react to form water. (a) Which reactant is limiting? (b) How much water forms? (c) In an experiment 63.0 g water is collected. What is the percent yield?
][
  (a) $n(ce("H2")) = 10.0\/2.016 = 4.96$ mol, $n(ce("O2")) = 64.0\/32.00 = 2.00$ mol. Divide by coefficients (2 and 1): 2.48 vs 2.00. #ce("O2") is limiting.

  (b) $n(ce("H2O")) = 2 times 2.00 = 4.00$ mol, $m = 4.00 times 18.02 = 72.1$ g. (#ce("H2") used: 4.00 mol = 8.06 g; 1.94 g left over.)

  (c) $63.0\/72.1 times 100 % = 87.4 %$.
]

#prob[Cement and #ce("CO2")][
  How many tonnes of #ce("CO2") are released by decomposing 1.00 t of limestone #ce("CaCO3")? What volume does this gas occupy at 0 °C and 1 atm (22.4 L/mol, see Chapter 2)?
][
  #ce("CaCO3 -> CaO + CO2"), 1:1. $M(ce("CaCO3")) = 100.09$ g/mol, $M(ce("CO2")) = 44.01$ g/mol.
  $ n = (1.00 times 10^6 "g")/(100.09 "g/mol") = 9.99 times 10^3 "mol", quad m(ce("CO2")) = 9.99 times 10^3 times 44.01 "g" = 0.440 "t". $
  Volume: $9.99 times 10^3 "mol" times 22.4 "L/mol" = 2.24 times 10^5 "L" = 224 "m"^3$, the volume of a small house, from one tonne of stone.
]

#summary[
  - Matter: pure substances (elements, compounds) vs. mixtures (homogeneous, heterogeneous).
  - Atom = nucleus (protons $Z$, neutrons) + electrons. $Z$ defines the element; electrons determine chemistry. Isotopes differ in neutron number. Mass number $A$ = protons + neutrons.
  - $1 "u" = 1.66 times 10^(-27)$ kg; atomic weight = abundance-weighted average of isotope masses.
  - Periodic table: groups (similar chemistry), periods; metals lose electrons (cations), nonmetals gain them (anions), aiming for a noble-gas electron count.
  - Ionic compounds: metal + nonmetal, neutral overall, written with empirical formula.
  - Balance equations with *coefficients*, never subscripts. Coefficients are *mole* ratios.
  - $N_A = 6.022 times 10^(23) "mol"^(-1)$; $n = m\/M$; molar mass in g/mol = formula weight in u.
  - Stoichiometry: grams → moles → (coefficient ratio) → moles → grams. Limiting reactant decides the yield.
]
