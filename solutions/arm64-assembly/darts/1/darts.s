.text
.globl score

// double score(double x, double y) -> int (returned in w0)
score:
    // Compute squared distance: d0 = x^2 + y^2
    fmul    d2, d0, d0          // d2 = x^2
    fmadd   d2, d1, d1, d2      // d2 = x^2 + y^2

    // Load radius constants using immediate fmov where possible,
    // otherwise compute the squares.
    fmov    d3, #1.0             // inner radius = 1.0 (squared = 1.0)
    fmov    d4, #5.0             // middle radius = 5.0
    fmul    d5, d4, d4           // d5 = 25.0
    fmov    d6, #10.0            // outer radius = 10.0
    fmul    d7, d6, d6           // d7 = 100.0

    // Compare against 1.0
    fcmp    d2, d3
    b.le    .Linner              // if squared <= 1.0 -> 10 points

    // Compare against 25.0
    fcmp    d2, d5
    b.le    .Lmiddle             // if squared <= 25.0 -> 5 points

    // Compare against 100.0
    fcmp    d2, d7
    b.le    .Louter              // if squared <= 100.0 -> 1 point

    // Otherwise miss
    mov     w0, #0
    ret

.Linner:
    mov     w0, #10
    ret

.Lmiddle:
    mov     w0, #5
    ret

.Louter:
    mov     w0, #1
    ret