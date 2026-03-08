
# Calculator

A hybrid C + x86 Assembly calculator demonstrating low-level programming concepts and SSE floating-point operations.

## Overview

This isn't just another calculator - it's a demonstration of how C and assembly code work together. The user interface and control flow are written in C, while the actual arithmetic operations are implemented in x86 assembly using SSE (Streaming SIMD Extensions) instructions.

### Why This Approach?

- **Learn calling conventions**: Understand how C passes `double` arguments to assembly functions via XMM registers
- **SSE instruction practice**: Use `addsd`, `subsd`, `mulsd`, `divsd` for scalar double-precision operations
- **Linking C with assembly**: Experience the full workflow of combining high-level and low-level code
- **Function pointers in C**: Dynamic operation selection using function pointers

## Architecture

```
┌─────────────────────────────────────────┐
│         calculator.c (C Code)           │
│  - User input/output                    │
│  - Operator selection (switch)          │
│  - Function pointer handling            │
│  - External function declarations       │
└─────────────────┬───────────────────────┘
                  │
                  │ Calls via function pointers
                  ↓
┌─────────────────────────────────────────┐
│      operations.asm (x86 Assembly)      │
│  - add:      addsd xmm0, xmm1           │
│  - subtract: subsd xmm0, xmm1           │
│  - multiply: mulsd xmm0, xmm1           │
│  - divide:   divsd xmm0, xmm1           │
└─────────────────────────────────────────┘
```

## Features

- ✅ Four basic operations: `+`, `-`, `*`, `/`
- ✅ Double-precision floating-point arithmetic
- ✅ Function pointers for operation selection
- ✅ Pure assembly implementation of math operations
- ✅ SSE instruction set usage
- ✅ Clean separation of concerns (C for logic, ASM for computation)

## Prerequisites

You'll need:
- **GCC** - C compiler
- **NASM** or **YASM** - Assembler for x86 assembly
- **Linux/WSL** - Tested on Linux systems (uses System V AMD64 ABI)

### Installing Dependencies

**Ubuntu/Debian:**
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install gcc nasm -y
```

**Arch Linux:**
```bash
sudo pacman -S gcc nasm
```

## Building the Project

### File Structure
```
calculator/
├── calculator.c      # Main C source (I/O, control flow)
├── operations.asm    # Assembly operations (SSE math)
├── Makefile          # Build automation (optional)
└── README.md         # This file
```

### Compilation Steps

**Method 1: Manual compilation**
```bash
# Assemble the ASM file to object code
nasm -f elf64 operations.asm -o operations.o

# Compile C code and link with assembly object
gcc calculator.c operations.o -o calculator -no-pie
```

**Method 2: Using Make** (if you have a Makefile)
```bash
make
```

### Running
```bash
./calculator
```

## Usage Example

```
Enter operator [+, -, *, /]: *
Enter two numbers: 7.5 4.2

Result: 31.50
```

```
Enter operator [+, -, *, /]: /
Enter two numbers: 100 3

Result: 33.33
```

## How It Works

### C Side (`calculator.c`)
1. Declares external assembly functions using `extern`
2. Reads operator and numbers from user
3. Uses a function pointer to select the appropriate operation
4. Calls the assembly function indirectly through the pointer
5. Prints the result

### Assembly Side (`operations.asm`)
1. Receives two `double` arguments in XMM0 and XMM1 (System V calling convention)
2. Performs SSE scalar double-precision operation
3. Returns result in XMM0
4. Each function is a single instruction + `ret`

### Calling Convention (System V AMD64 ABI)
- First floating-point argument → `xmm0`
- Second floating-point argument → `xmm1`
- Return value → `xmm0`

## Technical Deep Dive

### SSE Instructions Used
| Instruction | Operation | Description |
|------------|-----------|-------------|
| `addsd` | Addition | Add scalar double-precision |
| `subsd` | Subtraction | Subtract scalar double-precision |
| `mulsd` | Multiplication | Multiply scalar double-precision |
| `divsd` | Division | Divide scalar double-precision |

### Why SSE Instead of FPU?
- Modern x86-64 uses SSE for floating-point by default
- SSE is faster and more predictable than the x87 FPU stack
- Aligns with modern compiler conventions

## Learning Outcomes

Working on this project taught me:
- ✅ How C and assembly interface at the ABI level
- ✅ XMM register usage for floating-point operations
- ✅ NASM syntax and assembler toolchain
- ✅ Linking object files from different languages
- ✅ Function pointers and indirect function calls
- ✅ The `-no-pie` flag and position-independent code

## Known Limitations

- No division-by-zero checking in assembly (would fault)
- Only supports two-operand expressions
- No parentheses or operator precedence
- No input validation for malformed numbers

## Future Improvements

- [ ] Add division-by-zero check in assembly (compare and conditional jump)
- [ ] Implement more operations (modulo, power, sqrt)
- [ ] Add SIMD vector operations (operate on multiple values)
- [ ] Expression parser for complex calculations
- [ ] Error handling using return codes/flags
- [ ] Support for 32-bit builds (`elf32`, different calling convention)

## Troubleshooting

**"undefined reference to 'add'"**
- Make sure you assembled the .asm file first
- Check that you're linking the .o file: `gcc calculator.c operations.o`

**Segmentation fault on execution**
- Try adding `-no-pie` flag to GCC
- Ensure you're on a 64-bit system

**Assembly syntax errors**
- Verify you're using NASM (not YASM/GAS syntax)
- Check that section headers are correct (`.text`, `.data`)

## Project Context

This calculator is part of my journey into low-level programming and systems understanding. It bridges the gap between high-level C abstractions and raw machine instructions.

Check out my other projects exploring:
- Memory management and allocators
- Linux system calls and kernel interfaces  
- Binary exploitation and reverse engineering
- Custom shells and process management

## Author

**x86owl** (x86owl)
- GitHub: [@x86owl](https://github.com/x86owl)
- Website: [x86owl.dev](https://x86owl.github.io/x86owl.dev/)
- Discord: [Join the solo_shell community](https://discord.gg/Jm9gXbxf4V)

## License

MIT License - Feel free to learn from, modify, and share.

## Acknowledgments

Built to understand:
- System V AMD64 ABI calling conventions
- SSE instruction set architecture
- C/Assembly interoperability
- Low-level program construction

---

*"Understanding the machine means writing in its language."*
