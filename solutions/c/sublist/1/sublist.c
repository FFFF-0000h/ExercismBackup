#include "sublist.h"

// Helper function to check if 'small' is a contiguous sublist of 'big'
static int is_sublist(const int *small, size_t small_len,
                      const int *big,   size_t big_len) {
    if (small_len == 0) return 1;               // empty list is always a sublist
    if (big_len < small_len) return 0;          // not enough elements

    for (size_t i = 0; i <= big_len - small_len; ++i) {
        int match = 1;
        for (size_t j = 0; j < small_len; ++j) {
            if (big[i + j] != small[j]) {
                match = 0;
                break;
            }
        }
        if (match) return 1;
    }
    return 0;
}

comparison_result_t check_lists(int *list_to_compare, int *base_list,
                                size_t list_to_compare_element_count,
                                size_t base_list_element_count) {
    // Both empty -> equal
    if (list_to_compare_element_count == 0 && base_list_element_count == 0)
        return EQUAL;

    // One empty, the other not
    if (list_to_compare_element_count == 0)
        return SUBLIST;
    if (base_list_element_count == 0)
        return SUPERLIST;

    // Same length: check element-wise equality
    if (list_to_compare_element_count == base_list_element_count) {
        for (size_t i = 0; i < list_to_compare_element_count; ++i) {
            if (list_to_compare[i] != base_list[i])
                return UNEQUAL;
        }
        return EQUAL;
    }

    // Different lengths: one may be a sublist of the other
    if (list_to_compare_element_count < base_list_element_count) {
        if (is_sublist(list_to_compare, list_to_compare_element_count,
                       base_list, base_list_element_count))
            return SUBLIST;
    } else {
        if (is_sublist(base_list, base_list_element_count,
                       list_to_compare, list_to_compare_element_count))
            return SUPERLIST;
    }

    return UNEQUAL;
}