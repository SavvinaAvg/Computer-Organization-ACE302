----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2022 14:13:51
-- Design Name: 
-- Module Name: DECSTAGE - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECSTAGE is
--  Port ( );
    port( Instr:            in std_logic_vector(31 downto 0);
          RF_WrEn:          in std_logic;
          ALU_out:          in std_logic_vector(31 downto 0);
          MEM_out:          in std_logic_vector(31 downto 0);
          RF_WrData_sel:    in std_logic;
          RF_B_sel:         in std_logic;
          ImmExt:           in std_logic_vector(1 downto 0);
          Clk:              in std_logic;
          Rst:              in std_logic;
          Immed:            out std_logic_vector(31 downto 0);
          RF_A:             out std_logic_vector(31 downto 0);
          RF_B:             out std_logic_vector(31 downto 0)
         );
end DECSTAGE;

architecture Behavioral of DECSTAGE is

---------------- REGISTER FILE --------------------
    component RF is
        port(
        Ard1: in std_logic_vector(4 downto 0);
        Ard2: in std_logic_vector(4 downto 0);
        Awr: in std_logic_vector(4 downto 0);
        Dout1: out std_logic_vector(31 downto 0);
        Dout2: out std_logic_vector(31 downto 0);
        Din: in std_logic_vector(31 downto 0);
        WrEn: in std_logic;
        Clk: in std_logic;
        Rst: in std_logic
        );
    end component;
    
-------------------- MUX_2_1_5b ---------------------
    component MUX2x1_5b is
        port( din1: in std_logic_vector(4 downto 0);
              din2: in std_logic_vector(4 downto 0);
              sel:  in std_logic;
              dout: out std_logic_vector(4 downto 0)
         );
    end component;
------------------- MUX 2X1 -------------------------
    component MUX_2_1 is
        port ( InA: in std_logic_vector(31 downto 0);
               InB: in std_logic_vector(31 downto 0);
               sel: in std_logic;
               mux_out: out std_logic_vector(31 downto 0)
             );
    end component;
    
------------------ CONVERTER ---------------------------
    component CONV is
    port( Instr: in std_logic_vector(15 downto 0);
          ImmExt:   in std_logic_vector(1 downto 0);
          Immed: out std_logic_vector(31 downto 0)
        );  
    end component;
   
signal mux2_1_out: std_logic_vector(31 downto 0);
signal mux_5b_out: std_logic_vector(4 downto 0);
    
begin

---------------------- REGISTER FILE -----------------------
ref_file:
    RF port map (Ard1   =>  Instr(25 downto 21),
                 Ard2   =>  mux_5b_out,  
                 Awr    =>  Instr(20 downto 16),    
                 Dout1  =>  RF_A,
                 Dout2  =>  RF_B,
                 Din    =>  mux2_1_out,
                 WrEn   =>  RF_WrEn,
                 Clk    =>  Clk,
                 Rst    =>  Rst
                );
    
------------------------- MUX 2x1 5bits -----------------------------
mux2_1_5b:
    MUX2x1_5b port map(din1 =>  Instr(15 downto 11), 
                       din2 =>  Instr(20 downto 16),
                       sel  =>  RF_B_sel,
                       dout =>  mux_5b_out
                      );

------------------------ MUX 2X1 --------------------------------
mux2x1:
    MUX_2_1 port map(InA        =>  MEM_out,
                     InB        =>  ALU_out,
                     sel        =>  RF_WrData_sel,
                     mux_out    =>  mux2_1_out
                    );
                    
 ---------------------- CONVERTER ------------------------------
 converter:
    CONV port map(Instr    =>  Instr(15 downto 0),  
                  ImmExt   =>  ImmExt,
                  Immed    =>  Immed
                 );  
                                  
end Behavioral;
