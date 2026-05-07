# FPGA SoC Designs

This repository contains FPGA and SoC design projects built using Intel/Altera FPGA tools. The work focuses on hardware/software co-design, HPS-to-FPGA communication, memory-mapped I/O, Verilog hardware integration, and board-level testing.

## Repository Overview

This repository includes FPGA and SoC design work based on Intel FPGA development boards and tools.

The projects cover two main areas:

1. Hardware/software co-design using the Cyclone V SoC.
2. FPGA-based real-time game logic using Verilog.

The goal of this repository is to document practical FPGA design work involving RTL, embedded C, Linux user-space hardware access, and board-level validation.

## Projects Included

## 1. Cyclone V HPS-FPGA LED Control

This project demonstrates communication between the ARM Hard Processor System and the FPGA fabric on a Cyclone V SoC platform.

The FPGA side contains RTL and Platform Designer files that connect a PIO peripheral to FPGA LEDs. The HPS side contains a C program that runs on Linux and accesses FPGA registers through memory-mapped I/O.

The software uses `/dev/mem` and `mmap()` to map physical FPGA bridge addresses into Linux user space. After mapping the address range, the C program writes values to the FPGA-connected LED peripheral.

### Main Concepts

```text
Cyclone V SoC
ARM Hard Processor System
FPGA fabric
HPS-to-FPGA bridge
Lightweight HPS-to-FPGA bridge
Memory-mapped I/O
/dev/mem
mmap()
PIO peripheral
Embedded Linux
C programming
Verilog RTL
Intel Quartus
Platform Designer
```

### Project Path

```text
my_first_hps-fpga/my_first_hps-fpga/
```

### Important Folders

```text
fpga-rtl/   FPGA RTL, Quartus, and Platform Designer files
hps-c/      Linux C code for HPS-side hardware control
```

### Build and Run Flow

1. Open the FPGA project in Intel Quartus.
2. Verify or regenerate the Platform Designer system.
3. Compile the FPGA design.
4. Program the FPGA bitstream onto the Cyclone V SoC board.
5. Build the HPS C application inside the `hps-c` folder.
6. Run the program on the Linux side of the board.
7. Verify that software running on the ARM HPS controls the FPGA LEDs.

Example build flow:

```bash
cd my_first_hps-fpga/my_first_hps-fpga/hps-c
make
sudo ./my_first_hps-fpga
```

The executable may require root permission because it accesses `/dev/mem`.

## 2. FPGA Reaction Time Game

This project archive contains a Quartus design for a reaction-time game built on an Intel FPGA board.

The game uses FPGA logic to measure how quickly a user responds to LED prompts. A random LED is selected, and the player must flip the matching switch as fast as possible. The FPGA tracks timing, controls LEDs, reads switches, updates seven-segment displays, and manages game state.

### File

```text
Project 3 Module 4 Game.qar
```

### Main Concepts

```text
Verilog
Finite State Machine
FPGA timing logic
Switch input handling
LED output control
Seven-segment display control
Random target generation
Reaction-time measurement
Intel Quartus archive
```

### Game Behavior

1. The user starts the game using a push button.
2. The FPGA waits for a random delay.
3. A target LED turns on.
4. The user flips the matching switch.
5. The FPGA records the response time.
6. The game repeats for multiple targets.
7. The final reaction time is displayed on the board.

## Repository Structure

```text
FPGA_PERSONAL_DESIGN/
├── my_first_hps-fpga/
│   └── my_first_hps-fpga/
│       ├── fpga-rtl/
│       └── hps-c/
├── Project 3 Module 4 Game.qar
└── README.md
```

## Tools Used

```text
Intel Quartus Prime
Platform Designer / Qsys
Cyclone V SoC development flow
DE10-Lite FPGA development flow
Embedded Linux
GCC
Make
Verilog
C
```

## Skills Demonstrated

```text
FPGA design
RTL development
Hardware/software co-design
Embedded C programming
Linux user-space hardware access
Memory-mapped I/O
HPS-to-FPGA bridge usage
PIO peripheral control
Platform Designer integration
Quartus project development
Board-level testing
```

## What I Learned

This work helped me understand how FPGA hardware and embedded software interact in a real SoC system.

The HPS-FPGA project showed how software running on an ARM processor can control custom FPGA peripherals through memory-mapped registers.

The reaction-time game showed how FPGA logic can handle timing-sensitive behavior directly in hardware.

Together, these projects strengthened my understanding of FPGA design, SoC integration, hardware/software partitioning, and board-level validation.

## Author

Sriramkumar Jayaraman
