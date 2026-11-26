#import "lib.typ": *

= Dynamic Data Structures II

#lec(13, [Dynamic data structures II], [list class · stack · queue · binary search trees · tree traversals · removal])

#lecture[We now combine the two previous chapters: the pointer structures of Chapter 11 and the memory-owning classes of Chapter 12. Then we meet the first structure that is *not* a line: the binary search tree, where recursion and pointers fit together perfectly. It finds, inserts and deletes in about $log n$ steps.]

#include "ch13_a.typ"

== A linked list as a class

The loose functions of Chapter 11 required the caller to manage `head` and to call `free_list`. Now the list manages itself. The class owns its nodes (RAII, rule of three), the node type is a private detail, and a second pointer `tail_` to the *last* node makes `push_back` fast.

#cpp("intlist")

What to note:
- The `Node` struct is *private*: outsiders cannot even see nodes, only values. We could replace the implementation without anybody noticing (information hiding, Chapter 10).
- The invariants: `size_` is the number of nodes; `head_ == nullptr` iff the list is empty; `tail_` points to the last node (or is `nullptr` iff the list is empty). Every member function must keep them: look at `pop_front`, which has to clear `tail_` when the last node disappears.
- The destructor calls `clear()`; copy constructor and assignment do deep copies. Output line 3 shows that popping from the copy `b` leaves `a` untouched.

#fg("c13_stackqueue", [Two ways to use a sequence. A *stack* only works at one end (`push`, `pop`, `top`); a *queue* adds at the back and removes at the front.], w: 94%)

== Stacks and queues

Two simple "restricted" sequences appear all over computer science:

- A *stack* (last in, first out; LIFO) has `push`, `pop`, `top`. Think of a pile of plates. The call stack of Chapter 4 is one, as is the "undo" history of an editor and the evaluation of arithmetic expressions.
- A *queue* (first in, first out; FIFO) has `push`, `front`, `pop`. Think of the queue at the canteen. Print jobs, network packets and tasks of the operating system are queued.

Both can be implemented with a linked list (stack: `push_front` / `pop_front`; queue: `push_back` / `pop_front`, which is why we wanted the `tail_` pointer), or with a vector. The standard library provides `std::stack` and `std::queue`.

#cpp("stackqueue")

#ex("Checking brackets with a stack")[A string like `([]{})` is *well-formed* if every closing bracket matches the most recent still-open one. "Most recent still open" is exactly the top of a stack: each opening bracket is pushed, each closing one must match the top, which is then popped. The expression `([)]` fails because `)` meets `[` on the stack. The string `((` fails because the stack is not empty at the end. Compilers use the same idea to check the nesting of `{ }` in your programs.]

== Trees

Lists are one-dimensional: to find an element, you may have to look at all of them. How can we organise data so that one comparison rules out *half* of the remaining candidates, as in binary search (Chapter 9), but while still allowing fast insertion? The answer is a *tree*.

#defn[Binary tree][A *binary tree* is either empty, or consists of a *node* with a *key* and two *subtrees*: the *left* and the *right* subtree, which are again binary trees. The topmost node is the *root*, nodes without children are *leaves*. The *height* is the number of nodes on the longest path from the root to a leaf.]

#snip("struct TreeNode {
    int key;
    TreeNode* left;     // nullptr: no left child
    TreeNode* right;
};")

Note the *recursive definition*: a tree consists of trees. That is why recursive functions are the natural way to work with trees.

=== Binary search trees

#defn[Binary search tree (BST)][A binary tree in which for every node: all keys in its *left* subtree are *smaller* and all keys in its *right* subtree are *larger* than the node's key.]

#fg("c13_bst", [A binary search tree and the search for 35. At each node a single comparison decides in which subtree the key can be.], w: 70%)

The ordering property makes *searching* easy: compare with the root. Equal: found. Smaller: it can only be on the left. Larger: only on the right. *Inserting* works the same way: search for the key; where the search ends at an empty subtree (`nullptr`), a new node is created.

#cpp("bst")

Look at `insert`. It returns the root of the (sub)tree, and the caller stores it: `t->left = insert(t->left, key);`. When the recursion reaches an empty tree, it creates the node, and the assignment hooks it into the parent. That way no special code for "the first node" or for "which side" is needed. It is the recursive counterpart of pointer surgery.

#recipe[Writing recursive tree functions][
  + *Base case:* the empty tree (`t == nullptr`). What is the answer for it? (height 0, count 0, contains false, ...)
  + *Recursive case:* handle the node itself and call the function for `t->left` and `t->right`.
  + *Combine* the results: `1 + max(...)`, `1 + a + b`, ...]

=== Traversals

To *visit all* nodes, one has three natural orders, depending on when the node itself is processed relative to its subtrees:

#fg("c13_traversal", [The numbers show the order in which the keys are visited. In-order of a BST gives the keys *sorted*.], w: 100%)

- *Preorder*: node, left, right. (Copying a tree, printing its structure.)
- *Inorder*: left, node, right. For a search tree this produces the keys in ascending order, as the program output shows.
- *Postorder*: left, right, node. Children before the parent: this is the right order for *deleting* a tree, as in `free_tree` (if we deleted the node first, we would lose the pointers to its children).

#hood[The recursion of a tree traversal uses the call stack: when `inorder(t->left)` is running, the frames for the whole path from the root down to the current node are on the stack. The depth of the recursion is the *height* of the tree.]

=== Efficiency and the shape of the tree

Searching and inserting costs one step per level, so about the *height* of the tree. In a nicely *balanced* tree with $n$ nodes the height is about $log_2 n$: 20 for a million keys. But the shape depends on the order of insertion!

#fg("c13_degenerate", [The same keys inserted in different orders. If the keys arrive sorted, the tree degenerates into a list.], w: 90%)

The program above shows this: the 8 sorted keys produce height 8, a linked list in disguise. *Self-balancing* trees (AVL trees, red-black trees) repair the shape after each insertion. `std::set` and `std::map` (Chapter 10) are implemented as red-black trees, which is the reason why they guarantee $log n$ time.

#table(columns: (auto, auto, auto, auto), align: center, stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Operation*], [*vector (unsorted)*], [*linked list*], [*balanced search tree*],
  [find a key], [$n$], [$n$], [$log n$],
  [insert at the end], [1 (amortised)], [1 (with `tail_`)], [$log n$],
  [insert in the middle], [$n$], [1 (given position)], [$log n$],
  [elements in sorted order], [needs sorting], [needs sorting], [inorder traversal])

=== Removing a node

Insertion is easy, removal needs a case distinction, depending on the number of children of the node to be removed:

#fg("c13_erase", [The three cases of removal in a binary search tree.], w: 100%)

+ *Leaf*: simply delete it; the parent's pointer becomes `nullptr`.
+ *One child*: the child takes its place (the parent's pointer is redirected).
+ *Two children*: the node cannot just disappear. Replace its key by the *smallest key of the right subtree* (its *successor*, the next larger key; it has no left child), and remove that node instead. The ordering property is preserved.

#cpp("bst_erase")

#mistake[
- Forgetting the base case `t == nullptr`: the recursion dereferences a null pointer.
- In `insert`: not assigning the result back (`insert(t->left, key);` without `t->left = ...`). The new node is created and lost: a memory leak and a missing key.
- Deleting a node before reading its children's pointers.
- Using a plain `delete` without keeping the tree consistent: all pointers to the node must be updated.
]

#everyday[Trees are everywhere: the folders of a file system, the structure of a web page (the DOM), the parsing of an arithmetic expression or of your C++ program (the compiler's *syntax tree*), databases (indexes are B-trees), decision trees in machine learning, the call tree of a recursive function.]

#include "ch13_b.typ"

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Trees inside databases.* A database with a billion entries finds a record after a handful of steps, because the index is a balanced search tree. A binary tree needs $log_2 10^9 approx 30$ levels; real databases use B-trees with hundreds of children per node, so about four levels are enough. The same structure organises directories in many file systems. Without this, searching by name in a big table would mean reading every row, which would take minutes instead of milliseconds. It is the practical use of the binary-tree idea in this chapter.]

#everyday[*Git is a linked structure.* Every commit points to its parent commit (and a merge commit to two). Following these links from the newest commit backwards is walking through a linked list; the whole history of a project is a directed graph. When you type `git log`, the program follows the pointers exactly as in the list traversal you learned. Also, every commit is identified by a hash of its content and its parent's hash, so changing one old commit would change all later ones. The structure is a blockchain in miniature.]
// ALLTAG-END

#summary[
- A list class keeps `head_` / `tail_` / `size_` consistent and owns its nodes (rule of three).
- *Stack* (LIFO) and *queue* (FIFO) are restricted sequences; brackets can be checked with a stack.
- A *binary search tree*: left subtree smaller, right subtree larger. `contains` and `insert` follow one path: cost proportional to the height.
- Tree functions are naturally recursive: base case `nullptr`, then the two subtrees. *Inorder* gives sorted order; *postorder* is for deletion.
- The height depends on the insertion order: balanced $approx log_2 n$, degenerate $= n$. Removal has three cases.
]

#problems()

#prob("Draw the tree", [Insert the keys 8, 3, 10, 1, 6, 14, 4, 7 in this order into an empty binary search tree. Draw it, and give the preorder, inorder and postorder traversal and the height.],
[Root 8. 3 is left of 8, 10 right of 8. 1 left of 3, 6 right of 3. 14 right of 10. 4 left of 6, 7 right of 6.
Preorder: `8 3 1 6 4 7 10 14`. Inorder: `1 3 4 6 7 8 10 14` (sorted). Postorder: `1 4 7 6 3 14 10 8`. Height 4 (path 8 → 3 → 6 → 4).])

#prob("Tree functions", [Write recursive functions that compute (a) the sum of all keys, (b) the largest key of a non-empty BST, (c) the number of leaves.],
[```
int sum(const TreeNode* t) { return t == nullptr ? 0 : t->key + sum(t->left) + sum(t->right); }
int largest(const TreeNode* t) {                  // pre: t != nullptr
    return t->right == nullptr ? t->key : largest(t->right);   // go right as far as possible
}
int leaves(const TreeNode* t) {
    if (t == nullptr) return 0;
    if (t->left == nullptr && t->right == nullptr) return 1;
    return leaves(t->left) + leaves(t->right);
}
```
For the largest key we use the ordering property, so one path suffices instead of the whole tree.])

#prob("Queue by two stacks", [Explain how to implement a queue using two stacks.],
[Keep an *in* stack and an *out* stack. `push` puts the element on *in*. For `front` / `pop`: if *out* is empty, pop all elements from *in* and push them onto *out*, which reverses their order, so the oldest element ends on top. Then take from *out*. Each element is moved at most twice, so every operation is cheap on average.])

#prob("Remove the last node", [Write `Node* pop_back(Node* head)` for a singly linked list that removes the last node (list not empty) and returns the head. Why is it slow compared to `pop_front`, and what can be done?],
[```
Node* pop_back(Node* head) {
    if (head->next == nullptr) { delete head; return nullptr; }   // only one node
    Node* p = head;
    while (p->next->next != nullptr) p = p->next;     // stop at the second to last node
    delete p->next;
    p->next = nullptr;
    return head;
}
```
We must find the *second to last* node, which needs a walk over the whole list: $n$ steps. A *doubly linked list* (each node also has a `prev` pointer, plus `tail_`) makes this constant; `std::list` is one.])

#prob("Why does inorder sort?", [Give a short argument why the inorder traversal of a binary search tree visits the keys in ascending order.],
[By induction on the height. Inorder first visits the left subtree (all keys smaller than the root's key, in ascending order by induction), then the root, then the right subtree (all keys larger, in ascending order by induction). Together, the output is ascending. The empty tree (base case) outputs nothing.])
