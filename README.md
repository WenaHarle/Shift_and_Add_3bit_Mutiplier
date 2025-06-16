# ⚙️ 3-Bit × 3-Bit Shift-and-Add Binary Multiplier in VHDL

This repository contains a modular and synthesizable **3-bit by 3-bit binary multiplier** implemented using the **Shift-and-Add algorithm** in **VHDL**. The design follows a classic **datapath-control architecture**, making it ideal for FPGA prototyping, digital logic education, and embedded system applications.

---

## 📌 Project Summary

The multiplier operates by iteratively:

1. Checking the LSB of the multiplier.
2. Adding the multiplicand to an accumulator if the LSB is `1`.
3. Right-shifting the multiplier and left-shifting the multiplicand.
4. Repeating the process for 3 clock cycles to produce a 6-bit product.

---

## 🗂️ File Structure

```text
.
├── shift_3bit.vhd         # 3-bit shift register
├── adder_3bit.vhd         # 3-bit binary adder
├── register_3bit.vhd      # 3-bit register for accumulator/multiplicand
├── counter_2bit.vhd       # 2-bit counter for iteration control
├── control_unit.vhd       # FSM-based control logic
├── multiplier_3x3.vhd     # Top-level module (datapath + control)
├── tb.vhd                 # Testbench for simulation
└── README.md              # Project documentation
```

---

## 🧠 Architecture Overview
<img src="https://github.com/user-attachments/assets/5535faa2-a6d5-4df1-91d6-c2d772bcf4dd" alt="ASM Chart" width="50%">

### 🔹 Datapath Components

* **Adder (`adder_3bit.vhd`)**
  Performs 3-bit unsigned addition.

* **Registers (`register_3bit.vhd`)**
  Store multiplicand and accumulator values.

* **Shift Register (`shift_3bit.vhd`)**
  Holds the multiplier and enables bitwise right shifting.

* **Counter (`counter_2bit.vhd`)**
  Keeps track of the number of shift-add cycles (max = 3).

### 🔹 Control Unit

* **FSM (`control_unit.vhd`)**
  Manages:

  * LSB checking of multiplier
  * Conditional add enable
  * Shift operations
  * Loop termination via counter

### 🔹 Top-Level Module

* **`multiplier_3x3.vhd`**
  Connects datapath and control components.
  **I/O Ports:**

  * `clk`: System clock
  * `rst`: Asynchronous reset
  * `start`: Multiplication start trigger
  * `a`, `b`: 3-bit inputs
  * `p`: 6-bit product output
  * `done`: Completion flag

---

## 🧪 Testbench and Simulation

<img src="https://github.com/user-attachments/assets/d97481b4-82da-4413-9503-79a975603bd9" alt="Simulation Result" width="100%">
click
A dedicated testbench (`tb.vhd`) applies multiple input combinations and validates results through waveform or console output.

### ✅ Example Case

| A (Dec) | B (Dec) | A (Bin) | B (Bin) | Product (Dec) | Product (Bin) |
| ------- | ------- | ------- | ------- | ------------- | ------------- |
| 5       | 3       | `101`   | `011`   | 15            | `001111`      |

### 🧰 Supported Simulators

* **GHDL**
* **ModelSim / QuestaSim**
* **Vivado Simulator**

---

## 🛠️ Recommended Tools

| Task       | Tool             |
| ---------- | ---------------- |
| Simulation | Vivado Simulator |
| Synthesis  | Xilinx Vivado    |

---

## 🎓 Learning Outcomes

This project is suitable for digital design students and developers looking to:

* Learn binary multiplication in hardware.
* Understand datapath vs control separation.
* Build FSM-driven iterative logic.
* Apply modular RTL design principles.

---

## 🤝 Contributing

Contributions and suggestions are welcome!
Feel free to fork the repository and submit a pull request or open an issue.
