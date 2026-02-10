#if !defined(ALPHAMETICS_H)
#define ALPHAMETICS_H
#include <string>
#include <unordered_map>
#include <optional>
#include <set>
#include <vector>
#include <cmath>
#include <algorithm>

namespace alphametics {

std::vector<std::string> split(std::string text, const std::string& separator);
std::optional<std::unordered_map<char, int>> solve(std::string text);

class Solver{
    private:
        std::vector<std::string> words; // vector of TERMS and SUM as last word in it; 
        std::set<char> first; // set of first chars. leading digit of a multi-digit number must not be zero
        std::unordered_map<char, long long> weights; // weigths precalculated for every character, depend on positions and count
        
        std::vector<char> letters;
        std::vector<bool> used; // which digit we already used
        int size;

    public:
        std::unordered_map<char, int> solution;
        Solver(std::string& text);
        //bool verify();
        bool backtrack(int pos = 0, int sum = 0);
};


}  // namespace alphametics

#endif  // ALPHAMETICS_H