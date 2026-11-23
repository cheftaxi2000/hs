import type { ComponentType } from 'react';
import { Koordinaten, Kreis, Sekante } from './plates/Point';
import { Leiter, Rollen, SdpG, Schraube } from './plates/Rigid';
import { Leistung, Linienlast, Reduktion, Schere, Schwerpunkt } from './plates/Forces';
import { Dreigelenk, Fachwerk, Kettenlinie, Lager, Reibung, Schnitt, Seilreibung } from './plates/Structures';

export interface Chapter { id: string; num: string; title: string; plates: ComponentType[] }

/** Chapters as in the Lernskript (hs/mechanik1). */
export const CHAPTERS: Chapter[] = [
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
