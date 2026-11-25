#import "lib.typ": *

= Introduction and the First C++ Program

#lec(1, [Introduction, first C++ program], [programs · compiler · `main` · `cout` / `cin` · errors])

#lecture[This chapter answers three questions. What *is* a program? How does text that you type become something a computer can execute? And how do you write, compile and run your very first C++ program? By the end you will have written programs that read numbers, calculate with them and print the result.]

== What is a program?

#idea[A computer is incredibly fast and incredibly stupid. It can do only a few dozen kinds of elementary steps (add two numbers, compare two numbers, copy a value, jump to another place in the list of instructions), but it does them billions of times per second and never gets tired or bored. A *program* is a precise list of such steps, so precise that nothing is left to interpretation.]

Think of a cooking recipe: "stir until it looks good" is a fine instruction for a human, but a computer needs "stir for 30 seconds, then check if the temperature is above 80 degrees; if yes, stop; if not, stir for 10 more seconds". A recipe that a machine can follow without thinking is called an *algorithm*.

#defn[Algorithm and program][An *algorithm* is a finite, unambiguous sequence of elementary steps that solves a problem. A *program* is an algorithm written in a *programming language*, so that a computer can execute it.]

Why a special language? Because the "language" the processor really understands, *machine code*, consists of long strings of 0s and 1s. Nobody wants to write that. So humans write in a *high-level language* (here: *C++*), and a translator program, the *compiler*, converts it to machine code.

#intu[Programming languages are like very pedantic foreign languages. A human listener understands "me no coffee want" anyway. The compiler does not: one missing semicolon and it refuses the whole text. The good news: the language has only a few hundred rules in total, and they never change from one program to the next.]

== From source code to a running program

You write text in a file (the *source code*, for us a file such as `main.cpp`). A compiler translates it into an *executable* (machine code). Then you start the executable, and the computer runs it.

#fg("c01_pipeline", [The workflow. Mistakes can be caught in three different places, which is why there are three kinds of errors.], w: 92%)

On a Linux or Mac terminal (or in a university system such as Code Expert) this looks like:

```
g++ -o main main.cpp     # translate main.cpp into the executable "main"
./main                   # run it
```

#hood[The compiler does more than translating. It first *checks* that your text is a valid C++ program (spelling, grammar, types). Only if it is valid, it produces an executable. Then a *linker* glues in the ready-made parts you used, such as the code behind `std::cout`. When someone says "it compiles", it means: valid grammar. It says nothing about whether the program does what you wanted.]

=== Three kinds of errors

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Kind*], [*When you notice*], [*Example*],
  [Syntax error], [compiler stops, no executable], [forgot the `;`, misspelled a keyword],
  [Runtime error], [program crashes while running], [division by zero, invalid memory access],
  [Logic error], [program runs, answer is wrong], [computing `a + b / 2` instead of `(a + b) / 2`])

Syntax errors are the friendly ones: the compiler tells you the line. Here is what a missing semicolon looks like:

#err("err_semicolon")

Read compiler messages from the *top*. The first error is the real one; the following messages are often just consequences. Note that the compiler reports the line *after* the one where you forgot the semicolon: it only notices at `return`, which does not fit.

A second classic: forgetting the `std::` prefix (we explain it in a moment).

#err("err_std")

Logic errors are the nasty ones, because nobody complains. Which number does this program print as "average" of 10 and 20?

#cpp("wrong_avg")

Not 15, but 20: since division binds more tightly than addition (Chapter 2), the program computes `10 + (20 / 2)`.

#remember[The compiler checks the *form*, never the *intention*. Testing your program with inputs where you know the answer is part of programming, not an optional extra.]

== Hello, world

By tradition, the first program of every programming course prints a greeting.

#cpp("hello")

#fg("c01_anatomy", [Anatomy of the first program. The colours link each part of the program to its explanation.], w: 92%)

Line by line:
- `#include <iostream>`: the language itself knows nothing about the screen. *Libraries* add features. The *include* line says "paste in the description of the input / output library". Without it `std::cout` does not exist.
- `int main() { ... }`: a *function* called `main`. When you start the program, the computer begins executing at the first statement inside the curly braces. The word `int` says that `main` hands back an integer at the end.
- `std::cout << "Hello, world!\n";`: this is a *statement*. `std::cout` is the output stream ("the screen"); `<<` sends the thing on its right into it; `"Hello, world!\n"` is a *string literal*, and `\n` means "new line". The `std::` says that `cout` lives in the *standard library namespace*.
- `return 0;` ends `main` and reports "0 = all went well" to the operating system.

#trick[Read `<<` as an arrow]["`std::cout << x`" means "x flows into cout". You can chain: `std::cout << "a = " << a << "\n";` sends three things in a row. Similarly `std::cin >> a` means "a flows out of the keyboard": the arrow points to where the data goes.]

#mistake[
- Forgetting `;` at the end of a statement.
- Writing `cout` without `std::`.
- Using typographic quotes (like “this”) copied from a text editor: C++ only knows the plain `"`.
- Upper/lower case: `Main`, `Cout`, `Int` are different words from `main`, `cout`, `int`. C++ is case-sensitive.
]

== Variables, input and output

A program that always prints the same thing is boring. We want it to *read* data, *compute* and *print*. For this we need memory: *variables*.

#defn[Variable][A *variable* is a named place in the computer's memory that holds a value of a certain *type*. Declaring `int a;` creates a place called `a` for a whole number. Writing `a = 5;` stores 5 there. Reading `a` gets the stored value.]

Picture it as a labelled box. Our first interactive program reads a number $a$ and prints $a^8$. We could multiply $a$ seven times, but three multiplications are enough: $a^2 = a dot a$, $a^4 = a^2 dot a^2$, $a^8 = a^4 dot a^4$.

#cpp("power8")

What happens when the program runs? The operating system loads it; the first statement prints the prompt. `int a;` reserves memory for an integer. `std::cin >> a;` waits until you type a number and stores it into `a`. Then `b` is created and initialised with $a dot a$. The assignment `b = b * b;` reads the *old* value of `b`, multiplies, and stores the result back. Finally the output statement prints `a`, the text `^8 = ` and the value of `b * b`.

#trace(("statement", "a", "b"),
  ("int a; cin >> a;", "3", "—"),
  ("int b = a * a;", "3", "9"),
  ("b = b * b;", "3", "81"),
  ("print b * b", "3", "81 (prints 6561)"))

#check[What does `b = b * b;` mean mathematically? Why is `b = b * b;` fine in C++ although the equation $b = b^2$ only has the solutions 0 and 1?][The `=` is not an equation but an *assignment*: "compute the right side with the current values, then store the result into the variable on the left." It is a command, executed once, not a claim about equality.]

A second program, with decimals. `double` is the type for numbers with a decimal point. `const` means "this value is not supposed to change", the compiler will complain if you try.

#cpp("circle")

#intu[Programs work in three phases: *input* (read data), *processing* (compute), *output* (print the results). Almost every program in this course has exactly this shape. Whenever you get stuck, ask yourself: what is my input? what do I want as output? which steps lead from one to the other?]

== The vocabulary of a program

Every C++ text is built from a small set of building blocks. Knowing their names makes error messages and lectures much easier to follow.

#table(columns: (auto, 1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Term*], [*Meaning*], [*Example*],
  [Keyword], [word with a fixed meaning in the language, cannot be used as a name], [`int`, `return`, `const`],
  [Identifier], [name you choose for a variable or function: letters, digits, `_`, not starting with a digit], [`radius`, `b2`, `my_value`],
  [Literal], [a value written directly in the program], [`5`, `3.14`, `"text"`],
  [Operator], [symbol that combines values], [`+`, `*`, `<<`, `=`],
  [Expression], [something that has a value], [`a * a`, `5`, `b + 1`],
  [Statement], [a complete instruction, usually ending with `;`], [`b = b * b;`],
  [Comment], [text for humans, ignored by the compiler], [`// explanation`, `/* ... */`])

*Whitespace* (spaces, tabs, new lines) is mostly ignored, so you could write the whole program on one line. Don't: the layout is for human readers. Use *indentation* to show structure, one level deeper inside each pair of braces `{ }`. Good names (`radius` instead of `r2d2`) and a few comments about *why* you do something (not *what* every line does) make programs readable, for others and for yourself next week.

#everyday[Real software is read far more often than it is written. Large projects have millions of lines, written by hundreds of people. Style rules (naming, indentation, comments) exist because the *next reader* is the main customer of your code.]

== How to learn this

#recipe[Writing a program][
  + *Understand the task.* What is the input, what is the output? Work out an example by hand.
  + *Find the steps* on paper, in plain words, before typing any C++.
  + *Translate* the steps into statements. Keep programs small: compile after every few lines.
  + *Test* with inputs where you know the correct answer, including the extremes (0, negative, very large).
  + *Read errors from the top*, fix one error at a time.]

Programming is a practical skill, like playing an instrument: reading about it helps, but the skill comes from doing it. After every section of this script, type the examples yourself and change them. And learn to *trace by hand*: execute a program on paper, line by line, writing down the value of every variable (like the table above). If you can trace a program, you understand it. Many exam questions are exactly this.

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Who writes C++?* Almost everything where speed or direct control of the hardware matters: web browsers (Chrome, Firefox), game engines (Unreal), Photoshop and most other professional graphics tools, car and aircraft control software, trading systems in banks, and the data analysis framework ROOT at CERN, where physicists process the collisions of the Large Hadron Collider. The Ingenuity helicopter on Mars flew with software built on F Prime, a C++ framework from NASA's Jet Propulsion Laboratory. When something has to be fast, small and predictable, there is a good chance it is C++.]

#everyday[*Why compiled code is fast.* The compile step you met in this chapter is why a C++ program starts instantly: the work of translating has already been done, and the processor reads machine code directly. Languages that translate while running (Python, JavaScript) are more convenient but need more time and memory. This is also why your phone's camera pipeline, your car's brakes and your smartwatch use compiled code: the program must react in milliseconds, every time.]

#photo(("i_eniac",), [ENIAC (1945), one of the first electronic computers. It was «programmed» by plugging cables; later machines used stacks of punched cards. #credit[USGov-Military-Army, Public Domain, Wikimedia Commons]], ht: 5cm)
// ALLTAG-END

#summary[
- A *program* is a precise sequence of elementary steps; the *compiler* translates C++ source code into an executable.
- Every C++ program starts at `main`. Statements end with `;`. Case matters.
- `std::cout << x` prints, `std::cin >> x` reads. `#include <iostream>` is needed for both.
- *Variables* hold values; `=` is an assignment, not an equation.
- Three kinds of errors: *syntax* (compiler), *runtime* (crash), *logic* (wrong result). The compiler checks form, not intention.
- Work in three phases: input, processing, output; trace by hand to understand.
]

#problems()

#prob("Find the errors", [The following program should read an integer and print its double. It contains three syntax errors. Find them.
```
#include <iostream>
int Main() {
  int x
  std::cin >> x;
  std::cout << 2 * x << "\n"
  return 0;
}
```],
[+ `Main` must be written `main` (lower case). The compiler (linker) would complain that there is no `main`.
+ `int x` is missing its semicolon.
+ The `std::cout` statement is missing its semicolon.])

#prob("Trace by hand", [What is printed?
```
int a = 4;
int b = a + 2;
a = b * 2;
b = a - b;
std::cout << a << " " << b << "\n";
```],
[#trace(("after line", "a", "b"), ("1", "4", "—"), ("2", "4", "6"), ("3", "12", "6"), ("4", "12", "6"))
Output: `12 6`. (In line 4, `b = a - b` computes $12 - 6 = 6$.)])

#prob("Write a program", [Write a program that reads the length $l$ and the width $w$ of a rectangle (as `double`) and prints its area and its perimeter.],
[```
#include <iostream>
int main() {
  double l, w;
  std::cout << "length, width: ";
  std::cin >> l >> w;
  std::cout << "area = " << l * w << "\n";
  std::cout << "perimeter = " << 2 * (l + w) << "\n";
  return 0;
}
```
The parentheses in `2 * (l + w)` are essential. Note how `std::cin >> l >> w` reads two values in one chain.])

#prob("Exponentiation with few multiplications", [How many multiplications do you need to compute $a^(15)$ if you may store intermediate results in variables? Write the statements.],
[Five multiplications suffice: `b = a * a` ($a^2$), `c = b * a` ($a^3$), `d = c * c` ($a^6$), `e = d * d` ($a^12$), `f = e * c` ($a^15$). The route over $a^8 dot a^4 dot a^2 dot a$ needs six.])
