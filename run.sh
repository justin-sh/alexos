nasm -f bin boot/boot.asm -o boot.bin && qemu-system-i386 -drive file=boot.bin,format=raw,index=0,media=disk 
