#include "screen.h"

#include <stdint.h>
#include "port.h"

/* Declaration of private functions */
int get_cursor_pos();
void set_cursor_pos(int offset);
// int print_char_at(char c, int row, int col);
int get_offset(int row, int col);
int get_offset_row(int offset);
int get_offset_col(int offset);
uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg);
uint8_t default_color();

/**********************************************************
 * Public Kernel API functions                            *
 **********************************************************/
void clean_screen(void)
{
    uint8_t *buffer = (uint8_t *)VGA_ADDRESS;

    uint8_t color = VGA_COLOR_WHITE | VGA_COLOR_BLACK << 4;

    int p, r, c;
    for (r = 0; r < VGA_HEIGHT; r++)
    {
        for (c = 0; c < VGA_WIDTH; c++)
        {
            p = r * 80 + c;
            buffer[2*p] = ' ';
            buffer[2 * p + 1] = color;
        }
    }

    set_cursor_pos(get_offset(0, 0));
}

void print(char *message)
{
    print_at(message, -1, -1);
}

void print_at(char *message, int row, int col)
{
    int offset;

    print_char_at('x', -1, -1);
    print_char_at(message[1], -1, -1);

    int i = 0;
    while (message[i] != 0)
    {
        offset = print_char_at(message[i++], row, col);
        // row = get_offset_row(offset);
        // col = get_offset_col(offset);
    }
}

/* Private Functions */
int get_cursor_pos()
{
    /* Screen cursor position: ask VGA control register (0x3d4) for bytes
     * 14 = high byte of cursor and 15 = low byte of cursor. */
    /* Data is returned in VGA data register (0x3d5) */
    outb(CURSOR_CTRL, 14);
    int position = inb(CURSOR_DATA);
    position = position << 8;

    outb(CURSOR_CTRL, 15); /* requesting low byte */
    position += inb(CURSOR_DATA);

    return position*2;
}

void set_cursor_pos(int offset)
{
    offset /= 2;
    outb(CURSOR_CTRL, 14);
    outb(CURSOR_DATA, (uint8_t)offset>>8);

    outb(CURSOR_CTRL, 15);
    outb(CURSOR_DATA, (uint8_t)(offset & 0xff));
}

/**
 * 
 * return the position of next char
*/
int print_char_at(char c, int row, int col)
{
    uint8_t* buffer = (uint8_t*)VGA_ADDRESS;

    uint8_t color = VGA_COLOR_WHITE | VGA_COLOR_BLACK << 4;
    if(row >= VGA_HEIGHT || col >= VGA_WIDTH)
    {
        buffer[2 * VGA_HEIGHT * VGA_WIDTH - 2] = 'E';
        buffer[2 * VGA_HEIGHT * VGA_WIDTH - 1] = VGA_COLOR_RED | VGA_COLOR_WHITE << 4;
        return get_offset(row, col);
    }

    int offset;
    if (col >= 0 && row >= 0)
        offset = get_offset(row, col);
    else
        offset = get_cursor_pos();

    if(c == '\n'){
        row = get_offset_row(offset);
        offset = get_offset(row+1, 0);
    } else {
        buffer[offset] = c;
        buffer[offset+1] = color;
        offset += 2;
    }

    set_cursor_pos(offset);

    return offset;
}

int get_offset(int row, int col)
{
    return (row * VGA_WIDTH + col) * 2;
}

int get_offset_row(int offset)
{
    return offset / (2 * VGA_WIDTH);
}

int get_offset_col(int offset)
{
    return ( offset - get_offset_row(offset) * 2 * VGA_WIDTH ) / 2;
}

uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg)
{
    return fg | bg << 4;
}

uint8_t default_color()
{
    return vga_entry_color(WHITE_ON_BLACK, VGA_COLOR_BLACK);
}