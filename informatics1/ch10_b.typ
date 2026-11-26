#import "lib.typ": *

== How to solve exercises on classes, containers and iterators

The typical tasks are: *design a class* from a description, *find out what does not compile* (private access, `const`), *use a container* (mostly `map`), and *loops with iterators*.

#recipe("Design a class from a text description")[
+ *Nouns* in the description that describe the state become *data members* (private). Choose types.
+ *Verbs* ("add", "withdraw", "extend", "check whether") become *public member functions*.
+ Write down the *invariant*: which combinations of data are allowed? (`lo_ <= hi_`, `balance_ >= 0`, denominator $!= 0$.)
+ Write the *constructor* so that the invariant holds afterwards (check or repair the arguments).
+ For each member function that changes data, check: *does the invariant still hold afterwards?*
+ Every function that only reads gets `const`.
]

#ex("Exam-style: a class Interval")[
*Task.* Design a class for a closed interval $[a, b]$ of real numbers with: a constructor from two numbers (in any order), `length()`, `contains(x)` and `extend(x)`, which enlarges the interval so that it contains `x`.

#step[Data and invariant.] Two numbers `lo_` and `hi_`, invariant `lo_ <= hi_`.

#step[Constructor.] The two numbers may come in the wrong order, so the constructor *sorts* them. Now the invariant holds.

#step[Member functions.] `length` and `contains` only read: `const`. `extend` changes the object; it moves `lo_` down or `hi_` up, which can never break `lo_ <= hi_`.
#cpp("d10_interval")
]

#recipe("Which lines do not compile?")[
Go through `main` line by line and ask for each use of an object:
+ Is a *private* member used from outside the class? (`c.count_` in `main`): error.
+ Is a *non-`const`* member function called on a `const` object or through a `const&`? Error.
+ Does a `const` member function *change* a data member? Error inside the class.
+ Is a constructor called with arguments that do not match any constructor? Error.
]

#ex("Exam-style: find the errors")[
#err("err_d10_const")
There are *two* errors (the compiler shows the first one):
- Line 4: `value()` is declared `const`, so it must not change `count_`, but `++count_` does.
- Line 11: `count_` is `private`, so `main` may not access it. Use a public member function instead.
]

#recipe("Use a map")[
- `m[key]` returns the value for `key`; if there is no entry yet, it *creates* one with the default value (`0` for numbers, `""` for strings). Perfect for counting: `++m[key];`.
- To *check* whether a key exists without creating it: `m.find(key) != m.end()` (or `m.count(key) == 1`).
- Iterating gives the entries *sorted by key*; each entry has `->first` (key) and `->second` (value).
]

#ex("Exam-style: letter frequencies")[
*Task.* Count how often each letter occurs in a text and print the result in alphabetical order.

#step[Container.] "for each letter a count" is a dictionary from `char` to `int`: `std::map<char, int>`. The alphabetical order comes for free.
#cpp("d10_map")
]

#recipe("Loops with iterators")[
+ Template: `for (auto it = c.begin(); it != c.end(); ++it) { … *it … }`.
+ Never dereference `end()`. Never use an iterator after the container was changed (by `push_back`, `insert`, `erase`), *except* for the iterator that `erase` returns.
+ To remove elements while iterating: `it = c.erase(it);` and advance only when you did *not* erase.
+ Position of an iterator in a vector: `it - v.begin()`.
]

#ex("Exam-style: remove all zeros")[
*Task.* Remove all zeros from a vector using iterators.

#step[The trap.] `for (…; ++it) if (*it == 0) v.erase(it);` is wrong: after `erase`, `it` is invalid, and even if it worked, the `++it` would skip the element after each erased one (two zeros in a row!).

#step[The correct pattern.] `erase` returns an iterator to the element *after* the erased one. So we use that and do *not* advance in this case:
#cpp("d10_erase")
]

#ex("Exam-style: algorithms instead of loops")[
*Task.* Sort a vector, count the `2`s, compute the sum, find the maximum and the position of `5`.
#cpp("d10_algos2")
Note that `max_element` and `find` return *iterators*: `*big` is the value, `f - v.begin()` is the index.
]

#table(columns: (1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), inset: (y: 5pt),
  [*Exam question: "Which container would you use for …?"*], [*Answer*],
  [values in input order, access by position], [`std::vector`],
  [a set of distinct names, "is X in it?"], [`std::set`],
  [for each word its number of occurrences], [`std::map<std::string, int>`],
  [phone book: name → number], [`std::map<std::string, std::string>`],
  [many insertions and removals in the middle while walking through], [`std::list`])
