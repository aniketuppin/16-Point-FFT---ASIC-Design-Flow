# 16-Point-FFT---ASIC-Design-Flow
VLSI Mini Project 2022-23
1) The project aims to compute the DFT of 16-point sequence using the fft algorithm and involves ASIC design for the same.
2) It requires the use of Quartus Prime (EDA tool) and Questa Sim simulator for Synthesis and Simulation.
3) The backend physical design flow is carried out on OpenLane, an open-source tool, and the Skywater130nm technology file is used as the pdk file.
**Usage**
The simulation can be carried out by running the fft_top_tb verilog module.This requires 16 input sequences which can be provided in the testbench.Each number is a 32 bit complex number where the most 16 significant bits are real part and least 16 bits are imaginary part, each represented as 16 bit floating point number according to IEEE-754 format.
