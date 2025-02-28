## Requirements
- NASM (Netwide Assembler)
- GNU Linker (ld)
- 32-bit libraries (on 64-bit systems):
  ```bash
  sudo apt install gcc-multilib  # Debian/Ubuntu

## Build & Run

### Assemble with NASM:
```bash
nasm -f elf32 shell.asm -o shell.o
ld -m elf_i386 shell.o -o shell
./shell
```
