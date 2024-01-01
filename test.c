#include "stdio.h"

int get_offset_row(int offset)
{
    return offset / (2 * 80);
}

int get_offset_col(int offset)
{
    return ( offset - get_offset_row(offset) * 2 * 80 ) / 2;
}

int main()
{

    char *message = "Hq";
    int i =0;
    while (message[i] != 0)
    {
        printf("%c", message[i++]);
        // print_char_at(message[0], -1, -1);
    }
}