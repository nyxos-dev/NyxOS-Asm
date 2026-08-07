/* Link the kernel at 1 MiB with the Multiboot header first (GRUB scans the
   first 8 KiB of the file for it). */
ENTRY(_start)

SECTIONS {
    . = 1M;

    .multiboot : { *(.multiboot) }
    .text      : { *(.text) }
    .rodata    : { *(.rodata) }
    .data      : { *(.data) }
    .bss       : { *(.bss)  *(COMMON) }
}
