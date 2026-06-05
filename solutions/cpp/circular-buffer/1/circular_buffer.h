#pragma once
#include <vector>
#include <stdexcept>

namespace circular_buffer {

template <typename T>
class circular_buffer {
public:
    explicit circular_buffer(size_t capacity)
        : buffer_(capacity), head_(0), tail_(0), size_(0), capacity_(capacity) {}

    T read() {
        if (size_ == 0) {
            throw std::domain_error("Cannot read from empty buffer");
        }
        T value = buffer_[head_];
        head_ = (head_ + 1) % capacity_;
        size_--;
        return value;
    }

    void write(T value) {
        if (size_ == capacity_) {
            throw std::domain_error("Cannot write to full buffer");
        }
        buffer_[tail_] = value;
        tail_ = (tail_ + 1) % capacity_;
        size_++;
    }

    void overwrite(T value) {
        if (size_ == capacity_) {
            buffer_[head_] = value;
            head_ = (head_ + 1) % capacity_;
            tail_ = (tail_ + 1) % capacity_;
        } else {
            write(value);
        }
    }

    void clear() {
        head_ = 0;
        tail_ = 0;
        size_ = 0;
    }

private:
    std::vector<T> buffer_;
    size_t head_;
    size_t tail_;
    size_t size_;
    size_t capacity_;
};

}  // namespace circular_buffer