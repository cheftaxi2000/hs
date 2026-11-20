from sympy import *
a=symbols("a")
A=Matrix([[1,1,a],[1,a,1],[a,1,1]])
print(factor(A.det()))
for v in (1,-2,0,3): print(v, A.subs(a,v).rank())
# Rang Beispiel 3x4
B=Matrix([[1,2,0,1],[2,4,1,5],[3,6,1,6]]); print(B.rank(), B.rref())
# HLGS
H=Matrix([[1,2,0,1],[2,4,1,5]]); print(H.nullspace())
# Nichtkommutativ
A=Matrix([[1,2],[3,4]]); Bm=Matrix([[0,1],[1,0]]); print(A*Bm, Bm*A)
# Produkt 2x3 mal 3x2
P=Matrix([[1,2,3],[0,1,-1]]); Q=Matrix([[1,0],[2,1],[0,3]]); print(P*Q, Q*P)
# symm/antisym
C=Matrix([[1,2,3],[4,5,6],[7,8,10]]); S=(C+C.T)/2; K=(C-C.T)/2; print(S,K, S+K==C)
# Rangsatz-Fall quadratisch
print(Matrix([[1,2],[2,4]]).rank())
