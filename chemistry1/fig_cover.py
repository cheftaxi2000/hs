"""Cover: volume rendering of a hydrogen orbital (Chapter 6).
Glow = probability density |psi|^2, colour = sign of psi, on a deep plum background."""
import numpy as np, math, sys

def laguerre(k, a, x):
    L0, L1 = np.ones_like(x), 1 + a - x
    if k == 0: return L0
    for j in range(1, k):
        L0, L1 = L1, ((2 * j + 1 + a - x) * L1 - (j + a) * L0) / (j + 1)
    return L1

def legendre(l, m, x):
    pmm = np.ones_like(x)
    if m > 0: pmm = (-1) ** m * math.prod(range(1, 2 * m, 2)) * (1 - x * x) ** (m / 2)
    if l == m: return pmm
    pm1 = x * (2 * m + 1) * pmm
    if l == m + 1: return pm1
    for ll in range(m + 2, l + 1):
        pmm, pm1 = pm1, ((2 * ll - 1) * x * pm1 - (ll + m - 1) * pmm) / (ll - m)
    return pm1

def psi(n, l, m, X, Z):          # in the xz-plane (used by fig_ch06)
    r = np.hypot(X, Z) + 1e-12; ct = Z / r; rho = 2 * r / n
    R = rho ** l * np.exp(-rho / 2) * laguerre(n - l - 1, 2 * l + 1, rho)
    return R * legendre(l, abs(m), ct) * (np.sign(X) ** abs(m) if m != 0 else 1)

def psi3(n, l, m, x, y, z):
    r = np.sqrt(x * x + y * y + z * z) + 1e-12; ct = z / r; rho = 2 * r / n
    R = rho ** l * np.exp(-rho / 2) * laguerre(n - l - 1, 2 * l + 1, rho)
    ph = np.arctan2(y, x)
    ang = legendre(l, abs(m), ct) * (np.cos(m * ph) if m >= 0 else np.sin(-m * ph))
    return R * ang

if __name__ == "__main__":
    from PIL import Image, ImageFilter
    from render_orbital import render, rot
    W, H = 2480, 2197                         # 21.0 x 18.6 cm at 300 dpi
    yy, xx = np.mgrid[0:H, 0:W].astype(float)
    # background: deep plum, lighter halo behind the hero orbital
    hx, hy = 0.61 * W, 0.50 * H
    r = np.hypot((xx - hx) / W, (yy - hy) / W)
    top = np.array([0.24, 0.09, 0.27]); bot = np.array([0.045, 0.02, 0.07])
    t = np.clip(r / 0.75, 0, 1)[..., None] ** 0.9
    canvas = top * (1 - t) + bot * t
    # fine concentric rings around the hero (like Bohr shells), very faint
    for R0 in [0.30, 0.40, 0.52, 0.66]:
        d = np.abs(np.hypot(xx - hx, yy - hy) - R0 * W)
        canvas += (np.exp(-(d / 1.6) ** 2) * 0.10)[..., None] * np.array([1.0, 0.85, 0.95])
    # tiny "electron" dots on the rings
    rng = np.random.default_rng(5)
    for R0 in [0.30, 0.40, 0.52, 0.66]:
        for a in rng.uniform(0, 2 * np.pi, 3):
            cx_, cy_ = hx + R0 * W * np.cos(a), hy + R0 * W * np.sin(a)
            d2 = (xx - cx_) ** 2 + (yy - cy_) ** 2
            canvas += (np.exp(-d2 / (2 * 6.0 ** 2)) * 0.9 + np.exp(-d2 / (2 * 30.0 ** 2)) * 0.12)[..., None] * np.array([1.0, 0.82, 0.55])

    def place(q, ext, size, cx, cy, Rm, blur=0.0, iso=0.12, dim=1.0, glow=0.35):
        global canvas
        S_ = int(size * 1.9)
        img, a, _ = render(q, ext, S_, S_, size, iso=iso, Rm=Rm)
        img = img * dim
        pil = Image.fromarray((img * 255).astype(np.uint8)); pa = Image.fromarray((a * 255).astype(np.uint8))
        # supersampled edges: blur alpha slightly
        pa = pa.filter(ImageFilter.GaussianBlur(0.8 + blur))
        if blur: pil = pil.filter(ImageFilter.GaussianBlur(blur))
        img = np.asarray(pil).astype(float) / 255; a = np.asarray(pa).astype(float) / 255
        x0, y0 = int(cx - S_ / 2), int(cy - S_ / 2)
        xa, ya = max(x0, 0), max(y0, 0); xb, yb = min(x0 + S_, W), min(y0 + S_, H)
        sub_i = img[ya - y0:yb - y0, xa - x0:xb - x0]; sub_a = a[ya - y0:yb - y0, xa - x0:xb - x0, None]
        # glow: blurred copy added (screen) around the object
        g = Image.fromarray((np.clip(img * a[..., None], 0, 1) * 255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(size * 0.08))
        g = np.asarray(g).astype(float)[ya - y0:yb - y0, xa - x0:xb - x0] / 255 * glow
        reg = canvas[ya:yb, xa:xb]
        reg = 1 - (1 - reg) * (1 - g)
        canvas[ya:yb, xa:xb] = reg * (1 - sub_a) + sub_i * sub_a

    # small, out-of-focus orbitals in the background
    place((2, 1, 0), 9, 300, 0.10 * W, 0.80 * H, rot("z", 0.9) @ rot("x", -0.6), blur=5, dim=0.55, glow=0.25)
    place((3, 2, 0), 16, 420, 0.15 * W, 0.20 * H, rot("z", -0.5) @ rot("x", -1.2), blur=3.5, dim=0.7, glow=0.3)
    place((4, 3, 0), 26, 330, 0.93 * W, 0.12 * H, rot("z", 0.3) @ rot("x", -0.9), blur=6, dim=0.5, glow=0.25)
    place((3, 2, 2), 16, 260, 0.88 * W, 0.90 * H, rot("z", 0.2) @ rot("x", -0.5), blur=7, dim=0.45, glow=0.25)
    # hero: a g orbital (n = 5, l = 4)
    place((5, 4, 2), 44, 1360, hx, hy, rot("z", 0.5) @ rot("x", -1.1), glow=0.45)
    canvas = np.clip(canvas, 0, 1)
    # subtle film grain against banding
    canvas += rng.normal(0, 0.006, canvas.shape)
    Image.fromarray((np.clip(canvas, 0, 1) * 255).astype(np.uint8)).save("figs/cover.jpg", quality=93, subsampling=0)
