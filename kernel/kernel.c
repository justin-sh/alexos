#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "../drivers/port.h"
#include "../drivers/screen.h"

/* Check if the compiler thinks you are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

/* This tutorial will only work for the 32-bit ix86 targets. */
#if !defined(__i386__)
#error "This tutorial needs to be compiled with a ix86-elf compiler"
#endif

void kernel_main(void)
{
    /* Initialize terminal interface */
    clean_screen();
    int p = print_char_at('\n', 0, 0);
    p=print_char_at('a', -1, -1);
    p = print_char_at('a' , -1, -1);

    // print_char_at('0'+p, 2, 1);
    // print("He");
    // print_at("Hello, kernel World!", -1, -1);

    // char message[] = "Hq";
    int i =0;
    char c = '\0';
    // while (( c = message[i++]) != 'q')
    // {
    //     print_char_at(c, -1, -1);
    // print_char_at(message[0], -1, -1);
    // }

    // print_char_at(message[0], -1, -1);
    p = print_char_at('H', -1, -1);

    /* Newline support is left as an exercise. */
    // terminal_writestring("Hello, kernel World!");
}
