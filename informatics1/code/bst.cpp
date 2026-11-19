#include <algorithm>
#include <iostream>

struct TreeNode {
    int key;
    TreeNode* left;       // subtree with smaller keys
    TreeNode* right;      // subtree with larger keys
};

// inserts key into the tree with root t, returns the (possibly new) root
TreeNode* insert(TreeNode* t, int key) {
    if (t == nullptr) return new TreeNode{key, nullptr, nullptr};
    if (key < t->key) t->left = insert(t->left, key);
    else if (key > t->key) t->right = insert(t->right, key);
    return t;                                          // equal keys are ignored
}

bool contains(const TreeNode* t, int key) {
    if (t == nullptr) return false;
    if (key == t->key) return true;
    return key < t->key ? contains(t->left, key) : contains(t->right, key);
}

int height(const TreeNode* t) {                        // empty tree: 0
    if (t == nullptr) return 0;
    return 1 + std::max(height(t->left), height(t->right));
}

int count(const TreeNode* t) {
    return t == nullptr ? 0 : 1 + count(t->left) + count(t->right);
}

void inorder(const TreeNode* t) {                      // left, node, right: sorted order!
    if (t == nullptr) return;
    inorder(t->left);
    std::cout << t->key << " ";
    inorder(t->right);
}
void preorder(const TreeNode* t) {                     // node, left, right
    if (t == nullptr) return;
    std::cout << t->key << " ";
    preorder(t->left);
    preorder(t->right);
}
void postorder(const TreeNode* t) {                    // left, right, node
    if (t == nullptr) return;
    postorder(t->left);
    postorder(t->right);
    std::cout << t->key << " ";
}

void free_tree(TreeNode* t) {
    if (t == nullptr) return;
    free_tree(t->left);                                // children first, then the node itself
    free_tree(t->right);
    delete t;
}

int main() {
    TreeNode* root = nullptr;
    for (int k : {50, 30, 70, 20, 40, 60, 80, 35}) root = insert(root, k);
    std::cout << "inorder:   "; inorder(root);   std::cout << "\n";
    std::cout << "preorder:  "; preorder(root);  std::cout << "\n";
    std::cout << "postorder: "; postorder(root); std::cout << "\n";
    std::cout << "contains 60: " << contains(root, 60) << ", contains 65: " << contains(root, 65) << "\n";
    std::cout << "nodes " << count(root) << ", height " << height(root) << "\n";

    TreeNode* chain = nullptr;                          // sorted input: the worst case
    for (int k = 1; k <= 8; ++k) chain = insert(chain, k);
    std::cout << "sorted insertion of 8 keys: height " << height(chain) << "\n";
    free_tree(root);
    free_tree(chain);
    return 0;
}
