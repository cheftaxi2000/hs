from sympy import *
import numpy as np
A=Matrix([[0,1],[0,0]]); print(A*A)
A=Matrix([[1,0],[0,0]]); B=Matrix([[1,2],[3,4]]); C=Matrix([[1,2],[5,6]]); print(A*B, A*C, A*B==A*C)
F=Matrix([[1,1],[1,0]]); print(F**5, F**10)
# Elementarmatrizen
M=Matrix([[1,2,3],[4,5,6],[7,8,9]])
E1=Matrix([[0,1,0],[1,0,0],[0,0,1]]); E2=Matrix([[1,0,0],[0,3,0],[0,0,1]]); E3=Matrix([[1,0,0],[-4,1,0],[0,0,1]])
print(E1*M, E2*M, E3*M); print(M*E1)
# Transposition
A=Matrix([[1,2,3],[0,1,-1]]); B=Matrix([[1,0],[2,1],[0,3]])
assert (A*B).T==B.T*A.T
assert (A.T*A).T==A.T*A
# Spur
P=Matrix([[1,2],[3,4]]); Q=Matrix([[0,1],[1,5]]); assert (P*Q).trace()==(Q*P).trace(); print((P*Q).trace())
# Spalten- und Zeilenstruktur Beispiel
A=Matrix([[1,2,3],[0,1,-1]]); B=Matrix([[1,0],[2,1],[0,3]])
print(A*B[:,1], (A*B)[:,1], A[1,:]*B, (A*B)[1,:])
# (A+B)^2
X=Matrix([[1,1],[0,1]]); Y=Matrix([[1,0],[1,1]]); print((X+Y)**2, X**2+2*X*Y+Y**2, X**2+X*Y+Y*X+Y**2)
# AB=0
print(Matrix([[1,0],[0,0]])*Matrix([[0,0],[0,1]]))
