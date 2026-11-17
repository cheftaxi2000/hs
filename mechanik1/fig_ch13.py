from figlib import *
def kette():
    f = Fig(15.8, 5.4)
    o = P(3.6, 0.7)
    f.arrow((0.4, o[1]), (7.0, o[1]), lw=0.7, head=0.6); f.arrow((3.6, 0.5), (3.6, 4.9), lw=0.7, head=0.6); f.text((7.25, o[1]), "$x$"); f.text((3.6, 5.1), "$y$")
    xs = np.linspace(-2.0, 2.0, 80); a = 1.2
    f.path([(3.6 + x, o[1] + a * np.cosh(x / a)) for x in xs], lw=1.5)
    f.dot((3.6, o[1] + a), 0.07); f.text((3.6, o[1] + a), "$A$", dx=-0.3, dy=0.3)
    f.dim((3.6, o[1]), (3.6, o[1] + a), "$a$", off=0.35, size=9)
    xp = 1.3; yp = o[1] + a * np.cosh(xp / a); P_ = P(3.6 + xp, yp); f.dot(P_, 0.07)
    t = P(1.0, np.sinh(xp / a)); t = unit(t)
    f.arrow(P_, P_ + t * 1.5, c=F, lw=1.6); f.text(P_ + t * 1.5, r"$\mathbfit{S}$", c=F, dx=0.2, dy=0.35)
    f.arrow(P_, P_ + P(1.2, 0), c=F, lw=0.9, dash=(4, 3)); f.arrow(P_ + P(1.2, 0), P_ + t * 1.5, c=F, lw=0.9, dash=(4, 3))
    f.text(P_ + P(0.8, -0.3), "$H$", c=F, size=9); f.text(P_ + P(1.5, 0.5), "$V$", c=F, size=9)
    f.guide((3.6 + xp, o[1]), P_); f.text((3.6 + xp, o[1]), "$x$", dy=-0.3, size=8.5)
    # Element
    e = P(11.0, 2.2)
    pts = [e + P(-1.2, -0.6), e + P(-0.2, -0.05), e + P(0.8, 0.5), e + P(1.4, 0.9)]
    f.path(pts, lw=2.2)
    f.arrow(pts[0], pts[0] - P(1.0, 0), c=F, lw=1.4); f.text(pts[0] - P(1.0, 0), "$H$", c=F, dy=0.35, size=9, dx=0.0)
    f.arrow(pts[0], pts[0] + P(0, 0.9) * -1, c=F, lw=1.4); f.text(pts[0] - P(0, 0.9), "$V$", c=F, dx=0.35, size=9)
    f.arrow(pts[3], pts[3] + P(1.0, 0), c=F, lw=1.4); f.text(pts[3] + P(1.0, 0), "$H$", c=F, dy=0.35, size=9)
    f.arrow(pts[3], pts[3] + P(0, 1.0), c=F, lw=1.4); f.text(pts[3] + P(0, 1.0), r"$V+\mathrm{d}V$", c=F, dx=0.9, size=9)
    f.arrow(e + P(0.1, 0.1), e + P(0.1, -0.9), c=F, lw=1.4); f.text(e + P(0.1, -0.9), r"$p\,\mathrm{d}s$", c=F, dx=0.55, size=9)
    f.cap((11.0, 0.2), "Seilelement", size=8.5); f.cap((3.6, 0.1), "Kettenlinie", size=8.5)
    f.save("k13_kette")

def seilreibung():
    f = Fig(15.8, 5.0)
    c = P(3.0, 2.8); f.circle(c, 1.4, fc=LIGHT); f.dot(c, 0.06)
    f.arc(c, 1.4, 0, 180, lw=2.4)
    f.line((c[0] - 1.4, c[1]), (c[0] - 1.4, 0.9), lw=2.4); f.line((c[0] + 1.4, c[1]), (c[0] + 1.4, 0.9), lw=2.4)
    f.arrow((c[0] - 1.4, 1.1), (c[0] - 1.4, 0.3), c=F, lw=1.6); f.arrow((c[0] + 1.4, 1.1), (c[0] + 1.4, -0.0), c=F, lw=0) if False else None
    f.arrow((c[0] + 1.4, 1.5), (c[0] + 1.4, 0.2), c=F, lw=1.9)
    f.text((c[0] - 1.8, 0.7), "$S_1$", c=F, size=9.5); f.text((c[0] + 1.9, 0.8), "$S_2$", c=F, size=9.5)
    f.arc(c, 0.6, 0, 180, col=INK, lw=0.7); f.text(c + P(0, 0.9), r"$\alpha$", size=9)
    # Element
    e = P(11.0, -0.8); R = 3.6
    f.arc(e, R, 62, 118, lw=2.2)
    f.line(e, pol(e, R + 0.0, 62), c=GREY, lw=0.6, dash=(4, 3)); f.line(e, pol(e, R, 118), c=GREY, lw=0.6, dash=(4, 3))
    pL, pR = pol(e, R, 118), pol(e, R, 62)
    tL = P(-np.sin(rad(118)), np.cos(rad(118))) * -1; tR = P(-np.sin(rad(62)), np.cos(rad(62)))
    f.arrow(pL, pL + unit(P(-np.sin(rad(118)), np.cos(rad(118)))) * 1.2, c=F, lw=1.5); f.text(pL + unit(P(-np.sin(rad(118)), np.cos(rad(118)))) * 1.2, "$S$", c=F, dx=-0.3, dy=0.3, size=9)
    f.arrow(pR, pR - unit(P(-np.sin(rad(62)), np.cos(rad(62)))) * 1.2, c=F, lw=1.5); f.text(pR - unit(P(-np.sin(rad(62)), np.cos(rad(62)))) * 1.2, r"$S+\mathrm{d}S$", c=F, dx=0.9, dy=0.3, size=9)
    m = pol(e, R, 90); f.arrow(m + P(0, -1.0), m, c=F, lw=1.5); f.text(m + P(0.5, -0.7), r"$\mathrm{d}N$", c=F, size=9)
    f.arrow(m, m + P(-1.0, 0), c=F, lw=1.5); f.text(m + P(-1.0, 0.35), r"$\mu\,\mathrm{d}N$", c=F, size=9)
    f.arc(e, 1.6, 62, 118, lw=0.7); f.text(e + P(0, 1.95), r"$\mathrm{d}\varphi$", size=9)
    f.cap((11.0, 4.75), "Seilelement mit Reibung", size=8.5); f.cap((3.0, 4.75), "Seil über raue Rolle", size=8.5)
    f.save("k13_seilreibung")
kette(); seilreibung()
