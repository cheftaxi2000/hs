from sympy import *
import numpy as np
A=Matrix([[1,1,1],[2,-1,1],[1,3,-1]]); b=Matrix([6,3,4])
assert A.LUsolve(b)==Matrix([1,2,3])
# Elementare Schritte laut Text
M=Matrix([[1,1,1,6],[2,-1,1,3],[1,3,-1,4]])
M[1,:]=M[1,:]-2*M[0,:]; M[2,:]=M[2,:]-M[0,:]; assert M==Matrix([[1,1,1,6],[0,-3,-1,-9],[0,2,-2,-2]])
M[2,:]=3*M[2,:]; M[2,:]=M[2,:]+2*M[1,:]; assert M[2,:]==Matrix([[0,0,-8,-24]])
# Matrix-Vektor-Produkt
A=Matrix([[1,2,0],[3,-1,4]]); x=Matrix([2,1,-1]); print(A*x)
# Aufwand
n=symbols("n",integer=True,positive=True); j=symbols("j")
assert simplify(summation(j*(j+1),(j,1,n-1))-(n-1)*n*(n+1)/3)==0
# Pivot-Beispiel
eps=1e-20
def gauss_nopivot(eps):
    a=np.array([[eps,1.0],[1.0,1.0]]); b=np.array([1.0,2.0])
    l=a[1,0]/a[0,0]; a[1,:]-=l*a[0,:]; b[1]-=l*b[0]
    y=b[1]/a[1,1]; x=(b[0]-a[0,1]*y)/a[0,0]; return x,y
print(gauss_nopivot(eps))
a=np.array([[1.0,1.0],[eps,1.0]]); b=np.array([2.0,1.0])
l=a[1,0]/a[0,0]; a[1,:]-=l*a[0,:]; b[1]-=l*b[0]; y=b[1]/a[1,1]; x=(b[0]-a[0,1]*y)/a[0,0]; print(x,y)
# Beispiel 3x4
A=Matrix([[1,2,1,1],[2,4,3,1],[1,2,2,0]]); b=Matrix([4,9,5])
s,t=symbols("s t")
xs=Matrix([3-2*s-2*t,s,1+t,t]); assert simplify(A*xs-b)==zeros(3,1)
M=Matrix([[1,2,1,1,4],[2,4,3,1,9],[1,2,2,0,5]])
M[1,:]=M[1,:]-2*M[0,:]; M[2,:]=M[2,:]-M[0,:]; assert M==Matrix([[1,2,1,1,4],[0,0,1,-1,1],[0,0,1,-1,1]])
M[2,:]=M[2,:]-M[1,:]; assert M[2,:]==zeros(1,5)
# unloesbar
M=Matrix([[1,2,1,1,4],[2,4,3,1,9],[1,2,2,0,6]])
M[1,:]=M[1,:]-2*M[0,:]; M[2,:]=M[2,:]-M[0,:]; M[2,:]=M[2,:]-M[1,:]; assert M[2,:]==Matrix([[0,0,0,0,1]])
print("ok")
