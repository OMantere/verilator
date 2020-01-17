#!/usr/bin/env bash
verilator -Wall --trace --cc alu.v --exe alu_tb.cpp
make -C obj_dir -f Valu.mk
obj_dir/Valu
gtkwave trace.vcd

