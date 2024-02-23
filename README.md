# 16-Point-FFT---ASIC-Design-Flow
VLSI Mini Project 2022-23
1) The project involves the design of the Discrete Fourier Transform(DFT) of a 16-point sequence using the Fast Fourier Transform(FFT) algorithm and involves ASIC design for the same.
2) The Synthesis and Simulation is carried out on Quartus Prime (EDA tool) and Questa Sim simulator.
3) The backend physical design flow is carried out on OpenLane, an open-source tool, and the Skywater130nm technology file is used as the Process design kit(pdk) file.
4) **Usage**
The simulation can be carried out by running the testbench "fft_top_tb".This requires 16 input sequences which can be provided in the testbench.Each number is a 32 bit complex number where the most 16 significant bits represent the real value and least 16 bits represent imaginary value, and each 16 bit value is a floating point number in  accordance to the IEEE-754 format.
