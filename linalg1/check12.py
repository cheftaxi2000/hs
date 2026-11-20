from sympy import *
A=Matrix([[1,2,1],[2,4,3],[3,6,4]]); print(A.columnspace(), A.nullspace(), A.rank())
for v in ([2,3,5],[1,2,3],[1,2,4]):
    M=Matrix([[1,0],[1,1],[2,1]]); print(v, M.row_join(Matrix(v)).rank()==M.rank())
V=Matrix([[1,1,0],[0,1,1],[1,0,-1]]).T; print(V.rank(), V.nullspace())
W=Matrix([[1,2,1],[2,1,0],[0,3,2]]).T; print(W.rank(), W.nullspace())
print(Matrix([[1,2,3],[2,4,6]]).T.rank())
# 4 Vektoren im R^3
print(Matrix([[1,0,0],[0,1,0],[0,0,1],[1,1,1]]).T.rank(), Matrix([[1,0,0],[0,1,0],[0,0,1],[1,1,1]]).T.nullspace())
# span{(1,0,1),(0,1,2)} = {x+2y-z=0}
x,y,z=symbols("x y z"); print((x+2*y-z).subs({x:1,y:0,z:1}), (x+2*y-z).subs({x:0,y:1,z:2}))
# symm 2x2 erzeugend
# Beispiel Aufgabe
print(Matrix([[1,2,1],[1,3,2],[1,1,0]]).det())
# Unabhaengigkeit der Funktionen: Wronski det (1,x,x^2)
x=symbols("x"); print(Matrix([[1,x,x**2],[0,1,2*x],[0,0,2]]).det())
