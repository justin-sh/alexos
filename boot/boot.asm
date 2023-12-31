[org 0x7c00]

global  start
start:
    ; init stack point, total 1kb from 0x7c00
    mov     bp, 0x9000
    mov     sp, bp
    
    ; print string
    ; bx for the start index of string(end with 0)
    mov     bx, MSG_REAL_MODE
    call    print

    mov     bx, loaddisk
    call    print

    ; loading disk
    mov     bx, LOADER_ADDRESS  ; es:bx = 0x0000:0x9000 = 0x09000
    mov     dh, LOADER_SECTOR_SIZE
    call    disk_load

    ; mov     dx, [es:bx]         ; <- pointer to buffer where the data will be stored
    ; call    print_hex
    ; switch to protected mode
    call    switch_to_pm

jmp     $

%include 'boot/print.asm'
%include 'boot/disk.asm'
%include 'boot/gdt32.asm'
%include 'boot/switch2_32.asm'
%include 'boot/print32.asm'

[bits 32]
BEGIN_PM:
    mov     ebx, MSG_PM_MODE
    call    print32 ; Use our 32 - bit print routine.
    call    LOADER_ADDRESS
    jmp     $ ; Hang.

LOADER_ADDRESS      equ 0x2000
LOADER_SECTOR_SIZE  equ 0x02

MSG_REAL_MODE:
    db  'Started in bit-16 Read Mode', 13, 10, 0
loaddisk:
    db  'Loading disk ...', 13, 10, 0

MSG_PM_MODE:
    db  'Successfully landed in 32-bit Protected Mode', 0

times   510 -   ($-$$)  db  0
dw      0xaa55

; times   256 dw 0xdada
; times   256 dw 0xface
