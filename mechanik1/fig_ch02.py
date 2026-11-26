from figlib import *

def curve(u): return P(2.4 + 9.6 * u, 1.9 + 2.2 * np.sin(2.7 * u + 0.15))
def dcurve(u): return (curve(u + 1e-4) - curve(u - 1e-4)) / 2e-4

# ---------- 2.1 Ableitung ----------
def ableitung():
    f = Fig(15.8, 5.4)
    us = np.linspace(0.02, 0.98, 100); f.path([curve(u) for u in us], c=GREY, lw=1.1)
    o = P(0.9, 0.5); f.dot(o); f.text(o, "$O$", dx=-0.3, dy=-0.1)
    a, b = curve(0.40), curve(0.76)
    f.arrow(o, a, lw=1.1); f.arrow(o, b, lw=1.1)
    f.text((o + a) / 2, r"$\mathbfit{r}(t)$", dx=-0.5, dy=0.3)
    f.text((o + b) / 2, r"$\mathbfit{r}(t+\Delta t)$", dx=1.0, dy=-0.45)
    t = unit(dcurve(0.40)); f.line(a - t * 1.4, a + t * 5.2, c=V, lw=0.7, dash=(5, 3))
    f.arrow(a, a + t * 3.0, c=V, lw=1.5); f.text(a + t * 3.0, r"$\dot{\mathbfit{r}}\,\Delta t$", c=V, dx=0.1, dy=0.5)
    f.arrow(a, b, c=V, lw=1.5); f.text((a + b) / 2, r"$\Delta\mathbfit{r}$", c=V, dx=0.0, dy=-0.55)
    f.dot(a); f.dot(b); f.text(a, "$M(t)$", dx=-0.2, dy=0.5, size=8.5); f.text(b, r"$M(t+\Delta t)$", dx=0.25, dy=0.5, size=8.5)
    f.text(curve(0.93), "Bahnkurve $C$", dx=0.5, dy=-0.5, size=8.5, c=GREY)
    f.text(a + t * 5.2, "Tangente", c=V, size=8, dx=0.3, dy=0.25)
    f.save("k02_ableitung")

# ---------- 2.2 Bogenlänge ----------
def bogen():
    f = Fig(15.8, 4.7)
    us = np.linspace(0.02, 0.98, 100); f.path([curve(u) for u in us], c=GREY, lw=1.1)
    A, M_ = curve(0.12), curve(0.62)
    f.path([curve(u) for u in np.linspace(0.12, 0.62, 60)], c=INK, lw=2.4)
    f.dot(A); f.text(A, "$A$", dx=-0.1, dy=-0.4); f.dot(M_); f.text(M_, "$M$", dx=-0.15, dy=0.45)
    f.text(curve(0.37), "$s$", dx=0.1, dy=-0.5, size=10)
    o = P(0.9, 0.5); f.dot(o); f.text(o, "$O$", dx=-0.3, dy=0.0); f.arrow(o, M_, lw=1.0); f.text((o + M_) / 2, r"$\mathbfit{r}$", dx=0.45, dy=-0.25)
    t = unit(dcurve(0.62))
    f.arrow(M_, M_ + t * 3.1, c=V, lw=1.5); f.text(M_ + t * 3.1, r"$\mathbfit{v}=\dot s\,\boldsymbol{\tau}$", c=V, dx=0.1, dy=0.5)
    f.arrow(M_, M_ + t * 1.1, c=INK, lw=1.6, z=6); f.text(M_ + t * 0.9, r"$\boldsymbol{\tau}$", dx=0.0, dy=-0.45, size=10)
    f.save("k02_bogen")

# ---------- 2.3 Ableitung der Basisvektoren ----------
def basisableitung():
    f = Fig(15.8, 5.4)
    o = P(2.7, 0.9); R = 3.1
    f.axes2(o, 3.9, 3.9, neg=0.0)
    f.arc(o, R, 0, 90, col=GREY, lw=0.7, dash=(4, 3))
    a0, a1 = 26, 60
    p0, p1 = pol(o, R, a0), pol(o, R, a1)
    f.arrow(o, p0, lw=1.3); f.arrow(o, p1, c=GREY, lw=1.0)
    f.line(p0, p0 + 1.6 * nrm(p0 - o), c=INK, lw=0.6, dash=(4, 3))
    f.arrow(p0, p1, c=V, lw=1.7)
    f.text(o + (p0 - o) * 0.55, r"$\mathbfit{e}_\rho(t)$", dx=0.2, dy=-0.5, size=9)
    f.text(o + (p1 - o) * 0.5, r"$\mathbfit{e}_\rho(t+\Delta t)$", c=GREY, size=8.5, dx=-1.5, dy=0.25)
    f.text((p0 + p1) / 2, r"$\Delta\mathbfit{e}_\rho$", c=V, dx=0.75, dy=0.15)
    f.text(p0 + 1.65 * nrm(p0 - o), r"Richtung $\mathbfit{e}_\varphi$", dx=-0.7, dy=0.55, size=8.5)
    f.angle(o, 1.1, a0, a1, label=r"$\Delta\varphi$", lr=1.5, size=8.5); f.angle(o, 0.7, 0, a0, label=r"$\varphi$", lr=0.98, size=8.5)
    f.cap((4.0, 0.2), "Einheitskreis: $|\\Delta\\mathbfit{e}_\\rho|\\approx\\Delta\\varphi$", size=8)
    o = P(10.2, 0.9)
    rho, dr_, ph, dph = 2.9, 1.5, 24, 26
    P1, P2, P3, P4 = pol(o, rho, ph), pol(o, rho, ph + dph), pol(o, rho + dr_, ph + dph), pol(o, rho + dr_, ph)
    f.line(o, pol(o, rho + dr_ + 0.9, ph), c=GREY, lw=0.6, dash=(4, 3)); f.line(o, pol(o, rho + dr_ + 0.9, ph + dph), c=GREY, lw=0.6, dash=(4, 3))
    f.axes2(o, 4.6, 4.0, neg=0.0)
    f.arc(o, rho, ph - 4, ph + dph + 6, col=GREY, lw=0.7); f.arc(o, rho + dr_, ph - 4, ph + dph + 6, col=GREY, lw=0.7)
    f.arrow(P1, P4, c=INK, lw=1.3); f.arrow(P4, P3, c=INK, lw=1.3); f.arrow(P1, P3, c=V, lw=1.7)
    f.dot(P1)
    f.text((P1 + P4) / 2, r"$\mathrm{d}\rho$", dx=0.2, dy=-0.5, size=9)
    f.text((P4 + P3) / 2, r"$\rho\,\mathrm{d}\varphi$", dx=0.55, dy=0.45, size=9)
    f.text((P1 + P3) / 2, r"$\mathrm{d}\mathbfit{r}$", c=V, dx=-0.5, dy=0.15, size=9.5)
    f.angle(o, 1.3, ph, ph + dph, label=r"$\mathrm{d}\varphi$", lr=1.8, size=8.5)
    f.cap((11.5, 0.2), "Wegelement in Polarkoordinaten", size=8)
    f.save("k02_basisableitung")

# ---------- 2.4 Kreisbewegung ----------
def kreis():
    f = Fig(15.8, 6.0)
    o = P(5.0, 0.9); z0, R = 2.5, 2.5
    c = f.proj(o, 0, 0, z0)
    f.line(o + P(0, -0.2), o + P(0, 5.2), c=GREY, lw=0.7, dash=(6, 3, 1, 3))
    ell = [f.proj(o, R * np.cos(rad(a)), R * np.sin(rad(a)), z0) for a in np.linspace(0, 360, 120)]
    f.path(ell, c=GREY, lw=0.9, closed=True)
    am = 62
    Mp = f.proj(o, R * np.cos(rad(am)), R * np.sin(rad(am)), z0)
    d = f.proj(o, -np.sin(rad(am)), np.cos(rad(am)), 0) - o
    f.dot(o); f.text(o, "$O$", dx=-0.3, dy=-0.1)
    f.arrow(o, Mp, c=INK, lw=1.3); f.text(o + (Mp - o) * 0.55, r"$\mathbfit{r}$", dx=0.4, dy=-0.2)
    f.line(c, Mp, c=GREY, lw=0.7, dash=(4, 3)); f.text(c + (Mp - c) * 0.5, "$R$", dx=0.0, dy=0.3, size=8.5)
    f.arrow(Mp, Mp + unit(d) * 2.3, c=V, lw=1.6); f.text(Mp + unit(d) * 2.3, r"$\mathbfit{v}$", c=V, dx=0.3, dy=0.15)
    f.dot(Mp); f.text(Mp, "$M$", dx=0.2, dy=-0.4)
    f.arrow(c, c + P(0, 2.0), c=M, lw=1.6); f.text(c + P(0, 1.75), r"$\boldsymbol{\omega}$", c=M, dx=0.35, dy=0.0, size=10)
    # Drehsinn als waagrechter Kreis um die Achse (rechte Hand: von oben gesehen im Gegenuhrzeigersinn)
    ring = f.circle3(o, (0, 0, z0 + 1.25), 0.55, t0=-150, t1=170, n=120)
    f.path(ring[:-6], c=M, lw=1.0, z=6); f.head(ring[-1], ring[-1] - ring[-7], c=M, hl=0.2, z=6)
    f.cap((11.2, 4.4), "$|\\mathbfit{v}|=\\omega R$", size=9.5); f.cap((11.2, 3.6), "$\\mathbfit{v}\\perp\\boldsymbol{\\omega},\\ \\mathbfit{v}\\perp\\mathbfit{r}$", size=9.5)
    f.cap((11.2, 2.8), "$\\boldsymbol{\\omega}=\\dot\\varphi\\,\\mathbfit{e}_z$", size=9.5, c=M)
    f.save("k02_kreis")

ableitung(); bogen(); basisableitung(); kreis()
