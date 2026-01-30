; Everything that comes after a semicolon (;) is a comment.

; The functions below make use of the following structs and enum:
;
; struct car_t {
;    char name[10]; 10 x 1 byte
;    int16_t speed; 2 bytes
;    float battery; 4 bytes
;    * size * = 16 bytes
;    * alignment * = 4 bytes
; };
;
; enum surface_t {
;    ASPHALT, 4 bytes 
;    SAND, 4 bytes
;    ICE, 4 bytes
;    CLAY 4 bytes
;    * size = 4 bytes *
;    * alignment = 4 bytes
; };
;
; struct track_t {
;    enum surface_t surface; 4 bytes + 4 bytes padding
;    size_t distance; 8 bytes
;    * size * = 16 bytes
;    * alignment * = 8 bytes
; };
;
; struct race_t {
;    struct track_t track; 16 bytes 
;    uint8_t num_of_laps; 1 byte + 3 bytes padding
;    struct car_t cars[6]; 16bytes * 6 elements = 96 bytes
;    uint8_t num_of_running_cars; 1 byte + 3 bytes padding 
;    * size * =  120 bytes
;    * alignment * = 8 bytes (track_t)
; };
;
; struct tournament_t {
;    struct race_t races[20]; 120 bytes * 20 elements = 2400 bytes
;    size_t num_of_races; 8 bytes 
;    * size * = 2408 bytes
;    * alignment * = 8 bytes
; };

default rel

CAR_T_SIZE equ 16
TRACK_T_SIZE equ 16
RACE_T_SIZE equ 120
TOUR_T_SIZE equ 2408

MAX_CARS equ 6
MAX_RACES equ 20

section .rodata
    BATTERY dd 100.0
    STARTING_CARS db 0

section .text

; You should implement functions in the .text section.
; A skeleton is provided for the first function.

; the global directive makes a function visible to the test files.
global new_car
new_car:
    ; This function has signature: struct car_t new_car(short speed, const char name[]);
    ; It returns a new struct car_t with the values provided.
    ; The starting value for field 'battery' is 100.0.
    ; rdi - short speed
    ; rsi - char pointer

    lodsq 
    mov edx, dword[BATTERY]
    shl rdx, 16
    mov dx, di 
    shl rdx, 16
    mov dx, word[rsi]
    ret

global new_track
new_track:
; TODO: define the 'new_track' function.
; This function has signature: struct track_t new_track(enum surface_t surface, size_t distance);
; It returns a new struct track_t with the values provided.
    ; rdi - surface 4 bytes
    ; rsi - distance 8 bytes
    mov eax, edi
    mov rdx, rsi
    ret

global new_race
new_race:
; TODO: define the 'new_race' function.
; This function has signature: struct race_t new_race(struct track_t track, uint8_t num_of_laps);
; It returns a new struct race_t with the values provided.
; The starting number of running cars is 0.
    ;rdi = struct race_t pointer
    ;rsi = surface 4 bytes + padding 4 bytes
    ;rdx = distance 8 bytes
    ;rcx = num_of_laps byte + padding 7 bytes
    mov qword[rdi], rsi 
    mov qword[rdi + 8], rdx
    mov byte[rdi + TRACK_T_SIZE], cl
    mov byte[rdi + 20 + MAX_CARS*CAR_T_SIZE], 0 
    mov rax, rdi
    ret

global add_participant
add_participant:
; TODO: define the 'add_participant' function.
; This function has signature: bool add_participant(struct race_t *race, struct car_t car);
; If there's room for one more participant in the race, the car should be added to the list, updating the counter, and its participation is confirmed.
; Otherwise, the race organizers must inform the car's owner that it can't participate this time.
    ; rdi - race_t pointer
    ; rsi - car_t name[0..7]
    ; rdx - car_t name[8..9], car_t speed, car_t battery
    movzx rcx, byte[rdi + 20 + MAX_CARS * CAR_T_SIZE]
    cmp rcx, MAX_CARS
    je .full

    inc byte[rdi + 20 + MAX_CARS * CAR_T_SIZE]
    shl rcx, 4 
    mov qword[rdi + 20 + rcx], rsi
    mov qword[rdi + 28 + rcx], rdx
    mov al, 1
    ret
.full:
    mov al, 0
    ret

global add_race
add_race:
; TODO: define the 'add_race' function.
; This function has signature: void add_race(struct tournament_t *tournament, struct race_t race);
; It should add a race to the tournament's array and also update its counter.
    ; rdi - tournament_t pointer
    mov rcx, qword[rdi + RACE_T_SIZE * MAX_RACES]
    inc qword[rdi + RACE_T_SIZE * MAX_RACES]
    imul rcx, rcx, RACE_T_SIZE
    lea rdi, [rdi + rcx]
    lea rsi, [rsp + 8]
    mov rcx, RACE_T_SIZE
    rep movsb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
