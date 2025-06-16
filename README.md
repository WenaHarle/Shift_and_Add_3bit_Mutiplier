# ⚙️ 3-Bit × 3-Bit Shift-and-Add Binary Multiplier in VHDL

This repository provides a modular and synthesizable implementation of a **3-bit by 3-bit binary multiplier** using the **Shift-and-Add algorithm**, developed in **VHDL**. The design follows a classic datapath-control architecture and is suitable for FPGA prototyping, educational use, and low-resource embedded systems.

---

## 📌 Project Description

The multiplier operates by iteratively adding the multiplicand to an accumulator whenever the least significant bit (LSB) of the multiplier is `1`, followed by a logical right shift. This process repeats for 3 clock cycles, producing a 6-bit product.

The design is decomposed into reusable and well-defined components, promoting clarity, modularity, and testability.

---

## 🗂️ Repository Structure

```bash
.
├── shift_3bit.vhd         # Shift register 3 bit
├── adder_3bit.vhd         # 3-bit binary adder
├── register_3bit.vhd      # 3-bit register (used for accumulator and multiplicand)
├── counter_2bit.vhd       # 2-bit synchronous counter (max count = 3)
├── control_unit.vhd       # FSM-based control logic
├── multiplier_3x3.vhd     # Top-level multiplier module (datapath + control)
├── tb.vhd                 # Testbench for simulation and verification
└── README.md              # Project documentation
```

---

## 🧠 Architecture Overview

### 🔹 Datapath Components

* **3-Bit Adder (`adder_3bit.vhd`)**
  Performs unsigned addition between the multiplicand and the current accumulator value.

* **3-Bit Registers (`register_3bit.vhd`)**
  Used to store the accumulator and multiplicand values.

* **2-Bit Counter (`counter_2bit.vhd`)**
  Tracks the number of shift-and-add cycles (3 iterations total for a 3-bit multiplier).

### 🔹 Control Unit

* **Finite State Machine (`control_unit.vhd`)**
  Orchestrates the multiplication process. The control logic:

  * Checks the LSB of the multiplier.
  * Enables the adder and accumulator conditionally.
  * Triggers right-shift operations.
  * Detects the completion of the operation via the counter.

### 🔹 Top-Level Integration

* **`multiplier_3x3.vhd`**
  Instantiates and interconnects all datapath and control components. Defines I/O ports, including:

  * `clk`: System clock
  * `rst`: Active-high reset
  * `start`: Start signal
  * `a`, `b`: 3-bit unsigned operands
  * `p`: 6-bit product output
  * `done`: Indicates operation completion

---

## 🧪 Simulation and Verification
![image](https://github.com/user-attachments/assets/d97481b4-82da-4413-9503-79a975603bd9)


A complete testbench is provided in `tb.vhd`. It applies multiple test vectors and verifies the functionality of the multiplier via waveform inspection or console output.

### ✅ Example Test Case

| Input A | Input B | Binary A | Binary B | Product | Binary Product |
| ------- | ------- | -------- | -------- | ------- | -------------- |
| 5       | 3       | `101`    | `011`    | 15      | `001111`       |

### 💡 Simulation Tools Supported

* **GHDL**
* **ModelSim / QuestaSim**
* **Vivado Simulator**

---

## 🛠️ Recommended Toolchain

| Purpose     | Tool                                                                                               |
| ----------- | -------------------------------------------------------------------------------------------------- |
| Simulation  | Vivado Simulator                                                                   |
| Synthesis   | Xilinx Vivado                                                                     |

---

## 🎯 Educational Objectives

This project is suitable for digital design students and FPGA developers who want to:

* Understand low-level binary multiplication in hardware.
* Practice building modular RTL designs.
* Learn FSM-based control of iterative operations.
* Explore datapath-controller architecture principles.

---

## 🤝 Contributing

Contributions, suggestions, and feature improvements are welcome. Please fork the repository and submit a pull request or open an issue.

---
