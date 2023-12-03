// Simulation time units
`timescale 1ns/1ps

// Setting parameters for the test
`define ROWS 4
`define COLS 4
`define PCKG_SZ 40
`define FF_DPTH 8
`define BRDCST {8'b1111_1111}
`define FIFOS
`define LIB

// defines for choosing what to show in console
//`define DEBUG_AGT
//`define DEBUG_GEN
//`define DEBUG_SCB
//`define DEBUG_CHK
//`define DEBUG_DRV
//`define DEBUG_MNT
//`define DEBUG_BUILD

// defines for settint the test to run
//`define TEST_MSRC_DTAR
//`define TEST_MODO
`define TEST_INSTR_RDM
//`define TEST_RST
//`define TEST_NO_EXISTE
//`define TEST_SAME_DEST

// Files that need to be included
`include "cobertura.sv"
`include "fifo.sv"
`include "transactions.sv"
`include "Library.sv"
`include "Router_library.sv"
`include "interface.sv"
`include "mesh.sv"
`include "mesh44.sv"
`include "assertions.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agente.sv"
`include "scoreboard.sv"
`include "generator.sv"
`include "checker.sv"
`include "ambiente.sv"
`include "test.sv"

module tb;

    // Clock signal variable and generation
    reg clk;
    always #5 clk = ~clk;

    // Creates the interface instance
    if_dut #(.pckg_sz(`PCKG_SZ)) bus_if(.clk(clk));
  
    // Creates the test instance
    test #(.pckg_sz(`PCKG_SZ), .fifo_dpth(`FF_DPTH)) tst;

    // Creates the environment instance
    ambiente #(.pckg_sz(`PCKG_SZ), .fifo_dpth(`FF_DPTH)) amb;

    // The DUT is instantiated
    mesh_gnrtr #(.ROWS       (`ROWS),
                 .COLUMS     (`COLS),
                 .pckg_sz    (`PCKG_SZ),
                 .fifo_depth (`FF_DPTH),
                 .bdcst      (`BRDCST)) dut(
        .clk            (clk),
        .reset          (bus_if.reset),
        .pndng          (bus_if.pndng),
        .data_out       (bus_if.data_out),
        .popin          (bus_if.popin),
        .pop            (bus_if.pop),
        .data_out_i_in  (bus_if.data_out_i_in),
        .pndng_i_in     (bus_if.pndng_i_in)
    );

    initial begin 
        // Sets DUT inputs signals to 0
        clk = 0;
        bus_if.reset = 0;
        for (int i = 0; i < 16; i++) begin
            bus_if.pop[i]           = 0;
            bus_if.pndng_i_in[i]    = 0;
            bus_if.data_out_i_in[i] = 0;
        end
        // Applies reset
        @(posedge clk);
        bus_if.reset = 1;
        @(posedge clk);
        bus_if.reset = 0;

        // Creates the test object
        tst = new();

        // Connects multiple DUT interfaces
        tst.vif     = bus_if;
        /* tst.amb.vif = bus_if; */
        for(int i = 0; i < 16; i++) begin
            tst.amb.drv_array[i].vif = bus_if;
            tst.amb.mnt_array[i].vif = bus_if;
        end

        //tst.amb.monitor_inst.bus_if = bus_if;
        tst.amb.agt.vif = bus_if;
        tst.amb.gen.vif = bus_if;
      
        fork
            tst.run();
        join_none
        #14500;
        $display("----------------------------");
        $display("Datos perdidos por overflow");
        $display("----------------------------");
        #15000;
        $display("----------------------------");
        #100000;
        $finish;
    end
endmodule
