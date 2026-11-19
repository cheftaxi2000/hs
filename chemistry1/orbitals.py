"""Hydrogen-atom wavefunctions (used for the cover and Fig. 6.4)."""
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

