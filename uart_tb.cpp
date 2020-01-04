#include <stdlib.h>
#include "Vuart_recv.h"
#include "verilated.h"
#include <verilated_vcd_c.h>
#include <iostream>

using namespace std;

int main(int argc, char **argv) {
    Verilated::traceEverOn(true);
	Verilated::commandArgs(argc, argv);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
	Vuart_recv*tb = new Vuart_recv;
    tb->trace(m_trace, 99);
    m_trace->open("trace.vcd");

    int values[20] = {0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1};
    int rx;

	// Tick the clock until we are done
    int j = 0;
    for(int k = 0; k < 20; k++) {
        int rx = values[k];
        for(int i = 0; i < 10416; i++) {
            tb->UART_RX = rx;
            tb->CLK = 1;
            tb->eval();
            m_trace->dump(j*10);
            tb->CLK = 0;
            tb->eval();
            m_trace->dump(j*10 + 5);
            j++;
        }
        m_trace->flush();
    }
	
    m_trace->close();
}
