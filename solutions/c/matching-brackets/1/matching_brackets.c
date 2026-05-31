#include "matching_brackets.h"
#include <stdlib.h>   // for malloc, free
#include <string.h>   // for strlen

bool is_paired(const char *input) {
    size_t len = strlen(input);
    // Allocate enough memory for a worst-case stack (all opening brackets)
    char *stack = malloc(len + 1);
    if (stack == NULL) return false;   // allocation failure

    size_t top = 0;

    for (size_t i = 0; i < len; i++) {
        char c = input[i];

        if (c == '(' || c == '[' || c == '{') {
            stack[top++] = c;          // push opening bracket
        } else if (c == ')' || c == ']' || c == '}') {
            if (top == 0) {            // unmatched closing bracket
                free(stack);
                return false;
            }
            char open = stack[--top];  // pop
            if ((c == ')' && open != '(') ||
                (c == ']' && open != '[') ||
                (c == '}' && open != '{')) {
                free(stack);
                return false;          // mismatched pair
            }
        }
        // ignore any other characters
    }

    bool result = (top == 0);          // stack must be empty for a valid sequence
    free(stack);
    return result;
}