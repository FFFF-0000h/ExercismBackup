#include "high_scores.h"
#include <limits.h>

// Return the latest score (last element in array)
int32_t latest(const int32_t *scores, size_t scores_len) {
    // If array is empty, return 0 or some default value
    // Based on typical C conventions, we might return 0 for empty array
    if (scores_len == 0) {
        return 0;
    }
    return scores[scores_len - 1];
}

// Return the highest score
int32_t personal_best(const int32_t *scores, size_t scores_len) {
    if (scores_len == 0) {
        return 0;
    }
    
    int32_t best = INT32_MIN;
    for (size_t i = 0; i < scores_len; i++) {
        if (scores[i] > best) {
            best = scores[i];
        }
    }
    return best;
}

// Write the highest scores to `output` (in non-ascending order)
// Return the number of scores written
size_t personal_top_three(const int32_t *scores, size_t scores_len,
                          int32_t *output) {
    if (scores_len == 0) {
        return 0;
    }
    
    // Handle small arrays
    if (scores_len == 1) {
        output[0] = scores[0];
        return 1;
    }
    
    if (scores_len == 2) {
        // Put higher score first
        if (scores[0] >= scores[1]) {
            output[0] = scores[0];
            output[1] = scores[1];
        } else {
            output[0] = scores[1];
            output[1] = scores[0];
        }
        return 2;
    }
    
    // For 3 or more scores, find top 3
    // We'll use a simple approach: track top 3 scores
    int32_t top1 = INT32_MIN;
    int32_t top2 = INT32_MIN;
    int32_t top3 = INT32_MIN;
    
    for (size_t i = 0; i < scores_len; i++) {
        int32_t score = scores[i];
        
        if (score > top1) {
            top3 = top2;
            top2 = top1;
            top1 = score;
        } else if (score > top2) {
            top3 = top2;
            top2 = score;
        } else if (score > top3) {
            top3 = score;
        }
    }
    
    output[0] = top1;
    output[1] = top2;
    output[2] = top3;
    
    return 3;
}