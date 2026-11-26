#import "lib.typ": *

== The idea in plain words

=== Stack and queue: plates and the bakery

A *stack* is a pile of plates. You can only put a plate *on top* (`push`), look at the top plate (`top`) and take the top plate away (`pop`). The plate you put on last is the first you take off: *last in, first out* (LIFO). The "undo" button works like this: the last action you did is the first one undone.

A *queue* is the line at the bakery. New customers join at the *back* (`push`), the customer at the *front* is served first (`front`, `pop`): *first in, first out* (FIFO).

#cpp("d13_ops")

Follow it with pictures. After pushing `1, 2, 3` into both:
#mem(("", "1"), ("", "2"), ("top", "3"), note: [the stack: `top` is the last one pushed])
#mem(("front", "1"), ("", "2"), ("back", "3"), note: [the queue: `front` is the first one pushed])
`pop` removes `3` from the stack (the top) but `1` from the queue (the front). Then `4` is added: to the top of the stack, to the back of the queue. That gives `4 2 1` and `2 3 4`.

=== A tree is a family tree, or a folder structure

A list is a chain: each node has *one* successor. In a *tree*, each node can have *several* children. You know trees from the folders on your computer (a folder contains folders) and from family trees. In a *binary* tree, each node has at most two children, a *left* and a *right* one. The top node is the *root*, nodes without children are *leaves*.

=== The binary search tree is the guessing game "higher or lower"

"I think of a number between 1 and 100." You guess 50. "Lower." You guess 25. "Higher." … A *binary search tree* (BST) stores the numbers so that this game is built into the structure. The rule, valid at *every* node:

#align(center, block(fill: cblf, stroke: 0.7pt + cbl, radius: 4pt, inset: 10pt)[everything in the *left* subtree is *smaller*, everything in the *right* subtree is *larger*])

To find a key, start at the root and at each node ask "smaller or larger?", going left or right. Each comparison throws away a whole subtree. If the tree is well balanced, a million keys need only about 20 comparisons.

=== Three ways to visit every node

To visit all nodes recursively, you must decide *when* to handle the node itself, compared to its two subtrees:
- *Preorder:* first *me*, then left, then right. (Like reading a table of contents: chapter title first, then its sections.)
- *Inorder:* left, then *me*, then right. In a BST this gives the keys in *sorted* order, because everything smaller is on the left.
- *Postorder:* left, right, and *me last*. (Like computing the size of a folder: first the sizes of all subfolders, then the total. Or deleting a tree: delete the children before the parent.)

The names say where the node ("order") comes: *pre* = before, *in* = in between, *post* = after the subtrees.
