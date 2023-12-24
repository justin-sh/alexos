; print string
; bx for the start index of string(end with 0)
print:
    pusha
    .start:
        mov     al, [bx]
        cmp     al, 0
        je      .end
        
        mov     ah, 0eh
        int     10h

        add     bx, 1
        jmp     .start
    .end:
    
    popa
    ret


; receiving the data in 'dx'
print_hex:
    pusha
    .start:
        mov     cx, 4
    .loop:
        cmp     cx, 0
        je      .end

        mov     ax, dx

        and     ax, 0x000f
        add     al, 0x30
        cmp     al, 0x39        ; test if dl > number 9
        jle     .step2

        add     al, 0x07        ; add 0x30 to convert to A-F
    .step2:
        mov     bx, HEX_STR + 1
        add     bx, cx
        mov     [bx],   al

        ror     dx, 4
        sub     cx, 1
        jmp     .loop
    .end:
        mov     bx, HEX_STR
        call    print
    
    popa
    ret

    HEX_STR:    db  '0x0000', 0