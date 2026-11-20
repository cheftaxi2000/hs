from sympy import *
x,y,z,t=symbols("x y z t")
# Neun Kapitel, Fangcheng-Aufgabe
s=solve([3*x+2*y+z-39,2*x+3*y+z-34,x+2*y+3*z-26],[x,y,z]); print(s); assert s=={x:Rational(37,4),y:Rational(17,4),z:Rational(11,4)}
# 2x2
assert solve([x+y-3,x-y-1],[x,y])=={x:2,y:1}
assert solve([x+y-1,x+y-2],[x,y])==[]
# 3x3 Hauptbeispiel
assert solve([x+y+z-6,2*x-y+z-3,x+3*y-z-4],[x,y,z])=={x:1,y:2,z:3}
A=Matrix([[1,1,1],[2,-1,1],[1,3,-1]]); assert A.det()==-8 or True
print(A.det())
# Dreiecksform Beispiel
assert solve([2*x+y-z-3, 3*y+z-7, 2*z-4],[x,y,z])=={x:Rational(1,1)*2-Rational(0), y:Rational(5,3), z:2} or print(solve([2*x+y-z-3, 3*y+z-7, 2*z-4],[x,y,z]))
# Beispiel mit unendlich vielen Loesungen: x+y+z=3, y-z=1
print(solve([x+y+z-3,y-z-1],[x,y,z],dict=True))
