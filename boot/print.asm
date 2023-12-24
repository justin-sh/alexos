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