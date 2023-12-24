ORG 0x7c00

global  start
start:

    ; init stack point, total 1kb from 0x7c00
    mov     bp, 0x8000
    mov     sp, bp

    jmp     go

go:
    ; mov     ax, cs
    ; mov     ds, ax
    ; mov     es, ax
    
    ; print string
    ; bx for the start index of string(end with 0)
    mov     bx, loading
    call print

    mov     bx, loaddisk
    call    print

    mov     bx, 0x9000      ; es:bx = 0x0000:0x9000 = 0x09000
    mov     dh, 0x02
    call    disk_load


jmp     $

%include 'boot/print.asm'
%include 'boot/disk.asm'


loading:
    db  'Loading in BIT16 ...', 13, 10, 0
loaddisk:
    db  'Loading disk ...', 13, 10, 0

times   510 -   ($-$$)  db  0
dw      0xaa55

times   256 dw 0xdada
times   256 dw 0xface
