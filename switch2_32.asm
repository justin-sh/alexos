[bits 16]
switch_to_pm:
    cli
    lgdt    [gdt_descriptor]
    mov     eax,    cr0
    or      eax,    0x1      ; 3. set 32-bit mode bit in cr0
    mov     cr0,    eax
    jmp     CODE_SEG:init_pm


[bits 32]
init_pm:
    mov     ax,     DATA_SEG
    mov     ds,     ax
    mov     ss,     ax
    mov     es,     ax
    mov     fs,     ax
    mov     gs,     ax
    
    mov     ebp ,   0x90000 ; Update our stack position so it is right
    mov     esp ,   ebp     ; at the top of the free space.
    call    BEGIN_PM        ; Finally , call some well - known label