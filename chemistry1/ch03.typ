#import "lib.typ": *

= Reactions in Aqueous Solution

#lec(3, [Reactions in aqueous solution], [4.1–4.5])

#lecture[Most of the chemistry on our planet happens in water: in oceans, in cells, in cooling circuits, in batteries, on a wet steel bridge. This chapter introduces the three big families of reactions in water. In precipitation an insoluble solid forms. In acid–base reactions a proton ($ce("H^+")$) is transferred. In redox reactions electrons are transferred.]

== Solutions, electrolytes and nonelectrolytes

#defn[Solution, solvent, solute][A *solution* is a homogeneous mixture of two or more substances. The *solvent* is the substance present in the greatest amount; the *solutes* are the substances dissolved in it. In an *aqueous solution* (aq) the solvent is water.]

Water is an unusual molecule in many ways (more in Chapter 8). One of its key talents: it dissolves ionic solids such as NaCl remarkably well.

#defn[Electrolyte][An *electrolyte* is a substance whose aqueous solution contains ions and therefore conducts electricity. A *nonelectrolyte* dissolves as intact, neutral molecules and gives a non-conducting solution.
- *Strong electrolytes* dissociate (almost) completely into ions: soluble ionic compounds (NaCl, #ce("KNO3")), strong acids (HCl), strong bases (NaOH).
- *Weak electrolytes* form only a few ions; most of the solute stays as molecules: weak acids (acetic acid #ce("CH3COOH")), weak bases (#ce("NH3")).
- *Nonelectrolytes*: sugar #ce("C12H22O11"), ethanol #ce("C2H5OH"), urea.]

#rxn("NaCl(s) -> Na^+(aq) + Cl^-(aq)", note: [dissociation])

=== Why is water such a good solvent for ions?

#grid(columns: (1fr, 3.6cm), column-gutter: 12pt, align: horizon,
  [The O–H bonds in water are *polar*: oxygen pulls the shared electrons towards itself (it is more electronegative, Chapter 7). Oxygen carries a *partial negative charge* $delta^-$, the hydrogens partial positive charges $delta^+$ ("partial" means less than one elementary charge $e$). Because the molecule is bent, these charges do not cancel: water is a small *dipole*.],
  figure(image("figs/c03_water.svg"), caption: [Partial charges in water.]))

#fg("c03_hydration", [Hydration of ions. Water molecules orient themselves around each ion so that the oppositely charged end faces it. This "shell" of water stabilises the ion in solution.], w: 82%)

#micro[When salt dissolves, each ion leaving the crystal is immediately surrounded by water molecules (it is *hydrated* or *solvated*). Their attraction to the ion partly compensates the energy needed to pull the ion out of the crystal. Whether a substance finally dissolves depends on an energy balance *and* on the increase in disorder (entropy). Both ideas will be made precise in Chapters 4, 5 and 9. For now, we accept that some substances are *soluble* in water and others are *insoluble*.]

Nonelectrolytes such as sugar or ethanol dissolve because their molecules contain O–H groups that interact well with water, but the molecules stay intact.

== Precipitation reactions

#defn[Precipitate][A *precipitate* is an insoluble solid formed by a reaction in solution.]

#rxn("AgNO3(aq) + KCl(aq) -> AgCl(s) + KNO3(aq)")

When two clear solutions are mixed, a white solid suddenly appears: silver chloride, which is insoluble. Reactions of this pattern,
#rxn("AX + BY -> AY + BX")
in which cations and anions simply *swap partners*, are called *exchange* or *metathesis* reactions.

=== Molecular, complete ionic and net ionic equations

The equation above is a *molecular equation*: all compounds written as if they were neutral units. But #ce("AgNO3"), KCl and #ce("KNO3") are strong electrolytes; in solution they exist as separate ions. The *complete ionic equation* shows this:

#rxn("Ag^+(aq) + NO3^-(aq) + K^+(aq) + Cl^-(aq) -> AgCl(s) + K^+(aq) + NO3^-(aq)")

#ce("K^+") and #ce("NO3^-") appear unchanged on both sides. They are *spectator ions*: present, but not taking part. Cancelling them gives the *net ionic equation*:

#rxn("Ag^+(aq) + Cl^-(aq) -> AgCl(s)")

#intu[The net ionic equation is the chemistry; everything else is packaging. It tells you that *any* soluble silver salt mixed with *any* soluble chloride gives the same white precipitate. You could equally use #ce("AgClO4") and #ce("NaCl"): same net reaction.]

#recipe[net ionic equations][
  + Write the balanced molecular equation, with states.
  + Split every *strong electrolyte* in solution (aq) into its ions. Keep solids, liquids, gases and weak electrolytes as written.
  + Cancel ions that appear identically on both sides.
  + Check that atoms *and charges* balance.]

=== Will a precipitate form? Solubility rules

#table(columns: (auto, auto),
  [*Generally soluble* (in water)], [*Important exceptions*],
  [all compounds of #ce("Li^+"), #ce("Na^+"), #ce("K^+"), #ce("NH4^+")], [none],
  [all nitrates #ce("NO3^-"), acetates #ce("CH3COO^-")], [none],
  [chlorides, bromides, iodides], [#ce("Ag^+"), #ce("Hg2^2+"), #ce("Pb^2+")],
  [sulfates #ce("SO4^2-")], [#ce("Sr^2+"), #ce("Ba^2+"), #ce("Hg2^2+"), #ce("Pb^2+")],
  table.hline(stroke: 0.4pt),
  [*Generally insoluble*], [*Exceptions*],
  [sulfides #ce("S^2-")], [#ce("NH4^+"), alkali metals, #ce("Ca^2+"), #ce("Sr^2+"), #ce("Ba^2+")],
  [carbonates #ce("CO3^2-"), phosphates #ce("PO4^3-")], [#ce("NH4^+"), alkali metals],
  [hydroxides #ce("OH^-")], [#ce("NH4^+"), alkali metals, #ce("Ca^2+"), #ce("Sr^2+"), #ce("Ba^2+")])

#trick[the two "always soluble" families][If a compound contains an *alkali metal ion* or #ce("NH4^+"), or a *nitrate* or *acetate*, it is soluble. Done. Only otherwise do you need the rest of the table.]

#everyday[*Soap scum.* Soap is sodium stearate, #ce("Na(C17H35COO)"), soluble. In hard water containing #ce("Ca^2+"), an exchange reaction gives insoluble calcium stearate, the grey ring in the bathtub:
#rxn("2 Na(C17H35COO)(aq) + CaCl2(aq) -> Ca(C17H35COO)2(s) + 2 NaCl(aq)")
*Limescale* (Kalk) in kettles and pipes is a precipitate of #ce("CaCO3") from #ce("Ca^2+") and carbonate ions; it reduces heat transfer in boilers and heat exchangers and is a classic headache in process engineering. *Barium sulfate*, though barium ions are toxic, can be swallowed as an X-ray contrast agent precisely because it is so insoluble.]

== Acids, bases and neutralisation

#defn[Acid and base (Arrhenius / Brønsted)][An *acid* is a substance that ionises in water to form hydrogen cations #ce("H^+") (protons); acids are *proton donors*. A *base* is a substance that accepts (reacts with) #ce("H^+"); in water, bases produce hydroxide ions #ce("OH^-").]

#rxn("HCl(aq) -> H^+(aq) + Cl^-(aq)", note: [hydrochloric acid])
#rxn("HNO3(aq) -> H^+(aq) + NO3^-(aq)", note: [nitric acid])

HCl and #ce("HNO3") are *monoprotic*: each molecule releases one #ce("H^+"). Sulfuric acid is *diprotic*; it releases two, in two steps:
#rxn("H2SO4(aq) -> H^+(aq) + HSO4^-(aq)")
#rxn("HSO4^-(aq) <=> H^+(aq) + SO4^2-(aq)")

(In reality a bare proton never exists in water; it attaches to a water molecule, forming #ce("H3O^+"), the hydronium ion. #ce("H^+(aq)") is a convenient shorthand.)

Typical bases are the hydroxides, which simply release #ce("OH^-"):
#rxn("NaOH(aq) -> Na^+(aq) + OH^-(aq)")
#rxn("Ca(OH)2(aq) -> Ca^2+(aq) + 2 OH^-(aq)")
But a base does not need to contain #ce("OH^-"). Ammonia makes hydroxide by taking a proton from water:
#rxn("NH3(aq) + H2O(l) <=> NH4^+(aq) + OH^-(aq)")

=== Strong and weak

The strength of an acid or base describes *how much* #ce("H^+") or #ce("OH^-") it produces, i.e. how completely it ionises. Strong: HCl, HBr, HI, #ce("HNO3"), #ce("HClO4"), #ce("H2SO4") (first step); hydroxides of group 1 and Ca, Sr, Ba. Almost everything else is weak. The quantitative measure is the pH scale (later lectures).

#mistake[*Weak does not mean harmless.* Hydrofluoric acid HF is a *weak* acid but extremely dangerous: the fluoride ion penetrates skin and binds calcium in bones and blood ("bone seeker"). HF exposure is a medical emergency. Reactivity depends not only on the amount of #ce("H^+") but also on the anion.]

=== Neutralisation

#defn[Neutralisation][An acid and a hydroxide base react to form water and a *salt* (an ionic compound whose cation comes from the base and whose anion comes from the acid).]

#rxn("HCl(aq) + NaOH(aq) -> H2O(l) + NaCl(aq)")

Complete ionic and net ionic equations:

#rxn("H^+(aq) + Cl^-(aq) + Na^+(aq) + OH^-(aq) -> H2O(l) + Na^+(aq) + Cl^-(aq)")
#rxn("H^+(aq) + OH^-(aq) -> H2O(l)")

#remember[The net ionic equation of *every* neutralisation between a strong acid and a strong base is the same: #ce("H^+ + OH^- -> H2O"). This is why all such neutralisations release the same heat per mole of water formed (about 56 kJ/mol, see Chapter 4).]

#ex[Removing limescale with vinegar][
  Limescale #ce("CaCO3") is insoluble. Vinegar (acetic acid) reacts with it. The carbonate is a base; the products are a soluble salt, water and #ce("CO2") gas:
  #rxn("CaCO3(s) + 2 CH3COOH(aq) -> Ca(CH3COO)2(aq) + H2O(l) + CO2(g)")
  The fizzing is the #ce("CO2"). Carbonic acid #ce("H2CO3") formed in the exchange step is unstable and decomposes to #ce("H2O + CO2"), which drives the reaction forward because the gas escapes. Antacid tablets (#ce("CaCO3"), #ce("Mg(OH)2")) neutralise excess stomach acid by the same chemistry.
]

== Oxidation–reduction reactions

#idea[Precipitation: ions swap partners. Acid–base: a *proton* is transferred. Redox: *electrons* are transferred. Redox reactions power the world: combustion, corrosion, batteries, fuel cells, metal production, respiration.]

The name comes from the first reactions studied: metals giving electrons to oxygen and forming oxides, as in rust (#ce("Fe2O3")). Corrosion is the classic example: iron loses electrons to #ce("O2") (rust), silver loses electrons to #ce("H2S") in air (tarnish, #ce("Ag2S")).

#defn[Oxidation and reduction][*Oxidation* is the loss of electrons by an atom, ion or molecule: it becomes more positive. *Reduction* is the gain of electrons: it becomes more negative.]

#rxn("2 Ca(s) + O2(g) -> 2 CaO(s)")

Each Ca atom starts neutral and becomes #ce("Ca^2+"): calcium is oxidised. Each O atom starts neutral and becomes #ce("O^2-"): oxygen is reduced.

#remember[Oxidation and reduction always go *together*: electrons that one species loses must be gained by another. Mnemonic: *"LEO the lion says GER"*: #strong[L]osing #strong[E]lectrons is #strong[O]xidation, #strong[G]aining #strong[E]lectrons is #strong[R]eduction.]

The species that is oxidised (gives away electrons) is the *reducing agent* (reductant); the species that is reduced (takes electrons) is the *oxidising agent* (oxidant). Note the crossover: the reductant is oxidised.

=== Oxidation numbers: bookkeeping for electrons

In molecules, electrons are shared rather than fully transferred. To keep track anyway, every atom gets an *oxidation number* (oxidation state): the charge it *would* have if all bonds were completely ionic.

#recipe[assigning oxidation numbers][
  + An atom in its *elemental form* has 0 (Fe, #ce("O2"), #ce("H2"), #ce("S8")).
  + A *monatomic ion* has its charge (#ce("Na^+"): +1, #ce("O^2-"): −2).
  + *Nonmetals* usually have negative oxidation numbers:
    - O: −2 (except in peroxides like #ce("H2O2"), #ce("O2^2-"): −1);
    - H: +1 with nonmetals, −1 with metals (NaH);
    - F: always −1;
    - Cl, Br, I: −1, except when bonded to O (then positive).
  + The *sum* of all oxidation numbers equals the total charge: 0 for a neutral compound, the ion charge for a polyatomic ion.]

#ex[Oxidation numbers][
  - #ce("H2SO4"): $2(+1) + x + 4(-2) = 0 => x = +6$ for S.
  - #ce("Cr2O7^2-"): $2x + 7(-2) = -2 => x = +6$ for Cr.
  - #ce("NH4^+"): $x + 4(+1) = +1 => x = -3$ for N.
  - #ce("Fe3O4"): $3x + 4(-2) = 0 => x = +8\/3$. Fractional values are averages (here a mixture of Fe(II) and Fe(III)).
]

#fg("c03_oxladder", [Nitrogen in its compounds spans oxidation numbers from −3 to +5. Moving right is oxidation, moving left reduction.], w: 92%)

#ex[A displacement reaction][
  #rxn("Mg(s) + 2 HCl(aq) -> MgCl2(aq) + H2(g)")
  Oxidation numbers: Mg 0 → +2 (oxidised; reducing agent). H +1 → 0 (reduced; HCl is the oxidising agent). Cl stays −1 (spectator). Net ionic: #ce("Mg(s) + 2 H^+(aq) -> Mg^2+(aq) + H2(g)").

  A metal reacting with an acid or a metal salt and replacing the cation is a *displacement reaction*, #ce("A + BX -> AX + B").
]

=== The activity series

Which metals are oxidised by which ions? The *activity series* lists metals in order of how easily they are oxidised.

#fg("c03_activity", [The activity series (Brown Table 4.5, shortened). Metals at the top give away electrons most easily.], w: 62%)

#law[Using the activity series][
  - Any metal is oxidised by the cations of metals *below* it in the series.
  - Any metal *above hydrogen* reacts with acids to form #ce("H2").]
Examples: copper is above silver, so
#rxn("Cu(s) + 2 Ag^+(aq) -> Cu^2+(aq) + 2 Ag(s)")
happens (a copper wire in silver nitrate solution grows silver crystals and the solution turns blue). Nickel is above hydrogen:
#rxn("Ni(s) + 2 HCl(aq) -> NiCl2(aq) + H2(g)")
Copper is below hydrogen: copper does not dissolve in hydrochloric acid.


#everyday[*Noble metals* (Ag, Pt, Au) sit at the bottom: hard to oxidise, they do not corrode. That is why gold has been used as money and in jewellery for millennia, and why gold plating is used on electrical contacts. *Galvanised steel* uses the series the other way around: a zinc layer (above iron) is oxidised first and protects the iron, even where the coating is scratched (*sacrificial anode*; the same idea protects ship hulls and pipelines). Mixing metals carelessly, e.g. aluminium rivets in a copper sheet in the rain, creates a battery that eats the more active metal (*galvanic corrosion*), a classic design error. How to harvest the electron flow as useful electrical power is the topic of electrochemistry and batteries.]

== Concentration of solutions

#defn[Molarity][
  $ "molarity" = c = ("moles of solute")/("volume of solution in litres"), quad [c] = "mol/L" = "M". $
  A 1 M ("one molar") solution contains 1 mol of solute per litre of *solution* (not per litre of solvent).]

Every molarity problem is one of the forms of
$ n = c V. $

#ex[Preparing a solution][
  How do you prepare 250 mL of 0.100 M #ce("CuSO4")? $n = 0.100 "mol/L" times 0.250 "L" = 0.0250$ mol; $m = 0.0250 times 159.6 "g/mol" = 3.99$ g. Weigh 3.99 g of #ce("CuSO4"), dissolve in some water in a 250 mL volumetric flask and fill up to the mark.
]

#law[Dilution][Adding solvent does not change the amount of solute:
$ c_"conc" V_"conc" = c_"dil" V_"dil". $]

#mistake[For an electrolyte, the concentration of *ions* can differ from the concentration of the compound: 0.1 M #ce("CaCl2") contains 0.1 M #ce("Ca^2+") but 0.2 M #ce("Cl^-"). Also: molarity refers to the volume of *solution*; "1 mol in 1 L of water" gives slightly more than 1 L of solution.]

#ex[Titration][
  25.0 mL of an HCl solution of unknown concentration is neutralised by 18.6 mL of 0.120 M NaOH. Concentration of the HCl?

  $n(ce("NaOH")) = 0.120 times 0.0186 = 2.23 times 10^(-3)$ mol. HCl : NaOH = 1 : 1, so $n(ce("HCl")) = 2.23 times 10^(-3)$ mol, $c = 2.23 times 10^(-3) \/ 0.0250 = 0.0893$ M.
]

// ALLTAG-BEGIN
== More from everyday life and the professions

#everyday[*Limescale and antacids.* Hard water contains $"Ca"^(2+)$ and $"HCO"_3^-$. On heating, it gives solid calcium carbonate: $"Ca"^(2+) + 2 "HCO"_3^- -> "CaCO"_3 (s) + "CO"_2 + "H"_2 "O"$. That is the white crust in kettles and coffee machines, and the reason for descaling with citric acid, which dissolves the carbonate again. An antacid tablet for heartburn works the other way round: $"Mg(OH)"_2 + 2 "HCl" -> "MgCl"_2 + 2 "H"_2 "O"$ neutralises excess stomach acid. Both are the same type of reaction as in this chapter, just in the kitchen and in the body.]
// ALLTAG-END

#problems()

#prob[Electrolytes][
  Classify as strong, weak or nonelectrolyte: (a) #ce("KOH"), (b) #ce("CH3COOH"), (c) methanol #ce("CH3OH"), (d) #ce("Ba(NO3)2"), (e) #ce("NH3").
][
  (a) strong (soluble hydroxide, strong base); (b) weak (weak acid); (c) nonelectrolyte (molecular, no ions); (d) strong (soluble ionic compound, nitrate); (e) weak (weak base).
]

#prob[Precipitation and net ionic equation][
  Solutions of lead(II) nitrate and potassium iodide are mixed. Write the molecular, complete ionic and net ionic equation.
][
  Products of exchange: #ce("PbI2") (iodides are soluble *except* with #ce("Pb^2+"), so it precipitates, bright yellow) and #ce("KNO3") (soluble).

  Molecular: #ce("Pb(NO3)2(aq) + 2 KI(aq) -> PbI2(s) + 2 KNO3(aq)").

  Complete ionic: #ce("Pb^2+ + 2 NO3^- + 2 K^+ + 2 I^- -> PbI2(s) + 2 K^+ + 2 NO3^-").

  Net ionic: #ce("Pb^2+(aq) + 2 I^-(aq) -> PbI2(s)").
]

#prob[Oxidation numbers][
  Determine the oxidation number of the named element: (a) S in #ce("SO2"), (b) Mn in #ce("KMnO4"), (c) C in #ce("CH4") and #ce("CO2"), (d) Cl in #ce("ClO4^-").
][
  (a) $x + 2(-2) = 0 => +4$. (b) $+1 + x + 4(-2) = 0 => +7$. (c) In #ce("CH4"): $x + 4 = 0 => -4$; in #ce("CO2"): $+4$. Burning methane oxidises carbon from −4 to +4: 8 electrons per carbon atom, a lot of energy. (d) $x + 4(-2) = -1 => +7$.
]

#prob[Redox analysis][
  For #ce("Fe2O3(s) + 3 CO(g) -> 2 Fe(s) + 3 CO2(g)") (blast furnace), identify what is oxidised and reduced, and the oxidising and reducing agents.
][
  Fe: +3 → 0, reduced; #ce("Fe2O3") is the oxidising agent. C: +2 (in CO) → +4 (in #ce("CO2")), oxidised; CO is the reducing agent. O stays −2. Electrons: $2 times 3 = 6$ gained by Fe, $3 times 2 = 6$ lost by C. ✓
]

#prob[Activity series][
  Predict whether a reaction occurs; if so write the net ionic equation. (a) Zn in #ce("CuSO4") solution, (b) Ag in HCl, (c) Al in #ce("FeCl2") solution.
][
  (a) Zn is above Cu: #ce("Zn(s) + Cu^2+(aq) -> Zn^2+(aq) + Cu(s)"). (b) Ag is below H: no reaction. (c) Al is above Fe: #ce("2 Al(s) + 3 Fe^2+(aq) -> 2 Al^3+(aq) + 3 Fe(s)") (6 electrons transferred, charges balance: $+6 = +6$).
]

#prob[Dilution and ion concentration][
  50.0 mL of 0.400 M #ce("Na2SO4") are diluted to 250.0 mL. What are the final concentrations of #ce("Na^+") and #ce("SO4^2-")?
][
  $c_"dil" = 0.400 times 50.0\/250.0 = 0.0800$ M #ce("Na2SO4"). Each formula unit gives 2 #ce("Na^+") and 1 #ce("SO4^2-"): $[ce("Na^+")] = 0.160$ M, $[ce("SO4^2-")] = 0.0800$ M.
]

#prob[Limescale removal][
  A kettle contains 5.0 g of #ce("CaCO3") deposits. What volume of vinegar (0.83 M acetic acid) is needed at least?
][
  $n(ce("CaCO3")) = 5.0\/100.1 = 0.050$ mol. Ratio 1 : 2, so 0.100 mol acetic acid. $V = n\/c = 0.100\/0.83 = 0.12$ L $= 120$ mL.
]

#summary[
  - Solution = solvent + solutes. Electrolytes give ions (strong: completely; weak: partly); nonelectrolytes stay molecular.
  - Water is polar ($delta^-$ on O, $delta^+$ on H) and hydrates ions.
  - Precipitation = exchange reaction forming an insoluble solid. Use solubility rules (alkali, #ce("NH4^+"), nitrate, acetate: always soluble).
  - Net ionic equation: split strong electrolytes, cancel spectator ions.
  - Acid = #ce("H^+") donor, base = #ce("H^+") acceptor. Neutralisation: #ce("H^+ + OH^- -> H2O"), giving water + salt.
  - Redox: oxidation = loss of electrons (oxidation number increases), reduction = gain. Always together. LEO says GER.
  - Activity series: a metal is oxidised by cations below it; metals above #ce("H2") dissolve in acid.
  - Molarity $c = n\/V$; dilution $c_1 V_1 = c_2 V_2$.
]
