#import "lib.typ": *

= Expressions and Fundamental Types

#lec(2, [Expressions, fundamental types], [operators · precedence · `int` `double` `bool` `char` · conversions · overflow])

#lecture[Programs compute with values. This chapter covers the grammar of computing (expressions and operators) and the kinds of values the computer knows natively (the fundamental types). The most important message: the computer's numbers are *not* the numbers of mathematics. They have a finite size, and integer division behaves differently from what you learned at school.]

== Expressions and operators

#defn[Expression][An *expression* is a piece of program text that has a *value* (and a *type*). A literal (`5`), a variable (`a`), or operators applied to other expressions (`2 * a + 1`) are all expressions. The computer *evaluates* an expression, i.e. it computes its value.]

An operator takes *operands*. `+`, `-`, `*`, `/`, `%` need two (they are *binary*); the minus sign in `-a` needs one (*unary*). Evaluating `2 * x + 1 > y` means evaluating a tree: the operator with the highest priority sits lowest.

#fg("c02_tree", [The expression `2 * x + 1 > y` as a tree for x = 4, y = 7. The computer evaluates it from the leaves up to the root.], w: 62%)

=== Precedence and associativity

Two rules decide the shape of the tree. *Precedence* is the priority between different operators (as in "multiplication before addition"); *associativity* decides the order between operators of equal priority (`10 - 4 - 3` is `(10 - 4) - 3`, left to right).

#block(breakable: false, table(columns: (auto, 1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Priority*], [*Operators*], [*Associativity*],
  [highest], [`( )`  `a++` `a--`], [left],
  [], [`!` `-a` (unary) `++a` `--a`], [right],
  [], [`*` `/` `%`], [left],
  [], [`+` `-`], [left],
  [], [`<` `<=` `>` `>=`], [left],
  [], [`==` `!=`], [left],
  [], [`&&`], [left],
  [], [`||`], [left],
  [lowest], [`=` `+=` `-=` `*=` `/=` `%=`], [right]))

#trick[When in doubt, use parentheses][Nobody remembers the complete table. `(a * b) + c` is not wrong just because it is unnecessary. Parentheses cost nothing and make the code clearer. Memorise only: *unary first, then `* / %`, then `+ -`, then comparisons, then `&&`, then `||`, assignment last.*]

#cpp("precedence")

== Integer division and modulo

The operators `/` and `%` need special care. If *both* operands are integers, `/` is an *integer division*: the fractional part is discarded, rounding towards zero. `%` gives the remainder.

#rule[Division and remainder][For integers $a$ and $b != 0$:
$ (a "/" b) dot b + (a "%" b) = a. $
`7 / 2` is 3 and `7 % 2` is 1. For negative numbers the quotient is rounded towards zero (`-7 / 2` is `-3`), and the remainder has the sign of the dividend (`-7 % 2` is `-1`). Anything with at least one `double` operand is divided as a decimal number: `7 / 2.0` is 3.5.]

#intu[Think of sharing 7 sweets among 2 children: each gets `7 / 2 = 3`, and `7 % 2 = 1` sweet is left over. Integer division and remainder always come as a pair.]

#everyday[The remainder operator is a workhorse.
- *Even or odd?* `n % 2 == 0` means even.
- *Last digit* of a number: `n % 10`. *Remove the last digit*: `n / 10`.
- *Clock arithmetic*: what time is it 100 hours after 3 o'clock? `(3 + 100) % 24`.
- *Cycling through* `0, 1, ..., n-1` and starting again: `i % n`.
]

#ex("Digit sum of a three-digit number")[Task: for `n = 472` compute the sum of the digits.
#step[Idea] The last digit is `n % 10 = 2`. Removing it, `n / 10 = 47`, brings the next digit to the end.
#snip("int n = 472;
int sum = n % 10;        // 2
sum += (n / 10) % 10;    // 7  (47 % 10)
sum += n / 100;          // 4
// sum is 13")
]

== Variables, declarations and assignments

A variable needs to be *declared* before use: you tell the compiler its *type* and *name*. Optionally you give an initial value.

#snip("int a;           // declaration: space for an int, content undefined!
int b = 5;       // declaration with initialisation
double x = 2.5, y = -1.0;
const int k = 10; // a constant: cannot be changed later
a = b + k;       // assignment: a now contains 15")

#mistake[
- *Uninitialised variables.* `int a;` contains whatever bits happened to be in that memory before, not 0. Reading it is an error. Always initialise: `int a = 0;`.
- *Mixing up `=` and `==`.* `a = 5` stores 5 (and has the value 5); `a == 5` *asks* whether `a` equals 5.
- Using a variable before its declaration, or declaring the same name twice in the same scope.
]

#hood[An *assignment* has a left side that is a *place in memory* (an *lvalue*, something you can write to, like `a`) and a right side that is a *value* (an *rvalue*, like `a + 1`). That is why `a + 1 = 5` or `5 = a` are errors: `a + 1` is not a place. And an assignment is itself an expression whose value is the assigned value, so `a = b = 3;` works (right-associative: `a = (b = 3)`).]

== The fundamental types

Every value has a *type*. The type determines how many bits are used, how they are interpreted, and which operations are allowed.

#fg("c02_types", [Memory is organised in bytes (8 bits each). The type decides how many bytes a value occupies.], w: 92%)

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Type*], [*Literal*], [*Use*],
  [`int`], [`42`, `-7`], [whole numbers; the default choice],
  [`unsigned int`], [`42u`], [non-negative whole numbers (0 to about 4 billion)],
  [`long`], [`42l`], [whole numbers when `int` is too small],
  [`double`], [`3.14`, `2.5e-3`], [decimal ("floating-point") numbers; the default for real numbers],
  [`float`], [`3.14f`], [smaller, less precise decimals (rarely used here)],
  [`bool`], [`true`, `false`], [truth values],
  [`char`], [`'a'`, `'7'`, `'\n'`], [one character (stored as a small integer)])

The sizes are properties of your machine; typical values on a modern PC:

#cpp("sizes")

#intu[A type is a contract: "these bytes are to be read as a whole number" or "...as a decimal number". The same 32 bits can be the integer 1065353216 or the decimal number 1.0 (Chapter 8), depending only on which type the program claims.]

== Overflow: numbers have a finite size

A mathematician's integers go on forever. An `int` with 32 bits can represent only $2^32 approx 4.3 dot 10^9$ different values: from $-2^31$ to $2^31 - 1$.

#cpp("wrap")

For `unsigned` the behaviour is defined: arithmetic is performed modulo $2^32$, like a mileage counter that rolls over from 999999 to 000000. For the signed `int`, going beyond $2^31 - 1$ is formally *undefined behaviour*: the standard makes no promise whatsoever. In practice you often see the value wrap to negative numbers (Chapter 8 explains why), but the compiler is allowed to do anything.

#mistake[Computing $13!$ or $2^40$ with an `int`, adding up many large numbers, or subtracting from an `unsigned` that is already 0 (`0u - 1` is 4294967295, not -1). Rule: whenever numbers can become big, think about which type is large enough, and use `unsigned` only for bit patterns, never just "because the number cannot be negative".]

== Conversions between types

Operators need operands of the same type. If they differ, the compiler *converts implicitly*, usually towards the "bigger" type:

- `int` and `double` together give `double`: `1 + 2.5` is `3.5`.
- `bool` and `char` are promoted to `int` in arithmetic.
- Assigning a `double` to an `int` *truncates*: the fraction is cut off (no rounding), `3.99` becomes `3`, `-3.99` becomes `-3`.

If you want a conversion explicitly, say so with a *cast*: `static_cast<double>(a)`.

#cpp("conv")

Look at the first line: `a / b` is an integer division, so the result is `0`, and it is converted to `0.0` *after* the division. If you want 0.5, one operand must be a `double` before the division happens: `1.0 * a / b` or `static_cast<double>(a) / b`.

A `char` is a small integer: `'a'` is the number 97. So `c + 1` is the `int` 98, and only after the cast back to `char` it prints as `b`.

#mistake[`double average = (a + b) / 2;` with `int a, b`. The division is performed on integers and the result is truncated, and only afterwards it is stored in a `double`. Better: `(a + b) / 2.0`.]

== Increment, decrement, compound assignment

Adding one to a variable is so common that it has its own operators: `++a` and `a++` both increase `a` by 1. The difference is the *value of the expression*: `a++` yields the old value, `++a` the new one.

#cpp("incr")

Likewise `a += b` is shorthand for `a = a + b`, and similarly `-=`, `*=`, `/=`, `%=`. Use `++`/`+=` as stand-alone statements; mixing them into bigger expressions (`a = a++ + ++a`) is a recipe for confusion.

== Truth values and logical operators

Comparisons (`<  <=  >  >=  ==  !=`) produce a `bool`. Truth values are combined with

#table(columns: (auto, auto, auto, auto, auto), align: center, 
  [`a`], [`b`], [`a && b`], [`a || b`], [`!a`],
  [`false`], [`false`], [`false`], [`false`], [`true`],
  [`false`], [`true`], [`false`], [`true`], [`true`],
  [`true`], [`false`], [`false`], [`true`], [`false`],
  [`true`], [`true`], [`true`], [`true`], [`false`])

#defn[Short-circuit evaluation][`&&` and `||` evaluate the left operand first and the right operand *only if necessary*. `false && ...` is `false` and `true || ...` is `true` no matter what stands on the right.]

This is not only an optimisation: it lets you write guards such as `x != 0 && 10 / x > 1`, which never divides by zero.

#cpp("boolops")

Two things to learn from the last line. First, `1 < 2 < 3` is *not* the mathematical chain: it means `(1 < 2) < 3`, i.e. `true < 3`, i.e. `1 < 3`. To check "$1 < x < 3$" write `1 < x && x < 3`. Second, the leap year rule shows how real conditions combine: divisible by 4, except for multiples of 100, except for multiples of 400.

#rule[De Morgan's laws][`!(a && b)` is equivalent to `!a || !b`, and `!(a || b)` is equivalent to `!a && !b`. "Not (A and B)" means "not A or not B".]

#check[Write "`x` is *not* between 1 and 3 (inclusive)" without using `!`.][`x < 1 || x > 3` (De Morgan applied to `!(x >= 1 && x <= 3)`).]

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*The Patriot missile and a tiny rounding error.* On 25 February 1991, a Patriot air-defence battery in Dhahran failed to intercept an incoming Scud missile; 28 soldiers died. The system counted time in tenths of a second, and $0.1$ cannot be stored exactly in binary. The error is tiny, about $0.000000095$ s per tick, but after about 100 hours of operation it had grown to $0.34$ s, during which a Scud flies more than half a kilometre. The investigators (US Government Accountability Office) traced the failure to exactly this. Lesson: the type you choose decides what your program can and cannot represent.]

#everyday[*Never use `float` for money.* Banks and shops store amounts as whole numbers of cents (an `int` or `long`), not as `double`. With floating point, `0.1 + 0.2 == 0.3` is false, and after many additions the cents drift. With integers, $0.10 + 0.20$ becomes `10 + 20 == 30` and is exactly right. The same advice holds for time stamps, pixel coordinates and anything you want to compare for equality.]
// ALLTAG-END

#summary[
- An *expression* has a value and a type; *precedence* and *associativity* determine how it is parsed. Parentheses are free.
- Integer division truncates towards zero; `%` is the remainder; $(a/b) dot b + a % b = a$.
- Types: `int`, `unsigned`, `long`, `double`, `bool`, `char`. They have finite size, so *overflow* happens.
- Mixed `int` / `double` arithmetic converts to `double`; assigning `double` to `int` truncates. Use `static_cast`.
- `a++` returns the old value, `++a` the new one; `+=` etc. are shorthand.
- `&&`, `||` are evaluated lazily from the left. `1 < x < 3` does not mean what it says in mathematics.
]

#problems()

#prob("Evaluate", [What are the values of these expressions? (`int` unless stated)
(a) `5 + 3 * 2 - 4 / 2` #h(1em) (b) `17 % 5 * 2` #h(1em) (c) `-17 / 5` #h(1em) (d) `17 / 5.0` #h(1em) (e) `1 / 2 + 1 / 2.0` #h(1em) (f) `3 > 2 && 5 % 2 == 0`],
[(a) $5 + 6 - 2 = 9$. (b) `17 % 5` is 2, times 2 is 4. (c) $-3$ (rounded towards zero). (d) 3.4. (e) `1 / 2` is 0, `1 / 2.0` is 0.5, the sum is 0.5. (f) `3 > 2` is true, `5 % 2 == 0` is false, so `false`.])

#prob("Trace and predict", [What is printed?
```
int a = 3;
int b = a++ * 2;
int c = --a + b;
a += c;
std::cout << a << " " << b << " " << c;
```],
[#trace(("statement", "a", "b", "c"), ("int a = 3;", "3", "–", "–"), ("b = a++ * 2;", "4", "6", "–"), ("c = --a + b;", "3", "6", "9"), ("a += c;", "12", "6", "9"))
In `a++ * 2` the old value 3 is used, then `a` becomes 4. Then `--a` first decrements to 3, and $3 + 6 = 9$. Output: `12 6 9`.])

#prob("Seconds to clock time", [A variable `int t` holds a number of seconds (with $t >= 0$). Print it as hours, minutes and seconds, e.g. `t = 3725` as `1 h 2 min 5 s`.],
[```
int h = t / 3600;           // whole hours
int m = (t % 3600) / 60;    // what is left, in minutes
int s = t % 60;             // the remaining seconds
std::cout << h << " h " << m << " min " << s << " s\n";
```
For 3725: $h = 1$, $t % 3600 = 125$, $m = 2$, $s = 5$.])

#prob("Boolean expression", [Write a boolean expression that is true if and only if the integer `n` is a three-digit number (positive or negative) that is divisible by 7 but not by 14.],
[`(n >= 100 && n <= 999 || n <= -100 && n >= -999) && n % 7 == 0 && n % 14 != 0`. Since `&&` binds tighter than `||`, the first pair of conditions would be fine without inner parentheses, but the outer parentheses around the `||` are essential. Negative `n` also work because the remainder `n % 7 == 0` is zero for multiples regardless of sign.])

#prob("The average trap", [`int a = 7, b = 4; double avg = (a + b) / 2;`. What is `avg`? Give two corrections.],
[`avg` is 5, not 5.5, because `(a + b) / 2` is an integer division (`11 / 2 = 5`) and the `5` is only afterwards converted to `5.0`. Corrections: `(a + b) / 2.0` or `static_cast<double>(a + b) / 2`.])
