#!/bin/bash


/c/questasim_10.0b/win32/vlib.exe work
/c/questasim_10.0b/win32/vlog.exe +incdir+"../RTL/"+"../Simulation/" -writetoplevels questa.tops -timescale 1ps/1fs ../RTL/IEEE32_design.sv ../Simulation/IEEE32_tb.sv
/c/questasim_10.0b/win32/vsim.exe -f questa.tops -c -do "vsim -voptargs=+acc=npr; run -all; exit" -voptargs=+acc=npr | tee ../Simulation/log_ieee32.txt