#include "spiral_matrix.h"
#include <stdlib.h>

spiral_matrix_t *spiral_matrix_create(int size) {
    spiral_matrix_t *result = malloc(sizeof(spiral_matrix_t));
    if (!result) return NULL;

    result->size = size;
    if (size == 0) {
        result->matrix = NULL;
        return result;
    }

    // Allocate rows
    result->matrix = malloc(size * sizeof(int *));
    if (!result->matrix) {
        free(result);
        return NULL;
    }

    for (int i = 0; i < size; i++) {
        result->matrix[i] = malloc(size * sizeof(int));
        if (!result->matrix[i]) {
            // Cleanup on allocation failure
            for (int j = 0; j < i; j++) free(result->matrix[j]);
            free(result->matrix);
            free(result);
            return NULL;
        }
    }

    int top = 0, bottom = size - 1;
    int left = 0, right = size - 1;
    int num = 1;

    while (top <= bottom && left <= right) {
        // Fill top row
        for (int col = left; col <= right; col++) {
            result->matrix[top][col] = num++;
        }
        top++;

        // Fill right column
        for (int row = top; row <= bottom; row++) {
            result->matrix[row][right] = num++;
        }
        right--;

        // Fill bottom row (if still valid)
        if (top <= bottom) {
            for (int col = right; col >= left; col--) {
                result->matrix[bottom][col] = num++;
            }
            bottom--;
        }

        // Fill left column (if still valid)
        if (left <= right) {
            for (int row = bottom; row >= top; row--) {
                result->matrix[row][left] = num++;
            }
            left++;
        }
    }

    return result;
}

void spiral_matrix_destroy(spiral_matrix_t *matrix) {
    if (!matrix) return;
    for (int i = 0; i < matrix->size; i++) {
        free(matrix->matrix[i]);
    }
    free(matrix->matrix);
    free(matrix);
}