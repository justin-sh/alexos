#ifndef __SCREEN_H__

#define __SCREEN_H__

/*we will use VGA text mode buffer (located at 0xB8000)*/
#define VGA_ADDRESS 0xB8000

#define VGA_WIDTH   80
#define VGA_HEIGHT  25

#define CURSOR_CTRL 0x3d4
#define CURSOR_DATA 0x3d5

/* Hardware text mode color constants. */
enum vga_color
{
    VGA_COLOR_BLACK = 0,
    VGA_COLOR_BLUE = 1,
    VGA_COLOR_GREEN = 2,
    VGA_COLOR_CYAN = 3,
    VGA_COLOR_RED = 4,
    VGA_COLOR_MAGENTA = 5,
    VGA_COLOR_BROWN = 6,
    VGA_COLOR_LIGHT_GREY = 7,
    VGA_COLOR_DARK_GREY = 8,
    VGA_COLOR_LIGHT_BLUE = 9,
    VGA_COLOR_LIGHT_GREEN = 10,
    VGA_COLOR_LIGHT_CYAN = 11,
    VGA_COLOR_LIGHT_RED = 12,
    VGA_COLOR_LIGHT_MAGENTA = 13,
    VGA_COLOR_LIGHT_BROWN = 14,
    VGA_COLOR_WHITE = 15,
};

#define WHITE_ON_BLACK 0x0f

void clean_screen(void);
void print(char* message);
void print_at(char* message, int row, int col);
int print_char_at(char c, int row, int col);

#endif