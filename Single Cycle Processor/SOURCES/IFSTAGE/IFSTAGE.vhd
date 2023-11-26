----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2022 21:35:31
-- Design Name: 
-- Module Name: IFSTAGE - Behavioral
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

entity IFSTAGE is
--  Port ( );
    port(PC_Immed:   in std_logic_vector(31 downto 0);
         PC_sel:     in std_logic;
         PC_LdEn:    in std_logic;
         Reset:      in std_logic;
         Clk:        in std_logic;
         PC:         out std_logic_vector(31 downto 0)
         );
end IFSTAGE;

architecture Behavioral of IFSTAGE is

---------------- REGISTER -------------------------
    component REG is
        port( CLK: in std_logic;
              RST: in std_logic;
              WE: in std_logic;
              Datain: in std_logic_vector(31 downto 0);
              Dataout: out std_logic_vector(31 downto 0)
            );
    end component;
    
--------------------- MUX 2X1 ------------------------------    
    component MUX_2_1 is
        port ( InA: in std_logic_vector(31 downto 0);
               InB: in std_logic_vector(31 downto 0);
               sel: in std_logic;
               mux_out: out std_logic_vector(31 downto 0)
             );
    end component;

--------------------- ADDER INCREMENTOR ---------------------
    component Adder_Incrementor is
        port(din:  in std_logic_vector(31 downto 0);
             dout: out std_logic_vector(31 downto 0)
            );
    end component;
   
--------------------- ADDER IMMED -------------------------
    component Adder_Immed is
        port(din:       in std_logic_vector(31 downto 0);
             dout:      out std_logic_vector(31 downto 0);
             PC_Immed:  in std_logic_vector(31 downto 0)
            );
    end component;
    
------------------------- RAM --------------------------------
--    component RAM is
--        port(
--            clk        :  in std_logic;
--            inst_addr  :  in std_logic_vector(10 downto 0);
--            inst_dout  :  out std_logic_vector(31 downto 0);
--            data_we    :  in std_logic;
--            data_addr  :  in std_logic_vector(10 downto 0);
--            data_din   :  in std_logic_vector(31 downto 0);
--            data_dout  :  out std_logic_vector(31 downto 0)
--            );
--    end component;
    
-------------------- SIGNALS ---------------------------
    signal mux_out: std_logic_vector(31 downto 0);
    signal PC_out: std_logic_vector(31 downto 0);
    signal adder_inc_out: std_logic_vector(31 downto 0);
    signal adder_immed_out: std_logic_vector(31 downto 0);

begin

------------------ REGISTER ---------------------------
Register_PC:
    REG port map( Datain  => mux_out,
                  WE      => PC_LdEn,
                  RST     => Reset,
                  CLK     => clk,
                  Dataout => PC_out
                );  
    PC <= PC_out;              
------------------- MUX 2X1 ------------------------------
MUX2X1: 
    MUX_2_1 port map( InA       => adder_immed_out,
                      InB       => adder_inc_out, 
                      sel       => PC_sel,
                      mux_out   => mux_out
                     );            

------------------ Adder Incrementor --------------------------
Adder_Inc:
    Adder_Incrementor port map(din  => PC_out,
                               dout => adder_inc_out
                              );
                              
-------------------- Adder Immed ---------------------------
Adder_PC_immed:
    Adder_Immed port map(din        => adder_inc_out,
                         dout       => adder_immed_out,
                         PC_Immed   => PC_Immed
                        );
                                      
end Behavioral;
