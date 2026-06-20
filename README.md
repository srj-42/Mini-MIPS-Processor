# 3-Cycle MIPS Processor

This repository contains a basic 3-cycle implementation of a MIPS processor written in Verilog. 

## Overview

The processor operates using a simple 3-cycle finite state machine:
1. **Fetch & Decode**: Fetches the instruction from memory and decodes the register operands.
2. **Execute**: Performs arithmetic/logical calculations via the ALU, resolves branches/jumps, computes memory addresses, and manages I/O stalls.
3. **Writeback**: Commits register values to the Register File and updates the Program Counter.

## Modules

- `Computer.v`: Top-level wrapper module that interfaces the processor and unified memory, handles bus multiplexing, and tracks clock cycle performance.
- `Processor.v`: The CPU core controlling the state machine and datapath routing.
- `RegisterFile.v`: Standard MIPS register file containing 32 general-purpose registers.
- `ALU.v`: Performs operations including shifts, basic arithmetic/logic, comparisons, and branch resolution.
- `Memory.v`: A 256-word memory array supporting reads, writes, and subword (byte/halfword) writing.
- `defs.vh`: Header defining opcodes, function codes, and system call constants.

## Context

This project was developed for the CS220 (Computer Organization) course at IIT Kanpur during the Spring 2026 semester.
