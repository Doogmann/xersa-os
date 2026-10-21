.RECIPEPREFIX = >
CC      = i686-elf-gcc
AS      = nasm
CFLAGS  = -std=gnu11 -ffreestanding -O2 -g -Wall -Wextra -Isrc
LDFLAGS = -T linker.ld -ffreestanding -O2 -nostdlib
OBJS    = build/boot.o build/kernel.o

all: myos.iso

build/boot.o: src/boot.asm
> mkdir -p build
> $(AS) -f elf32 $< -o $@

build/%.o: src/%.c
> mkdir -p build
> $(CC) $(CFLAGS) -c $< -o $@

build/myos.bin: $(OBJS) linker.ld
> $(CC) $(LDFLAGS) -o $@ $(OBJS) -lgcc

myos.iso: build/myos.bin iso/boot/grub/grub.cfg
> mkdir -p iso/boot
> cp build/myos.bin iso/boot/myos.bin
> grub-mkrescue -o $@ iso

clean:
> rm -rf build myos.iso iso/boot/myos.bin

.PHONY: all clean
