#include "flower_field.h"
#include <stdlib.h>
#include <string.h>

char **annotate(const char **garden, const size_t rows) {
    if (garden == NULL || rows == 0) {
        return NULL;
    }
    
    // Get the length of the first row
    size_t cols = strlen(garden[0]);
    
    // Allocate memory for the annotation array (with extra slot for NULL terminator)
    char **annotation = malloc((rows + 1) * sizeof(char *));
    if (annotation == NULL) {
        return NULL;
    }
    
    // Process each row
    for (size_t i = 0; i < rows; i++) {
        // Allocate memory for this row (plus null terminator)
        annotation[i] = malloc((cols + 1) * sizeof(char));
        if (annotation[i] == NULL) {
            // Free previously allocated rows
            for (size_t j = 0; j < i; j++) {
                free(annotation[j]);
            }
            free(annotation);
            return NULL;
        }
        
        // Process each column in this row
        for (size_t j = 0; j < cols; j++) {
            if (garden[i][j] == '*') {
                annotation[i][j] = '*';
            } else {
                // Count adjacent flowers
                int flower_count = 0;
                
                // Check all 8 adjacent squares
                for (int di = -1; di <= 1; di++) {
                    for (int dj = -1; dj <= 1; dj++) {
                        if (di == 0 && dj == 0) {
                            continue;
                        }
                        
                        int ni = (int)i + di;
                        int nj = (int)j + dj;
                        
                        if (ni >= 0 && ni < (int)rows && 
                            nj >= 0 && nj < (int)cols) {
                            if (garden[ni][nj] == '*') {
                                flower_count++;
                            }
                        }
                    }
                }
                
                if (flower_count > 0) {
                    annotation[i][j] = '0' + flower_count;
                } else {
                    annotation[i][j] = ' ';
                }
            }
        }
        
        annotation[i][cols] = '\0';
    }
    
    // NULL terminate the array
    annotation[rows] = NULL;
    
    return annotation;
}

void free_annotation(char **annotation) {
    if (annotation == NULL) {
        return;
    }
    
    // Free each row until we hit NULL
    for (size_t i = 0; annotation[i] != NULL; i++) {
        free(annotation[i]);
    }
    free(annotation);
}