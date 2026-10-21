#include <stdint.h>
#include <stddef.h>

#define VGA_COLS 80
#define VGA_ROWS 25

static volatile uint16_t *const VGA = (volatile uint16_t *)0xB8000;

static void clear_screen(void) {
    for (size_t i = 0; i < VGA_COLS * VGA_ROWS; i++)
        VGA[i] = (uint16_t)(0x0F00 | ' ');
}

static void print(const char *s, size_t row, uint8_t color) {
    for (size_t i = 0; s[i]; i++)
        VGA[row * VGA_COLS + i] = (uint16_t)((color << 8) | (uint8_t)s[i]);
}

void kmain(void) {
    clear_screen();
    print("Hello from Xersa OS!", 0, 0x0A);
    print("Kernel is running.", 1, 0x07);
    for (;;) __asm__ volatile ("hlt");
}
