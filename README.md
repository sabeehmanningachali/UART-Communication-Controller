# UART Communication System in Verilog HDL

## Overview

This project implements a modular Universal Asynchronous Receiver Transmitter (UART) in Verilog HDL. The design follows a hierarchical approach in which each hardware module was designed, simulated, and verified independently before system-level integration.

The project was developed and simulated using **Icarus Verilog** and **GTKWave**, with an emphasis on modular digital design, finite state machines, shift-register based data transmission, and verification through waveform analysis.

---

## Features

- UART Transmitter
- UART Receiver
- Baud Rate Generator
- Odd Parity Generator
- Odd Parity Checker
- Parallel-In Serial-Out (PISO) Register
- Serial-In Parallel-Out (SIPO) Register
- FSM-based Transmitter Controller
- FSM-based Receiver Controller
- Negative Edge Detector
- Modular Verilog Design
- Simulation-based Verification

---

## Repository Structure

```
UART-Verilog/
│
├── src/
│   ├── baud_generator.v
│   ├── parity_generator.v
│   ├── parity_checker.v
│   ├── piso.v
│   ├── sipo_register.v
│   ├── tx_fsm.v
│   ├── receiver_fsm.v
│   ├── negative_edge_detector.v
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── uart_system.v
│
├── tb/
│   ├── baud_generator_tb.v
│   ├── parity_generator_tb.v
│   ├── parity_checker_tb.v
│   ├── piso_tb.v
│   ├── sipo_tb.v
│   ├── tx_fsm_tb.v
│   ├── receiver_fsm_tb.v
│   ├── uart_tx_tb.v
│   └── uart_system_tb.v
│
├── waveforms/
│
└── README.md
```

---

# UART Frame Format

The transmitter serializes an 11-bit UART frame.

```
---------------------------------------------------------
| Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 |Parity|Stop|
---------------------------------------------------------
```

- Start Bit : 0
- Data Bits : 8
- Parity : Odd
- Stop Bit : 1

---

# Modules

## Baud Generator

Generates the baud clock used by both the transmitter and receiver.

### Verification

- Clock division verified
- Correct baud tick generation observed in GTKWave

---

## Parity Generator

Computes odd parity for every transmitted byte.

### Tested Inputs

- 0x00
- 0xFF
- 0xAA
- 0xCC
- 0x5D

---

## Parity Checker

Checks received parity against regenerated parity.

### Verification

- Correct parity detection
- Error flag generation verified

---

## PISO Register

Loads

- Start bit
- Data byte
- Parity bit
- Stop bit

into an 11-bit shift register and serializes one bit per baud tick.

### Verification

- Correct loading
- Correct shifting sequence
- Serial output verified

---

## SIPO Register

Receives serial UART data and reconstructs

- Data byte
- Parity bit

### Verification

- Correct serial-to-parallel conversion
- Correct data extraction

---

## Negative Edge Detector

Detects the falling edge of the UART start bit.

### Verification

- Single-cycle pulse generation verified

---

## Transmitter FSM

Finite State Machine controlling UART transmission.

States

- Idle
- Load
- Shift
- Done

Outputs

- busy
- load
- shift

### Verification

- Proper state transitions
- Correct bit counting
- Busy signal verified

---

## Receiver FSM

Finite State Machine controlling UART reception.

Responsibilities

- Detect start bit
- Enable shifting
- Count received bits
- Generate load signal
- Assert busy

### Verification

- State transitions verified
- Bit counter verified

---

## UART Transmitter

Integrates

- Baud Generator
- Parity Generator
- TX FSM
- PISO Register

### Verification

- Complete UART frame transmission
- Correct start bit
- Correct data bits
- Correct parity
- Correct stop bit

---

## UART Receiver

Integrates

- Negative Edge Detector
- Receiver FSM
- SIPO Register
- Parity Checker

### Current Status

Receiver architecture has been implemented and individual modules verified.

System-level timing synchronization between the transmitter and receiver is currently under refinement.

---

## UART System

Top-level integration connecting transmitter and receiver through a common serial line.

### Current Status

- Transmitter operational
- Receiver detects incoming frames
- End-to-end data recovery requires receiver timing refinement

---

# Simulation

All simulations were carried out using

- Icarus Verilog
- GTKWave

### Individually Verified Modules

- ✔ Baud Generator
- ✔ Parity Generator
- ✔ Parity Checker
- ✔ Negative Edge Detector
- ✔ PISO Register
- ✔ SIPO Register
- ✔ TX FSM
- ✔ Receiver FSM
- ✔ UART Transmitter

---

# Development Process

The project followed a bottom-up design methodology.

1. Designed each hardware block independently.
2. Created dedicated Verilog testbenches.
3. Verified functionality through GTKWave.
4. Integrated modules into transmitter.
5. Integrated transmitter and receiver.
6. Performed system-level debugging and timing analysis.

---

# Current Progress

| Module | Status |
|----------|---------|
| Baud Generator | ✅ Verified |
| Parity Generator | ✅ Verified |
| Parity Checker | ✅ Verified |
| PISO Register | ✅ Verified |
| SIPO Register | ✅ Verified |
| Negative Edge Detector | ✅ Verified |
| TX FSM | ✅ Verified |
| Receiver FSM | ✅ Verified |
| UART Transmitter | ✅ Verified |
| UART Receiver | 🔄 Timing refinement in progress |
| Complete UART System | 🔄 Integration in progress |

---

# Tools

- Verilog HDL
- Icarus Verilog
- GTKWave
- Git
- GitHub

---

# Skills Demonstrated

- RTL Design
- Digital Logic Design
- Finite State Machine Design
- Shift Register Design
- Serial Communication
- UART Protocol
- Functional Verification
- Timing Analysis
- Simulation and Debugging
- Modular Hardware Design

---

# Future Improvements

- Receiver timing synchronization
- Configurable baud rates
- Parameterized data width
- Even/Odd parity selection
- FPGA implementation
- Hardware validation on FPGA board

---

## Author

**Sabeeh Muhammed MC**

B-Tech,Electrical Engineering  
Indian Institute of Technology Kanpur
