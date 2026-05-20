.text
.globl can_create
.globl can_attack

// int can_create(int row, int column);
// row in w0, column in w1
can_create:
    // Check row bounds: 0 <= row <= 7
    cmp     w0, #0
    b.lt    .invalid_create
    cmp     w0, #7
    b.gt    .invalid_create
    // Check column bounds: 0 <= column <= 7
    cmp     w1, #0
    b.lt    .invalid_create
    cmp     w1, #7
    b.gt    .invalid_create
    mov     w0, #1
    ret
.invalid_create:
    mov     w0, #0
    ret

// int can_attack(int white_row, int white_column, int black_row, int black_column);
// white_row in w0, white_col in w1, black_row in w2, black_col in w3
can_attack:
    // Same row?
    cmp     w0, w2
    b.eq    .attack_yes

    // Same column?
    cmp     w1, w3
    b.eq    .attack_yes

    // Check diagonal: |white_row - black_row| == |white_col - black_col|
    sub     w4, w0, w2      // w4 = row diff
    sub     w5, w1, w3      // w5 = col diff

    // Compute absolute value of row diff
    cmp     w4, #0
    b.pl    .abs_row_done
    neg     w4, w4
.abs_row_done:
    // Compute absolute value of col diff
    cmp     w5, #0
    b.pl    .abs_col_done
    neg     w5, w5
.abs_col_done:
    cmp     w4, w5
    b.ne    .attack_no

.attack_yes:
    mov     w0, #1
    ret

.attack_no:
    mov     w0, #0
    ret