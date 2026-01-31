#include "binary_search.h"

const int *binary_search(int value, const int *arr, size_t length) {
    if (length == 0) {
        return NULL;
    }

    int left = 0;
    int right = (int)length - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == value) {
            return &arr[mid];
        } else if (arr[mid] < value) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return 0;
}