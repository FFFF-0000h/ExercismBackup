// say.cpp
#include "say.h"
#include <stdexcept>
#include <string>

namespace say {

static const char* ones[] = {
    "zero", "one", "two", "three", "four",
    "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
};

static const char* tens[] = {
    "", "", "twenty", "thirty", "forty",
    "fifty", "sixty", "seventy", "eighty", "ninety"
};

static std::string convert_hundreds(int n) {
    std::string result;
    if (n >= 100) {
        result += ones[n / 100];
        result += " hundred";
        n %= 100;
        if (n > 0) result += " ";
    }
    if (n >= 20) {
        result += tens[n / 10];
        if (n % 10 != 0) {
            result += "-";
            result += ones[n % 10];
        }
    } else if (n > 0) {
        result += ones[n];
    }
    return result;
}

std::string in_english(long long n) {
    if (n < 0 || n > 999999999999LL)
        throw std::domain_error("Number out of range");

    if (n == 0) return "zero";

    std::string result;
    int billions = n / 1000000000LL;
    n %= 1000000000LL;
    int millions = n / 1000000;
    n %= 1000000;
    int thousands = n / 1000;
    int remainder = n % 1000;

    if (billions > 0) {
        result += convert_hundreds(billions) + " billion";
    }
    if (millions > 0) {
        if (!result.empty()) result += " ";
        result += convert_hundreds(millions) + " million";
    }
    if (thousands > 0) {
        if (!result.empty()) result += " ";
        result += convert_hundreds(thousands) + " thousand";
    }
    if (remainder > 0) {
        if (!result.empty()) result += " ";
        result += convert_hundreds(remainder);
    }

    return result;
}

}  // namespace say