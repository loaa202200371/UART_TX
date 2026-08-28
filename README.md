# UART_TX
A fully parameterized, modular Verilog UART Transmitter (TX) core featuring configurable bit-width, dynamic parity calculation, and complete testbench verification.

#  Verilog UART Transmitter (TX) Engine

An efficient, fully parameterized **UART Transmitter (TX)** core implemented in Verilog HDL. Designed with modularity and RTL best practices in mind, this module handles parallel-to-serial conversion, automatic parity generation, and frame control seamlessly.

---

##  What Problem Does This Solve?

Communicating with microcontrollers, FPGAs, or PC serial ports requires converting parallel data buses into a single-wire serial output. This engine takes an N-bit parallel byte, computes the parity, wraps it in standard UART framing bits (Start & Stop), and streams it bit-by-bit at your desired clock rate.

---

##  System Architecture & Modules

The architecture is divided into four cleanly decoupled hardware modules:

```text
                  +-----------------------------------+
                  |             UART_TX               |
                  |                                   |
 [P_in]  =========> [ Serializer ] ------> (Ser_in) --+
 [P_Bit] ---------> [ Parity Calc ] ------> (Par_bit) -+---> [ MUX ] ---> Tx_out
 [V_input/P_En] --> [ FSM Control ] ------> (Sel) ----+
                  +-----------------------------------+
