#import "lib.typ": *

== The idea in plain words

=== Inheritance: "is a", plus something extra

A dog *is an* animal: everything an animal has (a name, an age, it eats), a dog has too, plus some things of its own (it barks). Inheritance lets you write the common part *once*, in the *base class* `Animal`, and then say `class Dog : public Animal { … }`: "a `Dog` is an `Animal`, with these extras".

In memory, a `Dog` object literally *contains* an `Animal` object as its first part:

#mem(("Animal part: name_", "\"Rex\""), ("Animal part: age_", "3"), ("Dog part: ...", "…"), note: [A `Dog` object. Because it starts with a complete `Animal`, it can be used wherever an `Animal` is expected.])

This explains the order of construction: the house is built from the foundation up. First the `Animal` part is constructed, then the `Dog` part. Destruction goes the other way: first the `Dog` part is removed, then the `Animal` part.

=== The label on the box and what is really inside

When you have an `Animal* p` or an `Animal& r`, there are *two* types in play:
- the *static type*: what the *declaration* says, the label on the box: "this is some animal". The compiler only knows this one.
- the *dynamic type*: what *really* is in the box when the program runs: maybe a `Dog`, maybe a `Cat`.

The compiler uses the label to decide what you are *allowed* to call: through an `Animal&` you may call `eat()`, but not `bark()`, because not every animal can bark.

=== virtual: ask the object, not the label

Now both `Animal` and `Dog` have a function `sound()`. Which one runs for `r.sound()`, if `r` is an `Animal&` that refers to a dog?
- Without `virtual`, the *label* decides: `Animal::sound()` runs, even though there is a dog in the box.
- With `virtual` (in the base class), the *object* decides: the program looks at what is really in the box and runs `Dog::sound()`.

This is *polymorphism* ("many forms"): one line of code, `r.sound()`, does the right thing for every kind of animal, including kinds that are written years later.

#remember[Polymorphism works only through a *pointer* or a *reference*. If you copy a dog into a variable of type `Animal` (by value), only the `Animal` part is copied: the dog is "sliced off", and the copy is a plain animal.]

=== Abstract classes: a promise without a recipe

`virtual double area() const = 0;` says: "every shape *must* be able to compute its area, but there is no general recipe for it". A class with such a *pure virtual* function is *abstract*: you cannot create a "shape as such", only circles, rectangles, …, which fill in the recipe. The abstract class is a *contract*: code that uses a `Shape&` can rely on `area()` existing.
