#include <iostream>

struct TreeNode { int key; TreeNode* left; TreeNode* right; };

TreeNode* insert(TreeNode* t, int key) {
    if (t == nullptr) return new TreeNode{key, nullptr, nullptr};
    if (key < t->key) t->left = insert(t->left, key); else if (key > t->key) t->right = insert(t->right, key);
    return t;
}
void inorder(const TreeNode* t) {
    if (t == nullptr) return;
    inorder(t->left); std::cout << t->key << " "; inorder(t->right);
}

// removes the smallest key of the (non-empty) tree t; returns it through min
TreeNode* remove_min(TreeNode* t, int& min) {
    if (t->left == nullptr) {
        min = t->key;
        TreeNode* r = t->right;
        delete t;
        return r;
    }
    t->left = remove_min(t->left, min);
    return t;
}

// removes key from the tree t, returns the new root
TreeNode* erase(TreeNode* t, int key) {
    if (t == nullptr) return nullptr;                  // not found
    if (key < t->key) { t->left = erase(t->left, key); return t; }
    if (key > t->key) { t->right = erase(t->right, key); return t; }
    // found the node to remove
    if (t->left == nullptr) { TreeNode* r = t->right; delete t; return r; }   // 0 or 1 child
    if (t->right == nullptr) { TreeNode* l = t->left; delete t; return l; }
    t->right = remove_min(t->right, t->key);           // 2 children: take over the successor
    return t;
}

int main() {
    TreeNode* root = nullptr;
    for (int k : {50, 30, 70, 20, 40, 60, 80, 35}) root = insert(root, k);
    inorder(root); std::cout << "\n";
    root = erase(root, 20);  inorder(root); std::cout << "  (leaf 20 removed)\n";
    root = erase(root, 40);  inorder(root); std::cout << "  (node 40 with one child removed)\n";
    root = erase(root, 50);  inorder(root); std::cout << "  (root 50 with two children removed, new root " << root->key << ")\n";
    return 0;
}
