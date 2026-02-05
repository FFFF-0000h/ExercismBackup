#include "high_scores.h"

#include <algorithm>
#include <vector>

namespace arcade {

std::vector<int> HighScores::list_scores() {
    // Return all scores for this session.
    return scores;
}

int HighScores::latest_score() {
    // Return the latest score for this session.
    // Latest score is the last element added to the vector
    if (scores.empty()) {
        return 0;  // Or throw an exception, but returning 0 for empty
    }
    return scores.back();
}

int HighScores::personal_best() {
    // Return the highest score for this session.
    if (scores.empty()) {
        return 0;
    }
    return *std::max_element(scores.begin(), scores.end());
}

std::vector<int> HighScores::top_three() {
    // Return the top 3 scores for this session in descending order.
    
    // Create a copy of scores to avoid modifying the original
    std::vector<int> sorted_scores = scores;
    
    // Sort in descending order
    std::sort(sorted_scores.begin(), sorted_scores.end(), std::greater<int>());
    
    // Return at most 3 scores
    if (sorted_scores.size() > 3) {
        return std::vector<int>(sorted_scores.begin(), sorted_scores.begin() + 3);
    } else {
        return sorted_scores;
    }
}

}  // namespace arcade