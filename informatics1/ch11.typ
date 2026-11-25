#import "lib.typ": *

= Dynamic Memory, Pointers and Dynamic Data Structures I

#lec(11, [Dynamic memory, pointers, dynamic data structures I], [memory model · pointers · arrays · `new` / `delete` · linked lists])

#lecture[So far, the amount of memory a program uses was fixed when we wrote it (variables) or determined by the call depth (the stack). This chapter lifts the restriction: with *pointers* and *dynamic memory* a program can ask for memory *while running*, as much as it needs, and link pieces of memory into *data structures* of any shape. It is the most error-prone part of C++, and the one that explains how everything else works.]

== Where does data live?

A running program has several regions of memory:

#fg("c11_memory", [Memory regions of a running program. Every byte has an *address*, a number.], w: 84%)

- The *stack* holds the local variables and parameters of all active functions (Chapter 4). Its size is limited (typically a few megabytes). Memory is reserved and released automatically, at function entry and exit.
- The *static* region holds global variables and constants; it exists during the whole execution.
- The *heap* (also: *free store*) is for memory that you request explicitly with `new` and release with `delete`. It is large (gigabytes), and its objects live *as long as you want*, independent of function calls.

#intu[The stack is a pile of plates in a canteen: fast, tidy, but strictly last-in-first-out. The heap is a big warehouse: you can ask for a shelf of any size at any time and keep it as long as you like, but *you* have to remember to give it back, and you have to remember where you put it.]

== Pointers

Every variable lives at an address in memory. A *pointer* is a variable whose *value is an address*.

#defn[Pointer][A variable of type `T*` ("pointer to `T`") stores the address of an object of type `T`. Two operators belong to it:
- `&x` ("address of x") yields a pointer to the variable `x`,
- `*p` ("dereference p") is the object that `p` points to; it can be read and written.
`nullptr` is the special pointer value that points *nowhere*.]

#fg("c11_pointer", [`p` holds the address of `a`. Following the arrow (`*p`) leads to `a`.], w: 90%)

#cpp("ptr_basic")

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Reference `int&`*], [*Pointer `int*`*], [*Difference*],
  [`int& r = a;`], [`int* p = &a;`], [a reference *is* the variable (an alias); a pointer is a separate variable holding an address],
  [must be initialised], [may be `nullptr` or uninitialised], [],
  [can never be re-bound], [can point somewhere else later (`p = &b;`)], [],
  [used like the variable: `r`], [used with a star: `*p`], [])

#mistake[
- *Uninitialised pointers*: `int* p;` points to an arbitrary address. Writing `*p = 5` writes into a random place: crash or silent corruption. Initialise: `int* p = nullptr;`.
- *Dereferencing `nullptr`*: `*q` with `q == nullptr` crashes the program (segmentation fault). Check before: `if (q != nullptr) ...`.
- `int* a, b;` declares one pointer `a` and one plain `int b`: the star belongs to the *variable*. Write one declaration per line.
]

=== What do `&` and `*` mean?

The same symbols mean different things depending on the *context*. A frequent exam topic:

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Symbol*], [*Context*], [*Meaning*],
  [`&`], [after a *type* in a declaration: `int& r`], [reference type],
  [`&`], [*before a variable* in an expression: `&x`], [address-of],
  [`&`], [*between two values*: `a & b`], [bit-wise AND],
  [`&&`], [between truth values], [logical AND],
  [`*`], [after a *type* in a declaration: `int* p`], [pointer type],
  [`*`], [*before a pointer* in an expression: `*p`], [dereference],
  [`*`], [*between two values*: `a * b`], [multiplication])

#cpp("meanings")

== Arrays and pointer arithmetic

A built-in *array* `int a[5]` consists of five `int`s directly next to each other in memory (the older cousin of `std::vector`, with a fixed size). The *name* of an array converts to a pointer to its first element, and *pointer arithmetic* moves in units of elements: `p + 2` points to the element two further. In fact `a[i]` is defined as `*(a + i)`.

#cpp("ptr_arr")

#hood[A pointer `p + i` is not "address plus $i$", but "address plus $i$ times `sizeof(*p)`". That is why you can step through the elements with `++p`. Iterators (Chapter 10) of a vector are generalised pointers: `v.begin()` behaves like the pointer to the first element.]

#mistake[Pointer arithmetic is not checked: `a[7]` for a 5-element array simply reads whatever is there. Never move outside `[a, a + size]` (one *past* the end is allowed for comparing, not for dereferencing).]

== Dynamic memory: new and delete

#rule[new and delete][
- `new T(args)` allocates an object of type `T` *on the heap*, initialises it, and returns a pointer to it.
- `new T[n]` allocates an array of `n` elements; `n` may be a run-time value.
- `delete p;` destroys the single object and releases its memory. `delete[] p;` does the same for an array.
Every `new` must be paired with exactly one `delete` (and every `new[]` with a `delete[]`).]

#cpp("new_delete")

What is the use? The size `n` came from the *input*; a built-in array on the stack would need a size fixed in the source. (The `std::vector` of Chapter 6 does all this for you: it uses `new[]` and `delete[]` internally. Chapter 12 shows how.)

=== The four deadly sins

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Error*], [*What happens*],
  [*Memory leak*], [`new` without `delete`, or the only pointer to the memory is lost (`p = nullptr;` before `delete p;`). The program uses more and more memory until it is killed.],
  [*Dangling pointer*], [Using a pointer after the object has been deleted, or a pointer to a local variable that no longer exists. The memory may already belong to somebody else.],
  [*Double delete*], [`delete p; delete p;` corrupts the memory management: undefined behaviour.],
  [*Wrong delete*], [`delete` for an array (should be `delete[]`) or for memory not obtained by `new` (e.g. `delete &x`).])

#snip("int* make() {
    int x = 5;
    return &x;            // BUG: x dies at the end of make(); the pointer dangles
}
int* leak() {
    int* p = new int(5);
    return nullptr;       // BUG: the new int is lost forever: a leak
}")

#remember[*Who owns the memory?* For each object on the heap there must be exactly one place in the program that is responsible for deleting it. Write down who the owner is (a comment!), and delete at the latest when the owner is done. In Chapter 12 we make this automatic with *destructors*.]

== Pointers to structs

If `p` points to a struct, then `(*p).x` accesses a member. Because this is so common, there is a shorthand: `p->x`.

#cpp("node_ptr")

A struct can contain a pointer to *its own type*. That is the key to dynamic data structures.

== Dynamic data structures: the linked list

A `std::vector` stores its elements in one block of memory. Inserting in the middle means shifting everything behind it. A *linked list* takes the opposite approach: every element sits in its own little block, a *node*, which holds the value and a *pointer to the next node*. The last node has `next == nullptr`. The list itself is just a pointer to the first node, the *head*.

#fg("c11_list", [A linked list with three nodes. `head` points to the first node; the last `next` is `nullptr`.], w: 96%)

#cpp("list1")

The recurring pattern for *traversing* a list: `for (p = head; p != nullptr; p = p->next)`. Several remarks:
- `push_front` makes the new node point to the old head and returns it as the new head, an operation that needs *constant* time, whatever the length. The `new Node{v, head}` creates the node on the heap.
- To access the $k$-th element you must walk $k$ steps: a list has no `[i]`.
- `free_list` deletes node by node. It *first saves* `head->next`, because after `delete head` the node is gone, and reading from it would be a dangling-pointer error.
- The empty list is `head == nullptr`. Functions must handle it.

=== Insertion, removal, reversal

#fg("c11_insert", [Inserting a node after `p` in two pointer assignments. The *order* matters: first let the new node point onwards, then redirect `p`. In the other order, the rest of the list would be lost.], w: 80%)

#cpp("list2")

#recipe[Pointer surgery][
  + *Draw the picture*: boxes and arrows, before and after. Nobody gets pointer code right without a picture.
  + Find the *special cases*: empty list, first node, last node.
  + *Save* a pointer to anything that would otherwise become unreachable, before you overwrite a pointer.
  + Do the changes in an order that never loses a node.
  + Check with the empty list, a one-element list and a longer list.]

In `remove`, the first node is a special case because `head` itself changes: that is why the function returns the new head. The function `reverse` walks along the list and *redirects each `next` backwards*: `prev` is the already reversed part, `head` the part still to do.

#ex("Trace reverse for 2 → 3 → 4")[
#trace(("step", "prev", "head (to do)", "state of the links"),
  ("start", "null", "2", "2 → 3 → 4"),
  ("1", "2", "3", "2 → null,  3 → 4"),
  ("2", "3", "4", "3 → 2 → null,  4"),
  ("3", "4", "null", "4 → 3 → 2 → null"))
When `head` is null, `prev` points to the new first node: `return prev`.]

#everyday[Lists with pointers are everywhere: the undo history of an editor, the chain of blocks in a block chain, the free-space management of the heap itself, queues in operating systems, the "next" song in a playlist. Their strength: cheap insertion and deletion anywhere (once you hold a pointer to the place). Their weakness: no random access, and each element costs an extra pointer plus the overhead of its own allocation.]

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Heartbleed.* In 2014 a bug in OpenSSL, the library that secures a large part of the world's web traffic, let an attacker read memory that did not belong to the request. The code copied a number of bytes that the sender had claimed, without checking that the sender had actually sent that many; the surplus came from neighbouring memory, with passwords and private keys. It is the classical out-of-bounds read, the same bug you can write with a pointer or a `char` array in this chapter. The vulnerability affected hundreds of thousands of servers.]

#everyday[*Memory safety is the biggest class of security bugs.* Microsoft and the Chrome team have both reported that about 70% of their serious security vulnerabilities are memory-safety problems: dangling pointers, buffer overflows, use after free. That is why the industry is moving to safer languages (Rust is one) and to safer habits in C++: smart pointers, containers instead of raw arrays, and tools like AddressSanitizer that crash the program the moment it does something illegal. What you learn here is what you need to read their reports.]

#photo(("i_core", "i_dram",), [Left: magnetic core memory, where each tiny ring stores one bit. Right: a modern memory chip. A pointer is nothing but the number of one of these storage cells. #credit[Johann H. Addicks, CC BY-SA 3.0, Wikimedia Commons; Mister rf, CC BY-SA 4.0, Wikimedia Commons]], ht: 4.4cm)
// ALLTAG-END

#summary[
- Memory regions: *stack* (automatic), *static*, *heap* (manual, via `new` / `delete`).
- A *pointer* holds an address: `&x` address-of, `*p` dereference, `p->m` is `(*p).m`, `nullptr` points nowhere. Pointer arithmetic moves by elements; `a[i]` is `*(a + i)`.
- `new` / `delete`, `new[]` / `delete[]`: every allocation needs exactly one release. Beware of *leaks*, *dangling pointers*, *double delete*, and of dereferencing `nullptr`.
- *Linked list*: nodes with a value and a `next` pointer; traversal by `p = p->next`; draw pictures, handle special cases, never lose a node.
]

#problems()

#prob("Pointer trace", [What is printed?
```
int a = 1, b = 2;
int* p = &a;
int* q = &b;
*p = *q + 5;
q = p;
*q = *q * 2;
std::cout << a << " " << b << " " << *p;
```],
[`*p = *q + 5` sets `a = 2 + 5 = 7`. `q = p` makes `q` point to `a`. `*q = *q * 2` sets `a = 14`. `b` is unchanged. Output: `14 2 14`.])

#prob("What is wrong?", [Find the bug in each snippet.
(a) `int* p = new int[10]; ... delete p;` (b) `int* f() { int a[3] = {1, 2, 3}; return a; }` (c) `Node* p = new Node{1, nullptr}; delete p; std::cout << p->value;`],
[(a) Array allocated with `new[]` must be released with `delete[]`. (b) The array is a local variable and dies at the return; the returned pointer dangles. (c) `p` is used after `delete`: dangling pointer (use after free).])

#prob("List length and sum", [Write `int sum(const Node* head)` for a list of integers, once with a loop and once recursively.],
[```
int sum(const Node* head) {                 // loop
    int s = 0;
    for (const Node* p = head; p != nullptr; p = p->next) s += p->value;
    return s;
}
int sum_rec(const Node* head) {             // recursion: base case = empty list
    if (head == nullptr) return 0;
    return head->value + sum_rec(head->next);
}
```
A list is a *recursive* structure: a list is either empty or a value followed by a list. Recursive functions on lists mirror this definition.])

#prob("Append at the end", [Write `Node* push_back(Node* head, int v)` that appends a node at the end and returns the head. How long does it take for a list of length $n$?],
[```
Node* push_back(Node* head, int v) {
    Node* n = new Node{v, nullptr};
    if (head == nullptr) return n;          // empty list: the new node is the head
    Node* p = head;
    while (p->next != nullptr) p = p->next; // walk to the last node
    p->next = n;
    return head;
}
```
It needs $n$ steps. (A list that also stores a pointer to its *last* node makes this constant.)])

#prob("Dynamic array", [Write a function `int* make_range(int n)` that returns a heap array with the values $0, 1, ..., n-1$. Who must release the memory, and how?],
[```
int* make_range(int n) {
    int* a = new int[n];
    for (int i = 0; i < n; ++i) a[i] = i;
    return a;
}
```
The *caller* becomes the owner and must call `delete[] a;`, which has to be documented in the function's comment. A `std::vector<int>` return value avoids this problem altogether.])
