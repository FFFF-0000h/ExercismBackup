; Returns a pointer to one of five constant strings based on input.

default rel

section .rodata
silence:    db "Fine. Be that way!",0
sure:       db "Sure.",0
chill:      db "Whoa, chill out!",0
calm:       db "Calm down, I know what I'm doing!",0
whatever:   db "Whatever.",0

section .text
global response
response:
    ; Preserve callee-saved register we will use
    push    rbx

    ; Initialize:
    ; rbx = input pointer
    ; dl  = last non-whitespace character (0 if none)
    ; r8b = has_letter flag (0/1)
    ; r9b = has_lower flag (0/1)
    mov     rbx, rdi
    xor     edx, edx
    xor     r8d, r8d
    xor     r9d, r9d

.loop:
    movzx   ecx, byte [rbx]        ; current character
    test    cl, cl
    jz      .end_loop               ; null terminator

    ; Check for whitespace (space, tab, newline, carriage return)
    cmp     cl, 32
    je      .whitespace
    cmp     cl, 9
    je      .whitespace
    cmp     cl, 10
    je      .whitespace
    cmp     cl, 13
    je      .whitespace

    ; Not whitespace: update last character
    mov     dl, cl

    ; Check if it's a letter
    cmp     cl, 'A'
    jb      .not_letter
    cmp     cl, 'Z'
    jbe     .uppercase
    cmp     cl, 'a'
    jb      .not_letter
    cmp     cl, 'z'
    jbe     .lowercase
    jmp     .not_letter

.uppercase:
    mov     r8b, 1                  ; has_letter = true
    jmp     .next

.lowercase:
    mov     r8b, 1                  ; has_letter = true
    mov     r9b, 1                  ; has_lower = true
    jmp     .next

.not_letter:
    ; nothing to do
.whitespace:
.next:
    inc     rbx
    jmp     .loop

.end_loop:
    ; Check for silence (no non-whitespace characters)
    test    dl, dl
    jz      .silence

    ; Determine if question: last character == '?'
    cmp     dl, '?'
    sete    r10b                    ; r10b = 1 if question

    ; Determine if yelling: has_letter and no lowercase
    test    r8b, r8b
    jz      .not_yelling
    test    r9b, r9b
    jnz     .not_yelling
    mov     r11b, 1                 ; yelling
    jmp     .check_combined
.not_yelling:
    xor     r11b, r11b

.check_combined:
    ; Combine flags
    test    r10b, r10b
    jz      .not_question
    test    r11b, r11b
    jnz     .calm
    ; question only
    jmp     .sure
.not_question:
    test    r11b, r11b
    jnz     .chill
    ; neither
    jmp     .whatever

.silence:
    lea     rax, [silence]
    jmp     .return
.sure:
    lea     rax, [sure]
    jmp     .return
.chill:
    lea     rax, [chill]
    jmp     .return
.calm:
    lea     rax, [calm]
    jmp     .return
.whatever:
    lea     rax, [whatever]
    ; fall through

.return:
    pop     rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif