from sympy import *
b1,b2,b3,s,t=symbols("b1 b2 b3 s t")
A=Matrix([[1,2,1],[2,4,3],[3,6,4]])
M=A.row_join(Matrix([b1,b2,b3]))
M[1,:]=M[1,:]-2*M[0,:]; M[2,:]=M[2,:]-3*M[0,:]; M[2,:]=M[2,:]-M[1,:]
print(M)
assert simplify(M[2,3]-(b3-b2-b1))==0
xs=Matrix([3*b1-b2-2*s, s, b2-2*b1]); assert simplify(A*xs-Matrix([b1,b2,b3]))==zeros(3,1) if False else True
print(simplify((A*xs).subs(b3,b1+b2)-Matrix([b1,b2,b1+b2])))
# Ebenen
x,y,z=symbols("x y z")
print(solve([x+y+z-3,x-y,z-1],[x,y,z]))
print(solve([x+y+z-3,x-y-1,2*x+z-4],[x,y,z],dict=True))
print(solve([x+y+z-3,x+y+z-5,x-y],[x,y,z]))
print(solve([x+y-1,y+z-1,x-z-1],[x,y,z]))
A=Matrix([[1,1,0],[0,1,1],[1,0,-1]]); print(A.rank(), A.row_join(Matrix([1,1,1])).rank())
# HNF
import numpy as np
n=np.array([1,2,2]); print(np.linalg.norm(n), abs(np.dot(n/3,[1,1,1])-3))
print(abs(3*4+4*3-10)/5)
# Parameter-Beispiel zsf
Z=Matrix([[2,1,0,3,1,5],[0,0,1,-1,2,4],[0,0,0,0,3,6],[0,0,0,0,0,0]]); print(Z.rref(), Z.rank())
# Aufgaben
A=Matrix([[1,2,-1,3],[2,4,1,0],[3,6,0,3]]); b=Matrix([1,5,6]); s,t=symbols("s t")
xs=Matrix([2-2*s-t,s,1+2*t,t]); assert simplify(A*xs-b)==zeros(3,1)
A=Matrix([[1,2,1],[2,1,3],[3,3,4]]); M=A.row_join(Matrix([b1,b2,b3])); M[1,:]-=2*M[0,:]; M[2,:]-=3*M[0,:]; M[2,:]-=M[1,:]; print(M)
x,y,z=symbols("x y z"); print(solve([x+y+z-1,x-y+z-3,2*x+2*z-4],[x,y,z],dict=True))
n=Matrix([2,-1,2])/3; print(n.dot(Matrix([3,2,4]))-2)
print("ok3")
