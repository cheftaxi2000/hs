from sympy import *
a,b,c=symbols("a b c")
V=Matrix([[1,a,a**2],[1,b,b**2],[1,c,c**2]]); print(factor(V.det()))
# Block
M=Matrix([[1,2,5,6],[3,4,7,8],[0,0,2,1],[0,0,3,5]]); print(M.det(), Matrix([[1,2],[3,4]]).det()*Matrix([[2,1],[3,5]]).det())
# via LR
A=Matrix([[2,1,1],[4,3,3],[8,7,9]]); print(A.det())
B=Matrix([[0,2,1],[1,1,1],[2,1,3]]); print(B.det())
# R aus PA=LR: diag 2,1/2,3 ; P = swap(1,3): det P=-1 -> det A = -1 * (2*1/2*3) = -3 ?
print(2*Rational(1,2)*3)
# Produktsatz Beispiel
X=Matrix([[1,2],[3,4]]); Y=Matrix([[0,1],[1,5]]); print(X.det(),Y.det(),(X*Y).det())
# cA
print(Matrix([[1,2,0],[0,1,3],[0,0,2]]).det(), (3*Matrix([[1,2,0],[0,1,3],[0,0,2]])).det())
# det(A+B)
print((X+Y).det(), X.det()+Y.det())
# Aufgabe: 4x4 via Zeilenumformung
Q=Matrix([[1,2,3,4],[2,3,4,1],[3,4,1,2],[4,1,2,3]]); print(Q.det())
# Aufgabe: det parametrisch
t=symbols("t"); print(factor(Matrix([[1,t,t],[t,1,t],[t,t,1]]).det()))
# A^-1 det
print(Matrix([[2,1],[5,3]]).det(), Matrix([[2,1],[5,3]]).inv().det())
# Orthogonal det
print(Matrix([[Rational(3,5),Rational(4,5)],[-Rational(4,5),Rational(3,5)]]).det())
