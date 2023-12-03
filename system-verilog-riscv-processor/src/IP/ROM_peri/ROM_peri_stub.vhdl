-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Oct 29 21:53:12 2022
-- Host        : DESKTOP-IB8A7DA running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/jdavi/Documents/TEC/Taller_Digitales/Proyecto_4/lab4-g01_lab4/src/IP/ROM_peri/ROM_peri_stub.vhdl
-- Design      : ROM_peri
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROM_peri is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end ROM_peri;

architecture stub of ROM_peri is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[6:0],spo[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_13,Vivado 2019.1";
begin
end;
