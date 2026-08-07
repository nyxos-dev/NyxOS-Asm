# NyxOS-Asm - build a bootable Multiboot kernel from pure assembly.
#   make        -> nyxos-asm.elf   (boot with: qemu-system-x86_64 -kernel nyxos-asm.elf)
#   make run    -> build and boot in QEMU
KERNEL := nyxos-asm.elf

$(KERNEL): boot.o linker.ld
	ld -m elf_i386 -T linker.ld -o $@ boot.o
	@grub-file --is-x86-multiboot $@ && echo "multiboot: OK"

boot.o: boot.asm
	nasm -f elf32 $< -o $@

run: $(KERNEL)
	qemu-system-x86_64 -kernel $(KERNEL)

clean:
	rm -f boot.o $(KERNEL)

.PHONY: run clean
