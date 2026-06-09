#pragma once
#include <string>

namespace crypto_square {

class cipher {
public:
    explicit cipher(const std::string& text);
    std::string normalized_cipher_text() const;

private:
    std::string cipher_text_;
};

}