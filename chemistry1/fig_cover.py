"""Cover: probability densities of hydrogen orbitals (Chapter 6), cut through the xz-plane.
The two signs of the wavefunction get two colours (amber / rose) on a dark plum background."""
import numpy as np, math, matplotlib
matplotlib.use("agg")
import matplotlib.pyplot as plt

def laguerre(k, a, x):            # generalised Laguerre polynomial L_k^a(x)
    L0, L1 = np.ones_like(x), 1 + a - x
    if k == 0: return L0
    for j in range(1, k):
        L0, L1 = L1, ((2 * j + 1 + a - x) * L1 - (j + a) * L0) / (j + 1)
    return L1

def legendre(l, m, x):            # associated Legendre P_l^m(x), m >= 0
    pmm = np.ones_like(x)
    if m > 0: pmm = (-1) ** m * math.prod(range(1, 2 * m, 2)) * (1 - x * x) ** (m / 2)
    if l == m: return pmm
    pm1 = x * (2 * m + 1) * pmm
    if l == m + 1: return pm1
    for ll in range(m + 2, l + 1):
        pmm, pm1 = pm1, ((2 * ll - 1) * x * pm1 - (ll + m - 1) * pmm) / (ll - m)
    return pm1

def psi(n, l, m, X, Z):
    r = np.hypot(X, Z) + 1e-12; ct = Z / r
    rho = 2 * r / n
    R = rho ** l * np.exp(-rho / 2) * laguerre(n - l - 1, 2 * l + 1, rho)
    ang = legendre(l, abs(m), ct) * (np.sign(X) ** abs(m) if m != 0 else 1)   # cos(m phi) with phi = 0 / pi
    return R * ang

orbs = [(1,0,0),(2,0,0),(2,1,0),(2,1,1),(3,0,0),
        (3,1,0),(3,2,0),(3,2,1),(4,1,1),(4,0,0),
        (4,1,0),(4,2,0),(4,2,1),(4,3,0),(4,3,1),
        (4,3,2),(4,3,3),(5,2,1),(5,3,0),(5,4,2)]
W, H = 21.0, 18.6; nx, ny = 5, 4
dpi = 300
fig = plt.figure(figsize=(W / 2.54, H / 2.54), dpi=dpi)
ax = fig.add_axes([0, 0, 1, 1]); ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off")
BG = np.array([0x24, 0x12, 0x2e]) / 255
PO = np.array([0xf6, 0xb9, 0x4a]) / 255     # amber  (psi > 0)
NE = np.array([0xe8, 0x5d, 0x8a]) / 255     # rose   (psi < 0)
CORE = np.array([0xfb, 0xf1, 0xdc]) / 255   # cream highlight
ax.add_patch(plt.Rectangle((0, 0), W, H, fc=BG, ec="none"))
dx, dy = W / nx, H / ny; N = 520
for idx, (n, l, m) in enumerate(orbs):
    i, j = idx % nx, ny - 1 - idx // nx
    ext = {1: 4.5, 2: 11, 3: 21, 4: 34, 5: 50}[n]
    t = np.linspace(-ext, ext, N); X, Z = np.meshgrid(t, t)
    p = psi(n, l, m, X, Z); d = p * p
    d = (d / d.max()) ** 0.38
    s = np.sign(p)[..., None]
    col = np.where(s > 0, PO, NE)
    col = col * (1 - 0.55 * d[..., None] ** 3) + CORE * 0.55 * d[..., None] ** 3
    img = BG * (1 - d[..., None]) + col * d[..., None]
    # round vignette so the tiles melt into the background
    rr = np.hypot(X, Z) / ext; fade = np.clip((1 - rr) / 0.25, 0, 1)[..., None]
    img = BG * (1 - fade) + img * fade
    cx, cy = (i + 0.5) * dx, (j + 0.5) * dy; R = 0.47 * min(dx, dy)
    ax.imshow(img, extent=(cx - R, cx + R, cy - R, cy + R), origin="lower", interpolation="bicubic", zorder=2)
    lab = "spdfg"[l]
    ax.text(cx + R * 0.98, cy - R * 0.98, f"{n}{lab}", color="#f6efe2", alpha=0.55, fontsize=7,
            ha="right", va="bottom", family="DejaVu Sans", zorder=3)
fig.savefig("figs/cover.png", dpi=dpi)
fig.savefig("/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/cover_chem.png", dpi=60)
