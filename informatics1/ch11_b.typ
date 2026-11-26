#import "lib.typ": *

== How to solve exercises on pointers and lists

Pointer exercises come in four types: *trace a program* ("what is printed?"), *find the bug*, *write a list function* (count, insert, remove) and *arrays and pointer arithmetic*. For all of them, the same rule holds: *draw*. Every exam solution that is correct started with a drawing.

#recipe("Trace a pointer program")[
+ Make a table with the columns *address*, *name*, *value*. Invent addresses (1000, 1004, …).
+ For every pointer, write the address it contains as its value, *and* draw an arrow to that variable.
+ For each line decide: does it change a *pointer* (`p = …`: move an arrow) or a *value* (`*p = …`: change a box at the end of an arrow)?
+ `*p` on the right-hand side means: follow the arrow and *read* the value there.
]

#ex("Exam-style: what is printed?")[
#cpp("d11_ex1", out: false)

#step[Start.] `x = 1` and `y = 2`; `p` points to `x`, `q` points to `y`.

#step[`*p = *q;`] Read the value at the end of `q` (`2`) and write it at the end of `p`: `x = 2`. The arrows do not move.

#step[`*q = 3;`] Write `3` at the end of `q`: `y = 3`.

#step[`q = p;`] *No star*: copy the address. Now `q` contains the address of `x` and points to `x`, like `p`.

#step[`*q = *q + 10;`] At the end of `q` is `x`: `x = 2 + 10 = 12`.

#step[Answer.] `x = 12`, `y = 3`, and both `*p` and `*q` are `x`:
#outonly("d11_ex1")
]

#recipe("Walk through a linked list")[
Almost every list function starts with this loop:
#snip("for (const Node* p = head; p != nullptr; p = p->next) {
    // here p points to the current node; use p->value
}")
- `p = head`: put your finger on the first node.
- `p != nullptr`: as long as the finger is on a node.
- `p = p->next`: move the finger to the next node.
Before writing anything else, check the *empty list* (`head == nullptr`): does your code still work? The loop above simply runs zero times.
]

#ex("Exam-style: count in a list")[
*Task.* Count the nodes whose value is greater than `t`.

#step[Pattern.] The *count* pattern from Chapter 6, only with the list loop instead of an index loop.
#cpp("d11_count")
For the list `4 → 9 → 1 → 7` and `t = 3`, the values `4`, `9` and `7` count: `3`. For the empty list (`nullptr`), the loop does not run: `0`.
]

#recipe("Change a linked list (insert or remove)")[
+ *Draw the list before*, with the nodes as boxes and the pointers as arrows.
+ *Draw the list after*, as it should look.
+ Find the pointers that have to change (usually one or two `next` pointers, and possibly `head`).
+ Find the right *order*: never overwrite a pointer before you have saved what it pointed to, otherwise the rest of the list is lost.
+ Check the special cases: empty list, change at the *first* node (then `head` changes, so the function must return the new head or take `Node*&`), change at the last node.
]

#ex("Exam-style: insert into a sorted list")[
*Task.* Insert a value `v` into a list that is sorted in increasing order, so that it stays sorted.

#step[Case 1: new first node.] If the list is empty or `v` is smaller than the first value, the new node becomes the first. Its `next` is the old head:
#chain("head", "2", "5", "8", note: [before; insert `1`])
#chain("head", "1", "2", "5", "8", hlv: ("1",), note: [after: `head = new Node{1, head};`])

#step[Case 2: somewhere later.] Find the *predecessor* `p`: the last node whose value is smaller than `v`. The new node goes between `p` and `p->next`. To insert `6`, `p` stops at `5`, because `p->next->value` would be `8` $>= 6$:
#chain("head", "2", "5", "8", note: [before; `p` points to the node `5`])
#chain("head", "2", "5", "6", "8", hlv: ("6",), note: [after: `p->next = new Node{6, p->next};`])
The one line does both pointer changes in the right order: `new Node{6, p->next}` first creates the node with `next` pointing to `8`, *then* the result is stored in `p->next`.

#step[Code and test.] Inserting `5, 2, 8, 6, 1` one after the other:
#cpp("d11_sorted")
The function returns the head because in case 1 the head changes. The caller must write `head = insert_sorted(head, v);`.
]

#ex("Exam-style: free a whole list")[
*Task.* Delete all nodes of a list.

#step[The trap.] `delete p; p = p->next;` uses `p` *after* the node was given back: dangling pointer.

#step[Correct.] Save the next address first, then delete:
#snip("while (head != nullptr) {
    Node* next = head->next;   // 1. remember where the rest is
    delete head;               // 2. give the node back
    head = next;               // 3. continue with the rest
}")
]

#recipe("Arrays and pointer arithmetic")[
- The name of an array is (converted to) the address of its first element: `int* p = a;` means `p = &a[0]`.
- `p + k` points `k` *elements* further (not `k` bytes). `*(p + k)` is the same as `p[k]`.
- `q - p` is the number of elements between two pointers into the same array.
- Valid positions: the elements, plus the position *just behind* the last one (like `end()`). Dereferencing outside is undefined.
]

#ex("Exam-style: pointer arithmetic")[
#cpp("d11_arr", out: false)
#step[Draw the array.]
#mem(("a[0]", "10"), ("a[1]", "20"), ("a[2]", "30"), ("a[3]", "40"), ("a[4]", "50"))
`p` starts at `a[0]`: prints `10`. After `p = p + 2`, `p` is at `a[2]`: `30`. `p[1]` is one further, `a[3]`: `40`. `*(a + 4)` is `a[4]`: `50`. And `p - a` is the distance from `a[0]` to `a[2]`: `2`.
#outonly("d11_arr")
]

#mistake[
- `delete` for every `new`, `delete[]` for every `new[]`, and *exactly once*.
- After `delete p;` the pointer still contains the old address. Set it to `nullptr` if it is used again.
- Returning the address of a *local* variable (`return &x;`): the desk is cleared when the function ends, so the pointer points to garbage. Use `new` (or better, return by value).
- Losing the head: `head = head->next;` in a loop that should only *read* the list destroys your only access to the first node. Use a separate walking pointer `p`.
]
