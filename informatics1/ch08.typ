#import "lib.typ": *

= Number Representations

#lec(8, [Number representations], [binary · hexadecimal · two's complement · bit operations · IEEE 754 floating point])

#lecture[Until now we have treated `int` and `double` as black boxes that "mostly behave like numbers". This chapter opens the boxes. Why does `127 + 1` become $-128$ in 8 bits? Why is $0.1$ not exactly representable? Understanding the representation explains every surprise from Chapters 2 and 3, and it explains how a 370 million dollar rocket was lost.]

#include "ch08_a.typ"

== Positional number systems

You write the number $472$ in the *decimal* system with the *base* 10: each position has a weight that is ten times that of the position to its right.

$ 472 = 4 dot 10^2 + 7 dot 10^1 + 2 dot 10^0. $

Computers use base 2, the *binary* system, because a switch has two states (on / off, a voltage that is high or low). A binary digit is a *bit*. Eight bits form a *byte*. Every position has a weight that is a power of two:

#align(center, table(columns: (auto,) * 9, align: center, inset: (x: 7pt, y: 4pt),
  [*weight*], [128], [64], [32], [16], [8], [4], [2], [1],
  [*power*], [$2^7$], [$2^6$], [$2^5$], [$2^4$], [$2^3$], [$2^2$], [$2^1$], [$2^0$],
  [*bits of 13*], [0], [0], [0], [0], [1], [1], [0], [1]))

So $1101_2 = 8 + 4 + 0 + 1 = 13$. A number with $n$ bits can take $2^n$ different values.

=== Conversion decimal → binary

#recipe[Decimal to binary][
  + Divide the number by 2. Write down the *remainder* (0 or 1).
  + Continue with the quotient until it is 0.
  + Read the remainders from *bottom to top*.]

#ex("Convert 45 to binary")[
#trace(("division", "quotient", "remainder"), ("45 / 2", "22", "1"), ("22 / 2", "11", "0"), ("11 / 2", "5", "1"), ("5 / 2", "2", "1"), ("2 / 2", "1", "0"), ("1 / 2", "0", "1"))
Read the remainders from the bottom: $45 = 101101_2$. Check: $32 + 8 + 4 + 1 = 45$.
(This is exactly the algorithm behind `print_binary` of Problem 7.5.)]

#cpp("bits")

The loop in `print_bits` uses bit operations (Section 8.5): `(n >> i) & 1` isolates bit number `i`. The last line shows *hexadecimal* output.

== Hexadecimal

Long bit strings are unreadable for humans. The *hexadecimal* system (base 16) writes four bits as one digit: the digits are 0-9 and then `a`-`f` for 10-15. A byte is two hex digits.

#align(center, table(columns: (auto,) * 17, align: center, inset: (x: 4.5pt, y: 3.5pt),
  [*dec*], ..range(16).map(i => [#i]),
  [*hex*], ..range(16).map(i => text(font: mono, size: 8.5pt, "0123456789abcdef".at(i))),
  [*bin*], ..range(16).map(i => text(font: mono, size: 6.8pt, ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111").at(i)))))

$ 1101 space 0110 space 1010_2 = "d6a"_16 $

In C++ source, hexadecimal literals start with `0x` (`0xFF` is 255), binary literals with `0b` (`0b1010` is 10). Colours on web pages (`#1f7a70`), memory addresses and checksums are written in hex.

== Unsigned integers and overflow

With $n$ bits, an *unsigned* integer represents $0, 1, ..., 2^n - 1$. Addition works as in school, except that a carry out of the leftmost position is *lost*: the result is correct *modulo $2^n$*. Hence $255 + 1 = 0$ in 8 bits, and $0 - 1 = 255$: the "mileage counter that rolls over" from Chapter 2.

== Signed integers: two's complement

How can we represent *negative* numbers? The idea that all modern computers use is called the *two's complement*: with $n$ bits, the leftmost bit has the weight $-2^(n-1)$ instead of $+2^(n-1)$.

#defn[Two's complement][In an $n$-bit two's complement number $b_(n-1) ... b_1 b_0$ the value is
$ v = -b_(n-1) dot 2^(n-1) + sum_(i=0)^(n-2) b_i dot 2^i. $
The range is $-2^(n-1)$ to $2^(n-1) - 1$.]

For $n = 8$: $10000000 = -128$, $11111111 = -128 + 127 = -1$, $01111111 = 127$. The *leftmost bit is the sign* (1 means negative), but it is not "sign + magnitude": it has a weight.

#fg("c08_wheel", [All 3-bit patterns on a wheel. Counting up moves clockwise; after 011 (3) the next pattern 100 is -4: overflow is just "going around the wheel". Addition is the same operation for signed and unsigned numbers.], w: 62%)

#cpp("twos")

Some consequences:
- The *same bit pattern* means `-1` as a signed and `255` as an unsigned number. Which one is meant depends only on the *type*.
- There is *one more* negative number than positive ones: `-128 .. 127`. In `int`: $-2^31 .. 2^31 - 1$.
- Hardware needs only *one* adder for signed and unsigned numbers: the wheel does the work.

#rule[Negation in two's complement][To compute $-x$: *invert all bits, then add 1.* For $x = 5 = 00000101$: inverted $11111010$, plus one: $11111011 = -5$. Check: $-128 + 64 + 32 + 16 + 8 + 2 + 1 = -5$. ✓]

#everyday[*Overflow* is real. In 2015 it was reported that the Boeing 787's generators could shut down if powered for 248 days without a restart: a counter in hundredths of seconds overflows a signed 32-bit integer after $2^31 slash 100$ seconds = 248.5 days. Arithmetic overflow bugs have caused crashes in aircraft, games, and, as we will see, rockets.]

== Bit operations

C++ can operate directly on the individual bits of integers.

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Operator*], [*Name*], [*Effect*],
  [`a & b`], [AND], [bit is 1 if it is 1 in *both*],
  [`a | b`], [OR], [bit is 1 if it is 1 in *at least one*],
  [`a ^ b`], [XOR], [bit is 1 if the two bits *differ*],
  [`~a`], [NOT], [flip every bit],
  [`a << k`], [shift left], [move bits $k$ places up, fill with 0: multiplies by $2^k$],
  [`a >> k`], [shift right], [move bits $k$ places down: divides by $2^k$ (rounding down)])

#cpp("bitops")

#mistake[Do not confuse `&` / `|` (bit-wise, on numbers) with `&&` / `||` (logical, on truth values). And `^` is XOR, *not* "power": `2 ^ 3` is 1.]

#hood[Typical uses: *flags* (eight on/off settings stored in one byte, set with `|`, test with `&`), *masks* (`x & 0xFF` keeps only the lowest byte), fast multiplication by powers of two, cryptography and checksums (XOR), graphics and compression.]

== Floating-point numbers

How can a computer store $0.1$, $3.14159$, $6.02 dot 10^23$ or $10^(-19)$ in a fixed number of bits? Exactly like scientists do: in *scientific notation*, *mantissa* times a power of the base:

$ -6.25 = -1.5625 dot 4 = -1.5625 dot 2^2 $

The *point* floats: the exponent says where it is. The standard *IEEE 754* fixes the layout (every processor since the 1980s follows it):

#fg("c08_ieee", [Layout of IEEE 754 numbers: one *sign bit* $s$, the *exponent* $e$ (stored with a bias), and the *mantissa* $m$: the digits behind the leading 1.], w: 96%)

Details for `float`:
- The *sign bit* is 1 for negative numbers.
- A *normalised* number is written $1.m dot 2^E$ in binary. The leading 1 is always there, so it is not stored ("hidden bit"). Only the digits $m$ after the point are stored: 23 bits.
- The exponent $E$ is stored as $e = E + 127$ (the *bias*), so that no sign is needed for it.

#ex("Encode −6.25 as a float")[
#step[1. Sign] negative, so $s = 1$.
#step[2. Binary] $6.25 = 110.01_2$ ($4 + 2 + 0.25$).
#step[3. Normalise] $110.01_2 = 1.1001_2 dot 2^2$. So $E = 2$ and the digits after the point are $m = 1001 000...0$.
#step[4. Exponent] $e = 2 + 127 = 129 = 10000001_2$.
Result: `1 10000001 10010000000000000000000`. Compare the output of the program below.]

#cpp("float_bits")

Look at $0.1$: its mantissa `1001 1001 1001 ...` is periodic, exactly like $1/3 = 0.333...$ in decimal. It must be *rounded* (the last bit shows `...101`), so a `float` holding 0.1 is not exactly $0.1$. The same happens for `double` with its 52 mantissa bits, just much later in the decimal expansion. A decimal fraction is exactly representable only if it is a sum of powers of two: $0.5$, $0.25$, $0.75$ are fine, $0.1$ and $0.2$ are not.

=== What floating-point numbers can and cannot do

#fg("c08_density", [A toy format with only two mantissa bits. Between consecutive powers of two there are always equally many numbers, so the *absolute* gap grows with the size of the numbers while the *relative* gap stays about the same.], w: 96%)

#cpp("float_limits")

Reading the output:
- *Machine epsilon* ($2.2 dot 10^(-16)$ for `double`, $1.2 dot 10^(-7)$ for `float`) is the gap between 1 and the next larger number. Relative precision: about 16 decimal digits (`double`) and 7 (`float`).
- Too large results become `inf`, undefined ones `nan` ("not a number"), which also propagates: every calculation with `nan` gives `nan`. (Some systems print `-nan`; the sign of a nan carries no meaning.)
- *Absorption*: adding a tiny number to a large one does nothing: $10^16 + 1 = 10^16$, because the gap between neighbours at $10^16$ is 2. A `float` cannot even count beyond $2^24 = 16777216$ in steps of one.
- Addition is *not associative*: $(0.1 + 0.2) + 0.3 != 0.1 + (0.2 + 0.3)$ in the last bit. The order of summation matters. (Sum small numbers first!)

#remember[
+ `float`: about 7 digits, `double`: about 16 digits. Use `double`.
+ Subtracting two nearly equal numbers destroys digits (*cancellation*): $1.0000001 - 1.0000000$ has only one significant digit left.
+ Integers are exact (within their range), floating-point numbers are not. If you can use integers (cents instead of euros), do.
+ Never use `==` on results of calculations (Chapter 3).
]

#everyday[*Ariane 5, 4 June 1996.* Thirty-seven seconds after lift-off, the new European rocket veered off course and destroyed itself, a loss of about 370 million dollars. The cause: software reused from Ariane 4 converted a 64-bit floating-point number (the horizontal velocity) into a 16-bit signed integer. Ariane 5 was faster, the value exceeded 32767, the conversion overflowed (exactly like `static_cast<short>(40000)` in our program), the guidance computer reported a diagnostic error, and the main and backup computer shut down. One single unchecked conversion.]

#include "ch08_b.typ"

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*A Boeing 787 that must be restarted.* In 2015 the US aviation authority (FAA) ordered operators of Boeing 787 aircraft to power-cycle the aircraft's generator control units at least every 248 days. The reason was a counter of hundredths of a second stored in a signed 32-bit integer: after $2^(31)$ hundredths of a second, which is about $248.55$ days, the number overflows, and the units could shut down. It is the same kind of error as in Ariane 5, in a different place. Always ask: how large can this number become?]

#everyday[*Hexadecimal in colours and addresses.* Web colours like `#FF8800` are three bytes written in hexadecimal: red $=$ `FF` ($255$), green $=$ `88` ($136$), blue $=$ `00`. Hardware addresses of network cards (`3C:22:FB:...`), memory addresses in error messages and the checksums of downloads all use hex. Two hex digits are exactly one byte, which is why programmers like it: $16 = 2^4$, so each hex digit corresponds to exactly four bits.]

#everyday[*Rounding in finance and engineering.* Spreadsheets display $0.1 + 0.2$ as $0.3$ because they round the output, not the stored value. When thousands of such small errors add up (interest calculation, structural analysis over many steps), the order of operations matters: summing $10^6$ numbers from small to large gives a different, usually better, result than from large to small. Numerical software is designed with these effects in mind.]

#photo(("i_ariane",), [An Ariane 5 on the launch pad (here with the James Webb Space Telescope, 2021). The first Ariane 5 flight failed in 1996 because of an integer overflow. #credit[Bill Ingalls, Public Domain, Wikimedia Commons]], ht: 5.5cm)
// ALLTAG-END

#summary[
- Binary: positions with weights $2^i$. Hexadecimal: 4 bits per digit. Convert decimal → binary by repeated division by 2.
- $n$ bits give $2^n$ patterns. *Unsigned*: $0 .. 2^n - 1$. *Two's complement*: $-2^(n-1) .. 2^(n-1) - 1$; the top bit has the negative weight; negate by inverting and adding 1. Overflow wraps around.
- Bit operations: `& | ^ ~ << >>`.
- *IEEE 754*: sign, exponent (bias), mantissa (hidden leading 1). `double` has 52 mantissa bits (~16 digits). Most decimal fractions are not exact; large and small numbers do not mix well; `inf`, `nan` exist.
]

#problems()

#prob("Conversions", [(a) Write 100 in binary and hexadecimal. (b) What is $10110110_2$ in decimal if it is an unsigned 8-bit number, and what if it is an 8-bit two's complement number? (c) Write $-20$ as 8-bit two's complement.],
[(a) $100 = 64 + 32 + 4 = 1100100_2 = "64"_16$ (grouped as `0110 0100`). (b) Unsigned: $128 + 32 + 16 + 4 + 2 = 182$. Signed: $182 - 256 = -74$. (c) $20 = 00010100$; invert: $11101011$; add 1: $11101100$. Check: $-128 + 64 + 32 + 8 + 4 = -20$ ✓.])

#prob("Overflow", [`unsigned char a = 200, b = 100; int c = a + b; unsigned char d = a + b;` What are `c` and `d`?],
[In `a + b` both are promoted to `int`: `c = 300`. For `d` the value 300 is converted to `unsigned char`, which keeps only the lowest 8 bits: $300 - 256 = 44$. So `c = 300`, `d = 44`.])

#prob("Bit tricks", [What do these expressions compute for an `int x`? (a) `x & 1` (b) `x & (x - 1)` (c) `x << 1` (d) `x ^ x`. Evaluate (b) for `x = 12` and `x = 8`.],
[(a) The lowest bit: 1 if `x` is odd. (b) Clears the *lowest set bit*: $12 = 1100 -> 1100 and 1011 = 1000 = 8$. For $x = 8 = 1000$: $1000 and 0111 = 0$. Hence `x & (x - 1) == 0` tests whether `x` is a power of two (for $x > 0$). (c) $2x$. (d) Always 0.])

#prob("Floating-point encoding", [Encode $0.75$ as an IEEE `float` (sign, exponent field, mantissa).],
[$0.75 = 0.11_2 = 1.1_2 dot 2^(-1)$. Sign 0, $E = -1$ so $e = 126 = 01111110_2$, mantissa digits `1000...0`. Result: `0 01111110 10000000000000000000000`. (Exactly representable: a sum of powers of two.)])

#prob("Which comparisons are true?", [Assume `double`. Which of the following are (mathematically unexpected but) `true`? (a) `0.5 + 0.25 == 0.75` (b) `0.1 * 3 == 0.3` (c) `1e20 + 1 == 1e20` (d) `1.0 / 3 * 3 == 1.0`],
[(a) true and unsurprising: all three numbers are sums of powers of two, so no rounding at all. (b) false: $0.1 dot 3 = 0.30000000000000004$. (c) true by absorption: the gap at $10^20$ is much larger than 1. (d) true in IEEE arithmetic by lucky rounding, but one must not rely on it.])
