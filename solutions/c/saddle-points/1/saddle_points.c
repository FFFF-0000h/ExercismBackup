#include "saddle_points.h"
#include <stdlib.h>

saddle_points_t *saddle_points(int rows, int cols, uint8_t matrix[rows][cols]) {
    saddle_points_t *result = malloc(sizeof(saddle_points_t));
    if (!result) return NULL;

    size_t max_points = (size_t)rows * cols;
    result->points = malloc(sizeof(saddle_point_t) * max_points);
    if (!result->points && max_points > 0) {
        free(result);
        return NULL;
    }
    result->count = 0;

    if (rows <= 0 || cols <= 0) {
        return result; // empty matrix
    }

    // Row maximums
    uint8_t row_max[rows];
    for (int i = 0; i < rows; i++) {
        uint8_t max_val = matrix[i][0];
        for (int j = 1; j < cols; j++) {
            if (matrix[i][j] > max_val) {
                max_val = matrix[i][j];
            }
        }
        row_max[i] = max_val;
    }

    // Column minimums
    uint8_t col_min[cols];
    for (int j = 0; j < cols; j++) {
        uint8_t min_val = matrix[0][j];
        for (int i = 1; i < rows; i++) {
            if (matrix[i][j] < min_val) {
                min_val = matrix[i][j];
            }
        }
        col_min[j] = min_val;
    }

    // Collect saddle points (1‑based indices)
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == row_max[i] && matrix[i][j] == col_min[j]) {
                result->points[result->count].row = (size_t)(i + 1);
                result->points[result->count].column = (size_t)(j + 1);
                result->count++;
            }
        }
    }

    // Trim to exact size
    if (result->count > 0) {
        saddle_point_t *tmp = realloc(result->points, sizeof(saddle_point_t) * result->count);
        if (tmp) {
            result->points = tmp;
        }
    } else {
        free(result->points);
        result->points = NULL;
    }

    return result;
}

void free_saddle_points(saddle_points_t *sp) {
    if (sp) {
        free(sp->points);
        free(sp);
    }
}