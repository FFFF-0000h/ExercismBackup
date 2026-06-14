.equ MERCURY, 1
.equ VENUS, 2
.equ EARTH, 3
.equ MARS, 4
.equ JUPITER, 5
.equ SATURN, 6
.equ URANUS, 7
.equ NEPTUNE, 8

.text
.globl age

// Function: age
// Input:
//   x0 - planet (enum: MERCURY=1 through NEPTUNE=8)
//   x1 - seconds (integer)
// Output:
//   d0 - age in years on the specified planet (double)
age:
    // Save link register
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Convert seconds from integer to double
    scvtf d0, x1              // d0 = (double)seconds
    
    // Load Earth seconds per year constant
    ldr d1, earth_seconds
    
    // Calculate Earth years: d0 = seconds / seconds_per_earth_year
    fdiv d0, d0, d1
    
    // Get base address of orbital periods table
    ldr x2, =orbital_periods
    
    // Calculate offset into the table: (planet - 1) * 8 bytes
    sub x0, x0, #1
    lsl x0, x0, #3            // Multiply by 8 (size of double)
    add x2, x2, x0
    
    // Load orbital period
    ldr d1, [x2]
    
    // Calculate planet years: d0 = earth_years / orbital_period
    fdiv d0, d0, d1
    
    // Restore and return
    ldp x29, x30, [sp], #16
    ret

.align 3
earth_seconds:
    .double 31557600.0

.align 3
orbital_periods:
    .double 0.2408467    // Mercury
    .double 0.61519726   // Venus
    .double 1.0          // Earth
    .double 1.8808158    // Mars
    .double 11.862615    // Jupiter
    .double 29.447498    // Saturn
    .double 84.016846    // Uranus
    .double 164.79132    // Neptune