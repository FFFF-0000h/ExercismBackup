#include "pascals_triangle.h"
#include <stdlib.h>
#include <string.h>   // for memset

uint8_t **create_triangle(size_t rows) {
    if (rows == 0) {
        // The tests expect a 1×1 array containing 0 even when rows == 0
        uint8_t **tri = malloc(sizeof(uint8_t *));
        if (!tri) return NULL;
        tri[0] = malloc(sizeof(uint8_t));
        if (!tri[0]) {
            free(tri);
            return NULL;
        }
        tri[0][0] = 0;
        return tri;
    }

    uint8_t **triangle = malloc(rows * sizeof(uint8_t *));
    if (!triangle) return NULL;

    for (size_t i = 0; i < rows; i++) {
        // Each row is exactly `rows` elements wide, filled with 0
        triangle[i] = calloc(rows, sizeof(uint8_t));
        if (!triangle[i]) {
            // Cleanup previous rows on failure
            while (i > 0) {
                free(triangle[--i]);
            }
            free(triangle);
            return NULL;
        }

        // Pascal's triangle rule for columns 0 … i
        triangle[i][0] = 1;
        for (size_t j = 1; j <= i; j++) {
            // Each inner element is the sum of the two above it
            uint8_t left  = triangle[i - 1][j - 1];
            uint8_t right = (j < i) ? triangle[i - 1][j] : 0;
            triangle[i][j] = left + right;
        }
        // Remaining columns (i+1 … rows-1) stay 0 (already set by calloc)
    }

    return triangle;
}

void free_triangle(uint8_t **triangle, size_t rows) {
    if (triangle) {
        for (size_t i = 0; i < rows; i++) {
            free(triangle[i]);
        }
        free(triangle);
    }
}