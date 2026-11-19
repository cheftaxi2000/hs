#import "lib.typ": *

= Electronic Structure of Atoms and Periodic Trends

#lec(6, [Electronic structure, periodic trends], [6.1–6.9, 7.2–7.5])

#lecture[Electrons determine how atoms react and how they form bonds. To understand chemistry we must understand how electrons are organised in atoms, their *electronic structure*. A full treatment needs quantum mechanics (4th semester); here we sketch the essential ideas and their consequences, above all the shape of the periodic table.]

== Light: waves and photons

Almost everything we know about electrons in atoms comes from the light that atoms absorb and emit. So we start with light.

=== Light as a wave

#grid(columns: (1fr, 6.4cm), column-gutter: 12pt, align: horizon,
  [Light is an oscillating *electromagnetic wave*. Its key parameters are the *wavelength* $lambda$ (distance between two crests), the *frequency* $nu$ (oscillations per second, in Hz $= "s"^(-1)$) and the *speed of light* in vacuum $c = 2.998 times 10^8$ m/s. They are connected by],
  figure(image("figs/c06_wave.svg"), caption: [An electromagnetic wave.]))

$ c = lambda nu. $

The colour of visible light depends on its wavelength: about 430 nm is blue, 530 nm green, 630 nm red. Visible light (400–700 nm) is only a tiny window of the electromagnetic spectrum, which ranges from gamma rays and X-rays (short $lambda$) through ultraviolet, visible and infrared to microwaves and radio waves (long $lambda$).

=== Light as particles: photons

Around 1900, experiments (black-body radiation, photoelectric effect) showed that light carries energy only in *discrete packets*, called *photons* or *quanta*:

#formula[Energy of a photon][
  $ E = h nu = (h c)/lambda, quad quad h = 6.626 times 10^(-34) "J s" quad "(Planck's constant)". $]

Short wavelength means high energy per photon. That is why UV light gives sunburn and X-rays damage DNA, while even very bright red light cannot.

#intu[*Wave–particle duality.* Light behaves as a wave (it shows interference and diffraction) *and* as a stream of particles (it delivers energy in packets of $h nu$). Which aspect you see depends on the experiment. This duality is the central idea of quantum mechanics, and it applies to electrons too.]

== Line spectra and the Bohr model

=== The mystery of hydrogen

Hot solids such as the Sun or a light bulb filament emit *white light*: all colours, a *continuous spectrum*. But hydrogen gas in a discharge tube emits light only at a few sharp wavelengths, a *line spectrum*.

#fg("c06_spectrum", [Continuous spectrum of white light versus the line spectrum of hydrogen.], w: 88%)

In 1885 the Swiss schoolteacher Johann Balmer found that these wavelengths obey a simple empirical formula. Generalised, it is the *Rydberg equation*:
$ E_"ph" = (h c)/lambda = h c R_H (1/n_1^2 - 1/n_2^2), quad n_2 > n_1 >= 1 "integers", quad R_H = 1.097 times 10^7 "m"^(-1). $
But *why* does it work?

=== Bohr's model (1913)

Niels Bohr pictured the atom as a tiny solar system and made three postulates:
+ The electron can only occupy certain *allowed orbits*, each with a specific energy $E_n$.
+ In an allowed orbit the electron does not radiate (it is stable).
+ The electron can jump between allowed orbits by *absorbing* or *emitting* a photon whose energy equals exactly the energy difference: $E_"ph" = |Delta E| = h nu$.

#formula[Energy levels of hydrogen][
  $ E_n = -(h c R_H)/n^2 = -(2.18 times 10^(-18) "J")/n^2 = -(13.6 "eV")/n^2, quad n = 1, 2, 3, dots $
  The energy is *negative*: zero corresponds to the electron completely removed from the atom ($n = oo$).]

#fg("c06_bohr", [Energy levels of hydrogen. Transitions down to $n = 1$ emit ultraviolet photons (Lyman series); transitions down to $n = 2$ give the visible Balmer lines.], w: 58%)

#ex[Photon from $n = 3$ to $n = 1$][
  $ Delta E = E_1 - E_3 = -2.18 times 10^(-18) "J" (1/1^2 - 1/3^2) = -1.94 times 10^(-18) "J". $
  The atom loses energy, the emitted photon has $E_"ph" = +1.94 times 10^(-18)$ J:
  $ lambda = (h c)/E_"ph" = (6.626 times 10^(-34) times 2.998 times 10^8)/(1.94 times 10^(-18)) "m" = 103 "nm" quad "(extreme ultraviolet)". $
]

#mistake[Signs: $Delta E$ of the *atom* is negative for emission, but the photon energy is always positive. Always compute $E_"ph" = |Delta E|$, then $lambda = h c \/ E_"ph"$.]

#everyday[*Atomic light everywhere.* *Fireworks* and *flame tests* show line spectra: sodium burns yellow (589 nm), strontium red, copper green-blue, barium green. *Sodium street lamps* emit almost only the 589 nm line, which is why everything looks monochrome orange under them. *Neon signs* glow in the lines of neon. *Extreme ultraviolet (EUV) lithography* at 13.5 nm, produced by a tin plasma, is used to print the smallest transistors on today's computer chips; the ASML machines that do this cost hundreds of millions of francs each.]

=== Limits of the Bohr model

Bohr's model gets the energy levels of hydrogen right, but it cannot explain *why* the orbits are stable, and it fails for every atom with more than one electron. The correct description requires quantum mechanics.

== The quantum-mechanical atom

=== Matter waves and uncertainty

In 1924 Louis de Broglie proposed that, like light, *matter* has wave properties: a particle of mass $m$ and speed $v$ has the wavelength $lambda = h \/ (m v)$. For a baseball this is absurdly small, but for an electron in an atom it is comparable to the size of the atom. Electron diffraction confirmed it, and electron microscopes exploit it.

Heisenberg's *uncertainty principle* states that position and momentum of a particle cannot both be known precisely:
$ Delta x dot Delta(m v) >= h/(4 pi). $
For an electron in an atom, this means we cannot follow it along a sharp orbit. The orbit becomes "fuzzy": we must speak of an *electron cloud*.

=== Wavefunctions and orbitals

#law[What quantum mechanics says][
  - The motion of the electron is described by a *wavefunction* $psi$.
  - Because of the uncertainty principle we only know *probabilities*: $|psi|^2$ gives the probability of finding the electron in a region (the *electron density*).
  - Bohr's orbits become *atomic orbitals*: regions of electron density with characteristic energy and shape.
  - Each orbital is labelled by three quantum numbers $n, ell, m_ell$; the electron in it has a fourth, $m_s$.]

#table(columns: (auto, auto, auto, 1fr),
  [*quantum number*], [*name*], [*allowed values*], [*meaning*],
  [$n$], [principal], [$1, 2, 3, dots$], [shell; size and energy of the orbital (same $n$ as Bohr)],
  [$ell$], [angular momentum], [$0, 1, dots, n - 1$], [subshell; shape: $ell = 0, 1, 2, 3$ ↔ s, p, d, f],
  [$m_ell$], [magnetic], [$-ell, dots, 0, dots, +ell$], [orientation in space; $2 ell + 1$ orbitals per subshell],
  [$m_s$], [spin magnetic], [$+1/2, -1/2$], [spin "up" or "down"])

#ex[Counting orbitals][
  Shell $n = 3$: $ell = 0$ (one 3s orbital), $ell = 1$ (three 3p orbitals, $m_ell = -1, 0, +1$), $ell = 2$ (five 3d orbitals). Total $1 + 3 + 5 = 9 = n^2$ orbitals, holding up to $2 n^2 = 18$ electrons.
]

=== Shapes of orbitals

#fg("c06_orbitals", [Electron density $|psi|^2$ of hydrogen orbitals, cut through a plane containing the nucleus. Colour marks the sign of $psi$ (blue $+$, red $-$). White lines and circles are *nodes*, where the electron is never found.])

- *s orbitals* ($ell = 0$) are *spherical*. Only one orientation is possible, so $m_ell = 0$. Larger $n$ means a bigger orbital with $n - 1$ spherical nodes inside.
- *p orbitals* ($ell = 1$) have a *dumbbell* shape with two lobes on opposite sides of the nucleus and a nodal plane through it. Three orientations: $p_x, p_y, p_z$.
- *d orbitals* ($ell = 2$) mostly have a *four-leaf clover* shape. Five orientations.
- *f orbitals* ($ell = 3$) have even more complex shapes (seven orientations); see the cover of this script.

=== Energies of orbitals in hydrogen

In hydrogen (one electron) the energy depends *only on $n$*: 2s and 2p have the same energy, as do 3s, 3p and 3d. The lowest state (electron in 1s) is the *ground state*; all others are *excited states*.

=== Electron spin and the Pauli principle

Electrons behave as if they were spinning around their own axis. A rotating charge is a tiny magnet, and the magnetic field of an electron can be measured. (They do not really spin; spin is a purely quantum property.) There are only two possible spin orientations, $m_s = +1/2$ ("up", ↑) and $m_s = -1/2$ ("down", ↓).

#law[Pauli exclusion principle][No two electrons in an atom can have the same set of four quantum numbers $n, ell, m_ell, m_s$. Consequence: *each orbital holds at most two electrons, and they must have opposite spins.*]

#everyday[*MRI scanners* in hospitals use the spin of protons (nuclei have spin too) in a strong magnetic field: the energy difference between "up" and "down" corresponds to radio waves, and the signal maps the water content of tissue. *Hard drives* and *magnets* rely on unpaired electron spins aligning in iron, cobalt and neodymium.]

== Many-electron atoms and electron configurations

=== Orbital energies

#fg("c06_levels", [Orbital energies. Left: in hydrogen they depend only on $n$. Right: in many-electron atoms, electron–electron repulsion splits each shell, $E_s < E_p < E_d < E_f$, and 4s ends up below 3d. Each box is one orbital ($n, ell, m_ell$).])

In atoms with more than one electron, electrons repel each other and the subshells within a shell are no longer equal in energy: *s < p < d < f*. (The reason, screening, follows in Section 6.5.) The splitting is so large that 4s lies below 3d, and 5s below 4d.

=== Filling the orbitals

The ground-state electron configuration is built by placing electrons one by one into the lowest available orbitals (*Aufbau principle*), respecting the Pauli principle.

#grid(columns: (1fr, 4.4cm), column-gutter: 12pt, align: horizon,
  [
    The filling order can be read from the diagonal rule shown on the right, or, much better, *directly from the periodic table*: moving across the table from H to Og, you fill the subshells in order. The s block (groups 1–2) holds 2 electrons per row, the p block (groups 13–18) 6, the d block (transition metals) 10, the f block (lanthanides and actinides) 14.
    $ 1s, 2s, 2p, 3s, 3p, 4s, 3d, 4p, 5s, 4d, 5p, 6s, 4f, 5d, 6p, 7s, dots $
  ],
  figure(image("figs/c06_aufbau.svg"), caption: [Filling order (diagonal rule).]))

#law[Hund's rule][When electrons occupy orbitals of equal energy (e.g. the three 2p orbitals), they first go into *separate* orbitals with *parallel spins*, before pairing up.]

#intu[Electrons repel each other. In separate orbitals they are further apart, which lowers the energy, like passengers on a bus who take empty double seats before sitting next to a stranger.]

#ex[Electron configurations][
  #table(columns: (auto, auto, 1fr),
    [*atom*], [*configuration*], [*orbital diagram of the outer subshells*],
    [N ($Z = 7$)], [$1s^2 2s^2 2p^3$], [2s: ↑↓ #h(1em) 2p: ↑ ↑ ↑ (Hund: three unpaired)],
    [O ($Z = 8$)], [$1s^2 2s^2 2p^4$], [2s: ↑↓ #h(1em) 2p: ↑↓ ↑ ↑],
    [Na ($Z = 11$)], [$1s^2 2s^2 2p^6 3s^1 = [ce("Ne")] 3s^1$], [3s: ↑],
    [Fe ($Z = 26$)], [$[ce("Ar")] 4s^2 3d^6$], [3d: ↑↓ ↑ ↑ ↑ ↑ (four unpaired: magnetic!)],
    [Se ($Z = 34$)], [$[ce("Ar")] 4s^2 3d^(10) 4p^4$], [valence: $4s^2 4p^4$])
  The *condensed notation* [Ne], [Ar], … stands for the configuration of the preceding noble gas, the *core electrons*.
]

#defn[Valence electrons][The *valence electrons* are those in the outermost shell (plus, for transition metals, the partly filled d subshell). Filled d or f subshells are *not* counted as valence electrons. Valence electrons take part in bonding and determine the chemistry: selenium ($[ce("Ar")] 4s^2 3d^(10) 4p^4$) has 6 valence electrons, like oxygen and sulfur in the same group.]

#remember[Elements in the same *group* have the same *valence configuration* (e.g. all group 1: $n s^1$, all group 17: $n s^2 n p^5$). *This is why they behave alike chemically*, and why the periodic table works.]

*Exceptions:* nearly half-filled or nearly filled d subshells sometimes "borrow" an s electron: Cr is $[ce("Ar")] 4s^1 3d^5$, Cu is $[ce("Ar")] 4s^1 3d^(10)$. Do not memorise them, just be aware they exist.

== Effective nuclear charge and screening

Why is $E_s < E_p < E_d$ in a many-electron atom? Because of *screening*.

#defn[Effective nuclear charge][A valence electron is attracted by the $+Z e$ nucleus but repelled by the other electrons, especially the inner *core electrons*. It does not feel the full nuclear charge but only an *effective nuclear charge*
$ Z_"eff" = Z - S, $
where $S$ is the screening constant (roughly the number of core electrons).]

#micro[Picture yourself in a crowded hall listening to a speaker: people between you and the speaker partly block the sound. An s electron has some probability density very close to the nucleus (it *penetrates* the core) and feels more of the nuclear charge than a p electron, which feels more than a d electron. More attraction means lower energy: $E_s < E_p < E_d$.]

*Trends of $Z_"eff"$:*
- *Across a period* (left to right), $Z$ grows by one each step, but the number of core electrons stays the same: $Z_"eff"$ *increases*.
- *Down a group*, $Z_"eff"$ stays roughly constant (increases only slightly): more protons, but also a whole new shell of core electrons.

== Periodic trends

=== Atomic radii

The electron cloud has no sharp edge, so the size of an atom must be defined. Typical: the *bonding atomic radius* is half the distance between two identical bonded atoms (e.g. half the Cl–Cl bond length). From tables of such radii, bond lengths in new molecules can be estimated: $d_(A B) approx r_A + r_B$.

#fg("c06_radius", [Bonding atomic radii (pm) of the first 37 elements. Each period starts with a large alkali atom and shrinks towards the noble gas.])

#law[Trends in atomic radius][
  - *Down a group the radius increases:* $n$ grows, the outer electrons are in a larger shell.
  - *Across a period the radius decreases:* $Z_"eff"$ increases and pulls the valence electrons closer.]

=== Ionic radii

- *Cations are smaller* than their parent atoms (an outer shell is often emptied, and fewer electrons repel each other).
- *Anions are larger* than their parent atoms (added electrons repel each other).
- For ions of the same charge, the size increases down a group.
- *Isoelectronic series* (same number of electrons): the radius decreases with increasing nuclear charge, because the same electrons are pulled in more tightly. Example (all with 10 electrons): #ce("O^2-") 126 pm > #ce("F^-") 119 > #ce("Na^+") 116 > #ce("Mg^2+") 86 > #ce("Al^3+") 68 pm.

=== Ionisation energy

#defn[Ionisation energy][The *(first) ionisation energy* $I_1$ is the minimum energy needed to remove an electron from a gaseous atom in its ground state: #ce("Na(g) -> Na^+(g) + e^-"). The second ionisation energy $I_2$ removes the next electron: #ce("Na^+(g) -> Na^2+(g) + e^-"). Always $I_2 > I_1$ (it is harder to remove an electron from an already positive ion), and ionisation energies are always positive.]

#fg("c06_IE", [First ionisation energies (kJ/mol). Maxima at the noble gases, minima at the alkali metals.])

#law[Trends in ionisation energy][
  - *Across a period $I_1$ increases* (larger $Z_"eff"$, smaller atom, electron held more tightly).
  - *Down a group $I_1$ decreases* (electron further from the nucleus).]

The small dips inside a period are fine structure that confirms the orbital picture: B ($2p^1$) is easier to ionise than Be ($2s^2$) because a 2p electron is higher in energy; O ($2p^4$) is easier than N ($2p^3$) because the fourth p electron must pair up and is repelled by its partner.

Successive ionisation energies show a huge jump once the core is reached: for Na, $I_1 = 496$ kJ/mol, but $I_2 = 4562$ kJ/mol. This is why sodium forms #ce("Na^+") and never #ce("Na^2+").

=== Electron affinity

#defn[Electron affinity][The *electron affinity* $E A$ is the energy change when an electron is added to a gaseous atom: #ce("Cl(g) + e^- -> Cl^-(g)"). In the convention used here (and in Brown) it is usually negative (exothermic): the atom lowers its energy by accepting the electron.]

- *Halogens*: $E A lt.double 0$ (very favourable; adding one electron completes the p subshell). Cl: $-349$ kJ/mol.
- *Noble gases*: $E A > 0$ (the electron would have to start a new shell; the anion is unstable).

#mistake[Careful with signs! Ionisation energy is always positive (we must *put in* energy). Some books define electron affinity as the energy *released*, which makes it a positive number for Cl. Always check the convention.]

#everyday[*Why caesium is used in photocells and atomic clocks, why fluorine is so aggressive.* Caesium has the lowest ionisation energy of all stable elements (376 kJ/mol): light alone can knock electrons out, which made it the material of early photocells and night-vision devices. (Its precise line spectrum also defines the second.) Fluorine combines the highest $Z_"eff"$ of its period with a strongly negative electron affinity, so it pulls electrons from almost anything. That is why #ce("F2") attacks glass and steel, while in compounds such as PTFE (Teflon) the same strong C–F bonds make the material extremely inert.]

#problems()

#prob[Photon energy][
  A green laser pointer emits at 532 nm with a power of 5.0 mW. (a) What is the energy of one photon? (b) How many photons per second does it emit?
][
  (a) $E = h c\/lambda = 6.626 times 10^(-34) times 2.998 times 10^8 \/ 532 times 10^(-9) = 3.73 times 10^(-19)$ J.
  (b) $N = P\/E = 5.0 times 10^(-3) \/ 3.73 times 10^(-19) = 1.3 times 10^(16)$ photons per second.
]

#prob[Balmer line][
  Calculate the wavelength of the line emitted when the electron of hydrogen falls from $n = 4$ to $n = 2$. Which colour is it?
][
  $E_"ph" = 2.18 times 10^(-18) (1\/4 - 1\/16) = 2.18 times 10^(-18) times 0.1875 = 4.09 times 10^(-19)$ J.
  $lambda = h c \/ E_"ph" = 1.986 times 10^(-25) \/ 4.09 times 10^(-19) = 486$ nm: blue-green (the cyan line in Fig. 6.2).
]

#prob[Ionisation of hydrogen][
  What is the minimum energy (kJ/mol) and the longest wavelength of light that can ionise a hydrogen atom in its ground state?
][
  From $n = 1$ to $n = oo$: $Delta E = 2.18 times 10^(-18)$ J per atom; times $N_A$: $1312$ kJ/mol (exactly $I_1$ of H in Fig. 6.8). $lambda = h c \/ Delta E = 91.2$ nm (UV).
]

#prob[Quantum numbers][
  (a) Which of these sets of quantum numbers are impossible: $(2, 2, 0, +1/2)$, $(3, 1, -1, -1/2)$, $(1, 0, 1, +1/2)$, $(4, 3, -2, +1/2)$? (b) How many electrons can have $n = 4$, $ell = 2$?
][
  (a) $(2, 2, dots)$ impossible ($ell <= n - 1 = 1$). $(1, 0, 1, dots)$ impossible ($|m_ell| <= ell = 0$). The other two are allowed ($3p$ and $4f$).
  (b) $ell = 2$: five 4d orbitals, 10 electrons.
]

#prob[Electron configurations][
  Write the ground-state configurations of (a) P, (b) Ca, (c) #ce("Fe^3+"), (d) Br. How many unpaired electrons does each have?
][
  (a) P: $[ce("Ne")] 3s^2 3p^3$, three unpaired (Hund). (b) Ca: $[ce("Ar")] 4s^2$, none. (c) Fe: $[ce("Ar")] 4s^2 3d^6$; ions of transition metals lose the *4s electrons first*: #ce("Fe^3+") $= [ce("Ar")] 3d^5$, five unpaired. (d) Br: $[ce("Ar")] 4s^2 3d^(10) 4p^5$, one unpaired.
]

#prob[Periodic trends][
  Arrange in order: (a) increasing atomic radius: Mg, S, Ba, Cl; (b) increasing first ionisation energy: Na, K, Cl, Ar; (c) increasing ionic radius: #ce("S^2-"), #ce("Cl^-"), #ce("K^+"), #ce("Ca^2+").
][
  (a) Cl < S < Mg < Ba (across period 3 the radius shrinks; Ba is two periods lower).
  (b) K < Na < Cl < Ar (down a group $I_1$ falls; across a period it rises).
  (c) Isoelectronic (18 electrons): the larger $Z$, the smaller: #ce("Ca^2+") < #ce("K^+") < #ce("Cl^-") < #ce("S^2-").
]

#summary[
  - Light: $c = lambda nu$; photons $E = h nu = h c\/lambda$. Atoms emit/absorb only specific photons (line spectra).
  - Bohr: $E_n = -2.18 times 10^(-18) "J"\/n^2$; photon energy = $|Delta E|$ between levels.
  - Quantum mechanics: wavefunctions, probability clouds, orbitals labelled $n$ (shell, size), $ell$ (shape s, p, d, f), $m_ell$ (orientation), plus spin $m_s = plus.minus 1/2$.
  - Pauli: max. two electrons per orbital, opposite spins. Hund: fill equal orbitals singly with parallel spins first.
  - Many-electron atoms: $E_s < E_p < E_d$ (screening). Filling order follows the periodic table (s, p, d, f blocks).
  - Same group = same valence configuration = similar chemistry.
  - $Z_"eff"$ increases across a period. Radius: decreases across, increases down. $I_1$: increases across, decreases down. Cations smaller, anions larger than their atoms. Halogens: very negative $E A$.
]
