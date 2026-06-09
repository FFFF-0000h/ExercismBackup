#include "crypto_square.h"
#include <cctype>
#include <cmath>
#include <vector>

namespace crypto_square {

    cipher::cipher(const std::string& text) {
        // Normalize: remove non-alphanumeric, convert to lowercase
        std::string normalized;
        for (char c : text) {
            if (std::isalnum(static_cast<unsigned char>(c))) {
                normalized += std::tolower(static_cast<unsigned char>(c));
            }
        }

        if (normalized.empty()) {
            cipher_text_ = "";
            return;
        }

        int len = normalized.length();
        int c = static_cast<int>(std::ceil(std::sqrt(len)));
        int r = static_cast<int>(std::ceil(static_cast<double>(len) / c));

        while (c - r > 1) {
            c--;
            r = static_cast<int>(std::ceil(static_cast<double>(len) / c));
        }

        // Build rectangle
        std::vector<std::string> rows(r, std::string(c, ' '));
        for (int i = 0; i < len; i++) {
            int row = i / c;
            int col = i % c;
            rows[row][col] = normalized[i];
        }

        // Read columns
        std::string result;
        for (int col = 0; col < c; col++) {
            if (col > 0) {
                result += ' ';
            }
            for (int row = 0; row < r; row++) {
                result += rows[row][col];
            }
        }

        cipher_text_ = result;
    }

    std::string cipher::normalized_cipher_text() const {
        return cipher_text_;
    }

}  // namespace crypto_square