#import "lib.typ": *

== How to solve exercises on stacks, queues and trees

Typical tasks: *trace operations* on a stack or queue, *insert keys into a BST and draw it*, *write down a traversal*, and *write a recursive tree function*.

#recipe("Insert keys into a binary search tree by hand")[
+ The first key becomes the root.
+ For each further key: start at the root, compare, go *left if smaller*, *right if larger*, until you reach an empty place. Put the key there. Existing nodes never move.
+ The *order of insertion* determines the shape. The same keys in sorted order give a degenerate tree that looks like a list (see "Efficiency and the shape of the tree" above).
]

#ex("Exam-style: build the tree and give all three traversals")[
*Task.* Insert `50, 30, 70, 20, 40, 60, 80, 35` into an empty BST, draw it, and write down the preorder, inorder and postorder traversals.

#step[Build.] `50` is the root. `30 < 50`: left. `70 > 50`: right. `20`: left of `50`, left of `30`. `40`: left of `50`, right of `30`. `60`: right of `50`, left of `70`. `80`: right, right. `35`: left of `50` (to `30`), right of `30` (to `40`), left of `40`.
#plain("            50
          /    \\
        30      70
       /  \\    /  \\
     20   40  60   80
          /
        35")

#step[Preorder (me, left, right).] Start at `50`, then the whole left subtree in preorder (`30 20 40 35`), then the right (`70 60 80`): `50 30 20 40 35 70 60 80`.

#step[Inorder (left, me, right).] For a BST, simply the sorted keys: `20 30 35 40 50 60 70 80`.

#step[Postorder (left, right, me).] Left subtree in postorder: `20`, then the subtree of `40` gives `35 40`, then `30`. Right subtree: `60 80 70`. The root last: `20 35 40 30 60 80 70 50`.

#step[Check with the program.]
#cpp("d13_tree")
]

#trick[Traversals by hand: the walk around the tree][Draw a line that walks around the tree, starting left of the root, and touches every node three times: once from the left side (*pre*), once from below (*in*), once from the right side (*post*). Writing each key when you pass it on the chosen side gives the traversal.]

#recipe("Write a recursive function on a tree")[
+ *Base case:* the empty tree, `t == nullptr`. What is the answer? (Sum `0`, count `0`, height `0`, `false` for "contains".)
+ *Assume* that the function already works for `t->left` and `t->right` (leap of faith, Chapter 7).
+ *Combine:* how do you get the answer for `t` from the node's own key and the two answers?
+ Special cases like "is this a leaf?" (`t->left == nullptr && t->right == nullptr`) come *after* the empty-tree check.
]

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), inset: (y: 5pt),
  [*Function*], [*Empty tree*], [*Combine*],
  [number of nodes], [`0`], [`1 + count(left) + count(right)`],
  [sum of keys], [`0`], [`t->key + sum(left) + sum(right)`],
  [height], [`0`], [`1 + max(height(left), height(right))`],
  [number of leaves], [`0`], [leaf: `1`; else `leaves(left) + leaves(right)`],
  [contains `k` (BST)], [`false`], [equal: `true`; else search only the correct side],
  [largest key (BST)], [(not defined)], [go right until there is no right child],
  [delete the whole tree], [nothing], [postorder: delete left, delete right, then `delete t`])

These are all in the program above. For the tree of the example: the sum is $385$, there are $4$ leaves (`20, 35, 60, 80`), the height is $4$ (the path `50 – 30 – 40 – 35`), the largest key is `80`.

#recipe("Trace a stack or a queue")[
Draw the container as a row of boxes and mark clearly where *top* (stack) or *front* and *back* (queue) is. Then do the operations one by one, crossing out what is removed. Never do it in your head: the difference between `2 1` and `1 2` is exactly what the exam asks.
]

#recipe("Remove a key from a BST (summary)")[
+ Find the node.
+ *No child (leaf):* remove it, the parent's pointer becomes `nullptr`.
+ *One child:* the child takes the node's place.
+ *Two children:* replace the node's key by the *smallest key of the right subtree* (go right once, then left as far as possible), and remove that key from the right subtree. It has at most one child, so this is case 2 or 3.
]
