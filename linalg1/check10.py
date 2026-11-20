from sympy import *
A=Matrix([[2,1,0],[1,3,1],[0,1,2]]); b=Matrix([1,2,3]); x=A.LUsolve(b); print(x.T, A.det())
for i in range(3):
    Ai=A.copy(); Ai[:,i]=b; print(Ai.det(), Ai.det()/A.det())
print(A.adjugate()/A.det()==A.inv())
# 2x2 Cramer
B=Matrix([[3,2],[1,4]]); c=Matrix([9,8]); print(B.LUsolve(c).T, B.det(), Matrix([[9,2],[8,4]]).det(), Matrix([[3,9],[1,8]]).det())
# Adjunkte Beispiel 3x3 mit anderem A
C=Matrix([[1,2,3],[0,1,4],[5,6,0]]); print(C.adjugate(), C.det())
# komplexe Zahlen
z=(1+2*I)*(3-I); print(expand(z))
# positive reelle Zahlen als VR: 0-Vektor = 1; a (+) b = a*b; c (.) a = a^c
