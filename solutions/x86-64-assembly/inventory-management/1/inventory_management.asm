; Everything that comes after a semicolon (;) is a comment

WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

; the global directive makes a function visible to the test files
global get_box_weight
global max_number_of_boxes
global items_to_be_moved
global calculate_payment

get_box_weight:
    ; Parameters: di, si, dx, cx (16-bit each)
    ; Return: eax (32-bit)
    
    ; Save the second product count (dx) before it gets overwritten
    push rdx
    push rcx
    
    ; First product: di * si
    movzx eax, di      ; Zero-extend to 32-bit
    movzx ecx, si      ; Zero-extend to 32-bit
    mul ecx            ; edx:eax = eax * ecx
    ; eax contains first product (lower 32 bits)
    mov ebx, eax       ; Save first product in ebx
    
    ; Restore second product parameters
    pop rcx
    pop rdx
    
    ; Second product: dx * cx
    movzx eax, dx      ; Zero-extend to 32-bit  
    movzx ecx, cx      ; Zero-extend to 32-bit
    mul ecx            ; edx:eax = eax * ecx
    ; eax contains second product
    
    ; Add first product
    add eax, ebx       ; eax = total items weight
    
    ; Add empty box weight
    add eax, WEIGHT_OF_EMPTY_BOX
    
    ret

max_number_of_boxes:
    ; Parameter: dil (8-bit)
    ; Return: al (8-bit)
    
    ; If box height is 0, return 0 (avoid division by zero)
    test dil, dil
    jz .return_zero
    
    ; Copy box height to bl for division
    mov bl, dil        ; bl = box height
    
    ; Set up dividend: ax = 300
    mov ax, TRUCK_HEIGHT  ; ax = 300
    
    ; Divide ax (300) by bl (box height)
    div bl            ; al = ax ÷ bl, ah = remainder
    
    ; al contains the result (integer division)
    ret
    
.return_zero:
    xor al, al
    ret

items_to_be_moved:
    ; Parameters: edi, esi (32-bit each)
    ; Return: eax (32-bit)
    
    ; Subtract items in box from total unaccounted
    mov eax, edi    ; eax = items_unaccounted
    sub eax, esi    ; eax = items_unaccounted - items_in_box
    
    ret

calculate_payment:
    ; Parameters: rdi (upfront), esi (boxes), edx (trips), ecx (lost_items), r8 (item_value), r9b (workers)
    ; Return: rax (64-bit)
    
    ; Calculate box payment: boxes * PAY_PER_BOX
    mov eax, esi                ; eax = boxes
    imul eax, PAY_PER_BOX       ; eax = boxes * 5
    movsx rax, eax              ; Sign-extend to 64-bit
    
    ; Calculate trip payment: trips * PAY_PER_TRUCK_TRIP
    mov r10d, edx               ; r10d = trips
    imul r10d, PAY_PER_TRUCK_TRIP ; r10d = trips * 220
    movsx r10, r10d             ; Sign-extend to 64-bit
    add rax, r10                ; rax = box_payment + trip_payment
    
    ; Subtract upfront payment
    sub rax, rdi                ; rax = total_earned - upfront
    
    ; Calculate lost item cost: lost_items * item_value
    mov r10d, ecx               ; r10d = lost_items
    movsx r10, r10d             ; Sign-extend to 64-bit
    imul r10, r8                ; r10 = lost_items * item_value
    
    ; Subtract lost item cost
    sub rax, r10                ; rax = (earned - upfront) - lost_cost
    
    ; Now rax contains total payment/debt to split
    ; We need to divide by (workers + 1) since you're included in the split
    movzx r10, r9b              ; Zero-extend workers count
    inc r10                     ; r10 = workers + 1 (total people splitting)
    
    ; Prepare for division
    mov rdx, rax                ; Save original value
    mov rax, rdx                ; rax = value to divide
    cqo                         ; Sign-extend rax into rdx:rax
    idiv r10                    ; rax = quotient, rdx = remainder
    
    ; You get quotient + remainder
    add rax, rdx                ; rax = your_share + remainder
    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif