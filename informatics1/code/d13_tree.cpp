#include <iostream>
#include <algorithm>

struct TreeNode { int key; TreeNode* left; TreeNode* right; };

TreeNode* insert(TreeNode* t, int key) {
    if (t == nullptr) return new TreeNode{key, nullptr, nullptr};
    if (key < t->key)      t->left  = insert(t->left, key);
    else if (key > t->key) t->right = insert(t->right, key);
    return t;
}

void preorder(const TreeNode* t) {      // me, left, right
    if (t == nullptr) return;
    std::cout << t->key << " ";
    preorder(t->left);
    preorder(t->right);
}
void inorder(const TreeNode* t) {       // left, me, right
    if (t == nullptr) return;
    inorder(t->left);
    std::cout << t->key << " ";
    inorder(t->right);
}
void postorder(const TreeNode* t) {     // left, right, me
    if (t == nullptr) return;
    postorder(t->left);
    postorder(t->right);
    std::cout << t->key << " ";
}

int sum(const TreeNode* t) {
    if (t == nullptr) return 0;                         // empty tree
    return t->key + sum(t->left) + sum(t->right);       // me + left + right
}
int leaves(const TreeNode* t) {
    if (t == nullptr) return 0;
    if (t->left == nullptr && t->right == nullptr) return 1;  // a leaf
    return leaves(t->left) + leaves(t->right);
}
int height(const TreeNode* t) {
    if (t == nullptr) return 0;
    return 1 + std::max(height(t->left), height(t->right));
}
int largest(const TreeNode* t) {        // PRE: t != nullptr
    while (t->right != nullptr) t = t->right;           // always go right
    return t->key;
}
void destroy(TreeNode* t) {             // postorder: children first
    if (t == nullptr) return;
    destroy(t->left);
    destroy(t->right);
    delete t;
}

int main() {
    TreeNode* root = nullptr;
    for (int k : {50, 30, 70, 20, 40, 60, 80, 35}) root = insert(root, k);
    std::cout << "pre:  "; preorder(root);  std::cout << "\n";
    std::cout << "in:   "; inorder(root);   std::cout << "\n";
    std::cout << "post: "; postorder(root); std::cout << "\n";
    std::cout << "sum " << sum(root) << ", leaves " << leaves(root)
              << ", height " << height(root) << ", largest "
              << largest(root) << "\n";
    destroy(root);
}
