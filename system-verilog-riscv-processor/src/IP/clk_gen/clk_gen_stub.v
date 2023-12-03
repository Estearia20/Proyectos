// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Aug 22 15:24:05 2022
// Host        : LAPTOP-8OOJFQLK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top clk_gen -prefix
//               clk_gen_ clk_gen_stub.v
// Design      : clk_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_gen(clk_10MHz, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_10MHz,clk_in1" */;
  output clk_10MHz;
  input clk_in1;
endmodule
