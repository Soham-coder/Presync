# Presync

# Title
PreSyNC: Hardware realization of the Presynaptic Region of a Biologically Extensive Neuronal Circuitry

```diff
@@ Abstract—@@
Spiking Neural Networks (SNN) have gained relevance in recent times, due to their ability to mimic the biological nature to communicate and process sparse asynchronous binary signals in a massively parallel fashion. SNN based neuromorphic hardware exhibits highly desired favourable properties such as low power consumption, fast inference, and event-driven information processing. A recognized challenge of standard SNN neuron models is their limited capabilities in biological applications, such as applying neural networks to study network responses arising from variations pertaining to damage, external influence or disruptions in channel transfer dynamics.

This paper presents Pre-Synaptic Neuronal Circuit (PreSyNC), a high performance hardware realization of an input-specific presynaptic region of a generic neuron, without abstraction of primary intra-neuronal parameters. PreSyNC is configured to operate on three precision modes: IEEE 754 single precision, double precision and the recently developed universal number posit number system. The developed hardware design is compared to current standards of SNN neuron models as well as biological models in terms of flexibility, resource efficiency and damage modelling capability. Error margins as low as 0.9% were obtained and suggest the capability of our hardware in handling applications involving large scale neuron networks. These architectures are synthesized on 45 nm process
technology where they all operate at a minimum frequency of approximately 1GHz. The three precision modes are compared based on power, accuracy, and sensitivity handling and are expected to benefit implantation oriented applications such as neural prosthesis and Human-Computer Interaction (HMI). The posit-based implementation outperforms the rest of the operating modes in terms of RMS error, while having 26.3% less area and 25.2% less power consumption compared to double precision implementation. These new architectures can be expanded in the future with various post-synaptic inputs to open up a broader understanding of biological systems and other applications.

+ Index Terms—Neuromorphic computation, presynaptic region, neural networks, posit arithmetic
```

# Hardware

• Hardware design of Synaptic AI accelerator by taking realtime accurate intra-neuronal parameters in floating point single & double precision and recently developed number system Posit 32 bit with 4 bit exponent size

• Comparitive study of them in terms of accuracy, precision and sensitivity handling and economic footprint. The designs are pipelined to meet 1 Ghz frequency in 45nm ASIC with extensively optimised area and power

# Directory Structure

<details><summary><tt> Directory structure </tt></summary>
<p>

```prompt
- .
   - __Draft__
     - [NanoSys\_Draft.pdf](Draft/NanoSys_Draft.pdf)
   - __IEEE\_32__
     - __RTL__
       - [IEEE32\_design.sv](IEEE_32/RTL/IEEE32_design.sv)
     - __Simulation__
       - [IEEE32\_tb.sv](IEEE_32/Simulation/IEEE32_tb.sv)
       - [result.txt](IEEE_32/Simulation/result.txt)
     - __Synthesis\_logs__
       - [area.log](IEEE_32/Synthesis_logs/area.log)
       - [power.log](IEEE_32/Synthesis_logs/power.log)
       - [powerhier.log](IEEE_32/Synthesis_logs/powerhier.log)
       - [timing.log](IEEE_32/Synthesis_logs/timing.log)
     - __Utility__
       - [bin\_2\_dec.cpp](IEEE_32/Utility/bin_2_dec.cpp)
       - [run.sh](IEEE_32/Utility/run.sh)
   - __IEEE\_64__
     - __RTL__
       - [IEEE64\_design.sv](IEEE_64/RTL/IEEE64_design.sv)
     - __Simulation__
       - [IEEE64\_tb.sv](IEEE_64/Simulation/IEEE64_tb.sv)
       - [res\_64\_dec.csv](IEEE_64/Simulation/res_64_dec.csv)
     - __Synthesis\_logs__
       - [area.log](IEEE_64/Synthesis_logs/area.log)
       - [power.log](IEEE_64/Synthesis_logs/power.log)
       - [powerhier.log](IEEE_64/Synthesis_logs/powerhier.log)
       - [timing.log](IEEE_64/Synthesis_logs/timing.log)
     - __Utility__
       - [float64\_to\_dec.py](IEEE_64/Utility/float64_to_dec.py)
       - [run.sh](IEEE_64/Utility/run.sh)
   - __Posit\_32\_4__
     - __RTL__
       - [design\_posit.sv](Posit_32_4/RTL/design_posit.sv)
     - __Simulation__
       - [log\_posit.txt](Posit_32_4/Simulation/log_posit.txt)
       - [result\_decimal.csv](Posit_32_4/Simulation/result_decimal.csv)
       - [testbench\_posit.sv](Posit_32_4/Simulation/testbench_posit.sv)
     - __Synthesis\_logs__
       - [area.log](Posit_32_4/Synthesis_logs/area.log)
       - [power.log](Posit_32_4/Synthesis_logs/power.log)
       - [powerhier.log](Posit_32_4/Synthesis_logs/powerhier.log)
       - [timing.log](Posit_32_4/Synthesis_logs/timing.log)
     - __Utility__
       - [posit32hex.py](Posit_32_4/Utility/posit32hex.py)
       - [run.sh](Posit_32_4/Utility/run.sh)
   - [README.md](README.md)
```
</p>
</details>

# Description of contents-
```diff
+ RTL - contains design
+ Simulation - contains testbench and decimal results
+ Synthesis_logs - contains synthesis results in Synopsys DC in 45nm ASIC
+ Utility - contains Questasim 10.0b simulator run script and *.py/*.cpp file for conversion of posit<32,4> to decimal & IEEE32,64 to decimal
```
# Instruction to run-
```diff
# 1) Run the *.sh script present in Utlity folder. It will compile + simulate RTL+TB and generate log file in Simulation folder. Will run in Windows 32/64 bit OS in batch mode.
! Note- Change the Questasim executables(vlib, vlog, vsim) paths incase of Ubuntu or any Unix system to the respective paths where they get installed.
# 2) Execute the *.py/*.cpp file present in Utility folder to generate .csv or .txt file which will contain converted results from binary/hexadecimal to accurate decimals.  
```