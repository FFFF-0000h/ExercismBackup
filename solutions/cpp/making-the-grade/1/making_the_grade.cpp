#include <array>
#include <string>
#include <vector>
#include <sstream>

// Round down all provided student scores.
std::vector<int> round_down_scores(std::vector<double> student_scores) {
    std::vector<int> rounded_scores;
    rounded_scores.reserve(student_scores.size());
    
    for (double score : student_scores) {
        rounded_scores.push_back(static_cast<int>(score));
    }
    
    return rounded_scores;
}

// Count the number of failing students out of the group provided.
int count_failed_students(std::vector<int> student_scores) {
    int fail_count = 0;
    
    for (int score : student_scores) {
        if (score <= 40) {
            ++fail_count;
        }
    }
    
    return fail_count;
}

// Create a list of grade thresholds based on the provided highest grade.
std::array<int, 4> letter_grades(int highest_score) {
    std::array<int, 4> thresholds;
    
    // Calculate the range from 41 to highest_score
    int range = highest_score - 40;
    
    // Divide into 4 equal intervals using integer division
    int interval = range / 4;
    
    // Set thresholds
    thresholds[0] = 41;                // D starts at 41
    thresholds[1] = 41 + interval;     // C starts
    thresholds[2] = 41 + 2 * interval; // B starts
    thresholds[3] = 41 + 3 * interval; // A starts
    
    return thresholds;
}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string> student_ranking(
    std::vector<int> student_scores, std::vector<std::string> student_names) {
    
    std::vector<std::string> rankings;
    
    if (student_scores.size() != student_names.size()) {
        return rankings;
    }
    
    rankings.reserve(student_scores.size());
    
    for (size_t i = 0; i < student_scores.size(); ++i) {
        std::ostringstream oss;
        oss << (i + 1) << ". " << student_names[i] << ": " << student_scores[i];
        rankings.push_back(oss.str());
    }
    
    return rankings;
}

// Create a string that contains the name of the first student to make a perfect
// score on the exam.
std::string perfect_score(std::vector<int> student_scores,
                          std::vector<std::string> student_names) {
    
    if (student_scores.size() != student_names.size()) {
        return "";
    }
    
    for (size_t i = 0; i < student_scores.size(); ++i) {
        if (student_scores[i] == 100) {
            return student_names[i];
        }
    }
    
    return "";
}