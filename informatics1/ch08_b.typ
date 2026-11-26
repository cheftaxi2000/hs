#import "lib.typ": *

== How to solve exercises on number representations

Exercises on this chapter are mostly *conversions* and *"what is the value of this expression?"*. They are pure procedure: if you follow the recipe and write every step down, you cannot go wrong.

#recipe("Convert between the systems")[
- *Binary → decimal:* write the place values $128, 64, dots, 1$ above the bits and add those under which there is a 1.
- *Decimal → binary:* divide by 2 repeatedly, read the remainders from bottom to top (or subtract powers of two).
- *Binary ↔ hex:* groups of four bits, counted from the right; each group is one hex digit.
- *Hex → decimal:* each position is worth $16$ times the one to its right: $"2D"_16 = 2 dot 16 + 13 = 45$.
]

#recipe("Read an n-bit pattern as a signed number")[
+ Is the leftmost bit 0? Then it is the same as unsigned.
+ Is it 1? Then compute the unsigned value and subtract $2^n$ (for 8 bits: $-256$). Or: the top bit counts $-2^(n-1)$, the rest as usual.
]

#ex("Exam-style: one bit pattern, two meanings")[
*Task.* What is `10110110` as an unsigned and as a signed 8-bit number?

#step[Unsigned.] $128 + 32 + 16 + 4 + 2 = 182$.

#step[Signed.] Top bit is 1, so it is negative: $182 - 256 = -74$. Check with the "top bit is minus" view: $-128 + 32 + 16 + 4 + 2 = -74$. ✓
]

#ex("Exam-style: write a negative number in two's complement")[
*Task.* Write $-20$ as an 8-bit two's complement number.

#step[Step 1.] $20 = 16 + 4 = 00010100$.

#step[Step 2: invert.] $11101011$.

#step[Step 3: add 1.] $11101100$.

#step[Check.] $-128 + 64 + 32 + 8 + 4 = -20$. ✓
]

#recipe("What is the value of an expression with small or unsigned types?")[
+ *Compute the mathematically exact result* first, ignoring the types. (Remember: in C++, `char`, `short` and `unsigned char` are converted to `int` before any arithmetic.)
+ *Look at the type it is stored in.* If the result fits, done.
+ *Unsigned with $n$ bits:* reduce modulo $2^n$, i.e. add or subtract $2^n$ until the result is between $0$ and $2^n - 1$.
+ *Signed overflow of `int`:* this is *undefined behaviour* in C++; the exam answer is "undefined", not a number.
]

#ex("Exam-style: overflow")[
#cpp("d08_ex_overflow", out: false)

#step[`c`.] $200 + 100 = 300$ (computed as `int`). Stored into an `unsigned char` (0 to 255): $300 - 256 = 44$.

#step[`d`.] The same $300$, stored in an `int`: it fits, so $300$.

#step[`e`.] $3 - 5 = -2$ is computed as `int`, then stored in an `unsigned int` with 32 bits: $-2 + 2^(32) = 4 thin 294 thin 967 thin 294$.
#outonly("d08_ex_overflow")
]

#recipe("Bit operations")[
Write both numbers in binary *one below the other*, aligned on the right, and work column by column:
- `&` (and): 1 only where *both* are 1. Used to *test* or *clear* bits.
- `|` (or): 1 where *at least one* is 1. Used to *set* bits.
- `^` (xor): 1 where they are *different*.
- `<< k`: shift left by $k$ = multiply by $2^k$; `>> k`: shift right = divide by $2^k$ (rounding down, for non-negative numbers).
]

#ex("Exam-style: evaluate bit operations")[
*Task.* `a = 12`, `b = 10`. Compute `a & b`, `a | b`, `a ^ b`, `a << 2`, `a >> 1`.

#step[Write the bits.] `a = 1100`, `b = 1010`.
#align(center, block(breakable: false, table(columns: 5, inset: (x: 9pt, y: 3pt), stroke: none, align: right,
  [`a`], [`1`], [`1`], [`0`], [`0`],
  [`b`], [`1`], [`0`], [`1`], [`0`],
  table.hline(stroke: 0.5pt),
  [`&`], [`1`], [`0`], [`0`], [`0`],
  [`|`], [`1`], [`1`], [`1`], [`0`],
  [`^`], [`0`], [`1`], [`1`], [`0`])))
So `a & b` $= 8$, `a | b` $= 14$, `a ^ b` $= 6$. Shifting: `a << 2` $= 110000_2 = 48 = 12 dot 4$, and `a >> 1` $= 110_2 = 6 = 12 / 2$.
#cpp("d08_ex_ops")
]

#recipe("Encode a decimal number as an IEEE float")[
+ *Sign:* 0 for positive, 1 for negative. Continue with the absolute value.
+ *Write it in binary*, including the part after the point: $0.5 = 0.1_2$, $0.25 = 0.01_2$, $0.125 = 0.001_2$ …
+ *Normalise:* move the point so that exactly one `1` is in front of it: $110.01_2 = 1.1001_2 dot 2^2$. The power is the exponent $E$.
+ *Exponent field:* $E + 127$ in 8 bits (the *bias* is 127 for `float`, 1023 for `double`).
+ *Mantissa field:* the bits *after* the point (the leading `1` is not stored), filled up with zeros to 23 bits.
]

#ex("Exam-style: encode −6.25")[

#step[Sign.] Negative: $s = 1$.

#step[Binary.] $6 = 110_2$ and $0.25 = 0.01_2$, so $6.25 = 110.01_2$.

#step[Normalise.] $110.01_2 = 1.1001_2 dot 2^2$, so $E = 2$.

#step[Exponent field.] $2 + 127 = 129 = 10000001_2$.

#step[Mantissa.] The bits after the point: `1001`, then zeros.

#step[Result and check by the computer:]
#cpp("d08_floatbits")
The last line shows why `0.1` causes trouble: in binary it is $0.000110011001100 dots$ forever, like $1/3 = 0.333 dots$ in decimal, and must be cut off. Only numbers that are sums of a few powers of two (like $0.75 = 0.5 + 0.25$) are stored exactly.
]

#remember[Never compare floating-point results with `==`. Write `std::abs(x - y) < 1e-9` (or a tolerance that fits the problem). And for counting or money, use integers.]
