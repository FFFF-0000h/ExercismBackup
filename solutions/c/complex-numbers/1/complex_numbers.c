#include "complex_numbers.h"
#include <math.h>

complex_t c_add(complex_t a, complex_t b)
{
    complex_t result;
    result.real = a.real + b.real;
    result.imag = a.imag + b.imag;
    return result;
}

complex_t c_sub(complex_t a, complex_t b)
{
    complex_t result;
    result.real = a.real - b.real;
    result.imag = a.imag - b.imag;
    return result;
}

complex_t c_mul(complex_t a, complex_t b)
{
    complex_t result;
    // (a + bi) * (c + di) = (ac - bd) + (ad + bc)i
    result.real = a.real * b.real - a.imag * b.imag;
    result.imag = a.real * b.imag + a.imag * b.real;
    return result;
}

complex_t c_div(complex_t a, complex_t b)
{
    complex_t result;
    // (a + bi) / (c + di) = [(ac + bd) + (bc - ad)i] / (c^2 + d^2)
    double denominator = b.real * b.real + b.imag * b.imag;
    
    if (denominator == 0.0) {
        // Handle division by zero - return NaN or infinity
        // For this exercise, we assume b is not zero
        result.real = NAN;
        result.imag = NAN;
    } else {
        result.real = (a.real * b.real + a.imag * b.imag) / denominator;
        result.imag = (a.imag * b.real - a.real * b.imag) / denominator;
    }
    
    return result;
}

double c_abs(complex_t x)
{
    // |a + bi| = sqrt(a^2 + b^2)
    return sqrt(x.real * x.real + x.imag * x.imag);
}

complex_t c_conjugate(complex_t x)
{
    complex_t result;
    result.real = x.real;
    result.imag = -x.imag;
    return result;
}

double c_real(complex_t x)
{
    return x.real;
}

double c_imag(complex_t x)
{
    return x.imag;
}

complex_t c_exp(complex_t x)
{
    complex_t result;
    // e^(a + bi) = e^a * (cos(b) + i*sin(b))
    double exp_real = exp(x.real);
    result.real = exp_real * cos(x.imag);
    result.imag = exp_real * sin(x.imag);
    return result;
}