#include "rational_numbers.h"
#include <stdlib.h>
#include <math.h>

// Helper: greatest common divisor
static int gcd(int a, int b) {
    a = abs(a);
    b = abs(b);
    
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

// Helper: create reduced rational number
static rational_t create(int num, int den) {
    rational_t r = {num, den};
    
    if (den == 0) {
        return r;  // As per note, denominator can be 0
    }
    
    // Move sign to numerator
    if (den < 0) {
        r.numerator = -num;
        r.denominator = -den;
    }
    
    // Reduce to lowest terms
    int divisor = gcd(r.numerator, r.denominator);
    if (divisor != 0) {
        r.numerator /= divisor;
        r.denominator /= divisor;
    }
    
    return r;
}

rational_t add(rational_t r1, rational_t r2) {
    int num = r1.numerator * r2.denominator + r2.numerator * r1.denominator;
    int den = r1.denominator * r2.denominator;
    return create(num, den);
}

rational_t subtract(rational_t r1, rational_t r2) {
    int num = r1.numerator * r2.denominator - r2.numerator * r1.denominator;
    int den = r1.denominator * r2.denominator;
    return create(num, den);
}

rational_t multiply(rational_t r1, rational_t r2) {
    int num = r1.numerator * r2.numerator;
    int den = r1.denominator * r2.denominator;
    return create(num, den);
}

rational_t divide(rational_t r1, rational_t r2) {
    int num = r1.numerator * r2.denominator;
    int den = r1.denominator * r2.numerator;
    return create(num, den);
}

rational_t absolute(rational_t r) {
    int num = abs(r.numerator);
    int den = abs(r.denominator);
    return create(num, den);
}

rational_t exp_rational(rational_t r, int n) {
    if (n == 0) {
        return create(1, 1);
    }
    
    rational_t result = create(1, 1);
    rational_t base = r;
    int power = abs(n);
    
    while (power > 0) {
        if (power & 1) {
            result = multiply(result, base);
        }
        base = multiply(base, base);
        power >>= 1;
    }
    
    if (n < 0) {
        return divide(create(1, 1), result);
    }
    
    return result;
}

float exp_real(int x, rational_t r) {
    // x^(r.numerator/r.denominator) = (x^r.numerator)^(1/r.denominator)
    double base_pow_num = pow(x, r.numerator);
    return (float)pow(base_pow_num, 1.0 / r.denominator);
}

rational_t reduce(rational_t r) {
    return create(r.numerator, r.denominator);
}