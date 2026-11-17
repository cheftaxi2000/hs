from figlib import *
f = Fig(11.0, 1.0)
f.arrow((0.3, 0.5), (1.6, 0.5), c=V, lw=1.6); f.text((1.8, 0.5), "Geschwindigkeiten", c=V, ha="left", size=9.5)
f.arrow((4.7, 0.5), (6.0, 0.5), c=F, lw=1.6); f.text((6.2, 0.5), "Kräfte", c=F, ha="left", size=9.5)
f.arc((8.1, 0.5), 0.3, 200, -80, col=M, lw=1.3, arrow=True); f.text((8.65, 0.5), "Drehung, Momente", c=M, ha="left", size=9.5)
f.save("k00_farben")
