# DDR4-Memory-Controller-VLSI
DDR4 controller RTL + testbench simulation in QuestaSim

# DDR4 Memory Controller – VLSI Design & Verification (SystemVerilog)

This repository contains an RTL-based **DDR4 Memory Controller** design along with a **SystemVerilog testbench** for simulation and functional verification using **QuestaSim**.

The project demonstrates end-to-end workflow including **RTL compilation, top-module integration, testbench-driven simulation, and waveform-based debugging**.

---

## 🔧 Tools Used
- **SystemVerilog / Verilog**
- **QuestaSim (ModelSim)** for RTL simulation & waveform analysis

---

## 📁 Project Files
| File Name | Description |
|----------|-------------|
| `ddr4_rtl.sv` | DDR4 RTL logic and core functionality |
| `memory_controller.sv` | Controller logic for handling DDR4 operations |
| `dfi_interface.sv` | DFI interface module for control/data handshake |
| `ddr4_top.sv` | Top module integrating controller + interface + DDR4 RTL |
| `ddr_testbench.sv` | SystemVerilog testbench to simulate and verify the design |

---

## ▶️ How to Run (QuestaSim)

### ✅ Step 1: Open QuestaSim and go to the project folder
```tcl
cd D:/VLSIFIRST/project
vlib work
vlog *.sv
vsim ddr_testbench
add wave -r *
run -all

**Simulation Output
Functional simulation executed successfully in QuestaSim.
Verified design behavior through waveform analysis.

LinkedIn Video Demo: (https://www.linkedin.com/posts/deepika-kureti-kd_vlsi-ddr4-systemverilog-activity-7416758493350789121-NMiN?utm_source=share&utm_medium=member_desktop&rcm=ACoAADcoYTcBxcCs0VwU789J0gQYC-Ra2eTDJjQ)

🚀 Key Learnings
RTL compile flow and module dependency handling
Top-level integration and DUT instantiation from the testbench
Simulation debugging using waveform analysis
Best practices: compile RTL modules instead of using `include for design files

📌 Author
Kureti Deepika
B.Tech ECE | VLSI Design & Verification
GitHub: https://github.com/deepikakuret
