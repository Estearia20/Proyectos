// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Oct 29 21:53:12 2022
// Host        : DESKTOP-IB8A7DA running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/jdavi/Documents/TEC/Taller_Digitales/Proyecto_4/lab4-g01_lab4/src/IP/ROM_peri/ROM_peri_stub.v
// Design      : ROM_peri
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.1" *)
module ROM_peri(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[6:0],spo[31:0]" */;
  input [6:0]a;
  output [31:0]spo;
endmodule
