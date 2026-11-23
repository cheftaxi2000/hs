import type { ComponentType } from 'react';
import { Koordinaten, Kreis, Sekante } from './plates/Point';
import { Leiter, Rollen, SdpG, Schraube } from './plates/Rigid';
import { Leistung, Linienlast, Reduktion, Schere, Schwerpunkt } from './plates/Forces';
import { Dreigelenk, Fachwerk, Kettenlinie, Lager, Reibung, Schnitt, Seilreibung } from './plates/Structures';

import { Ableitungsfunktion, Bisektion, Differenzenquotient, EpsSchlauch, Euler, GeoReihe, Hauptsatz, KMult, Konvergenzradius, Kruemmung, Leibniz, Mittelwertsatz, Riemann, Rotationskoerper, Taylor, Umkehr, Wurzeln } from './plates/Analysis';

export interface Chapter { id: string; num: string; title: string; plates: ComponentType[] }
export interface Subject { id: string; name: string; title: string; lede: string; chapters: Chapter[] }

/** Chapters as in the Lernskript (hs/mechanik1). */
const MECHANIK: Chapter[] = [
  { id: 'k1', num: '1', title: 'Bewegung eines materiellen Punktes', plates: [Koordinaten] },
  { id: 'k2', num: '2', title: 'Geschwindigkeit', plates: [Sekante, Kreis] },
  { id: 'k3', num: '3', title: 'Kinematik starrer Körper', plates: [SdpG, Rollen, Leiter, Schraube] },
  { id: 'k4', num: '4', title: 'Kräfte', plates: [Linienlast] },
  { id: 'k5', num: '5', title: 'Leistung', plates: [Leistung] },
  { id: 'k6', num: '6', title: 'Äquivalenz und Reduktion', plates: [Reduktion] },
  { id: 'k7', num: '7', title: 'Parallele Kräfte und Schwerpunkt', plates: [Schwerpunkt] },
  { id: 'k8', num: '8', title: 'Ruhelage und Gleichgewicht', plates: [Schere] },
  { id: 'k9', num: '9', title: 'Lagerbindungen und Lagerkräfte', plates: [Lager] },
  { id: 'k10', num: '10', title: 'Statik der Systeme', plates: [Dreigelenk] },
  { id: 'k11', num: '11', title: 'Fachwerke', plates: [Fachwerk] },
  { id: 'k12', num: '12', title: 'Reibung', plates: [Reibung] },
  { id: 'k13', num: '13', title: 'Seilstatik', plates: [Kettenlinie, Seilreibung] },
  { id: 'k14', num: '14', title: 'Beanspruchung', plates: [Schnitt] },
];

/** Chapters as in the Lernskript (hs/analysis1). */
const ANALYSIS: Chapter[] = [
  { id: 'a1', num: '1', title: 'Folgen, Reihen und Funktionen', plates: [EpsSchlauch, GeoReihe, Bisektion, Umkehr] },
  { id: 'a2', num: '2', title: 'Differentialrechnung', plates: [Differenzenquotient, Ableitungsfunktion, Mittelwertsatz, Kruemmung] },
  { id: 'a3', num: '3', title: 'Komplexe Zahlen', plates: [Euler, KMult, Wurzeln] },
  { id: 'a4', num: '4', title: 'Integralrechnung', plates: [Riemann, Hauptsatz, Rotationskoerper] },
  { id: 'a5', num: '5', title: 'Reihen, Potenzreihen und Taylor', plates: [Taylor, Konvergenzradius, Leibniz] },
];

const count = (ch: Chapter[]) => ch.reduce((n, c) => n + c.plates.length, 0);
export const SUBJECTS: Subject[] = [
  { id: 'mechanik', name: 'Mechanik 1', title: 'Mechanik 1 in bewegten Tafeln', chapters: MECHANIK,
    lede: `${count(MECHANIK)} Figuren zum Lernskript, eine pro Begriff. Jede Bewegung ist aus den Gleichungen berechnet, nicht gezeichnet.` },
  { id: 'analysis', name: 'Analysis I', title: 'Analysis I in bewegten Tafeln', chapters: ANALYSIS,
    lede: `${count(ANALYSIS)} Figuren zum Lernskript: Grenzwerte, Ableitungen, komplexe Zahlen, Integrale und Reihen. Jede Kurve ist berechnet.` },
];
/** Which subject a hash belongs to: its own id, or one of its chapter or plate anchors. */
export function subjectOf(hash: string): Subject {
  const byPath = typeof location !== 'undefined' && /\/analysis\/?$/.test(location.pathname) ? SUBJECTS[1] : SUBJECTS[0];
  return SUBJECTS.find((s) => s.id === hash || s.chapters.some((c) => c.id === hash)) ?? byPath;
}
