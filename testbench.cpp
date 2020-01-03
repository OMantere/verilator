#include "Vcode.h"
#include "verilated.h"
int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vcode* top = new Vcode;
    while (!Verilated::gotFinish()) { top->eval(); }
    delete top;
    exit(0);
}
