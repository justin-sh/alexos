[bits 32]

VIDEO_ADDRESS   equ     0xb8000
WHITE_ON_BLACK  equ     0x0f

; ebx for the start index of string(end with 0)
print32:
    pusha

    mov     edx,    VIDEO_ADDRESS
    .start:
        mov     al,     [ebx]
        cmp     al,     0
        je      .end

        mov     ah,     WHITE_ON_BLACK
        mov     [edx],  ax
        add     ebx,    1
        add     edx,    2

        jmp     .start
    .end:

        popa
        ret
