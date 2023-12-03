// Simulation time units
//`timescale 1ns/1ps

// Setting parameters for the test
`define ROWS 4
`define COLS 4
`define PCKG_SZ 40
`define FF_DPTH 32
`define BRDCST {8'b1111_1111}
`define FIFOS
`define LIB

// defines for settint the test to run
`define TEST_RDM
//`define TEST_MODO
//`define TEST_SPC
//`define TEST_SPC_VARIAS
//`define TEST_SAME_DEST
//`define TEST_MSRC_DTAR
//`define TEST_RESET
// Files that need to be included
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fifo.sv"
`include "Library.sv"
`include "Router_library.sv"
`include "interface.sv"
`include "mesh.sv"
`include "path_gen.sv"
`include "assertions.sv"
`include "sequence_item.sv"
`include "item.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agente.sv"
`include "scoreboard.sv"
`include "cobertura.sv"
`include "ambiente.sv"
`include "test.sv"

module tb;

    // Clock signal variable and generation
    reg clk;
    always #5 clk = ~clk;

    // Creates the interface instance
    if_dut #(.pckg_sz(`PCKG_SZ)) bus_if(.clk(clk));
 
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
        // Sets DUT input signal to 0
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
    end

    // Execute the test
    initial begin
        // Register the IF at the data base
        uvm_config_db #(virtual if_dut)::set(null, "uvm_test_top", "if_dut", bus_if);
        // Register the FIFO_DPTH parameter
        uvm_config_db #(int)::set(null, "uvm_test_top.agt.drv", "FF_DPTH", `FF_DPTH);
	    // Configura el valor del parámetro pckg_sz para todas las clases necesarias
  	    uvm_config_db #(int)::set(null, "*", "pckg_sz", `PCKG_SZ);
        // Configura el valor del parámetro fifo_dpth para todas las clases necesarias
  	    uvm_config_db #(int)::set(null, "*", "fifo_dpth", `FF_DPTH);
        run_test("test");
    end

endmodule
