# Ripple Carry Adder-Subtractor & Carry Look-Ahead Adder-Subtractor

## Overview
This repository contains Verilog implementations of two 4-bit adder-subtractor circuits:
1. **Ripple Carry Adder-Subtractor (RCA)**
2. **Carry Look-Ahead Adder-Subtractor (CLA)**

Both designs perform addition and subtraction based on a mode control signal (`M`).

---

## 1. Ripple Carry Adder-Subtractor
### Description
A **Ripple Carry Adder-Subtractor** is a sequential circuit where carries ripple through each bit. It consists of:
- **Full Adders** connected in series.
- **Mode (`M`)** determines whether to add (`M=0`) or subtract (`M=1`).
- Subtraction is performed using **two’s complement** (`B' = ~B + 1`).

### Verilog Code
- **Full Adder Module** (`full_adder.v`)
- **4-bit Ripple Carry Adder-Subtractor Module** (`ripple_adder_subtractor.v`)
- **Testbench** (`tb_ripple_adder_subtractor.v`)

### Functionality
| A (4-bit) | B (4-bit) | M (Mode) | Output S (4-bit) | Carry/Borrow |
|-----------|-----------|----------|------------------|--------------|
| 0011 (3)  | 0001 (1)  | 0 (Add)  | 0100 (4)        | 0            |
| 0110 (6)  | 0011 (3)  | 1 (Sub)  | 0011 (3)        | 1 (No borrow)|

---

## 2. Carry Look-Ahead Adder-Subtractor
### Description
A **Carry Look-Ahead Adder-Subtractor (CLA)** improves speed by computing carry signals in parallel using:
- **Generate (`G = A & B`)**
- **Propagate (`P = A ⊕ B`)**
- Carry logic equations for fast addition/subtraction.

### Verilog Code
- **4-bit Carry Look-Ahead Adder-Subtractor** (`cla_adder_subtractor.v`)
- **Testbench** (`tb_cla_adder_subtractor.v`)

### Functionality
| A (4-bit) | B (4-bit) | M (Mode) | Output S (4-bit) | Carry/Borrow |
|-----------|-----------|----------|------------------|--------------|
| 0101 (5)  | 0011 (3)  | 0 (Add)  | 1000 (8)        | 0            |
| 0001 (1)  | 0010 (2)  | 1 (Sub)  | 1111 (-1)       | 0 (Borrow)   |

---

## Simulation & Testing
### Running Testbenches
To verify the circuits, use a Verilog simulator like **ModelSim, Xilinx Vivado, or Icarus Verilog (iverilog)**:
```sh
# Compile and simulate Ripple Carry Adder-Subtractor
iverilog -o ripple_tb tb_ripple_adder_subtractor.v ripple_adder_subtractor.v full_adder.v
vvp ripple_tb

# Compile and simulate Carry Look-Ahead Adder-Subtractor
iverilog -o cla_tb tb_cla_adder_subtractor.v cla_adder_subtractor.v
vvp cla_tb
```
### Expected Output
- The testbenches print `A`, `B`, `M`, `S`, and `Cout` for each case.
- You can compare the outputs with manual calculations to verify correctness.

---

## Key Takeaways
- **Ripple Carry Adder-Subtractor:** Simple but slower due to sequential carry propagation.
- **Carry Look-Ahead Adder-Subtractor:** Faster by computing carries in parallel.
- Both implementations use `M` to switch between addition and subtraction.

---

## Future Improvements
- Expand to **8-bit or 16-bit versions**.
- Implement a **Hybrid Adder** (CLA for MSB, RCA for LSB).
- Optimize for **hardware synthesis on FPGAs**.

---

## License
This project is released under the **MIT License**.

---

## Author
Developed by **Swayam**.