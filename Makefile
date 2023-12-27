# $@ = target file
# $< = first dependency
# $^ = all dependencies

# First rule is the one executed when no parameters are fed to the Makefile
all: run

# Notice how dependencies are built as needed
kernel.bin: kernel_entry.o kernel.o
	i686-elf-ld -o $@ -Ttext 0x2000 $^ --oformat binary

kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel/kernel.c
	i686-elf-gcc -ffreestanding -c $< -o $@

# Rule to disassemble the kernel - may be useful to debug
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

boot.bin: boot/boot.asm
	nasm $< -f bin -o $@

alexos.bin: boot.bin kernel.bin
	cat $^ > $@

run: alexos.bin
	qemu-system-i386 -drive file=$<,format=raw,index=0,media=disk

clean:
	rm -f *.bin *.o *.dis