# Assembly Language Interpreter (ALI)

## This project implements an Assembly Language Interpreter (ALI) for a Simple Assembly Language (SAL), as part of the coursework for CS 474: Object-Oriented Programming Languages and Environments at the University of Illinois at Chicago.

## Features

The ALI emulates a simple hardware architecture and interprets SAL programs, supporting the following key components:

### Emulated Hardware
1. **Memory:**
- Divided into 128 cells for program memory and 128 cells for data memory (total 256 locations).
- Data memory supports 16-bit integers in 2's complement representation.
2. **Registers:**
- **Accumulator (Register A):** Used for arithmetic operations.
- **Data Register (Register B):** Temporarily stores data during execution.
- **Program Counter (PC):** Tracks the memory address of the next instruction to execute. 
3. **Zero-Result Bit:** Indicates whether the result of the last ADD/SUB instruction is zero.

### SAL Instruction Set
* Arithmetic Operations: ADD, SUB
* Data Movement: LDA, LDI, STR, XCH
* Control Flow: JMP, JZS
* Program Termination: HLT

### User Interaction
* Execute programs line-by-line (s) or all instructions until completion (a).
* View the state of memory, registers, and the zero bit after each command.
* Quit the command loop (q).

## Design Highlights
* Implements the Command Design Pattern with an abstract Instruction superclass and concrete subclasses for each SAL instruction.
* Ensures modular and reusable code by encapsulating execution logic within individual instruction classes.
* Safeguards against infinite loops by limiting the maximum number of instructions executed.

## How to Use
1. Input a SAL program via a file in the current directory.
2. Use the command loop to execute the program step-by-step or in its entirety.
3. View program state in a user-friendly format (binary, decimal, or hexadecimal).

## Constraints
* Assumes SAL programs are correctly formatted.
* Does not support error handling for invalid SAL code.
* Memory, registers, and flags are initialized to zero before execution.