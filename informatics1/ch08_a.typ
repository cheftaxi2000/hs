#import "lib.typ": *

== The idea in plain words

=== Binary is counting with only two digits

In decimal, each position is worth ten times the one to its right: ones, tens, hundreds. In binary, each position is worth *twice* the one to its right: $1, 2, 4, 8, 16, 32, 64, 128, dots$ A binary number is a list of switches saying, for each of these values, "take it" (1) or "do not take it" (0).

#align(center, table(columns: 9, inset: (x: 7pt, y: 4pt), align: center, stroke: 0.5pt + luma(160),
  [*value*], [128], [64], [32], [16], [8], [4], [2], [1],
  [*bit*], [0], [0], [1], [0], [1], [1], [0], [1]))

This reads $32 + 8 + 4 + 1 = 45$. So $45 = 00101101_2$. That is all you need to read *any* binary number: add up the values above the ones.

=== From decimal to binary: two methods

*Method 1, subtract the largest power.* For $45$: the largest power of two that fits is $32$ (bit 1), rest $13$; $16$ does not fit (bit 0); $8$ fits (bit 1), rest $5$; $4$ fits (1), rest $1$; $2$ does not fit (0); $1$ fits (1). Result: $101101$.

*Method 2, divide by 2 repeatedly.* Divide, write down the remainder, continue with the quotient until you reach 0. The remainders, read *from bottom to top*, are the bits:

#trace(("number", "/ 2 =", "remainder"),
  ("45", "22", "1"), ("22", "11", "0"), ("11", "5", "1"), ("5", "2", "1"), ("2", "1", "0"), ("1", "0", "1"))

Read upwards: $101101$. Method 2 is exactly what a program does:

#cpp("d08_tobin")

=== Hexadecimal is binary in groups of four

Four bits have $16$ possible values, $0$ to $15$, so one hexadecimal digit (`0`–`9`, `A`=10, …, `F`=15) stands for exactly four bits. To convert binary to hex, cut the bits into groups of four *from the right* and translate each group: $0010 thin 1101 = $ `2D`. Back: write each hex digit as four bits. You never need to go through decimal.

=== A fixed number of bits is like a car's odometer

A variable of type `unsigned char` has exactly $8$ bits, so it can hold $2^8 = 256$ values, $0$ to $255$. What happens after $255$? Like an old car odometer that goes from `999999` to `000000`, the number *wraps around* to $0$:

#cpp("d08_wrap")

For unsigned types this is guaranteed: the result is the true result *modulo* $2^n$: for `200 + 100` in $8$ bits, the true result $300$ becomes $300 - 256 = 44$. The second line shows the same for a `signed char`, which goes from $127$ to $-128$: `s + 1` is computed as `int` ($128$), and storing $128$ in a `signed char` wraps around (guaranteed since C++20, and on all common computers before). For a plain `int` overflow, however, C++ makes *no* promise (undefined behaviour).

=== Negative numbers: the top bit is worth minus

In the *two's complement* system for $8$ bits, the leftmost bit is worth $-128$ instead of $+128$. All others keep their positive value. That's the whole idea:

#align(center, table(columns: 9, inset: (x: 7pt, y: 4pt), align: center, stroke: 0.5pt + luma(160),
  [*value*], [*−128*], [64], [32], [16], [8], [4], [2], [1],
  [`-45`], [1], [1], [0], [1], [0], [0], [1], [1]))

Check: $-128 + 64 + 16 + 2 + 1 = -45$. If the top bit is 0, the number is non-negative and reads as usual. If it is 1, the number is negative. `11111111` is $-128 + 127 = -1$.

#cpp("d08_bits8")

#trick[Negating in two's complement][To get the bits of $-x$ from those of $x$: *invert every bit, then add 1.* For $45 = 00101101$: inverted $11010010$, plus one $11010011$, which is the row for `-45` above.]
