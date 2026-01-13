; Everything that comes after a semicolon (;) is a comment

C2 equ 2
C3 equ 3
C4 equ 4
C5 equ 5
C6 equ 6
C7 equ 7
C8 equ 8
C9 equ 9
C10 equ 10
CJ equ 11
CQ equ 12
CK equ 13
CA equ 14

TRUE equ 1
FALSE equ 0

section .text

; You should implement functions in the .text section

; the global directive makes a function visible to the test files

global value_of_card
value_of_card:
    ; This function takes as parameter a number representing a card
    ; The function should return the numerical value of the passed-in card
    
    ; Parameter: card in rdi
    
    mov rax, rdi        ; Copy card to rax for comparison
    
    ; Check if card is face card (J, Q, K) - values 11, 12, 13
    cmp rax, 11
    jl .not_face        ; If card < 11, it's not a face card
    cmp rax, 13
    jg .not_face        ; If card > 13, it's not a face card
    
    ; Card is face card (J, Q, K), value is 10
    mov rax, 10
    ret
    
.not_face:
    ; Check if card is Ace (value 14)
    cmp rax, 14
    je .is_ace
    
    ; Card is number card (2-10), return its value
    ret
    
.is_ace:
    ; Ace has value 1 (for this function)
    mov rax, 1
    ret

global higher_card
higher_card:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return which card has the higher value
    ; If both have the same value, both should be returned
    ; If one is higher, the second one should be 0
    
    ; Parameters: card_one in rdi, card_two in rsi
    
    ; Get values of both cards
    push rdi            ; Save card_one (first)
    push rsi            ; Save card_two (second)
    
    ; Get value of card_one
    mov rdi, [rsp+8]    ; Get card_one from stack (was pushed first, so at [rsp+8])
    call value_of_card
    mov rbx, rax        ; Store SCORING value of card_one in rbx
    
    ; Get value of card_two  
    mov rdi, [rsp]      ; Get card_two from stack (was pushed second, so at [rsp])
    call value_of_card
    mov rcx, rax        ; Store SCORING value of card_two in rcx
    
    ; Compare SCORING values (not card numbers!)
    cmp rbx, rcx
    jg .card_one_higher_value
    jl .card_two_higher_value
    
    ; Scoring values are equal, return both ORIGINAL cards
    mov rax, [rsp+8]    ; Return original card_one
    mov rdx, [rsp]      ; Return original card_two
    add rsp, 16         ; Clean up stack
    ret
    
.card_one_higher_value:
    ; card_one has higher scoring value
    mov rax, [rsp+8]    ; Return original card_one
    xor rdx, rdx        ; rdx = 0
    add rsp, 16         ; Clean up stack
    ret
    
.card_two_higher_value:
    ; card_two has higher scoring value  
    mov rax, [rsp]      ; Return original card_two
    xor rdx, rdx        ; rdx = 0
    add rsp, 16         ; Clean up stack
    ret

global value_of_ace
value_of_ace:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return the value of an upcoming ace
    
    ; Parameters: card_one in rdi, card_two in rsi
    
    ; Get values of both cards
    push rsi            ; Save card_two
    push rdi            ; Save card_one
    
    ; Get value of card_one
    mov rdi, [rsp+8]    ; Get card_one from stack
    call value_of_card
    mov rbx, rax        ; Store value of card_one in rbx
    
    ; Get value of card_two
    mov rdi, [rsp]      ; Get card_two from stack
    call value_of_card
    add rbx, rax        ; Add value of card_two to rbx (total hand value)
    
    ; Check if either card is an Ace (value 14)
    mov rcx, [rsp+8]    ; Get card_one
    cmp rcx, 14
    je .return_one      ; If card_one is Ace, return 1
    
    mov rcx, [rsp]      ; Get card_two
    cmp rcx, 14
    je .return_one      ; If card_two is Ace, return 1
    
    ; Check if total hand value + 11 <= 21
    mov rax, rbx        ; Copy total hand value to rax
    add rax, 11         ; Add 11 (potential Ace value)
    cmp rax, 21
    jle .return_eleven  ; If total <= 21, Ace can be 11
    
.return_one:
    mov rax, 1
    add rsp, 16         ; Clean up stack
    ret
    
.return_eleven:
    mov rax, 11
    add rsp, 16         ; Clean up stack
    ret

global is_blackjack
is_blackjack:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards form a blackjack, and FALSE otherwise
    
    ; Parameters: card_one in rdi, card_two in rsi
    
    ; Check if one card is Ace (14) and the other is a ten-card (10, 11, 12, 13)
    
    ; Check if card_one is Ace
    cmp rdi, 14
    jne .check_card_two_ace
    
    ; card_one is Ace, check if card_two is ten-card
    cmp rsi, 10
    jl .not_blackjack
    cmp rsi, 13
    jg .not_blackjack
    jmp .is_blackjack_true
    
.check_card_two_ace:
    ; Check if card_two is Ace
    cmp rsi, 14
    jne .not_blackjack
    
    ; card_two is Ace, check if card_one is ten-card
    cmp rdi, 10
    jl .not_blackjack
    cmp rdi, 13
    jg .not_blackjack
    
.is_blackjack_true:
    mov rax, TRUE
    ret
    
.not_blackjack:
    mov rax, FALSE
    ret

global can_split_pairs
can_split_pairs:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards can be split into two pairs, and FALSE otherwise
    
    ; Parameters: card_one in rdi, card_two in rsi
    
    ; Get values of both cards
    push rsi
    push rdi
    
    ; Get value of card_one
    mov rdi, [rsp+8]
    call value_of_card
    mov rbx, rax        ; Store value of card_one in rbx
    
    ; Get value of card_two
    mov rdi, [rsp]
    call value_of_card
    mov rcx, rax        ; Store value of card_two in rcx
    
    ; Compare values
    cmp rbx, rcx
    je .can_split_true
    
.can_split_false:
    mov rax, FALSE
    add rsp, 16
    ret
    
.can_split_true:
    mov rax, TRUE
    add rsp, 16
    ret

global can_double_down
can_double_down:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards form a hand that can be doubled down, and FALSE otherwise
    
    ; Parameters: card_one in rdi, card_two in rsi
    
    ; Get values of both cards
    push rsi
    push rdi
    
    ; Get value of card_one
    mov rdi, [rsp+8]
    call value_of_card
    mov rbx, rax        ; Store value of card_one in rbx
    
    ; Get value of card_two
    mov rdi, [rsp]
    call value_of_card
    add rbx, rax        ; Add value of card_two to rbx (total hand value)
    
    ; Check if total is 9, 10, or 11
    cmp rbx, 9
    je .can_double_true
    cmp rbx, 10
    je .can_double_true
    cmp rbx, 11
    je .can_double_true
    
.can_double_false:
    mov rax, FALSE
    add rsp, 16
    ret
    
.can_double_true:
    mov rax, TRUE
    add rsp, 16
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif