from sympy import *
A=Matrix([[1,2,1],[2,5,3],[1,0,8]]); print(A.det(), A.inv())
M=A.row_join(eye(3)); print(M.rref()[0])
# 2x2 Formel
a,b,c,d=symbols("a b c d"); Mx=Matrix([[a,b],[c,d]]); print(simplify(Mx*Matrix([[d,-b],[-c,a]])/(a*d-b*c)))
# (AB)^-1
X=Matrix([[1,2],[3,5]]); Y=Matrix([[2,1],[1,1]]); print((X*Y).inv()==Y.inv()*X.inv(), X.inv(), Y.inv())
# singulaer
print(Matrix([[1,2],[2,4]]).rank())
# Orthogonal
Q=Matrix([[Rational(3,5),Rational(4,5)],[-Rational(4,5),Rational(3,5)]]); print(Q.T*Q)
# Givens
x=Matrix([3,4]); r=5; c=Rational(3,5); s=Rational(4,5); G=Matrix([[c,s],[-s,c]]); print(G*x, G.det())
# Givens 3x3 elimination: eliminate entry (3,1) of vector (1,2,2)?  zero 3rd comp with rotation in plane(1,3)
v=Matrix([2,5,1]); r=sqrt(4+1); c=2/r; s=1/r
G=Matrix([[c,0,s],[0,1,0],[-s,0,c]]); print(simplify(G*v))
# Householder
x=Matrix([3,4]); e1=Matrix([1,0]); v=x-5*e1; H=eye(2)-2*v*v.T/(v.T*v)[0]; print(H, H*x, H.det(), H*H)
x3=Matrix([2,1,2]); v=x3-3*Matrix([1,0,0]); H=eye(3)-2*v*v.T/(v.T*v)[0]; print(H, H*x3, H.T==H, H*H)
# Gauss-Jordan 2x2
P=Matrix([[2,1],[5,3]]); print(P.inv())
# regulaer <-> LGS
print(Matrix([[1,2],[3,4]]).inv())
# Inverse von Elementarmatrizen
E=Matrix([[1,0,0],[-4,1,0],[0,0,1]]); print(E.inv())
A=Matrix([[1,2,3],[0,1,4],[5,6,0]]); print(A.inv(), A.det())
v=Matrix([3,2,4]); c=Rational(3,5); s=Rational(4,5); G=Matrix([[c,0,s],[0,1,0],[-s,0,c]]); print(G*v, G.T*G)
