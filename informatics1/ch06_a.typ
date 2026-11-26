#import "lib.typ": *

== The idea in plain words

Before the formal rules, here is the picture you should keep in your head for this whole chapter. Every variable is a *box* in memory with a *name* written on it and a *value* inside.

=== A reference is a second name tag on the same box

Think of a person called Maximilian whom his friends call Max. "Max" and "Maximilian" are two names, but there is only *one* person: if Max gets a haircut, Maximilian has short hair too. A reference is exactly that: a second name for an existing box.

A *copy* is different. It is like making a photocopy of a page: you get a *new* page with the same text, and if you scribble on the copy, the original stays clean.

#cpp("d06_alias")

Draw this as boxes. After the first three lines, memory looks like this. There are only *two* boxes: `a` and `r` are two names on the first box.

#mem(("a  (also r)", "5"), ("c", "5"))

`r = 8` writes into the box called `a`/`r`; `c = 100` writes into the other box:

#mem(("a  (also r)", "8", hl), ("c", "100", hl))

#remember[`int& r = a;` creates *no new box*. It only puts a second name tag on the box of `a`. That is all a reference is. The `&` stands right after the type, in the *declaration*. (The `&` in front of a variable, `&a`, means something else: the address; that comes in Chapter 11.)]

=== Functions get either a photocopy or the original

When you call a function, each parameter is a new box in the *function's own area* of memory (its *frame*). With a normal parameter (`int n`), the value of the argument is *copied* into that box. With a reference parameter (`int& n`), *no* box is made: `n` is just a second name for the caller's variable.

#cpp("d06_frames")

Here is the memory during each call. The dashed rectangles are the frames of `main` and of the function:

#frames(frame("main", ("x", "3")), frame("by_value", ("n", "3 → 30", hl)))

`by_value` multiplies *its own* `n`. When the function ends, its frame disappears, and with it the `30`. `x` was never touched.

#frames(frame("main", ("x  (= n)", "3 → 30", hl)), frame("by_ref", ("n", "→ x")))

`by_ref` has no box of its own for `n`: `n` *is* `x`. Multiplying `n` multiplies `x`.

#trick[Asking the right question][For every parameter ask: *"Should the function change the caller's variable?"* If yes, use `&`. If no, and the type is small (`int`, `double`, `char`, `bool`), use a plain copy. If no, but the type is big (a `vector`, a `string`), use `const &`: no copy, and the compiler makes sure the function does not change it.]

=== A vector is a row of numbered lockers

Imagine a row of lockers in a school corridor. Each locker holds one value, all of the same type. The lockers are numbered *starting at 0*. The vector knows how many lockers it currently has (`size()`), and you can add a new locker at the end (`push_back`) or remove the last one (`pop_back`).

#mem(("[0]", "7"), ("[1]", "3"), ("[2]", "9"), note: [`v` with `size() == 3`. The last index is `2`, *one less than the size*.])

Watch the vector change step by step:

#cpp("d06_grow")

#remember[*Index* and *count* are different things. A vector with 3 elements has the indices `0`, `1`, `2`. `v[1]` is the *second* element. `v[3]` does *not* exist. Whenever you write a loop over a vector, the condition is `i < v.size()`, never `<=`.]
