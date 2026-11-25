#import "lib.typ": *

= Chemical Bonding and Molecular Geometry

#lec(7, [Chemical bonding, molecular shape], [8.1–8.8, 5.8, 9.1–9.2])

#lecture[Atoms and ions are held together in molecules and solids by chemical bonds. Bonds decide whether a substance is a gas or a rock, whether it conducts electricity, how much energy it stores, and what shape its molecules have. Shape in turn decides polarity, boiling points and how molecules recognise each other (Chapter 8).]

== Types of chemical bonds

Bonds involve the *valence electrons* (v.e.), typically those in the outermost shell. There are three idealised types:

#table(columns: (auto, 1fr, auto),
  [*bond type*], [*what holds the atoms together*], [*example*],
  [ionic], [electrostatic attraction between cations and anions (electrons transferred)], [NaCl, ionic solid],
  [covalent], [shared pairs of valence electrons between two atoms], [#ce("H2O") molecules],
  [metallic], [valence electrons shared by the entire solid ("electron sea")], [Ag(s), Cu(s), steel])

=== Lewis symbols and the octet rule

To discuss bonding we use a simple bookkeeping tool introduced by G. N. Lewis.

#defn[Lewis symbol][The chemical symbol of an element surrounded by one dot per valence electron. Place at most 2 dots on each of the 4 sides and spread them out before pairing; the four sides are equivalent.]

#fg("c07_lewis", [Lewis symbols of the period-2 elements. The number of dots is the number of valence electrons, which equals the group number for main-group elements (minus 10 for groups 13–18).], w: 90%)

#law[Octet rule][Atoms tend to gain, lose or share electrons until they are surrounded by *eight valence electrons*, the stable noble-gas configuration $n s^2 n p^6$. (Hydrogen aims for two, like helium.)]

The octet rule has exceptions (Section 7.6), but it is still extremely useful, especially for atoms whose valence electrons are in s and p subshells.

== Ionic bonding

Metal atoms (low ionisation energy) lose their valence electrons; nonmetal atoms (very negative electron affinity) gain them. Both end up with a noble-gas configuration:
#rxn("Na (1 v.e.) + Cl (7 v.e.) -> Na^+ + Cl^- (8 v.e.) -> NaCl(s)")

#why[is this favourable?][Taking an electron from Na *costs* energy ($I_1 = 496$ kJ/mol), and giving it to Cl only returns 349 kJ/mol. On its own, the electron transfer is uphill. The payoff comes afterwards: the oppositely charged ions *attract* each other strongly and pack into a crystal lattice. That releases far more energy than the transfer cost.]

#defn[Lattice energy][The energy required to completely separate one mole of a solid ionic compound into its gaseous ions:
$ ce("NaCl(s) -> Na^+(g) + Cl^-(g)"), quad Delta H_"lattice" = +788 "kJ/mol". $
The reverse, forming the crystal from the gaseous ions, is strongly exothermic.]

The lattice energy can be calculated by combining many ideas we have already met: Hess's law, $Delta H_f^degree$, ionisation energy and electron affinity (the *Born–Haber cycle*, Brown p. 376). Its size follows Coulomb's law: the potential energy of two charges $Q_1, Q_2$ at distance $d$ is $E prop Q_1 Q_2 \/ d$.

#remember[Lattice energy *increases with the ion charges* and *decreases with the ion sizes*. MgO (#ce("Mg^2+"), #ce("O^2-"): charge product 4) has a lattice energy of 3795 kJ/mol, almost five times that of NaCl. That is why MgO melts at 2852 °C and is used as refractory lining in furnaces, while NaCl melts at 801 °C.]

== Covalent bonding

Most substances are not ionic. Two nonmetals both want electrons; neither gives them away. Instead they *share* them.

#defn[Covalent bond][A pair of valence electrons shared between two atoms. The shared pair is the "glue" between the two positively charged nuclei. Each atom counts the shared electrons towards its octet.]

#fg("c07_simple", [Lewis structures of simple molecules. A line is a shared pair (bonding pair); dots are *lone pairs* (non-bonding pairs).], w: 82%)

#grid(columns: (1fr, 6.0cm), column-gutter: 12pt, align: horizon,
  [#micro[When two H atoms approach, each electron is attracted by *both* nuclei. The energy decreases until, at very short distance, the two nuclei begin to repel each other strongly. The minimum of the energy curve defines the *bond length* (74 pm for #ce("H2")); its depth is the energy needed to break the bond, the *bond enthalpy* (436 kJ/mol).]],
  figure(image("figs/c07_h2curve.svg"), caption: [Energy of two H atoms versus distance.]))

=== Multiple bonds

Atoms can share more than one pair:
- *single bond:* one shared pair (H–H, Cl–Cl);
- *double bond:* two shared pairs (O=C=O);
- *triple bond:* three shared pairs (N≡N).

The more shared pairs, the *shorter and stronger* the bond:

#table(columns: (auto, auto, auto, auto),
  [*bond*], [N–N], [N=N], [N≡N],
  [*length (pm)*], [147], [124], [110],
  [*bond enthalpy (kJ/mol)*], [163], [418], [941])

#everyday[*Why the air does not burn, and why fertiliser is expensive.* The N≡N triple bond (941 kJ/mol) is one of the strongest bonds known. That makes #ce("N2"), 78 % of air, almost inert: it does not take part in combustion and protects reactive materials as a cheap inert gas (food packaging, welding, tyre filling). Breaking it to make ammonia for fertiliser (Haber–Bosch) needs 450 °C, 200 bar and a catalyst, and consumes about 1–2 % of the world's energy supply.]

== Bond polarity and electronegativity

A Lewis structure suggests that the bonding pair is shared *equally*. Often it is not.

#defn[Bond polarity][In a *nonpolar covalent bond* the electrons are shared equally (#ce("Cl2"), #ce("N2"): identical atoms). In a *polar covalent bond* one atom attracts the bonding electrons more strongly than the other (HF, O–H).]

#defn[Electronegativity $chi$][The ability of an atom *in a molecule* to attract the shared electrons to itself. Linus Pauling defined a dimensionless scale from thermodynamic data; F, the most electronegative element, has 4.0. Electronegative atoms combine a large ionisation energy with a very negative electron affinity.]

#grid(columns: (1fr, 6.2cm), column-gutter: 12pt, align: horizon,
  [
    #law[Trend][Electronegativity *increases to the right* across a period and *upwards* in a group. The most electronegative elements are F, O, N, Cl (top right); the least are Cs and Fr (bottom left).]
    The *difference* $Delta chi$ between the two bonded atoms estimates the polarity of the bond. For HF: $Delta chi = 4.0 - 2.1 = 1.9$, a strongly polar covalent bond. Rule of thumb: if $Delta chi >= 2$, the bond is essentially *ionic* (LiF: $4.0 - 1.0 = 3.0$).
  ],
  figure(image("figs/c07_EN.svg"), caption: [Pauling electronegativities (main groups).]))

#fg("c07_continuum", [There is no sharp border between covalent and ionic bonding, but a continuum governed by the electronegativity difference.], w: 88%)

A polar bond is described with *partial charges*: $attach("H", tr: delta+) - attach("F", tr: delta-)$. $delta^+$ and $delta^-$ are fractions of an elementary charge.

=== Dipole moments

#defn[Dipole moment][Two charges $+Q$ and $-Q$ separated by a distance $r$ form a *dipole* with dipole moment
$ mu = Q r. $
It is a vector. In this course (physics convention) it points from the negative to the positive charge. (Many chemistry books draw the arrow the other way; the magnitude is the same.) Unit: debye, $1 "D" = 3.34 times 10^(-30)$ C m. A proton and an electron 0.1 nm apart give $mu = 4.8$ D.]

HF has $mu = 1.8$ D. Since its bond length is 92 pm, the partial charges are about $1.8\/(4.8 times 0.92) approx 0.41 e$: HF is about 41 % "ionic".

=== Ionic versus covalent: a continuum

- *More covalent* → molecular substances: low melting and boiling points, often gases or liquids.
- *More ionic* → ionic solids: brittle, high melting points.
- The $Delta chi$ rule is useful but not perfect. As the oxidation number of a metal increases, its bonds become more covalent: MnO (Mn +2) is an ionic solid that melts at 1945 °C; #ce("Mn2O7") (Mn +7) is a covalent, oily liquid that melts at 6 °C.

== Drawing Lewis structures

#recipe[Lewis structures][
  + *Sum the valence electrons* of all atoms. For an anion add one electron per negative charge; for a cation subtract one per positive charge.
  + *Write the skeleton* and connect atoms with single bonds (one line = 2 electrons). The central atom is often written first in the formula and is usually the least electronegative (never H).
  + *Complete the octets of the outer atoms* with lone pairs (H only needs 2).
  + *Place remaining electrons on the central atom*, even if it then exceeds an octet.
  + If the central atom has fewer than 8 electrons, *form multiple bonds* by moving lone pairs from outer atoms into bonds.]

#ex[HCN][
  #step[1.] v.e.: $1 + 4 + 5 = 10$.
  #step[2.–5.] Skeleton H–C–N uses 4 electrons. Six go around N, completing its octet. 0 remain for C, which has only 4. Move two lone pairs from N into the C–N bond to form a triple bond. Now C has 8 (2 from H–C, 6 from C≡N), N has 8, H has 2.
  #fg("c07_hcn", [Building the Lewis structure of HCN step by step.], w: 100%)
]

=== Formal charge: choosing between structures

Sometimes several Lewis structures satisfy the octet rule. Which is the best?

#defn[Formal charge][
  $ "formal charge" = ("valence e"^- "of free atom") - 1/2 ("bonding e"^-) - ("non-bonding e"^-). $
  It is the charge an atom would have if all bonding electrons were shared *equally*. The sum of formal charges equals the total charge of the molecule or ion.]

#law[Choosing the dominant structure][The dominant Lewis structure has formal charges *as close to zero as possible*, and any negative formal charge sits on the *more electronegative* atom.]

#ex[Cyanide ion #ce("CN^-") and thiocyanate #ce("SCN^-")][
  #ce("CN^-"): 10 v.e., triple bond, one lone pair on each atom. C: $4 - 3 - 2 = -1$. N: $5 - 3 - 2 = 0$. Sum $-1$ ✓.

  #ce("SCN^-") (16 v.e.) can be drawn as $[ce("S")=ce("C")=ce("N")]^-$ (formal charges S 0, C 0, N −1), as $[ce("S")-ce("C")equiv ce("N")]^-$ (S −1, C 0, N 0) or as $[ce("S")equiv ce("C")-ce("N")]^-$ (S +1, C 0, N −2). The third is clearly poor. Of the first two, the one with the negative charge on N is preferred because N is more electronegative than S. (In reality both contribute; see resonance.)
]

=== Oxidation number, formal charge, partial charge

We now have three ways to assign charge to an atom in a molecule. They answer different questions:

#table(columns: (auto, 1fr, auto),
  [*concept*], [*assumption*], [*H–Cl*],
  [oxidation number], [bonds completely ionic: shared electrons all go to the more electronegative atom (overestimates electronegativity)], [H +1, Cl −1],
  [formal charge], [bonding electrons shared exactly equally (ignores electronegativity)], [H 0, Cl 0],
  [partial charge], [the real distribution, somewhere in between (from experiment or calculation)], [H +0.18, Cl −0.18])

Oxidation numbers are for redox bookkeeping (Chapter 3), formal charges for choosing Lewis structures, partial charges for real physical properties (dipoles, intermolecular forces).

== Resonance and exceptions to the octet rule

=== Resonance structures

#fg("c07_ozone", [The two resonance structures of ozone. Formal charges in red. Experimentally both O–O bonds are identical (128 pm), between a single (148 pm) and a double bond (121 pm).], w: 72%)

Sometimes two or more *completely equivalent* Lewis structures can be drawn. In #ce("O3") (18 v.e.) the central O needs one single and one double bond, but which neighbour gets the double bond? Neither. The real molecule is a *blend* of both *resonance structures*: each O–O bond is "one and a half" bonds. The double-headed arrow ↔ does not mean the molecule flips back and forth; it means the truth lies in between.

#grid(columns: (1fr, 6.6cm), column-gutter: 12pt, align: horizon,
  [*Benzene* #ce("C6H6") is the most famous example: alternating single and double bonds can be drawn in two ways, but all six C–C bonds are identical (140 pm). The electrons of the double bonds are *delocalised* over the whole ring, often drawn as a circle. This delocalisation makes benzene unusually stable.],
  figure(image("figs/c07_benzene.svg"), caption: [Resonance in benzene.]))

#intu[A rhinoceros is sometimes described as a cross between a unicorn and a dragon: you describe a real animal by combining two imaginary ones. A resonance hybrid is the real molecule; the individual resonance structures are imaginary. The hybrid is a mixture of the structures, not an animal that is sometimes a unicorn and sometimes a dragon.]

=== Exceptions to the octet rule

#fg("c07_octetexc", [The three kinds of exceptions to the octet rule.], w: 90%)

+ *Odd number of electrons:* NO (nitric oxide, 11 v.e.) and #ce("NO2") cannot pair all electrons. Such *radicals* are very reactive (NO is a key air pollutant from engines and also a signalling molecule in the body).
+ *Less than an octet:* boron and beryllium compounds, e.g. #ce("BF3") with only 6 electrons on B. Such molecules eagerly accept a lone pair from another molecule (#ce("BF3 + NH3 -> F3B-NH3")).
+ *More than an octet* (*hypervalent* molecules): central atoms from period 3 or beyond, such as #ce("PCl5") (10 electrons on P), #ce("SF6") (12 on S), #ce("XeF4"). These atoms are large enough to fit more neighbours around them.

== Strengths and lengths of covalent bonds

#defn[Bond enthalpy][The enthalpy change for breaking a particular bond in one mole of a gaseous substance, e.g. #ce("Cl2(g) -> 2 Cl(g)"), $D(ce("Cl-Cl")) = 242$ kJ/mol. Always *positive* (breaking a bond costs energy). Tables give *average* values over many molecules.]

#formula[Estimating reaction enthalpies from bond enthalpies][
  $ Delta H_"rxn" approx sum D("bonds broken") - sum D("bonds formed"). $
  Breaking costs energy (+), forming releases energy (−). The reaction is exothermic if the bonds formed are stronger than the bonds broken.]

#table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
  [*bond*], [H–H], [C–H], [O–H], [C–C], [C=O#super[\*]], [O=O], [Cl–Cl], [H–Cl],
  [$D$ (kJ/mol)], [436], [413], [463], [348], [799], [495], [242], [431])
#text(size: 8.5pt)[#super[\*] in #ce("CO2").]

#ex[Combustion of methane from bond enthalpies][
  #rxn("CH4(g) + 2 O2(g) -> CO2(g) + 2 H2O(g)")
  Broken: 4 C–H + 2 O=O $= 4(413) + 2(495) = 2642$ kJ. Formed: 2 C=O + 4 O–H $= 2(799) + 4(463) = 3450$ kJ.
  $ Delta H approx 2642 - 3450 = -808 "kJ". $
  The accurate value (with water vapour) is $-802$ kJ: average bond enthalpies give a good estimate. The energy of fuels is stored in their weak C–H and C–C bonds compared to the very strong C=O and O–H bonds of the products.
]

#mistake[Bond enthalpies apply to *gases*. If a product is liquid, the heat of condensation is missing. And the sign: "broken minus formed", the opposite order from "products minus reactants" for $Delta H_f^degree$. Think: breaking costs, forming pays.]

== Molecular shapes: the VSEPR model

A Lewis structure shows which atoms are bonded, but not the 3D shape. The Lewis structure of #ce("CCl4") is drawn flat, but the real molecule is a tetrahedron. Shape matters enormously: it decides whether a molecule is polar (Chapter 8), how drugs fit into enzymes, how polymers pack.

#law[VSEPR model (valence-shell electron-pair repulsion)][
  - Electrons repel each other, so *electron domains* around a central atom arrange themselves *as far apart as possible*.
  - An *electron domain* is a region of electron density: a lone pair, a single bond, or a multiple bond (a double or triple bond counts as *one* domain).
  - The number of domains determines the *electron-domain geometry*. The *molecular geometry* describes only the positions of the *atoms*.]

#fg("c07_domains", [The five basic electron-domain geometries and their ideal bond angles.])

#intu[Tie two, three, four, five or six balloons together at their necks: they push each other into exactly these shapes. Two balloons point in opposite directions, three form a flat triangle, four a tetrahedron. Electron domains do the same, because they all carry negative charge.]

#recipe[predicting a molecular shape][
  + Draw the Lewis structure.
  + Count the electron domains around the central atom (bonding domains + lone pairs; a multiple bond counts once).
  + Electron-domain geometry from the number of domains (2 linear, 3 trigonal planar, 4 tetrahedral, 5 trigonal bipyramidal, 6 octahedral).
  + Molecular geometry: look only at the atoms.]

#fg("c07_shapes", [Molecular geometries when some domains are lone pairs (LP, blue). In the trigonal bipyramid, lone pairs always occupy the roomier equatorial positions.])

#table(columns: (auto, auto, auto, auto, auto),
  [*domains*], [*bonding*], [*lone pairs*], [*molecular geometry*], [*example*],
  [2], [2], [0], [linear], [#ce("CO2"), #ce("BeCl2")],
  [3], [3], [0], [trigonal planar], [#ce("BF3"), #ce("NO3^-")],
  [3], [2], [1], [bent], [#ce("SO2"), #ce("O3")],
  [4], [4], [0], [tetrahedral], [#ce("CH4"), #ce("CCl4")],
  [4], [3], [1], [trigonal pyramidal], [#ce("NH3")],
  [4], [2], [2], [bent], [#ce("H2O")],
  [5], [5 / 4 / 3 / 2], [0 / 1 / 2 / 3], [trig. bipyramidal / seesaw / T-shaped / linear], [#ce("PCl5"), #ce("SF4"), #ce("ClF3"), #ce("XeF2")],
  [6], [6 / 5 / 4], [0 / 1 / 2], [octahedral / square pyramidal / square planar], [#ce("SF6"), #ce("BrF5"), #ce("XeF4")])

#micro[*Lone pairs are fatter than bonding pairs.* A lone pair is held by only one nucleus and spreads out more; it pushes the bonds closer together. So bond angles shrink as lone pairs are added: #ce("CH4") 109.5°, #ce("NH3") 107°, #ce("H2O") 104.5°. Multiple bonds also take more room than single bonds.]

#everyday[*Why water is bent, and why that matters.* If water were linear like #ce("CO2"), its two O–H bond dipoles would cancel, it would be nonpolar, it would boil around −80 °C and there would be no liquid oceans and no life. The two lone pairs on oxygen bend the molecule to 104.5°. The same VSEPR reasoning explains why #ce("CO2") (linear, nonpolar) is a gas that does not dissolve well in water, and why the tetrahedral carbon atom is the 3D building block of all organic chemistry, from fuels to polymers to proteins.]

// ALLTAG-BEGIN
== More from everyday life and the professions

#everyday[*The microwave oven.* Water is a polar molecule with a permanent dipole. The oven's radiation at $2.45$ GHz is an oscillating electric field, and the molecules try to follow it, rotating back and forth billions of times per second. The friction with neighbouring molecules warms the food. A dry plastic plate with no polar molecules stays cold, and ice, where the molecules are locked in place, heats badly: the dipole picture explains both.]

#everyday[*Why $"CO"_2$ warms the climate and $"N"_2$ does not.* The light from the Earth's surface is infrared. A molecule absorbs it only if the vibration changes its dipole moment. $"N"_2$ and $"O"_2$ are symmetric and have no dipole, so their stretching vibration does not interact with infrared. $"CO"_2$ is linear, with no net dipole, but its asymmetric stretch and its bend produce a changing dipole and absorb, and so do $"H"_2 "O"$ and $"CH"_4$. The shapes in this chapter are the reason for the greenhouse effect.]
// ALLTAG-END

#problems()

#prob[Ionic or covalent?][
  Classify the bonds as nonpolar covalent, polar covalent or ionic: (a) C–H, (b) O–H, (c) K–F, (d) Br–Br, (e) Al–Cl.
][
  (a) $Delta chi = 0.4$: essentially nonpolar (hydrocarbons are nonpolar). (b) $1.4$: polar covalent. (c) $3.2$: ionic. (d) $0$: nonpolar covalent. (e) $1.5$: polar covalent (#ce("AlCl3") is indeed partly molecular; it sublimes at 180 °C, unlike a typical ionic solid).
]

#prob[Lattice energies][
  Rank by lattice energy: NaCl, MgO, KBr, NaF.
][
  MgO has doubly charged ions: by far the largest. Among the singly charged salts, the smaller the ions, the larger the lattice energy: NaF > NaCl > KBr. Order: KBr < NaCl < NaF < MgO (actual: 671, 788, 910, 3795 kJ/mol).
]

#prob[Lewis structures][
  Draw Lewis structures for (a) #ce("NH3"), (b) #ce("CO3^2-"), (c) formaldehyde #ce("H2CO"), (d) #ce("NH4^+").
][
  (a) 8 v.e.: N with three N–H bonds and one lone pair.
  (b) $4 + 3 times 6 + 2 = 24$ v.e. C central, one C=O and two C–O#super[−]; three equivalent resonance structures. All C–O bonds are equal (1⅓ bonds). Formal charges: two O at −1.
  (c) 12 v.e.: C central with two C–H bonds and a C=O double bond, two lone pairs on O. All formal charges 0.
  (d) $5 + 4 - 1 = 8$ v.e.: four N–H bonds, no lone pair. Formal charge on N: $5 - 4 - 0 = +1$.
]

#prob[Formal charges][
  Two Lewis structures of #ce("CO2") are O=C=O and O≡C–O (with appropriate lone pairs). Use formal charges to decide which is better.
][
  O=C=O: each O has 2 lone pairs: $6 - 2 - 4 = 0$; C: $4 - 4 - 0 = 0$. All zero.
  O≡C–O: triple-bonded O has 1 lone pair: $6 - 3 - 2 = +1$; single-bonded O has 3 lone pairs: $6 - 1 - 6 = -1$; C 0.
  O=C=O is preferred (all formal charges zero).
]

#prob[Bond enthalpies][
  Estimate $Delta H$ for #ce("H2(g) + Cl2(g) -> 2 HCl(g)") using the bond enthalpies in Section 7.7.
][
  Broken: H–H + Cl–Cl $= 436 + 242 = 678$ kJ. Formed: 2 H–Cl $= 862$ kJ. $Delta H approx 678 - 862 = -184$ kJ (tabulated: $-184.6$ kJ). A mixture of #ce("H2") and #ce("Cl2") explodes when exposed to light.
]

#prob[VSEPR][
  Predict electron-domain geometry, molecular geometry and approximate bond angles: (a) #ce("PCl3"), (b) #ce("CO2"), (c) #ce("SF6"), (d) #ce("XeF2"), (e) #ce("NO2^-").
][
  (a) 4 domains (3 bonds, 1 LP): tetrahedral / trigonal pyramidal, < 109.5° (about 100°).
  (b) 2 domains: linear / linear, 180°.
  (c) 6 domains: octahedral / octahedral, 90°.
  (d) Xe has 8 + 2 = 10 electrons: 2 bonds + 3 LP = 5 domains: trigonal bipyramidal / *linear* (lone pairs equatorial), 180°.
  (e) 18 v.e.; N with one single, one double bond (resonance) and one lone pair: 3 domains: trigonal planar / bent, slightly < 120° (115°).
]

#summary[
  - Ionic (transfer), covalent (sharing), metallic (electron sea). Octet rule: aim for 8 v.e. (H: 2).
  - Lattice energy grows with ion charge, shrinks with ion size.
  - Multiple bonds: shorter and stronger. Bond length = energy minimum; bond enthalpy = depth.
  - Electronegativity increases up and to the right (F = 4.0). $Delta chi$: 0 nonpolar, up to about 2 polar covalent, above about 2 ionic. Dipole $mu = Q r$.
  - Lewis structures: count v.e., skeleton, outer octets, rest on centre, multiple bonds. Best structure: formal charges near zero, negative charge on the electronegative atom.
  - Resonance: real molecule is a blend (#ce("O3"), benzene). Exceptions: odd electrons, < octet (B), > octet (period ≥ 3).
  - $Delta H approx sum D_"broken" - sum D_"formed"$.
  - VSEPR: domains as far apart as possible: 2 linear, 3 trigonal planar, 4 tetrahedral, 5 trigonal bipyramidal, 6 octahedral. Lone pairs count for the domain geometry but not for the molecular shape, and they compress bond angles.
]
