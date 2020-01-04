#!/usr/bin/env bash
verilator -Wall --trace --cc uart_recv.v --exe uart_tb.cpp
make -C obj_dir -fVuart_recv.mk
obj_dir/Vuart_recv
gtkwave trace.vcd

