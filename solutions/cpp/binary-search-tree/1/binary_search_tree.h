#pragma once

#include <memory>
#include <vector>
#include <stack>

namespace binary_search_tree {

template <typename T>
class binary_tree {
public:
    // Constructor with initial value
    explicit binary_tree(T value) : data_(value), left_(nullptr), right_(nullptr) {}
    
    // Default constructor
    binary_tree() : data_(T{}), left_(nullptr), right_(nullptr) {}
    
    // Insert a value into the tree
    void insert(T value) {
        if (value <= data_) {
            if (left_) {
                left_->insert(value);
            } else {
                left_ = std::make_unique<binary_tree<T>>(value);
            }
        } else {
            if (right_) {
                right_->insert(value);
            } else {
                right_ = std::make_unique<binary_tree<T>>(value);
            }
        }
    }
    
    // Access data
    const T& data() const { return data_; }
    T& data() { return data_; }
    
    // Access left subtree
    const std::unique_ptr<binary_tree<T>>& left() const { return left_; }
    std::unique_ptr<binary_tree<T>>& left() { return left_; }
    
    // Access right subtree
    const std::unique_ptr<binary_tree<T>>& right() const { return right_; }
    std::unique_ptr<binary_tree<T>>& right() { return right_; }
    
    // Iterator class for inorder traversal
    class iterator {
    public:
        using value_type = T;
        using reference = T&;
        using pointer = T*;
        using difference_type = std::ptrdiff_t;
        using iterator_category = std::forward_iterator_tag;
        
        iterator() : current_(nullptr) {}
        
        explicit iterator(binary_tree* root) {
            push_left(root);
            if (!stack_.empty()) {
                current_ = stack_.top();
                stack_.pop();
                push_left(current_->right_.get());
            } else {
                current_ = nullptr;
            }
        }
        
        const T& operator*() const { return current_->data_; }
        T& operator*() { return current_->data_; }
        const T* operator->() const { return &current_->data_; }
        T* operator->() { return &current_->data_; }
        
        iterator& operator++() {
            if (stack_.empty()) {
                current_ = nullptr;
            } else {
                current_ = stack_.top();
                stack_.pop();
                push_left(current_->right_.get());
            }
            return *this;
        }
        
        iterator operator++(int) {
            iterator temp = *this;
            ++(*this);
            return temp;
        }
        
        bool operator==(const iterator& other) const {
            return current_ == other.current_;
        }
        
        bool operator!=(const iterator& other) const {
            return !(*this == other);
        }
        
    private:
        binary_tree* current_;
        std::stack<binary_tree*> stack_;
        
        void push_left(binary_tree* node) {
            while (node) {
                stack_.push(node);
                node = node->left_.get();
            }
        }
    };
    
    iterator begin() { return iterator(this); }
    iterator end() { return iterator(); }
    
private:
    T data_;
    std::unique_ptr<binary_tree<T>> left_;
    std::unique_ptr<binary_tree<T>> right_;
};

}  // namespace binary_search_tree