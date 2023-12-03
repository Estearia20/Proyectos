`timescale 1ns/1ps

// For setting overall parameters
`define bits 1
`define drvrs 4
`define pkg_sz 24
`define broadcast {8'b0000_0011}

// For choosing a test to run
`define NEL

// Needed files
`include "Library.sv"
`include "interface.sv"
`include "interface_transactions.sv"
`include "driver.sv"
`include "monitor.sv"
`include "checker.sv"
`include "agente.sv"
`include "scoreboard.sv"
`include "generator.sv"
`include "ambiente.sv"

// Conditions for selecting a test file
`ifdef BRD
    `include "test_broadcast.sv"
`elsif NE
    `include "test_no_existe.sv"
`elsif RST
    `include "test_rst.sv"
`elsif SPC
    `include "test_spc_rand.sv"
`else
    `include "test.sv"
`endif

// Testbench, here dut and other modules are called
module tb;
    reg         clk;

    // For setting fifo dpth
    parameter fifo_dpth = 16;

    // Generate interface instance
    if_dut #(.bits(`bits), 
             .drvrs(`drvrs),
             .pkg_sz(`pkg_sz),
             .broadcast(`broadcast)) bus_if(.clk(clk));

    // Generates clk signal
    always #5 clk = ~clk;

    // Test instance
    test #(.bits(`bits), 
           .drvrs(`drvrs),
           .pkg_sz(`pkg_sz),
           .broadcast(`broadcast),
           .fifo_dpth(fifo_dpth)) tst;

    // Environment instance
    ambiente #(.bits(`bits), 
               .drvrs(`drvrs),
               .pkg_sz(`pkg_sz),
               .broadcast(`broadcast),
               .fifo_dpth(fifo_dpth)) amb;

    // DUT instance
    bs_gnrtr_n_rbtr #(.bits       (`bits),
                      .drvrs      (`drvrs),
                      .pckg_sz    (`pkg_sz),
                      .broadcast  (`broadcast)) dut(
        .clk    (bus_if.clk),
        .reset  (bus_if.rst),
        .pndng  (bus_if.pndng),
        .push   (bus_if.push),
        .pop    (bus_if.pop),
        .D_pop  (bus_if.d_in),
        .D_push (bus_if.d_out)
        );

    initial begin
        // Set DUT inputs to zero
        clk = 0;
        bus_if.rst = 0;
        for (int i = 0; i < `bits; i++)begin
            for(int j = 0; j < `drvrs; j++)begin
                bus_if.pndng[i][j] = 0;
                bus_if.d_in[i][j] = 0;
            end
        end  

        @(posedge clk);
	    bus_if.rst = 1;
        @(posedge clk);
        bus_if.rst = 0;
        tst = new();
        tst.bus_if = bus_if;
        // Connects bus interfaces for multiple drv and mnt objects
        for (int i = 0; i < `drvrs; i++) begin
            automatic int k = i;
            tst.amb.drv_array[k].vif = bus_if;
            tst.amb.mnt_array[k].bus_if = bus_if;
        end
        tst.amb.gen.bus_if = bus_if;
        tst.amb.agent_inst.bus_if = bus_if;
        fork
           tst.run();
        join_none
    end

endmodule

