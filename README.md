# 16-Point-FFT---ASIC-Design-Flow
VLSI Mini Project 2022-23
1) The project involves the design of the Discrete Fourier Transform(DFT) of a 16-point sequence using the Fast Fourier Transform(FFT) algorithm and involves ASIC design for the same.
2) The Synthesis and Simulation is carried out on Quartus Prime (EDA tool) and Questa Sim simulator.
3) The backend physical design flow is carried out on OpenLane, an open-source tool, and the Skywater130nm technology file is used as the Process design kit(pdk) file.
4) **Usage**
5) The simulation can be carried out as follows:
6)   the random_num.py generates 16 sequences randomly in a text file inputs.txt.
7)   then int2fp.py converts these sequences into IEEE-754 half-precision format, which is ready to be fed into the testbench.
8)   when the verilog simulation is carried out by running the testbench "new_tb.v" along with all the verilog modules the output sequence is written to a text file.
9)   then the float2int.py converts the sequence back into decimal format.
10)   finally the comparison.py compares the values given out by the RTL as well as the fft values calculated by the inbuilt fft function in python and displays the error margins.
