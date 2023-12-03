-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sun Oct 30 22:01:58 2022
-- Host        : DESKTOP-IB8A7DA running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/jdavi/Documents/TEC/Taller_Digitales/Proyecto_4/lab4-g01_lab4/src/IP/ROM/ROM/ROM_sim_netlist.vhdl
-- Design      : ROM
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ROM_dist_mem_gen_v8_0_13_rom is
  port (
    spo : out STD_LOGIC_VECTOR ( 28 downto 0 );
    a : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ROM_dist_mem_gen_v8_0_13_rom : entity is "dist_mem_gen_v8_0_13_rom";
end ROM_dist_mem_gen_v8_0_13_rom;

architecture STRUCTURE of ROM_dist_mem_gen_v8_0_13_rom is
  signal \spo[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[12]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[12]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[12]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[12]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[12]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[12]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[12]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[13]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[14]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[14]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[14]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[15]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[16]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[17]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[18]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[19]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[19]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[19]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[19]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[19]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[19]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[19]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[20]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[21]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[22]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[23]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[24]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[25]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[26]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[27]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[27]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[27]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[27]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[27]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[28]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[28]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[28]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[28]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[28]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[28]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[28]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[29]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[30]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[31]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_9_n_0\ : STD_LOGIC;
begin
\spo[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"51555555FFFFFFFF"
    )
        port map (
      I0 => a(7),
      I1 => a(4),
      I2 => \spo[0]_INST_0_i_1_n_0\,
      I3 => a(5),
      I4 => a(6),
      I5 => a(8),
      O => spo(0)
    );
\spo[0]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => a(2),
      I1 => a(3),
      O => \spo[0]_INST_0_i_1_n_0\
    );
\spo[10]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[10]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[10]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[10]_INST_0_i_3_n_0\,
      O => spo(7)
    );
\spo[10]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[10]_INST_0_i_4_n_0\,
      I1 => \spo[10]_INST_0_i_5_n_0\,
      O => \spo[10]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[10]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[10]_INST_0_i_6_n_0\,
      I1 => \spo[10]_INST_0_i_7_n_0\,
      O => \spo[10]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[10]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[10]_INST_0_i_8_n_0\,
      I1 => \spo[10]_INST_0_i_9_n_0\,
      O => \spo[10]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[10]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0205011612156737"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[10]_INST_0_i_4_n_0\
    );
\spo[10]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7304EF3B10591149"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[10]_INST_0_i_5_n_0\
    );
\spo[10]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"284993344F334109"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[10]_INST_0_i_6_n_0\
    );
\spo[10]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"46DF9A2AF9AA26D4"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[10]_INST_0_i_7_n_0\
    );
\spo[10]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B27D5FC728AAA0B8"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[10]_INST_0_i_8_n_0\
    );
\spo[10]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4E21E8FFF53FFE48"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[10]_INST_0_i_9_n_0\
    );
\spo[11]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[11]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[11]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[11]_INST_0_i_3_n_0\,
      O => spo(8)
    );
\spo[11]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[11]_INST_0_i_4_n_0\,
      I1 => \spo[11]_INST_0_i_5_n_0\,
      O => \spo[11]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[11]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[11]_INST_0_i_6_n_0\,
      I1 => \spo[11]_INST_0_i_7_n_0\,
      O => \spo[11]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[11]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[11]_INST_0_i_8_n_0\,
      I1 => \spo[11]_INST_0_i_9_n_0\,
      O => \spo[11]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[11]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3325612642255443"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[11]_INST_0_i_4_n_0\
    );
\spo[11]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"67000DF9901D810D"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[11]_INST_0_i_5_n_0\
    );
\spo[11]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D428BCD2849D0424"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[11]_INST_0_i_6_n_0\
    );
\spo[11]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"442DC96CED5FCE09"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[11]_INST_0_i_7_n_0\
    );
\spo[11]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A2BD6553000E884C"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[11]_INST_0_i_8_n_0\
    );
\spo[11]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"81B80062246F66CC"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[11]_INST_0_i_9_n_0\
    );
\spo[12]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3000BBBB30008888"
    )
        port map (
      I0 => \spo[12]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[12]_INST_0_i_2_n_0\,
      I3 => a(6),
      I4 => a(7),
      I5 => \spo[12]_INST_0_i_3_n_0\,
      O => spo(9)
    );
\spo[12]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[12]_INST_0_i_4_n_0\,
      I1 => \spo[12]_INST_0_i_5_n_0\,
      O => \spo[12]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[12]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0804011108002000"
    )
        port map (
      I0 => a(4),
      I1 => a(1),
      I2 => a(2),
      I3 => a(3),
      I4 => a(0),
      I5 => a(5),
      O => \spo[12]_INST_0_i_2_n_0\
    );
\spo[12]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[12]_INST_0_i_6_n_0\,
      I1 => \spo[12]_INST_0_i_7_n_0\,
      O => \spo[12]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[12]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C080908208211940"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[12]_INST_0_i_4_n_0\
    );
\spo[12]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0040100000020A80"
    )
        port map (
      I0 => a(4),
      I1 => a(1),
      I2 => a(3),
      I3 => a(2),
      I4 => a(0),
      I5 => a(5),
      O => \spo[12]_INST_0_i_5_n_0\
    );
\spo[12]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000008243904"
    )
        port map (
      I0 => a(1),
      I1 => a(2),
      I2 => a(3),
      I3 => a(0),
      I4 => a(5),
      I5 => a(4),
      O => \spo[12]_INST_0_i_6_n_0\
    );
\spo[12]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000400000"
    )
        port map (
      I0 => a(5),
      I1 => a(1),
      I2 => a(2),
      I3 => a(3),
      I4 => a(0),
      I5 => a(4),
      O => \spo[12]_INST_0_i_7_n_0\
    );
\spo[13]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[13]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[13]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[13]_INST_0_i_3_n_0\,
      O => spo(10)
    );
\spo[13]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[13]_INST_0_i_4_n_0\,
      I1 => \spo[13]_INST_0_i_5_n_0\,
      O => \spo[13]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[13]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[13]_INST_0_i_6_n_0\,
      I1 => \spo[13]_INST_0_i_7_n_0\,
      O => \spo[13]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[13]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[13]_INST_0_i_8_n_0\,
      I1 => \spo[13]_INST_0_i_9_n_0\,
      O => \spo[13]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[13]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"055850000A484002"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[13]_INST_0_i_4_n_0\
    );
\spo[13]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000E0DD80CD91"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[13]_INST_0_i_5_n_0\
    );
\spo[13]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0300440930882290"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[13]_INST_0_i_6_n_0\
    );
\spo[13]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5550000040050528"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[13]_INST_0_i_7_n_0\
    );
\spo[13]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6088AA022AA00088"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(2),
      I3 => a(3),
      I4 => a(1),
      I5 => a(5),
      O => \spo[13]_INST_0_i_8_n_0\
    );
\spo[13]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000A1146008010"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[13]_INST_0_i_9_n_0\
    );
\spo[14]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000C0A0C0A0"
    )
        port map (
      I0 => \spo[14]_INST_0_i_1_n_0\,
      I1 => \spo[14]_INST_0_i_2_n_0\,
      I2 => a(8),
      I3 => a(6),
      I4 => \spo[14]_INST_0_i_3_n_0\,
      I5 => a(7),
      O => spo(11)
    );
\spo[14]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010000100022040"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[14]_INST_0_i_1_n_0\
    );
\spo[14]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000100002000000"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(2),
      I3 => a(3),
      I4 => a(1),
      I5 => a(5),
      O => \spo[14]_INST_0_i_2_n_0\
    );
\spo[14]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000000000"
    )
        port map (
      I0 => a(5),
      I1 => a(1),
      I2 => a(3),
      I3 => a(2),
      I4 => a(0),
      I5 => a(4),
      O => \spo[14]_INST_0_i_3_n_0\
    );
\spo[15]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[15]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[15]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[15]_INST_0_i_3_n_0\,
      O => spo(12)
    );
\spo[15]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[15]_INST_0_i_4_n_0\,
      I1 => \spo[15]_INST_0_i_5_n_0\,
      O => \spo[15]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[15]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[15]_INST_0_i_6_n_0\,
      I1 => \spo[15]_INST_0_i_7_n_0\,
      O => \spo[15]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[15]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[15]_INST_0_i_8_n_0\,
      I1 => \spo[15]_INST_0_i_9_n_0\,
      O => \spo[15]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[15]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D326EC4444C0000B"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[15]_INST_0_i_4_n_0\
    );
\spo[15]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"266600426A811154"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[15]_INST_0_i_5_n_0\
    );
\spo[15]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0338C4AA75338994"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[15]_INST_0_i_6_n_0\
    );
\spo[15]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"554E00245013B9A8"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[15]_INST_0_i_7_n_0\
    );
\spo[15]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"620990643600815C"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[15]_INST_0_i_8_n_0\
    );
\spo[15]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"218C648D24AC640C"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(3),
      I3 => a(2),
      I4 => a(1),
      I5 => a(0),
      O => \spo[15]_INST_0_i_9_n_0\
    );
\spo[16]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[16]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[16]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[16]_INST_0_i_3_n_0\,
      O => spo(13)
    );
\spo[16]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[16]_INST_0_i_4_n_0\,
      I1 => \spo[16]_INST_0_i_5_n_0\,
      O => \spo[16]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[16]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[16]_INST_0_i_6_n_0\,
      I1 => \spo[16]_INST_0_i_7_n_0\,
      O => \spo[16]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[16]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[16]_INST_0_i_8_n_0\,
      I1 => \spo[16]_INST_0_i_9_n_0\,
      O => \spo[16]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[16]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A284032622B08805"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[16]_INST_0_i_4_n_0\
    );
\spo[16]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2226DDDA2CC9CEE4"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[16]_INST_0_i_5_n_0\
    );
\spo[16]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000000"
    )
        port map (
      I0 => a(5),
      I1 => a(1),
      I2 => a(3),
      I3 => a(2),
      I4 => a(0),
      I5 => a(4),
      O => \spo[16]_INST_0_i_6_n_0\
    );
\spo[16]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A020488A0006180"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[16]_INST_0_i_7_n_0\
    );
\spo[16]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A7A222280999C20"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[16]_INST_0_i_8_n_0\
    );
\spo[16]_INST_0_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
        port map (
      I0 => a(5),
      I1 => a(3),
      I2 => a(2),
      I3 => a(1),
      I4 => a(4),
      O => \spo[16]_INST_0_i_9_n_0\
    );
\spo[17]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[17]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[17]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[17]_INST_0_i_3_n_0\,
      O => spo(14)
    );
\spo[17]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[17]_INST_0_i_4_n_0\,
      I1 => \spo[17]_INST_0_i_5_n_0\,
      O => \spo[17]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[17]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[17]_INST_0_i_6_n_0\,
      I1 => \spo[17]_INST_0_i_7_n_0\,
      O => \spo[17]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[17]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[17]_INST_0_i_8_n_0\,
      I1 => \spo[17]_INST_0_i_9_n_0\,
      O => \spo[17]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[17]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"82A184009A102D01"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(1),
      I5 => a(2),
      O => \spo[17]_INST_0_i_4_n_0\
    );
\spo[17]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0013001042112111"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(1),
      I5 => a(2),
      O => \spo[17]_INST_0_i_5_n_0\
    );
\spo[17]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"20F00D05D01F9050"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[17]_INST_0_i_6_n_0\
    );
\spo[17]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8004106200476600"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[17]_INST_0_i_7_n_0\
    );
\spo[17]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E00083A60200C22C"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[17]_INST_0_i_8_n_0\
    );
\spo[17]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"20204C4C2004DCDD"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(2),
      I3 => a(0),
      I4 => a(3),
      I5 => a(1),
      O => \spo[17]_INST_0_i_9_n_0\
    );
\spo[18]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[18]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[18]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[18]_INST_0_i_3_n_0\,
      O => spo(15)
    );
\spo[18]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[18]_INST_0_i_4_n_0\,
      I1 => \spo[18]_INST_0_i_5_n_0\,
      O => \spo[18]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[18]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[18]_INST_0_i_6_n_0\,
      I1 => \spo[18]_INST_0_i_7_n_0\,
      O => \spo[18]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[18]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[18]_INST_0_i_8_n_0\,
      I1 => \spo[18]_INST_0_i_9_n_0\,
      O => \spo[18]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[18]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000110213320155"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[18]_INST_0_i_4_n_0\
    );
\spo[18]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2262001026015044"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[18]_INST_0_i_5_n_0\
    );
\spo[18]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"20000010D0050040"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[18]_INST_0_i_6_n_0\
    );
\spo[18]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CC80440304800880"
    )
        port map (
      I0 => a(0),
      I1 => a(4),
      I2 => a(1),
      I3 => a(2),
      I4 => a(3),
      I5 => a(5),
      O => \spo[18]_INST_0_i_7_n_0\
    );
\spo[18]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E09C08A2033288EC"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[18]_INST_0_i_8_n_0\
    );
\spo[18]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"284044040004D4D5"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(2),
      I3 => a(0),
      I4 => a(3),
      I5 => a(1),
      O => \spo[18]_INST_0_i_9_n_0\
    );
\spo[19]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3088308830BB3088"
    )
        port map (
      I0 => \spo[19]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[19]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[19]_INST_0_i_3_n_0\,
      I5 => a(6),
      O => spo(16)
    );
\spo[19]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[19]_INST_0_i_4_n_0\,
      I1 => \spo[19]_INST_0_i_5_n_0\,
      O => \spo[19]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[19]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[19]_INST_0_i_6_n_0\,
      I1 => \spo[19]_INST_0_i_7_n_0\,
      O => \spo[19]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[19]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"601400A2031000EC"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[19]_INST_0_i_3_n_0\
    );
\spo[19]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0221040212102541"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(1),
      I5 => a(2),
      O => \spo[19]_INST_0_i_4_n_0\
    );
\spo[19]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"004E001000091800"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[19]_INST_0_i_5_n_0\
    );
\spo[19]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000008000000400"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[19]_INST_0_i_6_n_0\
    );
\spo[19]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"820604C828066580"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[19]_INST_0_i_7_n_0\
    );
\spo[20]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[20]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[20]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[20]_INST_0_i_3_n_0\,
      O => spo(17)
    );
\spo[20]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[20]_INST_0_i_4_n_0\,
      I1 => \spo[20]_INST_0_i_5_n_0\,
      O => \spo[20]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[20]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[20]_INST_0_i_6_n_0\,
      I1 => \spo[20]_INST_0_i_7_n_0\,
      O => \spo[20]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[20]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[20]_INST_0_i_8_n_0\,
      I1 => \spo[20]_INST_0_i_9_n_0\,
      O => \spo[20]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[20]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02040F6514310400"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[20]_INST_0_i_4_n_0\
    );
\spo[20]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"316300D001020008"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[20]_INST_0_i_5_n_0\
    );
\spo[20]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5B6230BC78B6AFB9"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[20]_INST_0_i_6_n_0\
    );
\spo[20]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"11A88059014192C1"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[20]_INST_0_i_7_n_0\
    );
\spo[20]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A5480A20D00AA040"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[20]_INST_0_i_8_n_0\
    );
\spo[20]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9CD1A0E59D9FA5B4"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[20]_INST_0_i_9_n_0\
    );
\spo[21]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[21]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[21]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[21]_INST_0_i_3_n_0\,
      O => spo(18)
    );
\spo[21]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[21]_INST_0_i_4_n_0\,
      I1 => \spo[21]_INST_0_i_5_n_0\,
      O => \spo[21]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[21]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[21]_INST_0_i_6_n_0\,
      I1 => \spo[21]_INST_0_i_7_n_0\,
      O => \spo[21]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[21]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[21]_INST_0_i_8_n_0\,
      I1 => \spo[21]_INST_0_i_9_n_0\,
      O => \spo[21]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[21]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0004264481020000"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[21]_INST_0_i_4_n_0\
    );
\spo[21]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"771249E825194880"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[21]_INST_0_i_5_n_0\
    );
\spo[21]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"03BC68F240890B58"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[21]_INST_0_i_6_n_0\
    );
\spo[21]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00020000452C730C"
    )
        port map (
      I0 => a(4),
      I1 => a(3),
      I2 => a(2),
      I3 => a(1),
      I4 => a(0),
      I5 => a(5),
      O => \spo[21]_INST_0_i_7_n_0\
    );
\spo[21]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"988800044C208A04"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[21]_INST_0_i_8_n_0\
    );
\spo[21]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AB41406F480B41B6"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[21]_INST_0_i_9_n_0\
    );
\spo[22]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[22]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[22]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[22]_INST_0_i_3_n_0\,
      O => spo(19)
    );
\spo[22]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[22]_INST_0_i_4_n_0\,
      I1 => \spo[22]_INST_0_i_5_n_0\,
      O => \spo[22]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[22]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[22]_INST_0_i_6_n_0\,
      I1 => \spo[22]_INST_0_i_7_n_0\,
      O => \spo[22]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[22]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[22]_INST_0_i_8_n_0\,
      I1 => \spo[22]_INST_0_i_9_n_0\,
      O => \spo[22]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[22]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02070744346E023F"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[22]_INST_0_i_4_n_0\
    );
\spo[22]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"235A35010100C09C"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[22]_INST_0_i_5_n_0\
    );
\spo[22]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4B2204C280DE715D"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(2),
      I3 => a(3),
      I4 => a(0),
      I5 => a(1),
      O => \spo[22]_INST_0_i_6_n_0\
    );
\spo[22]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C00004484D012C45"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(3),
      I3 => a(2),
      I4 => a(1),
      I5 => a(0),
      O => \spo[22]_INST_0_i_7_n_0\
    );
\spo[22]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3141084000000346"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[22]_INST_0_i_8_n_0\
    );
\spo[22]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AD00CA7880427278"
    )
        port map (
      I0 => a(4),
      I1 => a(1),
      I2 => a(5),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[22]_INST_0_i_9_n_0\
    );
\spo[23]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[23]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[23]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[23]_INST_0_i_3_n_0\,
      O => spo(20)
    );
\spo[23]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[23]_INST_0_i_4_n_0\,
      I1 => \spo[23]_INST_0_i_5_n_0\,
      O => \spo[23]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[23]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[23]_INST_0_i_6_n_0\,
      I1 => \spo[23]_INST_0_i_7_n_0\,
      O => \spo[23]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[23]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[23]_INST_0_i_8_n_0\,
      I1 => \spo[23]_INST_0_i_9_n_0\,
      O => \spo[23]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[23]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D38787D61D644854"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[23]_INST_0_i_4_n_0\
    );
\spo[23]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"557D17194F4C8ABC"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[23]_INST_0_i_5_n_0\
    );
\spo[23]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"138468B1848D8B44"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[23]_INST_0_i_6_n_0\
    );
\spo[23]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"93EC032160B352D8"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[23]_INST_0_i_7_n_0\
    );
\spo[23]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"84DA1C20CCA51A10"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[23]_INST_0_i_8_n_0\
    );
\spo[23]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9F55760D988345D8"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[23]_INST_0_i_9_n_0\
    );
\spo[24]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[24]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[24]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[24]_INST_0_i_3_n_0\,
      O => spo(21)
    );
\spo[24]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[24]_INST_0_i_4_n_0\,
      I1 => \spo[24]_INST_0_i_5_n_0\,
      O => \spo[24]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[24]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[24]_INST_0_i_6_n_0\,
      I1 => \spo[24]_INST_0_i_7_n_0\,
      O => \spo[24]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[24]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[24]_INST_0_i_8_n_0\,
      I1 => \spo[24]_INST_0_i_9_n_0\,
      O => \spo[24]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[24]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"11010140B2400033"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[24]_INST_0_i_4_n_0\
    );
\spo[24]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"100601C0600100D4"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[24]_INST_0_i_5_n_0\
    );
\spo[24]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1015008030022E90"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[24]_INST_0_i_6_n_0\
    );
\spo[24]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C008C66050E98398"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(2),
      I3 => a(3),
      I4 => a(1),
      I5 => a(0),
      O => \spo[24]_INST_0_i_7_n_0\
    );
\spo[24]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200860050000"
    )
        port map (
      I0 => a(4),
      I1 => a(1),
      I2 => a(5),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[24]_INST_0_i_8_n_0\
    );
\spo[24]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"04B020CC00210450"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[24]_INST_0_i_9_n_0\
    );
\spo[25]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[25]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[25]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[25]_INST_0_i_3_n_0\,
      O => spo(22)
    );
\spo[25]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[25]_INST_0_i_4_n_0\,
      I1 => \spo[25]_INST_0_i_5_n_0\,
      O => \spo[25]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[25]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[25]_INST_0_i_6_n_0\,
      I1 => \spo[25]_INST_0_i_7_n_0\,
      O => \spo[25]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[25]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[25]_INST_0_i_8_n_0\,
      I1 => \spo[25]_INST_0_i_9_n_0\,
      O => \spo[25]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[25]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"066C6489EE64C808"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[25]_INST_0_i_4_n_0\
    );
\spo[25]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0206202442094922"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[25]_INST_0_i_5_n_0\
    );
\spo[25]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"84557179BC3DC8A0"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(2),
      I3 => a(3),
      I4 => a(0),
      I5 => a(1),
      O => \spo[25]_INST_0_i_6_n_0\
    );
\spo[25]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02008000C11E64B4"
    )
        port map (
      I0 => a(4),
      I1 => a(3),
      I2 => a(1),
      I3 => a(2),
      I4 => a(0),
      I5 => a(5),
      O => \spo[25]_INST_0_i_7_n_0\
    );
\spo[25]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"800D2058097D6741"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(1),
      I5 => a(2),
      O => \spo[25]_INST_0_i_8_n_0\
    );
\spo[25]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0271195138E88C00"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(3),
      I3 => a(1),
      I4 => a(0),
      I5 => a(2),
      O => \spo[25]_INST_0_i_9_n_0\
    );
\spo[26]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E2FFFF00E20000"
    )
        port map (
      I0 => \spo[31]_INST_0_i_1_n_0\,
      I1 => a(6),
      I2 => \spo[26]_INST_0_i_1_n_0\,
      I3 => a(7),
      I4 => a(8),
      I5 => \spo[26]_INST_0_i_2_n_0\,
      O => spo(23)
    );
\spo[26]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000800000094900"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[26]_INST_0_i_1_n_0\
    );
\spo[26]_INST_0_i_2\: unisim.vcomponents.MUXF8
     port map (
      I0 => \spo[26]_INST_0_i_3_n_0\,
      I1 => \spo[26]_INST_0_i_4_n_0\,
      O => \spo[26]_INST_0_i_2_n_0\,
      S => a(7)
    );
\spo[26]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[26]_INST_0_i_5_n_0\,
      I1 => \spo[26]_INST_0_i_6_n_0\,
      O => \spo[26]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[26]_INST_0_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[26]_INST_0_i_7_n_0\,
      I1 => \spo[26]_INST_0_i_8_n_0\,
      O => \spo[26]_INST_0_i_4_n_0\,
      S => a(6)
    );
\spo[26]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"80A30200000080A0"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(3),
      I3 => a(2),
      I4 => a(1),
      I5 => a(5),
      O => \spo[26]_INST_0_i_5_n_0\
    );
\spo[26]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2204400408008540"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[26]_INST_0_i_6_n_0\
    );
\spo[26]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A800005040852800"
    )
        port map (
      I0 => a(4),
      I1 => a(1),
      I2 => a(5),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[26]_INST_0_i_7_n_0\
    );
\spo[26]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0801080080020020"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(3),
      I3 => a(2),
      I4 => a(1),
      I5 => a(5),
      O => \spo[26]_INST_0_i_8_n_0\
    );
\spo[27]_INST_0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[27]_INST_0_i_1_n_0\,
      I1 => \spo[27]_INST_0_i_2_n_0\,
      O => spo(24),
      S => a(8)
    );
\spo[27]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[28]_INST_0_i_3_n_0\,
      I1 => \spo[27]_INST_0_i_3_n_0\,
      I2 => a(7),
      I3 => \spo[27]_INST_0_i_4_n_0\,
      I4 => a(6),
      I5 => \spo[27]_INST_0_i_5_n_0\,
      O => \spo[27]_INST_0_i_1_n_0\
    );
\spo[27]_INST_0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \spo[29]_INST_0_i_1_n_0\,
      I1 => a(6),
      I2 => \spo[30]_INST_0_i_2_n_0\,
      I3 => a(7),
      O => \spo[27]_INST_0_i_2_n_0\
    );
\spo[27]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A000044444201000"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[27]_INST_0_i_3_n_0\
    );
\spo[27]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4260001008654050"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[27]_INST_0_i_4_n_0\
    );
\spo[27]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"82008200010882C4"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[27]_INST_0_i_5_n_0\
    );
\spo[28]_INST_0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[28]_INST_0_i_1_n_0\,
      I1 => \spo[28]_INST_0_i_2_n_0\,
      O => spo(25),
      S => a(8)
    );
\spo[28]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[28]_INST_0_i_3_n_0\,
      I1 => \spo[28]_INST_0_i_4_n_0\,
      I2 => a(7),
      I3 => \spo[28]_INST_0_i_5_n_0\,
      I4 => a(6),
      I5 => \spo[28]_INST_0_i_6_n_0\,
      O => \spo[28]_INST_0_i_1_n_0\
    );
\spo[28]_INST_0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \spo[29]_INST_0_i_1_n_0\,
      I1 => a(6),
      I2 => \spo[28]_INST_0_i_7_n_0\,
      I3 => a(7),
      O => \spo[28]_INST_0_i_2_n_0\
    );
\spo[28]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000080020000"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(3),
      I3 => a(2),
      I4 => a(1),
      I5 => a(5),
      O => \spo[28]_INST_0_i_3_n_0\
    );
\spo[28]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8040000000315002"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(0),
      I4 => a(3),
      I5 => a(2),
      O => \spo[28]_INST_0_i_4_n_0\
    );
\spo[28]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4060004028754000"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[28]_INST_0_i_5_n_0\
    );
\spo[28]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"82008200018882C0"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[28]_INST_0_i_6_n_0\
    );
\spo[28]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040094900"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[28]_INST_0_i_7_n_0\
    );
\spo[29]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E2FFFF00E20000"
    )
        port map (
      I0 => \spo[29]_INST_0_i_1_n_0\,
      I1 => a(6),
      I2 => \spo[31]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => a(8),
      I5 => \spo[31]_INST_0_i_3_n_0\,
      O => spo(26)
    );
\spo[29]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0221100404000400"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[29]_INST_0_i_1_n_0\
    );
\spo[30]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E2FFFF00E20000"
    )
        port map (
      I0 => \spo[30]_INST_0_i_1_n_0\,
      I1 => a(6),
      I2 => \spo[30]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => a(8),
      I5 => \spo[30]_INST_0_i_3_n_0\,
      O => spo(27)
    );
\spo[30]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0223100444000404"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[30]_INST_0_i_1_n_0\
    );
\spo[30]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000800040094900"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[30]_INST_0_i_2_n_0\
    );
\spo[30]_INST_0_i_3\: unisim.vcomponents.MUXF8
     port map (
      I0 => \spo[30]_INST_0_i_4_n_0\,
      I1 => \spo[30]_INST_0_i_5_n_0\,
      O => \spo[30]_INST_0_i_3_n_0\,
      S => a(7)
    );
\spo[30]_INST_0_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[30]_INST_0_i_6_n_0\,
      I1 => \spo[30]_INST_0_i_7_n_0\,
      O => \spo[30]_INST_0_i_4_n_0\,
      S => a(6)
    );
\spo[30]_INST_0_i_5\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[30]_INST_0_i_8_n_0\,
      I1 => \spo[30]_INST_0_i_9_n_0\,
      O => \spo[30]_INST_0_i_5_n_0\,
      S => a(6)
    );
\spo[30]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"880108AC22000200"
    )
        port map (
      I0 => a(4),
      I1 => a(1),
      I2 => a(2),
      I3 => a(3),
      I4 => a(0),
      I5 => a(5),
      O => \spo[30]_INST_0_i_6_n_0\
    );
\spo[30]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1260800008254000"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[30]_INST_0_i_7_n_0\
    );
\spo[30]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"984400000035C400"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(0),
      I4 => a(3),
      I5 => a(2),
      O => \spo[30]_INST_0_i_8_n_0\
    );
\spo[30]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0880000020071200"
    )
        port map (
      I0 => a(4),
      I1 => a(3),
      I2 => a(5),
      I3 => a(1),
      I4 => a(2),
      I5 => a(0),
      O => \spo[30]_INST_0_i_9_n_0\
    );
\spo[31]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E2FFFF00E20000"
    )
        port map (
      I0 => \spo[31]_INST_0_i_1_n_0\,
      I1 => a(6),
      I2 => \spo[31]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => a(8),
      I5 => \spo[31]_INST_0_i_3_n_0\,
      O => spo(28)
    );
\spo[31]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0221100444000400"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[31]_INST_0_i_1_n_0\
    );
\spo[31]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000080004009C900"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[31]_INST_0_i_2_n_0\
    );
\spo[31]_INST_0_i_3\: unisim.vcomponents.MUXF8
     port map (
      I0 => \spo[31]_INST_0_i_4_n_0\,
      I1 => \spo[31]_INST_0_i_5_n_0\,
      O => \spo[31]_INST_0_i_3_n_0\,
      S => a(7)
    );
\spo[31]_INST_0_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[31]_INST_0_i_6_n_0\,
      I1 => \spo[31]_INST_0_i_7_n_0\,
      O => \spo[31]_INST_0_i_4_n_0\,
      S => a(6)
    );
\spo[31]_INST_0_i_5\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[31]_INST_0_i_8_n_0\,
      I1 => \spo[31]_INST_0_i_9_n_0\,
      O => \spo[31]_INST_0_i_5_n_0\,
      S => a(6)
    );
\spo[31]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"82A30200000080A0"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(3),
      I3 => a(2),
      I4 => a(1),
      I5 => a(5),
      O => \spo[31]_INST_0_i_6_n_0\
    );
\spo[31]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0260000008254000"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[31]_INST_0_i_7_n_0\
    );
\spo[31]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0000030300B0000"
    )
        port map (
      I0 => a(1),
      I1 => a(4),
      I2 => a(5),
      I3 => a(2),
      I4 => a(3),
      I5 => a(0),
      O => \spo[31]_INST_0_i_8_n_0\
    );
\spo[31]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000000001020060"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      I5 => a(0),
      O => \spo[31]_INST_0_i_9_n_0\
    );
\spo[4]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[4]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[4]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[4]_INST_0_i_3_n_0\,
      O => spo(1)
    );
\spo[4]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[4]_INST_0_i_4_n_0\,
      I1 => \spo[4]_INST_0_i_5_n_0\,
      O => \spo[4]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[4]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[4]_INST_0_i_6_n_0\,
      I1 => \spo[4]_INST_0_i_7_n_0\,
      O => \spo[4]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[4]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[4]_INST_0_i_8_n_0\,
      I1 => \spo[4]_INST_0_i_9_n_0\,
      O => \spo[4]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[4]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C9CA899F8FBBBEBD"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(3),
      I3 => a(0),
      I4 => a(1),
      I5 => a(2),
      O => \spo[4]_INST_0_i_4_n_0\
    );
\spo[4]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"515522725312226A"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[4]_INST_0_i_5_n_0\
    );
\spo[4]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"583088A64314C429"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[4]_INST_0_i_6_n_0\
    );
\spo[4]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02A8BACC1D404D55"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[4]_INST_0_i_7_n_0\
    );
\spo[4]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1554545455575557"
    )
        port map (
      I0 => a(4),
      I1 => a(2),
      I2 => a(3),
      I3 => a(0),
      I4 => a(1),
      I5 => a(5),
      O => \spo[4]_INST_0_i_8_n_0\
    );
\spo[4]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B5DD853F8F0A8A0A"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[4]_INST_0_i_9_n_0\
    );
\spo[5]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[5]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[5]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[5]_INST_0_i_3_n_0\,
      O => spo(2)
    );
\spo[5]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[5]_INST_0_i_4_n_0\,
      I1 => \spo[5]_INST_0_i_5_n_0\,
      O => \spo[5]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[5]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[5]_INST_0_i_6_n_0\,
      I1 => \spo[5]_INST_0_i_7_n_0\,
      O => \spo[5]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[5]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[5]_INST_0_i_8_n_0\,
      I1 => \spo[5]_INST_0_i_9_n_0\,
      O => \spo[5]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[5]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3357277235440455"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[5]_INST_0_i_4_n_0\
    );
\spo[5]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"26224D8DAC0D5C94"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[5]_INST_0_i_5_n_0\
    );
\spo[5]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FF77D9BCEF3FF6"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[5]_INST_0_i_6_n_0\
    );
\spo[5]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF57EEBFADF3FBC3"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[5]_INST_0_i_7_n_0\
    );
\spo[5]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E82BA3A98228A8A8"
    )
        port map (
      I0 => a(4),
      I1 => a(3),
      I2 => a(2),
      I3 => a(0),
      I4 => a(1),
      I5 => a(5),
      O => \spo[5]_INST_0_i_8_n_0\
    );
\spo[5]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"668EECC0CCCD5DDD"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[5]_INST_0_i_9_n_0\
    );
\spo[6]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[6]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[6]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[6]_INST_0_i_3_n_0\,
      O => spo(3)
    );
\spo[6]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[6]_INST_0_i_4_n_0\,
      I1 => \spo[6]_INST_0_i_5_n_0\,
      O => \spo[6]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[6]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[6]_INST_0_i_6_n_0\,
      I1 => \spo[6]_INST_0_i_7_n_0\,
      O => \spo[6]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[6]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[6]_INST_0_i_8_n_0\,
      I1 => \spo[6]_INST_0_i_9_n_0\,
      O => \spo[6]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[6]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2221100454200410"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[6]_INST_0_i_4_n_0\
    );
\spo[6]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"26AC0010220D0D04"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[6]_INST_0_i_5_n_0\
    );
\spo[6]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A84C3139C6F35406"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(1),
      I3 => a(0),
      I4 => a(3),
      I5 => a(2),
      O => \spo[6]_INST_0_i_6_n_0\
    );
\spo[6]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A801E2B21722AE82"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[6]_INST_0_i_7_n_0\
    );
\spo[6]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"882B2321820088A8"
    )
        port map (
      I0 => a(4),
      I1 => a(3),
      I2 => a(2),
      I3 => a(0),
      I4 => a(1),
      I5 => a(5),
      O => \spo[6]_INST_0_i_8_n_0\
    );
\spo[6]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"60204CCC24805CDD"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(2),
      I3 => a(0),
      I4 => a(3),
      I5 => a(1),
      O => \spo[6]_INST_0_i_9_n_0\
    );
\spo[7]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[7]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[7]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[7]_INST_0_i_3_n_0\,
      O => spo(4)
    );
\spo[7]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[7]_INST_0_i_4_n_0\,
      I1 => \spo[7]_INST_0_i_5_n_0\,
      O => \spo[7]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[7]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[7]_INST_0_i_6_n_0\,
      I1 => \spo[7]_INST_0_i_7_n_0\,
      O => \spo[7]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[7]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[7]_INST_0_i_8_n_0\,
      I1 => \spo[7]_INST_0_i_9_n_0\,
      O => \spo[7]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[7]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CE64D884618C2409"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[7]_INST_0_i_4_n_0\
    );
\spo[7]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0454300BDFA92108"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[7]_INST_0_i_5_n_0\
    );
\spo[7]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C28E80C643007109"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(2),
      I3 => a(3),
      I4 => a(1),
      I5 => a(0),
      O => \spo[7]_INST_0_i_6_n_0\
    );
\spo[7]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"208810061B000610"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[7]_INST_0_i_7_n_0\
    );
\spo[7]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"87DD194D71624C33"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(3),
      I5 => a(1),
      O => \spo[7]_INST_0_i_8_n_0\
    );
\spo[7]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0BFBA339C1207820"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(1),
      I5 => a(2),
      O => \spo[7]_INST_0_i_9_n_0\
    );
\spo[8]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[8]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[8]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[8]_INST_0_i_3_n_0\,
      O => spo(5)
    );
\spo[8]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[8]_INST_0_i_4_n_0\,
      I1 => \spo[8]_INST_0_i_5_n_0\,
      O => \spo[8]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[8]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[8]_INST_0_i_6_n_0\,
      I1 => \spo[8]_INST_0_i_7_n_0\,
      O => \spo[8]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[8]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[8]_INST_0_i_8_n_0\,
      I1 => \spo[8]_INST_0_i_9_n_0\,
      O => \spo[8]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[8]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8843A83242C89FE5"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(2),
      I4 => a(1),
      I5 => a(3),
      O => \spo[8]_INST_0_i_4_n_0\
    );
\spo[8]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4015901243D2A22A"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[8]_INST_0_i_5_n_0\
    );
\spo[8]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0008000070040040"
    )
        port map (
      I0 => a(2),
      I1 => a(4),
      I2 => a(0),
      I3 => a(3),
      I4 => a(1),
      I5 => a(5),
      O => \spo[8]_INST_0_i_6_n_0\
    );
\spo[8]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00A4008001018001"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(3),
      I3 => a(1),
      I4 => a(2),
      I5 => a(0),
      O => \spo[8]_INST_0_i_7_n_0\
    );
\spo[8]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1054551140159202"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[8]_INST_0_i_8_n_0\
    );
\spo[8]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A00000004A1A5232"
    )
        port map (
      I0 => a(4),
      I1 => a(1),
      I2 => a(3),
      I3 => a(0),
      I4 => a(2),
      I5 => a(5),
      O => \spo[8]_INST_0_i_9_n_0\
    );
\spo[9]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \spo[9]_INST_0_i_1_n_0\,
      I1 => a(8),
      I2 => \spo[9]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[9]_INST_0_i_3_n_0\,
      O => spo(6)
    );
\spo[9]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[9]_INST_0_i_4_n_0\,
      I1 => \spo[9]_INST_0_i_5_n_0\,
      O => \spo[9]_INST_0_i_1_n_0\,
      S => a(6)
    );
\spo[9]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[9]_INST_0_i_6_n_0\,
      I1 => \spo[9]_INST_0_i_7_n_0\,
      O => \spo[9]_INST_0_i_2_n_0\,
      S => a(6)
    );
\spo[9]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[9]_INST_0_i_8_n_0\,
      I1 => \spo[9]_INST_0_i_9_n_0\,
      O => \spo[9]_INST_0_i_3_n_0\,
      S => a(6)
    );
\spo[9]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9EB9F4C6E7A6E5D1"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(3),
      I3 => a(0),
      I4 => a(1),
      I5 => a(2),
      O => \spo[9]_INST_0_i_4_n_0\
    );
\spo[9]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"571316BC942D058D"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[9]_INST_0_i_5_n_0\
    );
\spo[9]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"48F38C1E8FCFE4DB"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      I5 => a(3),
      O => \spo[9]_INST_0_i_6_n_0\
    );
\spo[9]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A9950FC310E56FBB"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(3),
      I4 => a(2),
      I5 => a(1),
      O => \spo[9]_INST_0_i_7_n_0\
    );
\spo[9]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B70008A238C70A42"
    )
        port map (
      I0 => a(4),
      I1 => a(0),
      I2 => a(5),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[9]_INST_0_i_8_n_0\
    );
\spo[9]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"202F40A771CC7A2B"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => a(0),
      I3 => a(1),
      I4 => a(3),
      I5 => a(2),
      O => \spo[9]_INST_0_i_9_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ROM_dist_mem_gen_v8_0_13_synth is
  port (
    spo : out STD_LOGIC_VECTOR ( 28 downto 0 );
    a : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ROM_dist_mem_gen_v8_0_13_synth : entity is "dist_mem_gen_v8_0_13_synth";
end ROM_dist_mem_gen_v8_0_13_synth;

architecture STRUCTURE of ROM_dist_mem_gen_v8_0_13_synth is
begin
\gen_rom.rom_inst\: entity work.ROM_dist_mem_gen_v8_0_13_rom
     port map (
      a(8 downto 0) => a(8 downto 0),
      spo(28 downto 0) => spo(28 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ROM_dist_mem_gen_v8_0_13 is
  port (
    a : in STD_LOGIC_VECTOR ( 8 downto 0 );
    d : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 8 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    i_ce : in STD_LOGIC;
    qspo_ce : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qspo_rst : in STD_LOGIC;
    qdpo_rst : in STD_LOGIC;
    qspo_srst : in STD_LOGIC;
    qdpo_srst : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dpo : out STD_LOGIC_VECTOR ( 31 downto 0 );
    qspo : out STD_LOGIC_VECTOR ( 31 downto 0 );
    qdpo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of ROM_dist_mem_gen_v8_0_13 : entity is 9;
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of ROM_dist_mem_gen_v8_0_13 : entity is "0";
  attribute C_DEPTH : integer;
  attribute C_DEPTH of ROM_dist_mem_gen_v8_0_13 : entity is 512;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of ROM_dist_mem_gen_v8_0_13 : entity is "./";
  attribute C_FAMILY : string;
  attribute C_FAMILY of ROM_dist_mem_gen_v8_0_13 : entity is "artix7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_CE : integer;
  attribute C_HAS_QSPO_CE of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of ROM_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of ROM_dist_mem_gen_v8_0_13 : entity is "ROM.mif";
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of ROM_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of ROM_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_REG_A_D_INPUTS : integer;
  attribute C_REG_A_D_INPUTS of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of ROM_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of ROM_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of ROM_dist_mem_gen_v8_0_13 : entity is 32;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ROM_dist_mem_gen_v8_0_13 : entity is "dist_mem_gen_v8_0_13";
end ROM_dist_mem_gen_v8_0_13;

architecture STRUCTURE of ROM_dist_mem_gen_v8_0_13 is
  signal \<const0>\ : STD_LOGIC;
  signal \^spo\ : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  dpo(31) <= \<const0>\;
  dpo(30) <= \<const0>\;
  dpo(29) <= \<const0>\;
  dpo(28) <= \<const0>\;
  dpo(27) <= \<const0>\;
  dpo(26) <= \<const0>\;
  dpo(25) <= \<const0>\;
  dpo(24) <= \<const0>\;
  dpo(23) <= \<const0>\;
  dpo(22) <= \<const0>\;
  dpo(21) <= \<const0>\;
  dpo(20) <= \<const0>\;
  dpo(19) <= \<const0>\;
  dpo(18) <= \<const0>\;
  dpo(17) <= \<const0>\;
  dpo(16) <= \<const0>\;
  dpo(15) <= \<const0>\;
  dpo(14) <= \<const0>\;
  dpo(13) <= \<const0>\;
  dpo(12) <= \<const0>\;
  dpo(11) <= \<const0>\;
  dpo(10) <= \<const0>\;
  dpo(9) <= \<const0>\;
  dpo(8) <= \<const0>\;
  dpo(7) <= \<const0>\;
  dpo(6) <= \<const0>\;
  dpo(5) <= \<const0>\;
  dpo(4) <= \<const0>\;
  dpo(3) <= \<const0>\;
  dpo(2) <= \<const0>\;
  dpo(1) <= \<const0>\;
  dpo(0) <= \<const0>\;
  qdpo(31) <= \<const0>\;
  qdpo(30) <= \<const0>\;
  qdpo(29) <= \<const0>\;
  qdpo(28) <= \<const0>\;
  qdpo(27) <= \<const0>\;
  qdpo(26) <= \<const0>\;
  qdpo(25) <= \<const0>\;
  qdpo(24) <= \<const0>\;
  qdpo(23) <= \<const0>\;
  qdpo(22) <= \<const0>\;
  qdpo(21) <= \<const0>\;
  qdpo(20) <= \<const0>\;
  qdpo(19) <= \<const0>\;
  qdpo(18) <= \<const0>\;
  qdpo(17) <= \<const0>\;
  qdpo(16) <= \<const0>\;
  qdpo(15) <= \<const0>\;
  qdpo(14) <= \<const0>\;
  qdpo(13) <= \<const0>\;
  qdpo(12) <= \<const0>\;
  qdpo(11) <= \<const0>\;
  qdpo(10) <= \<const0>\;
  qdpo(9) <= \<const0>\;
  qdpo(8) <= \<const0>\;
  qdpo(7) <= \<const0>\;
  qdpo(6) <= \<const0>\;
  qdpo(5) <= \<const0>\;
  qdpo(4) <= \<const0>\;
  qdpo(3) <= \<const0>\;
  qdpo(2) <= \<const0>\;
  qdpo(1) <= \<const0>\;
  qdpo(0) <= \<const0>\;
  qspo(31) <= \<const0>\;
  qspo(30) <= \<const0>\;
  qspo(29) <= \<const0>\;
  qspo(28) <= \<const0>\;
  qspo(27) <= \<const0>\;
  qspo(26) <= \<const0>\;
  qspo(25) <= \<const0>\;
  qspo(24) <= \<const0>\;
  qspo(23) <= \<const0>\;
  qspo(22) <= \<const0>\;
  qspo(21) <= \<const0>\;
  qspo(20) <= \<const0>\;
  qspo(19) <= \<const0>\;
  qspo(18) <= \<const0>\;
  qspo(17) <= \<const0>\;
  qspo(16) <= \<const0>\;
  qspo(15) <= \<const0>\;
  qspo(14) <= \<const0>\;
  qspo(13) <= \<const0>\;
  qspo(12) <= \<const0>\;
  qspo(11) <= \<const0>\;
  qspo(10) <= \<const0>\;
  qspo(9) <= \<const0>\;
  qspo(8) <= \<const0>\;
  qspo(7) <= \<const0>\;
  qspo(6) <= \<const0>\;
  qspo(5) <= \<const0>\;
  qspo(4) <= \<const0>\;
  qspo(3) <= \<const0>\;
  qspo(2) <= \<const0>\;
  qspo(1) <= \<const0>\;
  qspo(0) <= \<const0>\;
  spo(31 downto 4) <= \^spo\(31 downto 4);
  spo(3) <= \<const0>\;
  spo(2) <= \<const0>\;
  spo(1) <= \^spo\(0);
  spo(0) <= \^spo\(0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\synth_options.dist_mem_inst\: entity work.ROM_dist_mem_gen_v8_0_13_synth
     port map (
      a(8 downto 0) => a(8 downto 0),
      spo(28 downto 1) => \^spo\(31 downto 4),
      spo(0) => \^spo\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ROM is
  port (
    a : in STD_LOGIC_VECTOR ( 8 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ROM : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ROM : entity is "ROM,dist_mem_gen_v8_0_13,{}";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ROM : entity is "xil_defaultlib_ROM";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ROM : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of ROM : entity is "dist_mem_gen_v8_0_13,Vivado 2019.1";
end ROM;

architecture STRUCTURE of ROM is
  signal NLW_U0_dpo_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_qspo_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of U0 : label is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 0;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 0;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of U0 : label is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of U0 : label is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of U0 : label is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 0;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 9;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 512;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_clk : integer;
  attribute c_has_clk of U0 : label is 0;
  attribute c_has_qspo : integer;
  attribute c_has_qspo of U0 : label is 0;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_has_qspo_rst : integer;
  attribute c_has_qspo_rst of U0 : label is 0;
  attribute c_has_qspo_srst : integer;
  attribute c_has_qspo_srst of U0 : label is 0;
  attribute c_has_spo : integer;
  attribute c_has_spo of U0 : label is 1;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "ROM.mif";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 1;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 0;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 32;
begin
U0: entity work.ROM_dist_mem_gen_v8_0_13
     port map (
      a(8 downto 0) => a(8 downto 0),
      clk => '0',
      d(31 downto 0) => B"00000000000000000000000000000000",
      dpo(31 downto 0) => NLW_U0_dpo_UNCONNECTED(31 downto 0),
      dpra(8 downto 0) => B"000000000",
      i_ce => '1',
      qdpo(31 downto 0) => NLW_U0_qdpo_UNCONNECTED(31 downto 0),
      qdpo_ce => '1',
      qdpo_clk => '0',
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(31 downto 0) => NLW_U0_qspo_UNCONNECTED(31 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(31 downto 0) => spo(31 downto 0),
      we => '0'
    );
end STRUCTURE;
