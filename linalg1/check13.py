from sympy import *
x=symbols("x")
print(Matrix([[1,1],[1,-1]]).LUsolve(Matrix([3,1])).T)
p=2+3*x-x**2; print(expand(4+(x-1)-(x-1)**2-p), p.subs(x,1), diff(p,x).subs(x,1), diff(p,x,2).subs(x,1)/2)
# Pivotspalten Basis des Bildes
A=Matrix([[1,2,0,1],[2,4,1,5],[3,6,1,6]]); print(A.rref(), A.columnspace())
print(A.T.rank(), A.rank(), A.rowspace())
# Basis von {x+2y-z=0}
print(Matrix([[1,2,-1]]).nullspace())
# Basisergaenzung: (1,1,0),(0,1,1) zu Basis R^3
print(Matrix([[1,1,0],[0,1,1],[0,0,1]]).det(), Matrix([[1,1,0],[0,1,1],[1,0,0]]).det())
# dim Symm 3x3 = 6; dim antisym = 3
# Basiswechsel R^2: B=(1,1),(1,-1) ; C=(1,0),(1,2)
Bm=Matrix([[1,1],[1,-1]]); Cm=Matrix([[1,1],[0,2]]); T=Cm.inv()*Bm; print(T)
print(Matrix([[1,2,3],[2,4,6],[1,0,1]]).rank())
