#import "lib.typ": *
#set heading(numbering: none)
= Anhang: Formelsammlung

#let fs(title, body) = block(width: 100%, breakable: false, spacing: 1.2em,
  [#text(font: "Inter", size: 9pt, weight: 600, title) #v(-4pt) #line(length: 100%, stroke: 0.4pt) #v(-2pt) #body])

#fs[Koordinaten und Geschwindigkeit (Kap. 1--2)][
  $ vr = x ve_x + y ve_y + z ve_z = rho ve_rho + z ve_z = r ve_r $
  $ x = rho cos phi = r sin theta cos psi, quad y = rho sin phi = r sin theta sin psi, quad z = r cos theta $
  $ vv = dot(vr) = dot(s) vtau, wide dot(ve)_rho = dot(phi) ve_phi, quad dot(ve)_phi = -dot(phi) ve_rho $
  $ vv = dot(x) ve_x + dot(y) ve_y + dot(z) ve_z = dot(rho) ve_rho + rho dot(phi) ve_phi + dot(z) ve_z = dot(r) ve_r + r dot(theta) ve_theta + r sin theta dot(psi) ve_psi $
  $ "Kreisbewegung:" quad vv = vom times vr, quad vom = dot(phi) ve_z, quad v = omega R $
]

#fs[Starrer Körper (Kap. 3)][
  $ "SdpG:" quad vv_M dot.c arrow(M N) = vv_N dot.c arrow(M N) wide "Grundgleichung:" quad vv_M = vv_B + vom times arrow(B M) $
  $ "Invarianten:" quad vom, quad vv_omega wide "Zentralachse:" quad arrow(B Z) = (vom times vv_B) / omega^2, quad d_Z = (|(vv_B)_perp|) / omega $
  $ "Eben:" quad vom = dot(phi) ve_z, quad vv_M perp arrow(Z M), quad v_M = omega overline(Z M) wide "Rollen:" quad v_O = omega R $
]

#fs[Leistung, Moment, Reduktion (Kap. 5--6)][
  $ PP = vF dot.c vv wide vM_O = arrow(O A) times vF, quad |vM_O| = F a wide PP = vv_B dot.c vR + vom dot.c vM_B $
  $ vR = sum vF_i, quad vM_O = sum arrow(O A_i) times vF_i wide vM_P = vM_O + arrow(P O) times vR $
  $ M_x = y Z - z Y, quad M_y = z X - x Z, quad M_z = x Y - y X $
  $ "Kräftepaar:" quad M = b F wide "Hebelgesetz:" quad a_1 F_1 = a_2 F_2 wide "Zentralachse:" quad arrow(B Z) = (vR times vM_B) / R^2 $
]

#fs[Schwerpunkt (Kap. 7)][
  $ vr_S = (sum F_i vr_i) / (sum F_i) wide R = integral q dif x, quad x_S = (integral x q dif x) / (integral q dif x) wide vr_S = (sum G_i vr_i) / (sum G_i) wide vr_C = 1/m integral vr dif m $
  Gleichlast: $R = q_0 L$ in der Mitte. Dreieckslast: $R = q_0 L\/2$ bei $2L\/3$ von der Spitze. \
  Dreieck $h\/3$, Halbkreisfläche $4R\/(3 pi)$, Halbkreisbogen $2R\/pi$, Kegel $h\/4$, Halbkugel $3R\/8$, Halbkugelschale $R\/2$.
]

#fs[Gleichgewicht (Kap. 8--11)][
  $ "PdvL:" quad tilde(PP) = 0 quad "für alle virtuellen Bewegungszustände" wide "Hauptsatz:" quad vR^((a)) = bold(0), quad vM_O^((a)) = bold(0) $
  Eben: $sum X = 0$, $sum Y = 0$, $sum M_z = 0$. Loslager 1, Gelenk 2, Einspannung 3 Unbekannte. Feder: $F = k Delta x$.
  $ "Unbestimmtheit:" quad u = n - m wide "Fachwerk:" quad u = s + r - 2k quad ("eben"), quad u = s + r - 3k quad ("räumlich") $
  Balken auf zwei Stützen mit Einzellast: $A_y = F b \/ L$, $B_y = F a \/ L$.
]

#fs[Reibung (Kap. 12)][
  $ "Haften:" quad |F_R| <= mu_0 N wide "Gleiten:" quad F_R = mu_1 N quad ("gegen" vv) wide "schiefe Ebene:" quad tan alpha <= mu_0 $
  $ "Gelenk:" quad |M_R| <= mu_0 r_L |vZ| quad "bzw." quad = mu_1 r_L |vZ| wide "Rollen:" quad |M_R| <= mu_2 N $
]

#fs[Seile (Kap. 13)][
  $ H = "konst." = p a, quad V = p s, quad S = p y wide y = a cosh(x/a), quad s = a sinh(x/a), quad y^2 - s^2 = a^2 $
  $ "flach:" quad y - a approx x^2 / (2a), quad f approx (p l^2) / (8H) wide "Seilreibung:" quad S_2 <= S_1 e^(mu_0 alpha) $
]

#fs[Beanspruchung (Kap. 14)][
  $ vR = N ve_x + Q_y ve_y + Q_z ve_z, quad vM_C = T ve_x + M_y ve_y + M_z ve_z $
  $ Q'_y = -q_y, quad M'_z = -Q_y, quad Q'_z = -q_z, quad M'_y = Q_z wide Q_y (a^+) - Q_y (a^-) = -F_y, quad M_z (b^+) - M_z (b^-) = -M $
  $ "Kreisbogen:" quad N' + Q_r + R q_phi = 0, quad Q'_r - N + R q_r = 0, quad M'_z - R Q_r = 0 $
  $ Q'_z + R q_z = 0, quad T' + M_r = 0, quad M'_r - T + R Q_z = 0 $
  Gleichlast auf zwei Stützen: $M_"max" = q_0 L^2 \/ 8$. Einzellast: $M_"max" = F a b \/ L$. Kragarm mit Endlast: $M_"max" = F L$.
]
