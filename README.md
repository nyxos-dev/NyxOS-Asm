# NyxOS-Asm

NyxOS, rebuilt from scratch in Assembly — a freestanding x86_64 operating system.
Part of the NyxOS family: the same OS, built again in a different language.

The original (C): https://github.com/kazah-png/nyx-os

**Why Assembly:** the ground floor — nothing sits between you and the CPU.
Proven in the wild: MikeOS and countless others.

**Layout:** `boot/` — entry + bootstrap · `kernel/` — the kernel proper.

**Status:** early — bringing up the toolchain and a minimal higher-half kernel.
