#include "complex_numbers.h"
#include <cmath>

namespace complex_numbers {

Complex Complex::add(const Complex& other) const {
    return Complex(real_ + other.real_, imag_ + other.imag_);
}

Complex Complex::sub(const Complex& other) const {
    return Complex(real_ - other.real_, imag_ - other.imag_);
}

Complex Complex::mul(const Complex& other) const {
    double a = real_, b = imag_;
    double c = other.real_, d = other.imag_;
    return Complex(a * c - b * d, b * c + a * d);
}

Complex Complex::div(const Complex& other) const {
    double a = real_, b = imag_;
    double c = other.real_, d = other.imag_;
    double denom = c * c + d * d;
    return Complex((a * c + b * d) / denom, (b * c - a * d) / denom);
}

double Complex::abs() const {
    return std::sqrt(real_ * real_ + imag_ * imag_);
}

Complex Complex::conj() const {
    return Complex(real_, -imag_);
}

Complex Complex::exp() const {
    double exp_real = std::exp(real_);
    return Complex(exp_real * std::cos(imag_), exp_real * std::sin(imag_));
}

// Mixed operator implementations
Complex operator+(const Complex& lhs, double rhs) {
    return Complex(lhs.real() + rhs, lhs.imag());
}
Complex operator+(double lhs, const Complex& rhs) {
    return Complex(lhs + rhs.real(), rhs.imag());
}
Complex operator-(const Complex& lhs, double rhs) {
    return Complex(lhs.real() - rhs, lhs.imag());
}
Complex operator-(double lhs, const Complex& rhs) {
    return Complex(lhs - rhs.real(), -rhs.imag());
}
Complex operator*(const Complex& lhs, double rhs) {
    return Complex(lhs.real() * rhs, lhs.imag() * rhs);
}
Complex operator*(double lhs, const Complex& rhs) {
    return Complex(lhs * rhs.real(), lhs * rhs.imag());
}
Complex operator/(const Complex& lhs, double rhs) {
    return Complex(lhs.real() / rhs, lhs.imag() / rhs);
}
Complex operator/(double lhs, const Complex& rhs) {
    double denom = rhs.real() * rhs.real() + rhs.imag() * rhs.imag();
    return Complex((lhs * rhs.real()) / denom, (-lhs * rhs.imag()) / denom);
}

}  // namespace complex_numbers