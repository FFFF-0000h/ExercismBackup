// square_root.c
#include "square_root.h"

int square_root(int n) {
    if (n <= 0) return 0;  // handle invalid input, though problem guarantees positive
    int low = 1, high = n;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        // Check if mid is the exact root using integer division to avoid overflow
        if (mid == n / mid && n % mid == 0) {
            return mid;
        }
        if (mid < n / mid) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return 0;  // should never be reached for a perfect square input
}