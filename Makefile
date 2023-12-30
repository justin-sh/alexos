# $@ = target file
# $< = first dependency
# $^ = all dependencies

C_SOUECES=$(wildcard kernel/*.c drivers/*.c)
HEADERS=$(wildcard kernel/*.h drives/*.h)
OBJ=$(C_SOUECES:.c=.o)

# First rule is the one executed when no parameters are fed to the Makefile
all: run

run: alexos.bin
	qemu-system-i386 -drive file=$<,format=raw,index=0,media=disk

alexos.bin: boot/boot.bin kernel.bin
	cat $^ > $@

# Notice how dependencies are built as needed
kernel.bin: kernel/kernel_entry.o $(OBJ)
	i686-elf-ld -o $@ -Ttext 0x2000 $^ --oformat binary

# kernel/kernel_entry.o: kernel/kernel_entry.asm
# 	nasm $< -f elf -o $@

%.o: %.c
	i686-elf-gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

# kernel/kernel.o: kernel/kernel.c
# 	i686-elf-gcc -ffreestanding -c $< -o $@

# Rule to disassemble the kernel - may be useful to debug
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

# boot.bin: boot/boot.asm
# 	nasm $< -f bin -o $@

clean:
	rm -f *.bin *.o *.dis
	rm -rf kernel/*.o drivers/*.o