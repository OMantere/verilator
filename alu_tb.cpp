#include <stdlib.h>
#include "Valu.h"
#include "verilated.h"
#include <verilated_vcd_c.h>
#include <iostream>

using namespace std;

int main(int argc, char **argv) {
    Verilated::traceEverOn(true);
	Verilated::commandArgs(argc, argv);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
	Valu *tb = new Valu;
    tb->trace(m_trace, 99);
    m_trace->open("trace.vcd");
    int j = 0;
    while (!Verilated::gotFinish()) {
        tb->CLK = 1;
        tb->eval();
        m_trace->dump(j*10);
        tb->CLK = 0;
        tb->eval();
        m_trace->dump(j*10 + 5);
        j++;
    }
    m_trace->flush();
    m_trace->close();
}
