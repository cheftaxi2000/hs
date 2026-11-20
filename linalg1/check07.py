from sympy import *
p,q,al,be=symbols("phi psi alpha beta", real=True)
R=lambda t: Matrix([[cos(t),-sin(t)],[sin(t),cos(t)]])
S=lambda a: Matrix([[cos(2*a),sin(2*a)],[sin(2*a),-cos(2*a)]])
assert simplify(R(p)*R(q)-R(p+q))==zeros(2,2)
assert simplify(S(al)*S(be)-R(2*(al-be)))==zeros(2,2)
assert simplify(R(p)*S(al)-S(al+p/2))==zeros(2,2)
assert simplify(S(al)*R(p)-S(al-p/2))==zeros(2,2)
assert simplify(S(al)*S(al))==eye(2) or simplify(S(al)*S(al)-eye(2))==zeros(2,2)
assert simplify(S(al).det()+1)==0 and simplify(R(p).det()-1)==0
print(R(pi/2)*Matrix([1,2]), S(pi/4), S(0))
# Spiegelung an Gerade Richtung u = (cos a, sin a): S = 2 u u^T - I
u=Matrix([cos(al),sin(al)]); assert simplify(2*u*u.T-eye(2)-S(al))==zeros(2,2)
# LR
A=Matrix([[2,1,1],[4,3,3],[8,7,9]])
L,U,perm=A.LUdecomposition(); print(L,U,perm)
# 4x4 Beispiel fuer Aufgabe
B=Matrix([[1,2,1],[3,8,5],[2,7,7]]); print(B.LUdecomposition())
# Winkel
x=Matrix([1,1,0]); y=Matrix([0,1,1]); print(acos(x.dot(y)/(x.norm()*y.norm())))
# Cauchy-Schwarz Beispiel
print((x.dot(y))**2, x.dot(x)*y.dot(y))
# Rotation 60 deg
print(R(pi/3), S(pi/6))
