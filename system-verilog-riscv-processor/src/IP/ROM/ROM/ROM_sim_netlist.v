// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Oct 30 22:01:58 2022
// Host        : DESKTOP-IB8A7DA running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/jdavi/Documents/TEC/Taller_Digitales/Proyecto_4/lab4-g01_lab4/src/IP/ROM/ROM/ROM_sim_netlist.v
// Design      : ROM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "ROM,dist_mem_gen_v8_0_13,{}" *) (* ORIG_REF_NAME = "xil_defaultlib_ROM" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module ROM
   (a,
    spo);
  input [8:0]a;
  output [31:0]spo;

  wire [8:0]a;
  wire [31:0]spo;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "9" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "512" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "ROM.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  ROM_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule

(* C_ADDR_WIDTH = "9" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "512" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "artix7" *) (* C_HAS_CLK = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "0" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "0" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "1" *) (* C_HAS_WE = "0" *) 
(* C_MEM_INIT_FILE = "ROM.mif" *) (* C_MEM_TYPE = "0" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "1" *) (* C_REG_A_D_INPUTS = "0" *) (* C_REG_DPRA_INPUT = "0" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "32" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_13" *) 
module ROM_dist_mem_gen_v8_0_13
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [8:0]a;
  input [31:0]d;
  input [8:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [31:0]spo;
  output [31:0]dpo;
  output [31:0]qspo;
  output [31:0]qdpo;

  wire \<const0> ;
  wire [8:0]a;
  wire [31:0]\^spo ;

  assign dpo[31] = \<const0> ;
  assign dpo[30] = \<const0> ;
  assign dpo[29] = \<const0> ;
  assign dpo[28] = \<const0> ;
  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qdpo[31] = \<const0> ;
  assign qdpo[30] = \<const0> ;
  assign qdpo[29] = \<const0> ;
  assign qdpo[28] = \<const0> ;
  assign qdpo[27] = \<const0> ;
  assign qdpo[26] = \<const0> ;
  assign qdpo[25] = \<const0> ;
  assign qdpo[24] = \<const0> ;
  assign qdpo[23] = \<const0> ;
  assign qdpo[22] = \<const0> ;
  assign qdpo[21] = \<const0> ;
  assign qdpo[20] = \<const0> ;
  assign qdpo[19] = \<const0> ;
  assign qdpo[18] = \<const0> ;
  assign qdpo[17] = \<const0> ;
  assign qdpo[16] = \<const0> ;
  assign qdpo[15] = \<const0> ;
  assign qdpo[14] = \<const0> ;
  assign qdpo[13] = \<const0> ;
  assign qdpo[12] = \<const0> ;
  assign qdpo[11] = \<const0> ;
  assign qdpo[10] = \<const0> ;
  assign qdpo[9] = \<const0> ;
  assign qdpo[8] = \<const0> ;
  assign qdpo[7] = \<const0> ;
  assign qdpo[6] = \<const0> ;
  assign qdpo[5] = \<const0> ;
  assign qdpo[4] = \<const0> ;
  assign qdpo[3] = \<const0> ;
  assign qdpo[2] = \<const0> ;
  assign qdpo[1] = \<const0> ;
  assign qdpo[0] = \<const0> ;
  assign qspo[31] = \<const0> ;
  assign qspo[30] = \<const0> ;
  assign qspo[29] = \<const0> ;
  assign qspo[28] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[31:4] = \^spo [31:4];
  assign spo[3] = \<const0> ;
  assign spo[2] = \<const0> ;
  assign spo[1] = \^spo [0];
  assign spo[0] = \^spo [0];
  GND GND
       (.G(\<const0> ));
  ROM_dist_mem_gen_v8_0_13_synth \synth_options.dist_mem_inst 
       (.a(a),
        .spo({\^spo [31:4],\^spo [0]}));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_13_rom" *) 
module ROM_dist_mem_gen_v8_0_13_rom
   (spo,
    a);
  output [28:0]spo;
  input [8:0]a;

  wire [8:0]a;
  wire [28:0]spo;
  wire \spo[0]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_2_n_0 ;
  wire \spo[10]_INST_0_i_3_n_0 ;
  wire \spo[10]_INST_0_i_4_n_0 ;
  wire \spo[10]_INST_0_i_5_n_0 ;
  wire \spo[10]_INST_0_i_6_n_0 ;
  wire \spo[10]_INST_0_i_7_n_0 ;
  wire \spo[10]_INST_0_i_8_n_0 ;
  wire \spo[10]_INST_0_i_9_n_0 ;
  wire \spo[11]_INST_0_i_1_n_0 ;
  wire \spo[11]_INST_0_i_2_n_0 ;
  wire \spo[11]_INST_0_i_3_n_0 ;
  wire \spo[11]_INST_0_i_4_n_0 ;
  wire \spo[11]_INST_0_i_5_n_0 ;
  wire \spo[11]_INST_0_i_6_n_0 ;
  wire \spo[11]_INST_0_i_7_n_0 ;
  wire \spo[11]_INST_0_i_8_n_0 ;
  wire \spo[11]_INST_0_i_9_n_0 ;
  wire \spo[12]_INST_0_i_1_n_0 ;
  wire \spo[12]_INST_0_i_2_n_0 ;
  wire \spo[12]_INST_0_i_3_n_0 ;
  wire \spo[12]_INST_0_i_4_n_0 ;
  wire \spo[12]_INST_0_i_5_n_0 ;
  wire \spo[12]_INST_0_i_6_n_0 ;
  wire \spo[12]_INST_0_i_7_n_0 ;
  wire \spo[13]_INST_0_i_1_n_0 ;
  wire \spo[13]_INST_0_i_2_n_0 ;
  wire \spo[13]_INST_0_i_3_n_0 ;
  wire \spo[13]_INST_0_i_4_n_0 ;
  wire \spo[13]_INST_0_i_5_n_0 ;
  wire \spo[13]_INST_0_i_6_n_0 ;
  wire \spo[13]_INST_0_i_7_n_0 ;
  wire \spo[13]_INST_0_i_8_n_0 ;
  wire \spo[13]_INST_0_i_9_n_0 ;
  wire \spo[14]_INST_0_i_1_n_0 ;
  wire \spo[14]_INST_0_i_2_n_0 ;
  wire \spo[14]_INST_0_i_3_n_0 ;
  wire \spo[15]_INST_0_i_1_n_0 ;
  wire \spo[15]_INST_0_i_2_n_0 ;
  wire \spo[15]_INST_0_i_3_n_0 ;
  wire \spo[15]_INST_0_i_4_n_0 ;
  wire \spo[15]_INST_0_i_5_n_0 ;
  wire \spo[15]_INST_0_i_6_n_0 ;
  wire \spo[15]_INST_0_i_7_n_0 ;
  wire \spo[15]_INST_0_i_8_n_0 ;
  wire \spo[15]_INST_0_i_9_n_0 ;
  wire \spo[16]_INST_0_i_1_n_0 ;
  wire \spo[16]_INST_0_i_2_n_0 ;
  wire \spo[16]_INST_0_i_3_n_0 ;
  wire \spo[16]_INST_0_i_4_n_0 ;
  wire \spo[16]_INST_0_i_5_n_0 ;
  wire \spo[16]_INST_0_i_6_n_0 ;
  wire \spo[16]_INST_0_i_7_n_0 ;
  wire \spo[16]_INST_0_i_8_n_0 ;
  wire \spo[16]_INST_0_i_9_n_0 ;
  wire \spo[17]_INST_0_i_1_n_0 ;
  wire \spo[17]_INST_0_i_2_n_0 ;
  wire \spo[17]_INST_0_i_3_n_0 ;
  wire \spo[17]_INST_0_i_4_n_0 ;
  wire \spo[17]_INST_0_i_5_n_0 ;
  wire \spo[17]_INST_0_i_6_n_0 ;
  wire \spo[17]_INST_0_i_7_n_0 ;
  wire \spo[17]_INST_0_i_8_n_0 ;
  wire \spo[17]_INST_0_i_9_n_0 ;
  wire \spo[18]_INST_0_i_1_n_0 ;
  wire \spo[18]_INST_0_i_2_n_0 ;
  wire \spo[18]_INST_0_i_3_n_0 ;
  wire \spo[18]_INST_0_i_4_n_0 ;
  wire \spo[18]_INST_0_i_5_n_0 ;
  wire \spo[18]_INST_0_i_6_n_0 ;
  wire \spo[18]_INST_0_i_7_n_0 ;
  wire \spo[18]_INST_0_i_8_n_0 ;
  wire \spo[18]_INST_0_i_9_n_0 ;
  wire \spo[19]_INST_0_i_1_n_0 ;
  wire \spo[19]_INST_0_i_2_n_0 ;
  wire \spo[19]_INST_0_i_3_n_0 ;
  wire \spo[19]_INST_0_i_4_n_0 ;
  wire \spo[19]_INST_0_i_5_n_0 ;
  wire \spo[19]_INST_0_i_6_n_0 ;
  wire \spo[19]_INST_0_i_7_n_0 ;
  wire \spo[20]_INST_0_i_1_n_0 ;
  wire \spo[20]_INST_0_i_2_n_0 ;
  wire \spo[20]_INST_0_i_3_n_0 ;
  wire \spo[20]_INST_0_i_4_n_0 ;
  wire \spo[20]_INST_0_i_5_n_0 ;
  wire \spo[20]_INST_0_i_6_n_0 ;
  wire \spo[20]_INST_0_i_7_n_0 ;
  wire \spo[20]_INST_0_i_8_n_0 ;
  wire \spo[20]_INST_0_i_9_n_0 ;
  wire \spo[21]_INST_0_i_1_n_0 ;
  wire \spo[21]_INST_0_i_2_n_0 ;
  wire \spo[21]_INST_0_i_3_n_0 ;
  wire \spo[21]_INST_0_i_4_n_0 ;
  wire \spo[21]_INST_0_i_5_n_0 ;
  wire \spo[21]_INST_0_i_6_n_0 ;
  wire \spo[21]_INST_0_i_7_n_0 ;
  wire \spo[21]_INST_0_i_8_n_0 ;
  wire \spo[21]_INST_0_i_9_n_0 ;
  wire \spo[22]_INST_0_i_1_n_0 ;
  wire \spo[22]_INST_0_i_2_n_0 ;
  wire \spo[22]_INST_0_i_3_n_0 ;
  wire \spo[22]_INST_0_i_4_n_0 ;
  wire \spo[22]_INST_0_i_5_n_0 ;
  wire \spo[22]_INST_0_i_6_n_0 ;
  wire \spo[22]_INST_0_i_7_n_0 ;
  wire \spo[22]_INST_0_i_8_n_0 ;
  wire \spo[22]_INST_0_i_9_n_0 ;
  wire \spo[23]_INST_0_i_1_n_0 ;
  wire \spo[23]_INST_0_i_2_n_0 ;
  wire \spo[23]_INST_0_i_3_n_0 ;
  wire \spo[23]_INST_0_i_4_n_0 ;
  wire \spo[23]_INST_0_i_5_n_0 ;
  wire \spo[23]_INST_0_i_6_n_0 ;
  wire \spo[23]_INST_0_i_7_n_0 ;
  wire \spo[23]_INST_0_i_8_n_0 ;
  wire \spo[23]_INST_0_i_9_n_0 ;
  wire \spo[24]_INST_0_i_1_n_0 ;
  wire \spo[24]_INST_0_i_2_n_0 ;
  wire \spo[24]_INST_0_i_3_n_0 ;
  wire \spo[24]_INST_0_i_4_n_0 ;
  wire \spo[24]_INST_0_i_5_n_0 ;
  wire \spo[24]_INST_0_i_6_n_0 ;
  wire \spo[24]_INST_0_i_7_n_0 ;
  wire \spo[24]_INST_0_i_8_n_0 ;
  wire \spo[24]_INST_0_i_9_n_0 ;
  wire \spo[25]_INST_0_i_1_n_0 ;
  wire \spo[25]_INST_0_i_2_n_0 ;
  wire \spo[25]_INST_0_i_3_n_0 ;
  wire \spo[25]_INST_0_i_4_n_0 ;
  wire \spo[25]_INST_0_i_5_n_0 ;
  wire \spo[25]_INST_0_i_6_n_0 ;
  wire \spo[25]_INST_0_i_7_n_0 ;
  wire \spo[25]_INST_0_i_8_n_0 ;
  wire \spo[25]_INST_0_i_9_n_0 ;
  wire \spo[26]_INST_0_i_1_n_0 ;
  wire \spo[26]_INST_0_i_2_n_0 ;
  wire \spo[26]_INST_0_i_3_n_0 ;
  wire \spo[26]_INST_0_i_4_n_0 ;
  wire \spo[26]_INST_0_i_5_n_0 ;
  wire \spo[26]_INST_0_i_6_n_0 ;
  wire \spo[26]_INST_0_i_7_n_0 ;
  wire \spo[26]_INST_0_i_8_n_0 ;
  wire \spo[27]_INST_0_i_1_n_0 ;
  wire \spo[27]_INST_0_i_2_n_0 ;
  wire \spo[27]_INST_0_i_3_n_0 ;
  wire \spo[27]_INST_0_i_4_n_0 ;
  wire \spo[27]_INST_0_i_5_n_0 ;
  wire \spo[28]_INST_0_i_1_n_0 ;
  wire \spo[28]_INST_0_i_2_n_0 ;
  wire \spo[28]_INST_0_i_3_n_0 ;
  wire \spo[28]_INST_0_i_4_n_0 ;
  wire \spo[28]_INST_0_i_5_n_0 ;
  wire \spo[28]_INST_0_i_6_n_0 ;
  wire \spo[28]_INST_0_i_7_n_0 ;
  wire \spo[29]_INST_0_i_1_n_0 ;
  wire \spo[30]_INST_0_i_1_n_0 ;
  wire \spo[30]_INST_0_i_2_n_0 ;
  wire \spo[30]_INST_0_i_3_n_0 ;
  wire \spo[30]_INST_0_i_4_n_0 ;
  wire \spo[30]_INST_0_i_5_n_0 ;
  wire \spo[30]_INST_0_i_6_n_0 ;
  wire \spo[30]_INST_0_i_7_n_0 ;
  wire \spo[30]_INST_0_i_8_n_0 ;
  wire \spo[30]_INST_0_i_9_n_0 ;
  wire \spo[31]_INST_0_i_1_n_0 ;
  wire \spo[31]_INST_0_i_2_n_0 ;
  wire \spo[31]_INST_0_i_3_n_0 ;
  wire \spo[31]_INST_0_i_4_n_0 ;
  wire \spo[31]_INST_0_i_5_n_0 ;
  wire \spo[31]_INST_0_i_6_n_0 ;
  wire \spo[31]_INST_0_i_7_n_0 ;
  wire \spo[31]_INST_0_i_8_n_0 ;
  wire \spo[31]_INST_0_i_9_n_0 ;
  wire \spo[4]_INST_0_i_1_n_0 ;
  wire \spo[4]_INST_0_i_2_n_0 ;
  wire \spo[4]_INST_0_i_3_n_0 ;
  wire \spo[4]_INST_0_i_4_n_0 ;
  wire \spo[4]_INST_0_i_5_n_0 ;
  wire \spo[4]_INST_0_i_6_n_0 ;
  wire \spo[4]_INST_0_i_7_n_0 ;
  wire \spo[4]_INST_0_i_8_n_0 ;
  wire \spo[4]_INST_0_i_9_n_0 ;
  wire \spo[5]_INST_0_i_1_n_0 ;
  wire \spo[5]_INST_0_i_2_n_0 ;
  wire \spo[5]_INST_0_i_3_n_0 ;
  wire \spo[5]_INST_0_i_4_n_0 ;
  wire \spo[5]_INST_0_i_5_n_0 ;
  wire \spo[5]_INST_0_i_6_n_0 ;
  wire \spo[5]_INST_0_i_7_n_0 ;
  wire \spo[5]_INST_0_i_8_n_0 ;
  wire \spo[5]_INST_0_i_9_n_0 ;
  wire \spo[6]_INST_0_i_1_n_0 ;
  wire \spo[6]_INST_0_i_2_n_0 ;
  wire \spo[6]_INST_0_i_3_n_0 ;
  wire \spo[6]_INST_0_i_4_n_0 ;
  wire \spo[6]_INST_0_i_5_n_0 ;
  wire \spo[6]_INST_0_i_6_n_0 ;
  wire \spo[6]_INST_0_i_7_n_0 ;
  wire \spo[6]_INST_0_i_8_n_0 ;
  wire \spo[6]_INST_0_i_9_n_0 ;
  wire \spo[7]_INST_0_i_1_n_0 ;
  wire \spo[7]_INST_0_i_2_n_0 ;
  wire \spo[7]_INST_0_i_3_n_0 ;
  wire \spo[7]_INST_0_i_4_n_0 ;
  wire \spo[7]_INST_0_i_5_n_0 ;
  wire \spo[7]_INST_0_i_6_n_0 ;
  wire \spo[7]_INST_0_i_7_n_0 ;
  wire \spo[7]_INST_0_i_8_n_0 ;
  wire \spo[7]_INST_0_i_9_n_0 ;
  wire \spo[8]_INST_0_i_1_n_0 ;
  wire \spo[8]_INST_0_i_2_n_0 ;
  wire \spo[8]_INST_0_i_3_n_0 ;
  wire \spo[8]_INST_0_i_4_n_0 ;
  wire \spo[8]_INST_0_i_5_n_0 ;
  wire \spo[8]_INST_0_i_6_n_0 ;
  wire \spo[8]_INST_0_i_7_n_0 ;
  wire \spo[8]_INST_0_i_8_n_0 ;
  wire \spo[8]_INST_0_i_9_n_0 ;
  wire \spo[9]_INST_0_i_1_n_0 ;
  wire \spo[9]_INST_0_i_2_n_0 ;
  wire \spo[9]_INST_0_i_3_n_0 ;
  wire \spo[9]_INST_0_i_4_n_0 ;
  wire \spo[9]_INST_0_i_5_n_0 ;
  wire \spo[9]_INST_0_i_6_n_0 ;
  wire \spo[9]_INST_0_i_7_n_0 ;
  wire \spo[9]_INST_0_i_8_n_0 ;
  wire \spo[9]_INST_0_i_9_n_0 ;

  LUT6 #(
    .INIT(64'h51555555FFFFFFFF)) 
    \spo[0]_INST_0 
       (.I0(a[7]),
        .I1(a[4]),
        .I2(\spo[0]_INST_0_i_1_n_0 ),
        .I3(a[5]),
        .I4(a[6]),
        .I5(a[8]),
        .O(spo[0]));
  LUT2 #(
    .INIT(4'h7)) 
    \spo[0]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .O(\spo[0]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[10]_INST_0 
       (.I0(\spo[10]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[10]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[10]_INST_0_i_3_n_0 ),
        .O(spo[7]));
  MUXF7 \spo[10]_INST_0_i_1 
       (.I0(\spo[10]_INST_0_i_4_n_0 ),
        .I1(\spo[10]_INST_0_i_5_n_0 ),
        .O(\spo[10]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_2 
       (.I0(\spo[10]_INST_0_i_6_n_0 ),
        .I1(\spo[10]_INST_0_i_7_n_0 ),
        .O(\spo[10]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_3 
       (.I0(\spo[10]_INST_0_i_8_n_0 ),
        .I1(\spo[10]_INST_0_i_9_n_0 ),
        .O(\spo[10]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h0205011612156737)) 
    \spo[10]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[10]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7304EF3B10591149)) 
    \spo[10]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[10]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h284993344F334109)) 
    \spo[10]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[10]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h46DF9A2AF9AA26D4)) 
    \spo[10]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[10]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hB27D5FC728AAA0B8)) 
    \spo[10]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[10]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h4E21E8FFF53FFE48)) 
    \spo[10]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[10]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[11]_INST_0 
       (.I0(\spo[11]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[11]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[11]_INST_0_i_3_n_0 ),
        .O(spo[8]));
  MUXF7 \spo[11]_INST_0_i_1 
       (.I0(\spo[11]_INST_0_i_4_n_0 ),
        .I1(\spo[11]_INST_0_i_5_n_0 ),
        .O(\spo[11]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_2 
       (.I0(\spo[11]_INST_0_i_6_n_0 ),
        .I1(\spo[11]_INST_0_i_7_n_0 ),
        .O(\spo[11]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_3 
       (.I0(\spo[11]_INST_0_i_8_n_0 ),
        .I1(\spo[11]_INST_0_i_9_n_0 ),
        .O(\spo[11]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h3325612642255443)) 
    \spo[11]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[11]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h67000DF9901D810D)) 
    \spo[11]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[11]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hD428BCD2849D0424)) 
    \spo[11]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[11]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h442DC96CED5FCE09)) 
    \spo[11]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[11]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hA2BD6553000E884C)) 
    \spo[11]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[11]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h81B80062246F66CC)) 
    \spo[11]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[11]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3000BBBB30008888)) 
    \spo[12]_INST_0 
       (.I0(\spo[12]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[12]_INST_0_i_2_n_0 ),
        .I3(a[6]),
        .I4(a[7]),
        .I5(\spo[12]_INST_0_i_3_n_0 ),
        .O(spo[9]));
  MUXF7 \spo[12]_INST_0_i_1 
       (.I0(\spo[12]_INST_0_i_4_n_0 ),
        .I1(\spo[12]_INST_0_i_5_n_0 ),
        .O(\spo[12]_INST_0_i_1_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h0804011108002000)) 
    \spo[12]_INST_0_i_2 
       (.I0(a[4]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[0]),
        .I5(a[5]),
        .O(\spo[12]_INST_0_i_2_n_0 ));
  MUXF7 \spo[12]_INST_0_i_3 
       (.I0(\spo[12]_INST_0_i_6_n_0 ),
        .I1(\spo[12]_INST_0_i_7_n_0 ),
        .O(\spo[12]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hC080908208211940)) 
    \spo[12]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[12]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0040100000020A80)) 
    \spo[12]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[1]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[0]),
        .I5(a[5]),
        .O(\spo[12]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000008243904)) 
    \spo[12]_INST_0_i_6 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[12]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000400000)) 
    \spo[12]_INST_0_i_7 
       (.I0(a[5]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[12]_INST_0_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[13]_INST_0 
       (.I0(\spo[13]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[13]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[13]_INST_0_i_3_n_0 ),
        .O(spo[10]));
  MUXF7 \spo[13]_INST_0_i_1 
       (.I0(\spo[13]_INST_0_i_4_n_0 ),
        .I1(\spo[13]_INST_0_i_5_n_0 ),
        .O(\spo[13]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_2 
       (.I0(\spo[13]_INST_0_i_6_n_0 ),
        .I1(\spo[13]_INST_0_i_7_n_0 ),
        .O(\spo[13]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_3 
       (.I0(\spo[13]_INST_0_i_8_n_0 ),
        .I1(\spo[13]_INST_0_i_9_n_0 ),
        .O(\spo[13]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h055850000A484002)) 
    \spo[13]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[13]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h000000E0DD80CD91)) 
    \spo[13]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[13]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0300440930882290)) 
    \spo[13]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[13]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h5550000040050528)) 
    \spo[13]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[13]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h6088AA022AA00088)) 
    \spo[13]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[13]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h00000A1146008010)) 
    \spo[13]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[13]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000C0A0C0A0)) 
    \spo[14]_INST_0 
       (.I0(\spo[14]_INST_0_i_1_n_0 ),
        .I1(\spo[14]_INST_0_i_2_n_0 ),
        .I2(a[8]),
        .I3(a[6]),
        .I4(\spo[14]_INST_0_i_3_n_0 ),
        .I5(a[7]),
        .O(spo[11]));
  LUT6 #(
    .INIT(64'h0010000100022040)) 
    \spo[14]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[14]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000100002000000)) 
    \spo[14]_INST_0_i_2 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[14]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \spo[14]_INST_0_i_3 
       (.I0(a[5]),
        .I1(a[1]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[14]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[15]_INST_0 
       (.I0(\spo[15]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[15]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[15]_INST_0_i_3_n_0 ),
        .O(spo[12]));
  MUXF7 \spo[15]_INST_0_i_1 
       (.I0(\spo[15]_INST_0_i_4_n_0 ),
        .I1(\spo[15]_INST_0_i_5_n_0 ),
        .O(\spo[15]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_2 
       (.I0(\spo[15]_INST_0_i_6_n_0 ),
        .I1(\spo[15]_INST_0_i_7_n_0 ),
        .O(\spo[15]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_3 
       (.I0(\spo[15]_INST_0_i_8_n_0 ),
        .I1(\spo[15]_INST_0_i_9_n_0 ),
        .O(\spo[15]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hD326EC4444C0000B)) 
    \spo[15]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[15]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h266600426A811154)) 
    \spo[15]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[15]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0338C4AA75338994)) 
    \spo[15]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[15]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h554E00245013B9A8)) 
    \spo[15]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[15]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h620990643600815C)) 
    \spo[15]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[15]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h218C648D24AC640C)) 
    \spo[15]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[15]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[16]_INST_0 
       (.I0(\spo[16]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[16]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[16]_INST_0_i_3_n_0 ),
        .O(spo[13]));
  MUXF7 \spo[16]_INST_0_i_1 
       (.I0(\spo[16]_INST_0_i_4_n_0 ),
        .I1(\spo[16]_INST_0_i_5_n_0 ),
        .O(\spo[16]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_2 
       (.I0(\spo[16]_INST_0_i_6_n_0 ),
        .I1(\spo[16]_INST_0_i_7_n_0 ),
        .O(\spo[16]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_3 
       (.I0(\spo[16]_INST_0_i_8_n_0 ),
        .I1(\spo[16]_INST_0_i_9_n_0 ),
        .O(\spo[16]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hA284032622B08805)) 
    \spo[16]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[16]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h2226DDDA2CC9CEE4)) 
    \spo[16]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[16]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000040000000)) 
    \spo[16]_INST_0_i_6 
       (.I0(a[5]),
        .I1(a[1]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[16]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0A020488A0006180)) 
    \spo[16]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[16]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0A7A222280999C20)) 
    \spo[16]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[16]_INST_0_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h00000100)) 
    \spo[16]_INST_0_i_9 
       (.I0(a[5]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[1]),
        .I4(a[4]),
        .O(\spo[16]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[17]_INST_0 
       (.I0(\spo[17]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[17]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[17]_INST_0_i_3_n_0 ),
        .O(spo[14]));
  MUXF7 \spo[17]_INST_0_i_1 
       (.I0(\spo[17]_INST_0_i_4_n_0 ),
        .I1(\spo[17]_INST_0_i_5_n_0 ),
        .O(\spo[17]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_2 
       (.I0(\spo[17]_INST_0_i_6_n_0 ),
        .I1(\spo[17]_INST_0_i_7_n_0 ),
        .O(\spo[17]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_3 
       (.I0(\spo[17]_INST_0_i_8_n_0 ),
        .I1(\spo[17]_INST_0_i_9_n_0 ),
        .O(\spo[17]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h82A184009A102D01)) 
    \spo[17]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[2]),
        .O(\spo[17]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0013001042112111)) 
    \spo[17]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[2]),
        .O(\spo[17]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h20F00D05D01F9050)) 
    \spo[17]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[17]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8004106200476600)) 
    \spo[17]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[17]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hE00083A60200C22C)) 
    \spo[17]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[17]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h20204C4C2004DCDD)) 
    \spo[17]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[17]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[18]_INST_0 
       (.I0(\spo[18]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[18]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[18]_INST_0_i_3_n_0 ),
        .O(spo[15]));
  MUXF7 \spo[18]_INST_0_i_1 
       (.I0(\spo[18]_INST_0_i_4_n_0 ),
        .I1(\spo[18]_INST_0_i_5_n_0 ),
        .O(\spo[18]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_2 
       (.I0(\spo[18]_INST_0_i_6_n_0 ),
        .I1(\spo[18]_INST_0_i_7_n_0 ),
        .O(\spo[18]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_3 
       (.I0(\spo[18]_INST_0_i_8_n_0 ),
        .I1(\spo[18]_INST_0_i_9_n_0 ),
        .O(\spo[18]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h2000110213320155)) 
    \spo[18]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[18]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h2262001026015044)) 
    \spo[18]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[18]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h20000010D0050040)) 
    \spo[18]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[18]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCC80440304800880)) 
    \spo[18]_INST_0_i_7 
       (.I0(a[0]),
        .I1(a[4]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[5]),
        .O(\spo[18]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hE09C08A2033288EC)) 
    \spo[18]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[18]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h284044040004D4D5)) 
    \spo[18]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[18]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h3088308830BB3088)) 
    \spo[19]_INST_0 
       (.I0(\spo[19]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[19]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[19]_INST_0_i_3_n_0 ),
        .I5(a[6]),
        .O(spo[16]));
  MUXF7 \spo[19]_INST_0_i_1 
       (.I0(\spo[19]_INST_0_i_4_n_0 ),
        .I1(\spo[19]_INST_0_i_5_n_0 ),
        .O(\spo[19]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0_i_2 
       (.I0(\spo[19]_INST_0_i_6_n_0 ),
        .I1(\spo[19]_INST_0_i_7_n_0 ),
        .O(\spo[19]_INST_0_i_2_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h601400A2031000EC)) 
    \spo[19]_INST_0_i_3 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[19]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0221040212102541)) 
    \spo[19]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[2]),
        .O(\spo[19]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h004E001000091800)) 
    \spo[19]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[19]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h1000008000000400)) 
    \spo[19]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[19]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h820604C828066580)) 
    \spo[19]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[19]_INST_0_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[20]_INST_0 
       (.I0(\spo[20]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[20]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[20]_INST_0_i_3_n_0 ),
        .O(spo[17]));
  MUXF7 \spo[20]_INST_0_i_1 
       (.I0(\spo[20]_INST_0_i_4_n_0 ),
        .I1(\spo[20]_INST_0_i_5_n_0 ),
        .O(\spo[20]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_2 
       (.I0(\spo[20]_INST_0_i_6_n_0 ),
        .I1(\spo[20]_INST_0_i_7_n_0 ),
        .O(\spo[20]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_3 
       (.I0(\spo[20]_INST_0_i_8_n_0 ),
        .I1(\spo[20]_INST_0_i_9_n_0 ),
        .O(\spo[20]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h02040F6514310400)) 
    \spo[20]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[20]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h316300D001020008)) 
    \spo[20]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[20]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h5B6230BC78B6AFB9)) 
    \spo[20]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[20]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h11A88059014192C1)) 
    \spo[20]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[20]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hA5480A20D00AA040)) 
    \spo[20]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[20]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h9CD1A0E59D9FA5B4)) 
    \spo[20]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[20]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[21]_INST_0 
       (.I0(\spo[21]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[21]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[21]_INST_0_i_3_n_0 ),
        .O(spo[18]));
  MUXF7 \spo[21]_INST_0_i_1 
       (.I0(\spo[21]_INST_0_i_4_n_0 ),
        .I1(\spo[21]_INST_0_i_5_n_0 ),
        .O(\spo[21]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_2 
       (.I0(\spo[21]_INST_0_i_6_n_0 ),
        .I1(\spo[21]_INST_0_i_7_n_0 ),
        .O(\spo[21]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_3 
       (.I0(\spo[21]_INST_0_i_8_n_0 ),
        .I1(\spo[21]_INST_0_i_9_n_0 ),
        .O(\spo[21]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h0004264481020000)) 
    \spo[21]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[21]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h771249E825194880)) 
    \spo[21]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[21]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h03BC68F240890B58)) 
    \spo[21]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[21]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00020000452C730C)) 
    \spo[21]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[1]),
        .I4(a[0]),
        .I5(a[5]),
        .O(\spo[21]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h988800044C208A04)) 
    \spo[21]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[21]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAB41406F480B41B6)) 
    \spo[21]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[21]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[22]_INST_0 
       (.I0(\spo[22]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[22]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[22]_INST_0_i_3_n_0 ),
        .O(spo[19]));
  MUXF7 \spo[22]_INST_0_i_1 
       (.I0(\spo[22]_INST_0_i_4_n_0 ),
        .I1(\spo[22]_INST_0_i_5_n_0 ),
        .O(\spo[22]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_2 
       (.I0(\spo[22]_INST_0_i_6_n_0 ),
        .I1(\spo[22]_INST_0_i_7_n_0 ),
        .O(\spo[22]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_3 
       (.I0(\spo[22]_INST_0_i_8_n_0 ),
        .I1(\spo[22]_INST_0_i_9_n_0 ),
        .O(\spo[22]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h02070744346E023F)) 
    \spo[22]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[22]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h235A35010100C09C)) 
    \spo[22]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[22]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h4B2204C280DE715D)) 
    \spo[22]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[0]),
        .I5(a[1]),
        .O(\spo[22]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hC00004484D012C45)) 
    \spo[22]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[22]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h3141084000000346)) 
    \spo[22]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[22]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAD00CA7880427278)) 
    \spo[22]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[1]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[22]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[23]_INST_0 
       (.I0(\spo[23]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[23]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[23]_INST_0_i_3_n_0 ),
        .O(spo[20]));
  MUXF7 \spo[23]_INST_0_i_1 
       (.I0(\spo[23]_INST_0_i_4_n_0 ),
        .I1(\spo[23]_INST_0_i_5_n_0 ),
        .O(\spo[23]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_2 
       (.I0(\spo[23]_INST_0_i_6_n_0 ),
        .I1(\spo[23]_INST_0_i_7_n_0 ),
        .O(\spo[23]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_3 
       (.I0(\spo[23]_INST_0_i_8_n_0 ),
        .I1(\spo[23]_INST_0_i_9_n_0 ),
        .O(\spo[23]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hD38787D61D644854)) 
    \spo[23]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[23]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h557D17194F4C8ABC)) 
    \spo[23]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[23]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h138468B1848D8B44)) 
    \spo[23]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[23]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h93EC032160B352D8)) 
    \spo[23]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[23]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h84DA1C20CCA51A10)) 
    \spo[23]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[23]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h9F55760D988345D8)) 
    \spo[23]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[23]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[24]_INST_0 
       (.I0(\spo[24]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[24]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[24]_INST_0_i_3_n_0 ),
        .O(spo[21]));
  MUXF7 \spo[24]_INST_0_i_1 
       (.I0(\spo[24]_INST_0_i_4_n_0 ),
        .I1(\spo[24]_INST_0_i_5_n_0 ),
        .O(\spo[24]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[24]_INST_0_i_2 
       (.I0(\spo[24]_INST_0_i_6_n_0 ),
        .I1(\spo[24]_INST_0_i_7_n_0 ),
        .O(\spo[24]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[24]_INST_0_i_3 
       (.I0(\spo[24]_INST_0_i_8_n_0 ),
        .I1(\spo[24]_INST_0_i_9_n_0 ),
        .O(\spo[24]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h11010140B2400033)) 
    \spo[24]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[24]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h100601C0600100D4)) 
    \spo[24]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[24]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h1015008030022E90)) 
    \spo[24]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[24]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hC008C66050E98398)) 
    \spo[24]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[24]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000200860050000)) 
    \spo[24]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[1]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[24]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h04B020CC00210450)) 
    \spo[24]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[24]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[25]_INST_0 
       (.I0(\spo[25]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[25]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[25]_INST_0_i_3_n_0 ),
        .O(spo[22]));
  MUXF7 \spo[25]_INST_0_i_1 
       (.I0(\spo[25]_INST_0_i_4_n_0 ),
        .I1(\spo[25]_INST_0_i_5_n_0 ),
        .O(\spo[25]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[25]_INST_0_i_2 
       (.I0(\spo[25]_INST_0_i_6_n_0 ),
        .I1(\spo[25]_INST_0_i_7_n_0 ),
        .O(\spo[25]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[25]_INST_0_i_3 
       (.I0(\spo[25]_INST_0_i_8_n_0 ),
        .I1(\spo[25]_INST_0_i_9_n_0 ),
        .O(\spo[25]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h066C6489EE64C808)) 
    \spo[25]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[25]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0206202442094922)) 
    \spo[25]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[25]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h84557179BC3DC8A0)) 
    \spo[25]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[0]),
        .I5(a[1]),
        .O(\spo[25]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h02008000C11E64B4)) 
    \spo[25]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[3]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[0]),
        .I5(a[5]),
        .O(\spo[25]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h800D2058097D6741)) 
    \spo[25]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[2]),
        .O(\spo[25]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0271195138E88C00)) 
    \spo[25]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[1]),
        .I4(a[0]),
        .I5(a[2]),
        .O(\spo[25]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \spo[26]_INST_0 
       (.I0(\spo[31]_INST_0_i_1_n_0 ),
        .I1(a[6]),
        .I2(\spo[26]_INST_0_i_1_n_0 ),
        .I3(a[7]),
        .I4(a[8]),
        .I5(\spo[26]_INST_0_i_2_n_0 ),
        .O(spo[23]));
  LUT6 #(
    .INIT(64'h0000800000094900)) 
    \spo[26]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[26]_INST_0_i_1_n_0 ));
  MUXF8 \spo[26]_INST_0_i_2 
       (.I0(\spo[26]_INST_0_i_3_n_0 ),
        .I1(\spo[26]_INST_0_i_4_n_0 ),
        .O(\spo[26]_INST_0_i_2_n_0 ),
        .S(a[7]));
  MUXF7 \spo[26]_INST_0_i_3 
       (.I0(\spo[26]_INST_0_i_5_n_0 ),
        .I1(\spo[26]_INST_0_i_6_n_0 ),
        .O(\spo[26]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[26]_INST_0_i_4 
       (.I0(\spo[26]_INST_0_i_7_n_0 ),
        .I1(\spo[26]_INST_0_i_8_n_0 ),
        .O(\spo[26]_INST_0_i_4_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h80A30200000080A0)) 
    \spo[26]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[26]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h2204400408008540)) 
    \spo[26]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[26]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hA800005040852800)) 
    \spo[26]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[1]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[26]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0801080080020020)) 
    \spo[26]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[26]_INST_0_i_8_n_0 ));
  MUXF7 \spo[27]_INST_0 
       (.I0(\spo[27]_INST_0_i_1_n_0 ),
        .I1(\spo[27]_INST_0_i_2_n_0 ),
        .O(spo[24]),
        .S(a[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[27]_INST_0_i_1 
       (.I0(\spo[28]_INST_0_i_3_n_0 ),
        .I1(\spo[27]_INST_0_i_3_n_0 ),
        .I2(a[7]),
        .I3(\spo[27]_INST_0_i_4_n_0 ),
        .I4(a[6]),
        .I5(\spo[27]_INST_0_i_5_n_0 ),
        .O(\spo[27]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \spo[27]_INST_0_i_2 
       (.I0(\spo[29]_INST_0_i_1_n_0 ),
        .I1(a[6]),
        .I2(\spo[30]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .O(\spo[27]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hA000044444201000)) 
    \spo[27]_INST_0_i_3 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[27]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4260001008654050)) 
    \spo[27]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[27]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h82008200010882C4)) 
    \spo[27]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[27]_INST_0_i_5_n_0 ));
  MUXF7 \spo[28]_INST_0 
       (.I0(\spo[28]_INST_0_i_1_n_0 ),
        .I1(\spo[28]_INST_0_i_2_n_0 ),
        .O(spo[25]),
        .S(a[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[28]_INST_0_i_1 
       (.I0(\spo[28]_INST_0_i_3_n_0 ),
        .I1(\spo[28]_INST_0_i_4_n_0 ),
        .I2(a[7]),
        .I3(\spo[28]_INST_0_i_5_n_0 ),
        .I4(a[6]),
        .I5(\spo[28]_INST_0_i_6_n_0 ),
        .O(\spo[28]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \spo[28]_INST_0_i_2 
       (.I0(\spo[29]_INST_0_i_1_n_0 ),
        .I1(a[6]),
        .I2(\spo[28]_INST_0_i_7_n_0 ),
        .I3(a[7]),
        .O(\spo[28]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0001000080020000)) 
    \spo[28]_INST_0_i_3 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[28]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8040000000315002)) 
    \spo[28]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[28]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h4060004028754000)) 
    \spo[28]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[28]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h82008200018882C0)) 
    \spo[28]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[28]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000040094900)) 
    \spo[28]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[28]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \spo[29]_INST_0 
       (.I0(\spo[29]_INST_0_i_1_n_0 ),
        .I1(a[6]),
        .I2(\spo[31]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(a[8]),
        .I5(\spo[31]_INST_0_i_3_n_0 ),
        .O(spo[26]));
  LUT6 #(
    .INIT(64'h0221100404000400)) 
    \spo[29]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[29]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \spo[30]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(a[6]),
        .I2(\spo[30]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(a[8]),
        .I5(\spo[30]_INST_0_i_3_n_0 ),
        .O(spo[27]));
  LUT6 #(
    .INIT(64'h0223100444000404)) 
    \spo[30]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[30]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000800040094900)) 
    \spo[30]_INST_0_i_2 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[30]_INST_0_i_2_n_0 ));
  MUXF8 \spo[30]_INST_0_i_3 
       (.I0(\spo[30]_INST_0_i_4_n_0 ),
        .I1(\spo[30]_INST_0_i_5_n_0 ),
        .O(\spo[30]_INST_0_i_3_n_0 ),
        .S(a[7]));
  MUXF7 \spo[30]_INST_0_i_4 
       (.I0(\spo[30]_INST_0_i_6_n_0 ),
        .I1(\spo[30]_INST_0_i_7_n_0 ),
        .O(\spo[30]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0_i_5 
       (.I0(\spo[30]_INST_0_i_8_n_0 ),
        .I1(\spo[30]_INST_0_i_9_n_0 ),
        .O(\spo[30]_INST_0_i_5_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h880108AC22000200)) 
    \spo[30]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[0]),
        .I5(a[5]),
        .O(\spo[30]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h1260800008254000)) 
    \spo[30]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[30]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h984400000035C400)) 
    \spo[30]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[30]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0880000020071200)) 
    \spo[30]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[3]),
        .I2(a[5]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[30]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \spo[31]_INST_0 
       (.I0(\spo[31]_INST_0_i_1_n_0 ),
        .I1(a[6]),
        .I2(\spo[31]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(a[8]),
        .I5(\spo[31]_INST_0_i_3_n_0 ),
        .O(spo[28]));
  LUT6 #(
    .INIT(64'h0221100444000400)) 
    \spo[31]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[31]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000080004009C900)) 
    \spo[31]_INST_0_i_2 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[31]_INST_0_i_2_n_0 ));
  MUXF8 \spo[31]_INST_0_i_3 
       (.I0(\spo[31]_INST_0_i_4_n_0 ),
        .I1(\spo[31]_INST_0_i_5_n_0 ),
        .O(\spo[31]_INST_0_i_3_n_0 ),
        .S(a[7]));
  MUXF7 \spo[31]_INST_0_i_4 
       (.I0(\spo[31]_INST_0_i_6_n_0 ),
        .I1(\spo[31]_INST_0_i_7_n_0 ),
        .O(\spo[31]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0_i_5 
       (.I0(\spo[31]_INST_0_i_8_n_0 ),
        .I1(\spo[31]_INST_0_i_9_n_0 ),
        .O(\spo[31]_INST_0_i_5_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h82A30200000080A0)) 
    \spo[31]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[31]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0260000008254000)) 
    \spo[31]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[31]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hC0000030300B0000)) 
    \spo[31]_INST_0_i_8 
       (.I0(a[1]),
        .I1(a[4]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[31]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h2000000001020060)) 
    \spo[31]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[31]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[4]_INST_0 
       (.I0(\spo[4]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[4]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[4]_INST_0_i_3_n_0 ),
        .O(spo[1]));
  MUXF7 \spo[4]_INST_0_i_1 
       (.I0(\spo[4]_INST_0_i_4_n_0 ),
        .I1(\spo[4]_INST_0_i_5_n_0 ),
        .O(\spo[4]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_2 
       (.I0(\spo[4]_INST_0_i_6_n_0 ),
        .I1(\spo[4]_INST_0_i_7_n_0 ),
        .O(\spo[4]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_3 
       (.I0(\spo[4]_INST_0_i_8_n_0 ),
        .I1(\spo[4]_INST_0_i_9_n_0 ),
        .O(\spo[4]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hC9CA899F8FBBBEBD)) 
    \spo[4]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[1]),
        .I5(a[2]),
        .O(\spo[4]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h515522725312226A)) 
    \spo[4]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[4]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h583088A64314C429)) 
    \spo[4]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[4]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h02A8BACC1D404D55)) 
    \spo[4]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[4]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h1554545455575557)) 
    \spo[4]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[4]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hB5DD853F8F0A8A0A)) 
    \spo[4]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[4]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[5]_INST_0 
       (.I0(\spo[5]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[5]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[5]_INST_0_i_3_n_0 ),
        .O(spo[2]));
  MUXF7 \spo[5]_INST_0_i_1 
       (.I0(\spo[5]_INST_0_i_4_n_0 ),
        .I1(\spo[5]_INST_0_i_5_n_0 ),
        .O(\spo[5]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_2 
       (.I0(\spo[5]_INST_0_i_6_n_0 ),
        .I1(\spo[5]_INST_0_i_7_n_0 ),
        .O(\spo[5]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_3 
       (.I0(\spo[5]_INST_0_i_8_n_0 ),
        .I1(\spo[5]_INST_0_i_9_n_0 ),
        .O(\spo[5]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h3357277235440455)) 
    \spo[5]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[5]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h26224D8DAC0D5C94)) 
    \spo[5]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[5]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hF7FF77D9BCEF3FF6)) 
    \spo[5]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[5]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFF57EEBFADF3FBC3)) 
    \spo[5]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[5]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hE82BA3A98228A8A8)) 
    \spo[5]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[5]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h668EECC0CCCD5DDD)) 
    \spo[5]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[5]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[6]_INST_0 
       (.I0(\spo[6]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[6]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[6]_INST_0_i_3_n_0 ),
        .O(spo[3]));
  MUXF7 \spo[6]_INST_0_i_1 
       (.I0(\spo[6]_INST_0_i_4_n_0 ),
        .I1(\spo[6]_INST_0_i_5_n_0 ),
        .O(\spo[6]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_2 
       (.I0(\spo[6]_INST_0_i_6_n_0 ),
        .I1(\spo[6]_INST_0_i_7_n_0 ),
        .O(\spo[6]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_3 
       (.I0(\spo[6]_INST_0_i_8_n_0 ),
        .I1(\spo[6]_INST_0_i_9_n_0 ),
        .O(\spo[6]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h2221100454200410)) 
    \spo[6]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[6]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h26AC0010220D0D04)) 
    \spo[6]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[6]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hA84C3139C6F35406)) 
    \spo[6]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[6]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hA801E2B21722AE82)) 
    \spo[6]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[6]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h882B2321820088A8)) 
    \spo[6]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[6]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h60204CCC24805CDD)) 
    \spo[6]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[6]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[7]_INST_0 
       (.I0(\spo[7]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[7]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[7]_INST_0_i_3_n_0 ),
        .O(spo[4]));
  MUXF7 \spo[7]_INST_0_i_1 
       (.I0(\spo[7]_INST_0_i_4_n_0 ),
        .I1(\spo[7]_INST_0_i_5_n_0 ),
        .O(\spo[7]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_2 
       (.I0(\spo[7]_INST_0_i_6_n_0 ),
        .I1(\spo[7]_INST_0_i_7_n_0 ),
        .O(\spo[7]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_3 
       (.I0(\spo[7]_INST_0_i_8_n_0 ),
        .I1(\spo[7]_INST_0_i_9_n_0 ),
        .O(\spo[7]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hCE64D884618C2409)) 
    \spo[7]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[7]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0454300BDFA92108)) 
    \spo[7]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[7]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hC28E80C643007109)) 
    \spo[7]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[7]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h208810061B000610)) 
    \spo[7]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[7]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h87DD194D71624C33)) 
    \spo[7]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[7]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0BFBA339C1207820)) 
    \spo[7]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[2]),
        .O(\spo[7]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[8]_INST_0 
       (.I0(\spo[8]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[8]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[8]_INST_0_i_3_n_0 ),
        .O(spo[5]));
  MUXF7 \spo[8]_INST_0_i_1 
       (.I0(\spo[8]_INST_0_i_4_n_0 ),
        .I1(\spo[8]_INST_0_i_5_n_0 ),
        .O(\spo[8]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_2 
       (.I0(\spo[8]_INST_0_i_6_n_0 ),
        .I1(\spo[8]_INST_0_i_7_n_0 ),
        .O(\spo[8]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_3 
       (.I0(\spo[8]_INST_0_i_8_n_0 ),
        .I1(\spo[8]_INST_0_i_9_n_0 ),
        .O(\spo[8]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h8843A83242C89FE5)) 
    \spo[8]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[8]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h4015901243D2A22A)) 
    \spo[8]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[8]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0008000070040040)) 
    \spo[8]_INST_0_i_6 
       (.I0(a[2]),
        .I1(a[4]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[5]),
        .O(\spo[8]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00A4008001018001)) 
    \spo[8]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[8]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h1054551140159202)) 
    \spo[8]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[8]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hA00000004A1A5232)) 
    \spo[8]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[1]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[2]),
        .I5(a[5]),
        .O(\spo[8]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[9]_INST_0 
       (.I0(\spo[9]_INST_0_i_1_n_0 ),
        .I1(a[8]),
        .I2(\spo[9]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[9]_INST_0_i_3_n_0 ),
        .O(spo[6]));
  MUXF7 \spo[9]_INST_0_i_1 
       (.I0(\spo[9]_INST_0_i_4_n_0 ),
        .I1(\spo[9]_INST_0_i_5_n_0 ),
        .O(\spo[9]_INST_0_i_1_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_2 
       (.I0(\spo[9]_INST_0_i_6_n_0 ),
        .I1(\spo[9]_INST_0_i_7_n_0 ),
        .O(\spo[9]_INST_0_i_2_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_3 
       (.I0(\spo[9]_INST_0_i_8_n_0 ),
        .I1(\spo[9]_INST_0_i_9_n_0 ),
        .O(\spo[9]_INST_0_i_3_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'h9EB9F4C6E7A6E5D1)) 
    \spo[9]_INST_0_i_4 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[1]),
        .I5(a[2]),
        .O(\spo[9]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h571316BC942D058D)) 
    \spo[9]_INST_0_i_5 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[9]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h48F38C1E8FCFE4DB)) 
    \spo[9]_INST_0_i_6 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[9]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hA9950FC310E56FBB)) 
    \spo[9]_INST_0_i_7 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[9]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hB70008A238C70A42)) 
    \spo[9]_INST_0_i_8 
       (.I0(a[4]),
        .I1(a[0]),
        .I2(a[5]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[9]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h202F40A771CC7A2B)) 
    \spo[9]_INST_0_i_9 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[9]_INST_0_i_9_n_0 ));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_13_synth" *) 
module ROM_dist_mem_gen_v8_0_13_synth
   (spo,
    a);
  output [28:0]spo;
  input [8:0]a;

  wire [8:0]a;
  wire [28:0]spo;

  ROM_dist_mem_gen_v8_0_13_rom \gen_rom.rom_inst 
       (.a(a),
        .spo(spo));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
