#!/usr/bin/env bash
verilator -Wall --cc code.v --exe testbench.cpp
make -C obj_dir -f Vcode.mk
obj_dir/Vcode

