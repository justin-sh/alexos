; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
    pusha

    push dx

    mov     ah, 0x02    ; read disk
    mov     al, dh      ; number of sectors to read

    mov     cl, 0x02    ; sector number 1-63 (bits 0-5)
                        ; high two bits of cylinder (bits 6-7, hard disk only)
    mov     ch, 0x00    ; ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')
    ; dl <- drive number. Our caller sets it as a parameter and gets it from BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov     dh, 0x00    ; dh <- head number (0x0 .. 0xF)

    ; [es:bx] <- pointer to buffer where the data will be stored
    ; caller sets it up for us, and it is actually the standard location for int 13h
    int     0x13
    jc      .disk_error ; if error (stored in the carry bit)

    pop     dx
    cmp     al, dh      ; BIOS also sets 'al' to the # of sectors read. Compare it.
    jne     .sector_error

    popa
    ret

.disk_error:
    mov     bx, DISK_ERROR
    call    print
    jmp     .end

.sector_error:
    mov     bx, SECTORS_ERROR
    call    print
    jmp     .end

.end:
    jmp     $

DISK_ERROR:     db  'Disk load error!', 13, 10, 0
SECTORS_ERROR:  db "Incorrect number of sectors read", 0