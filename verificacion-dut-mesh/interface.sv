// Interface for connecting with the DUT
interface if_dut #(parameter pckg_sz = 25) (input clk);

    // Signals required to connect with the DUT 
    // COLS = 4, ROWS = 4 for default
    logic reset;
    logic pndng[16];
    logic pndng_i_in[16];
    logic pop[16];
    logic popin[16];

    logic [pckg_sz-1:0] data_out[16];
    logic [pckg_sz-1:0] data_out_i_in[16];
endinterface

