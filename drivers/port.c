/**
 * Read a byte from the specified port
 */
unsigned char inb(unsigned short port){
    unsigned char result;
    /* Inline assembler syntax
     * !! Notice how the source and destination registers are switched from NASM !!
     *
     * '"=a" (result)'; set '=' the C variable '(result)' to the value of register e'a'x
     * '"d" (port)': map the C variable '(port)' into e'd'x register
     *
     * Inputs and outputs are separated by colons
     */
    __asm__( // ".intel_syntax\t"
            "inb %1, %0"
            : "=a"(result)
            : "d"(port)
            );
    return result;
}
void outb(unsigned short port, unsigned char data){
    __asm__("outb %1, %0" : : "d"(port), "a"(data));
}

unsigned short inw(unsigned short port){
    unsigned short result;
    __asm__("in %%dx, %%ax" : "=a"(result) : "d"(port));
    return result;
}
void outw(unsigned short port, unsigned short data){
    __asm__("out %%ax, %%dx" : : "a"(data), "d"(port));
}