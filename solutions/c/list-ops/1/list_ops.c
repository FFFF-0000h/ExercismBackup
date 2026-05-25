// list_ops.c
#include "list_ops.h"
#include <string.h>

list_t *new_list(size_t length, list_element_t elements[]) {
    list_t *list = malloc(sizeof(list_t) + length * sizeof(list_element_t));
    if (!list) return NULL;
    list->length = length;
    if (length > 0 && elements) {
        memcpy(list->elements, elements, length * sizeof(list_element_t));
    }
    return list;
}

list_t *append_list(list_t *list1, list_t *list2) {
    if (!list1 || !list2) return NULL;
    size_t len = list1->length + list2->length;
    list_t *new = malloc(sizeof(list_t) + len * sizeof(list_element_t));
    if (!new) return NULL;
    new->length = len;
    memcpy(new->elements, list1->elements, list1->length * sizeof(list_element_t));
    memcpy(new->elements + list1->length, list2->elements, list2->length * sizeof(list_element_t));
    return new;
}

list_t *filter_list(list_t *list, bool (*filter)(list_element_t)) {
    if (!list || !filter) return NULL;
    size_t count = 0;
    for (size_t i = 0; i < list->length; i++) {
        if (filter(list->elements[i])) count++;
    }
    list_t *new = malloc(sizeof(list_t) + count * sizeof(list_element_t));
    if (!new) return NULL;
    new->length = count;
    size_t j = 0;
    for (size_t i = 0; i < list->length; i++) {
        if (filter(list->elements[i])) {
            new->elements[j++] = list->elements[i];
        }
    }
    return new;
}

size_t length_list(list_t *list) {
    if (!list) return 0;
    return list->length;
}

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t)) {
    if (!list || !map) return NULL;
    list_t *new = malloc(sizeof(list_t) + list->length * sizeof(list_element_t));
    if (!new) return NULL;
    new->length = list->length;
    for (size_t i = 0; i < list->length; i++) {
        new->elements[i] = map(list->elements[i]);
    }
    return new;
}

list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t)) {
    if (!list || !foldl) return initial;
    list_element_t acc = initial;
    for (size_t i = 0; i < list->length; i++) {
        acc = foldl(acc, list->elements[i]);
    }
    return acc;
}

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t)) {
    if (!list || !foldr) return initial;
    list_element_t acc = initial;
    for (size_t i = list->length; i > 0; i--) {
        acc = foldr(list->elements[i - 1], acc);
    }
    return acc;
}

list_t *reverse_list(list_t *list) {
    if (!list) return NULL;
    list_t *new = malloc(sizeof(list_t) + list->length * sizeof(list_element_t));
    if (!new) return NULL;
    new->length = list->length;
    for (size_t i = 0; i < list->length; i++) {
        new->elements[i] = list->elements[list->length - 1 - i];
    }
    return new;
}

void delete_list(list_t *list) {
    free(list);
}