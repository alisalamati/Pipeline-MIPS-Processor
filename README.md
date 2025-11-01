# Pipeline MIPS Processor

### Overview  
This project implements a **pipelined MIPS processor** using **VHDL**, designed to improve instruction throughput by executing multiple stages of the instruction cycle in parallel.  
The processor supports essential MIPS instructions and simulates realistic pipeline behavior including data hazards and control flow handling.

---

### 🧩 Project Structure
- `Codes/` — contains all VHDL modules (ALU, Control Unit, Pipeline Registers, etc.)
- `Testbench/` — includes simulation files for verifying pipeline behavior
- `Docs/` — design documentation and diagrams (if available)

---

### ⚙️ Features
1. **Five-stage pipeline** architecture (IF, ID, EX, MEM, WB)  
2. **Hazard management** using data forwarding and stalling  
3. **Register file and memory unit** implemented in VHDL  
4. Fully **simulatable** in ModelSim or GHDL  
5. Comparison between pipelined and single-cycle performance  

---

### ✅ Results & Learning Outcomes
- Verified correct execution of all test instructions  
- Demonstrated significant throughput improvement over a non-pipelined processor  
- Gained practical experience in:
  - VHDL hardware design  
  - Pipeline control and hazard detection  
  - Digital system simulation and debugging  

---

### 🛠 How to Run
```bash
# Compile and simulate (example)
vcom *.vhd
vsim pipeline_tb
