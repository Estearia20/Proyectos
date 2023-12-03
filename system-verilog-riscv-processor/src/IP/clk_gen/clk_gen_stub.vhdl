-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Aug 22 15:24:05 2022
-- Host        : LAPTOP-8OOJFQLK running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top clk_gen -prefix
--               clk_gen_ clk_gen_stub.vhdl
-- Design      : clk_gen
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_gen is
  Port ( 
    clk_10MHz : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_gen;

architecture stub of clk_gen is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_10MHz,clk_in1";
begin
end;
