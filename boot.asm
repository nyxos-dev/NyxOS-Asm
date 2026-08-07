; ============================================================
; NyxOS-Asm - a from-scratch x86 kernel in pure assembly.
; ============================================================
; A Multiboot1 kernel: GRUB / QEMU -kernel loads it in 32-bit
; protected mode, it sets up a stack, paints a banner straight
; into VGA text memory at 0xB8000, and halts. No C, no libc.
bits 32

MB_MAGIC    equ 0x1BADB002              ; multiboot1 magic
MB_FLAGS    equ 0x0
MB_CHECKSUM equ -(MB_MAGIC + MB_FLAGS)

section .multiboot
align 4
    dd MB_MAGIC
    dd MB_FLAGS
    dd MB_CHECKSUM

section .bss
align 16
stack_bottom:
    resb 16384                          ; 16 KiB kernel stack
stack_top:

section .text
global _start
_start:
    mov esp, stack_top                  ; a stack to call our own

    mov edi, 0xB8000                    ; VGA text framebuffer
    ; clear the screen to black
    mov ecx, 80*25
    mov ax, 0x0F20                      ; space, white on black
.clear:
    mov [edi], ax
    add edi, 2
    loop .clear

    mov edi, 0xB8000
    mov esi, banner
    mov ah, 0x0D                        ; bright magenta on black - Nyx purple
.print:
    lodsb
    test al, al
    jz .hang
    mov [edi], al
    mov [edi+1], ah
    add edi, 2
    jmp .print

.hang:
    cli
.loop:
    hlt
    jmp .loop

section .rodata
banner: db "NyxOS-Asm  ::  booting from scratch in x86 assembly", 0
