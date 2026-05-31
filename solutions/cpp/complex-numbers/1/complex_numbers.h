#pragma once

namespace complex_numbers {

class Complex {
public:
    Complex(double real, double imag) : real_(real), imag_(imag) {}

    double real() const { return real_; }
    double imag() const { return imag_; }

    // Member functions for core operations
    Complex add(const Complex& other) const;
    Complex sub(const Complex& other) const;
    Complex mul(const Complex& other) const;
    Complex div(const Complex& other) const;
    double abs() const;
    Complex conj() const;
    Complex exp() const;

    // Operator overloads
    Complex operator+(const Complex& other) const { return add(other); }
    Complex operator-(const Complex& other) const { return sub(other); }
    Complex operator*(const Complex& other) const { return mul(other); }
    Complex operator/(const Complex& other) const { return div(other); }

private:
    double real_;
    double imag_;
};

// Mixed operators (complex <op> double and double <op> complex)
Complex operator+(const Complex& lhs, double rhs);
Complex operator+(double lhs, const Complex& rhs);
Complex operator-(const Complex& lhs, double rhs);
Complex operator-(double lhs, const Complex& rhs);
Complex operator*(const Complex& lhs, double rhs);
Complex operator*(double lhs, const Complex& rhs);
Complex operator/(const Complex& lhs, double rhs);
Complex operator/(double lhs, const Complex& rhs);

}  // namespace complex_numbers