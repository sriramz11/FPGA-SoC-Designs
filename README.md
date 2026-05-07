# FPGA SoC Designs

This repository contains FPGA and SoC design projects built using Intel/Altera FPGA tools. The work focuses on RTL design, hardware/software co-design, HPS-to-FPGA communication, memory-mapped I/O, timing logic, seven-segment display control, and board-level testing.

## Repository Overview

This repository includes FPGA and SoC design work based on Intel FPGA development boards and tools.

The projects cover three main areas:

1. Hardware/software co-design using the Cyclone V SoC.
2. FPGA-based BCD counter and seven-segment display logic.
3. FPGA-based real-time game logic using Verilog.

The goal of this repository is to document practical FPGA design work involving RTL, embedded C, Linux user-space hardware access, memory-mapped register control, and real board validation.

## Projects Included

## 1. Cyclone V HPS-FPGA LED Control

This project demonstrates communication between the ARM Hard Processor System and the FPGA fabric on a Cyclone V SoC platform.

The FPGA side contains RTL and Platform Designer files that connect a PIO peripheral to FPGA LEDs. The HPS side contains a C program that runs on Linux and accesses FPGA registers through memory-mapped I/O.

The software uses `/dev/mem` and `mmap()` to map physical FPGA bridge addresses into Linux user space. After mapping the address range, the C program writes values to the FPGA-connected LED peripheral.

### Project Path

```text
my_first_hps-fpga/my_first_hps-fpga/
```

### Important Folders

```text
fpga-rtl/   FPGA RTL, Quartus, and Platform Designer files
hps-c/      Linux C code for HPS-side hardware control
```

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

## 2. BCD Counter and Seven-Segment Display Project

This project contains a Verilog-based BCD counter design for an Intel FPGA board. The design uses the board clock, divides it down to a slower timing tick, and increments a three-digit BCD count from 000 to 999.

The count is displayed on three seven-segment displays. `HEX0` shows the ones digit, `HEX1` shows the tens digit, and `HEX2` shows the hundreds digit.

### Project Path

```text
prj3_lab5_2/
```

### Important Files

```text
part2_bcd_counter.v   Top-level BCD counter design
counter_modk.v        Parameterized modulo-k counter
bcd7seg.v             BCD to seven-segment decoder
lab5.sdc              Timing constraints file
lab5_2.qpf            Quartus project file
lab5_2.qsf            Quartus settings file
```

### Main Concepts

```text
Verilog RTL
BCD counting
Modulo-k counter design
Clock division
Seven-segment display decoding
Active-low reset
Synchronous counter logic
Quartus project setup
Timing constraints
Board-level display testing
```

### Design Behavior

1. The FPGA receives the board clock through `CLOCK_50`.
2. A parameterized counter divides the clock down to a slower tick.
3. The BCD counter increments once per timing tick.
4. The counter rolls over from 999 back to 000.
5. `KEY[0]` acts as an active-low reset.
6. The ones, tens, and hundreds digits are sent to seven-segment display decoders.
7. The decoded outputs drive `HEX0`, `HEX1`, and `HEX2`.

### Module Breakdown

### `counter_modk.v`

This module implements a reusable modulo-k counter.

It uses parameters for counter width and rollover value. The counter increments on each clock cycle. When the count reaches the rollover value, it resets to zero and raises a rollover signal.

This module is useful for clock division, timing generation, and reusable counter-based logic.

### `bcd7seg.v`

This module converts a 4-bit BCD digit into the corresponding seven-segment display pattern.

It supports decimal digits from 0 through 9 and blanks or disables unsupported values depending on the implementation.

### `part2_bcd_counter.v`

This is the top-level module for the BCD counter project.

It connects the clock divider, BCD digit registers, reset input, and seven-segment display outputs.

## 3. FPGA Reaction Time Game

This project archive contains a Quartus design for a reaction-time game built on an Intel FPGA board.

The game uses FPGA logic to measure how quickly a user responds to LED prompts. A random LED is selected, and the player must flip the matching switch as fast as possible. The FPGA tracks timing, controls LEDs, reads switches, updates seven-segment displays, and manages game state.

### File

```text
my_game.qar
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
FPGA-SoC-Designs/
├── my_first_hps-fpga/
│   └── my_first_hps-fpga/
│       ├── fpga-rtl/
│       └── hps-c/
├── prj3_lab5_2/
│   ├── db/
│   ├── incremental_db/
│   ├── output_files/
│   ├── simulation/
│   │   └── modelsim/
│   ├── bcd7seg.v
│   ├── c5_pin_model_dump.txt
│   ├── counter_modk.v
│   ├── lab5.sdc
│   ├── lab5_2.qpf
│   ├── lab5_2.qsf
│   ├── lab5_2.qsf.bak
│   ├── lab5_2.qws
│   └── part2_bcd_counter.v
├── my_game.qar
└── README.md
```

## Tools Used

```text
Intel Quartus Prime
Platform Designer / Qsys
Cyclone V SoC development flow
DE10-Lite FPGA development flow
ModelSim
Embedded Linux
GCC
Make
Verilog
SystemVerilog
C
Tcl
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
Clock division
BCD counter design
Seven-segment display decoding
Finite State Machine design
Quartus project development
Platform Designer integration
Timing constraint usage
Board-level testing
```

## What I Learned

This repository helped me understand how FPGA hardware and embedded software interact in real systems.

The HPS-FPGA project showed how software running on an ARM processor can control custom FPGA peripherals through memory-mapped registers.

The BCD counter project strengthened my understanding of clock division, rollover logic, BCD counting, reset behavior, and seven-segment display decoding in Verilog.

The reaction-time game showed how FPGA logic can handle timing-sensitive behavior directly in hardware using FSM-based control.

Together, these projects improved my understanding of FPGA design, SoC integration, hardware/software partitioning, timing logic, and board-level validation.

## Author

Sriramkumar Jayaraman
