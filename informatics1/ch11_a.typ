#import "lib.typ": *

== The idea in plain words

Pointers are the topic that confuses most students, and almost always for the same reason: they try to understand them without drawing. With the right picture, pointers are simple.

=== Memory is a street with numbered houses

Imagine the computer's memory as one very long street. Every house has a *house number* (the *address*) and can hold one value. A variable is a house that we gave a name. When we write `int a = 5;`, the computer picks a free house, say number 1000, writes the name `a` on it and puts `5` inside.

A *pointer* is a house that does not contain a normal value but a *house number*: a slip of paper saying "go to house 1000". That is all. Two operations:
- `&a`: "What is the house number of `a`?" The answer is `1000`.
- `*p`: "Go to the house whose number is written in `p`, and use what is in *that* house."

=== One program, slowly, with a table

#cpp("d11_star")

We invent house numbers (the real ones do not matter, only that they are different). After the first three lines:

#memtab(("1000", "a", "5"), ("1004", "b", "9"), ("1008", "p", "1000"))

`p` contains `1000`, the address of `a`. We say *`p` points to `a`* and draw an arrow from `p` to `a`. Now:
- `*p = 7;`: go to house `1000` (because `p` contains `1000`) and put `7` there. So `a` becomes `7`. `p` itself is unchanged.
- `p = &b;`: put the address of `b`, `1004`, into `p`. Now `p` points to `b`. `a` is unchanged.
- `*p = *p + 1;`: read the value in house `1004` (`9`), add one, write it back: `b` becomes `10`.

#memtab(("1000", "a", "7"), ("1004", "b", "10"), ("1008", "p", "1004"))

#remember[Two kinds of assignment, and you must always know which one you are doing:
- `p = …` (no star) changes *where `p` points*. Only the slip of paper changes.
- `*p = …` (with star) changes *the value in the house `p` points to*. The slip stays the same.]

=== Reading the declarations aloud

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), inset: (y: 5pt),
  [*Code*], [*Read it as …*],
  [`int* p;`], ["`p` is a pointer to an `int`" (a slip that can hold the number of an `int`-house)],
  [`int* p = &a;`], ["`p` points to `a`"],
  [`*p`], ["the thing `p` points to"],
  [`p->value`], ["the member `value` of the thing `p` points to", short for `(*p).value`],
  [`p = nullptr;`], ["`p` points nowhere" (an empty slip)])

=== Stack and heap: the desk and the storage room

The variables of a function live on the *stack*. Think of it as your desk: when a function starts, it gets some space on the desk, and when it ends, the desk is cleared *automatically*. You never have to clean up.

Sometimes data must outlive the function that created it, or you do not know in advance how much you need. Then you rent a box in the *storage room*, the *heap*: `new int(5)` rents a box, puts `5` inside and gives you its *number*, a pointer. The storage room is not cleaned up automatically. When you no longer need the box, you must give it back with `delete p;`. If you forget, the box stays rented until the program ends (a *memory leak*). If you use the number after giving the box back, you walk into somebody else's box (a *dangling pointer*).

=== A linked list is a treasure hunt

In a treasure hunt, each clue tells you something *and* where the next clue is hidden. The last clue says "this is the end". A linked list works the same way. Each *node* is a small struct on the heap with a value and the address of the next node:

#snip("struct Node {
    int value;     // the information
    Node* next;    // where the next node is (or nullptr at the end)
};")

#chain("head", "4", "9", "1", "7", note: [Each box is a node: the value on the left, the pointer `next` on the right. `head` is a pointer to the first node.])

You only hold the first clue (`head`). To reach the third node you have to follow the arrows: `head->next->next`. There is no `list[2]`. In exchange, inserting a node in the middle costs just two pointer changes; nothing has to be moved.
