from sympy import *
import numpy as np
x=symbols("x")
# Basiswechsel
B=Matrix([[1,1],[1,-1]]); C=Matrix([[1,1],[0,2]]); T=C.inv()*B; print(T, T*Matrix([2,1]), C.inv()*Matrix([3,1]))
# Ableitung P2->P1
D=Matrix([[0,1,0],[0,0,2]]); print(D*Matrix([2,3,-1]))   # p=2+3x-x^2 -> p'=3-2x -> (3,-2)
# Projektion
a=Matrix([1,2]); P=a*a.T/(a.T*a)[0]; print(P, P*P==P, P*Matrix([3,1]), P.rank())
# Interpolation
t=symbols("t"); V=Matrix([[1,0,0],[1,1,1],[1,2,4]]); print(V.det(), V.LUsolve(Matrix([1,0,3])).T)
# Rangsatz Beispiel
A=Matrix([[1,2,0,1],[2,4,1,5],[3,6,1,6]]); print(A.rank(), len(A.nullspace()))
# Kontraktion Fixpunkt
f=lambda v: v/2+np.array([1,1]); v=np.array([0.0,0.0])
for _ in range(6): v=f(v); print(v)
# Barnsley contractivity
mats=[np.array([[0,0],[0,.16]]),np.array([[.85,.04],[-.04,.85]]),np.array([[.2,-.26],[.23,.22]]),np.array([[-.15,.28],[.26,.24]])]
for M in mats: print(np.linalg.norm(M,2), abs(np.linalg.det(M)))
print(sum([0.01,0.85,0.07,0.07]))
# Sierpinski dimension
print(np.log(3)/np.log(2), np.log(2)/np.log(3))
# Drehung um Punkt p=(1,0) um 90 Grad: x -> R(x-p)+p ; Bild von (2,0): (1,1)
R=Matrix([[0,-1],[1,0]]); p=Matrix([1,0]); print(R*(Matrix([2,0])-p)+p)
