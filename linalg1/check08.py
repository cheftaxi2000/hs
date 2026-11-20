from sympy import *
# LR loesen, mehrere rechte Seiten
A=Matrix([[2,1,1],[4,3,3],[8,7,9]]); 
for b in ([1,2,3],[2,4,8],[0,0,1]): print(b, A.LUsolve(Matrix(b)).T)
# PA=LR
A=Matrix([[0,2,1],[1,1,1],[2,1,3]])
# erste Pivotspalte: groesster Eintrag 2 (Zeile 3) -> tausche Z1<->Z3
P=Matrix([[0,0,1],[0,1,0],[1,0,0]]); PA=P*A; print(PA)
L,U,perm=PA.LUdecomposition(); print(L,U,perm)
# zweiter Schritt moeglicherweise Tausch:
B=Matrix([[0,1,1],[1,1,2],[2,1,1]]); 
# Sarrus
D=Matrix([[2,0,1],[1,3,2],[1,1,1]]); print(D.det())
a,b,c,d,e,f,g,h,i=symbols("a b c d e f g h i")
M=Matrix([[a,b,c],[d,e,f],[g,h,i]]); assert expand(M.det()-(a*e*i+b*f*g+c*d*h-c*e*g-b*d*i-a*f*h))==0
# Kofaktoren / Adjunkte
D=Matrix([[2,0,1],[1,3,2],[1,1,1]]); C=D.cofactor_matrix(); print(C, C.T, D.adjugate(), D*D.adjugate())
# 4x4
Q=Matrix([[1,0,2,0],[3,1,0,2],[0,2,1,0],[1,0,0,3]]); print(Q.det())
# 2x2 Flaeche
print(Matrix([[3,1],[1,2]]).det())
# Volumen
print(Matrix([[1,0,0],[1,2,0],[1,1,3]]).det())
# Sarrus-Beispiel Aufgabe
print(Matrix([[1,2,3],[4,5,6],[7,8,10]]).det(), Matrix([[1,2,3],[4,5,6],[7,8,9]]).det())
# Entwicklung 3x3 nach 2. Zeile
print(Matrix([[3,1,2],[0,2,0],[1,4,1]]).det())
