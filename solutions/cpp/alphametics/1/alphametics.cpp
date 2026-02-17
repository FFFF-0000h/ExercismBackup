#include "alphametics.h"

namespace alphametics {

std::vector<std::string> split(std::string text, const std::string& separator){
    std::vector<std::string> result;
    while(true){
        auto pos = text.find(separator);
        if(pos != std::string::npos) {
            result.push_back(text.substr(0, pos));
            text = text.substr(pos + separator.length(), text.length() - (pos + separator.length()));
        } else {
            result.push_back(text.substr(0, text.length()));
            break;
        }
    }
    return result;
}

Solver::Solver(std::string& text) : used(10, false){
    auto left_right = split(text, " == "); //left_rigth[0] are TERMS, left_rigth[1] is SUM
    words = split(left_right[0], " + ");
    words.push_back(left_right[1]); // last word is SUM

    for(auto word : words){
        if (word.size() > 1){first.insert(word.at(0));} // insert to set of first chars

        long long d{1}; // weigths for TERMS will be positive
        if(word == left_right[1]) d = -1;  // weights for SUM will be negative
        for(auto it = word.rbegin(); it != word.rend(); it++) {
            weights[*it] += d; // summarize weights of letters in different words
            d *= 10; // weights for letters from rigth to left are: 1, 10, 100, 1000 .....
        }
    }

    // create vector of letters sorted by desc of abs weights
    // so we will start to solve with most valuable letters first
    // it should optimize solution time
    std::vector<std::pair<char, int>> letters_pairs(weights.begin(), weights.end());
    std::sort(letters_pairs.begin(), letters_pairs.end(), [] (auto a, auto b) {return abs(a.second) > abs(b.second);});
    for(auto kv : letters_pairs) {letters.push_back(kv.first);} //

    size = weights.size();
}

bool Solver::backtrack(int pos, int sum){
    // basic case
    if(pos == size){
        if(sum == 0) return true;
        return false;
    }

    // dive to the next level
    for(int i = 0; i < 10; i++){
        if(used[i]) continue; // every digit can be used only once
        if(i == 0 && first.find(letters[pos]) != first.end()) continue; // leading 0 is not allowed

        // ok, now let's try it
        solution[letters[pos]] = i;
        used[i] = true;
        sum += weights[letters[pos]] * i; // calculate checksumm on the fly
        if(backtrack(pos + 1, sum)) return true; // recursive dive to the next level
        // solution is not fit - we should revert our last changes
        solution.erase(letters[pos]);
        used[i] = false;
        sum -= weights[letters[pos]] * i;
    }

    return false;
}

std::optional<std::unordered_map<char, int>> solve(std::string text){
    Solver solver(text);
    if(solver.backtrack()) return solver.solution;
    return std::nullopt;
}

}  // namespace alphametics