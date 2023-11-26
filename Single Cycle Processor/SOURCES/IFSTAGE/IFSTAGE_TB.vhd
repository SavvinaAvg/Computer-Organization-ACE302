----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2022 16:05:39
-- Design Name: 
-- Module Name: IFSTAGE_TB - Behavior
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
use ieee.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE_TB is
--  Port ( );
end IFSTAGE_TB;

architecture Behavior of IFSTAGE_TB is
    
    component IFSTAGE_TopModule is
        port(PC_Immed:   in std_logic_vector(31 downto 0);
             PC_sel:     in std_logic;
             PC_LdEn:    in std_logic;
             Reset:      in std_logic;
             Clk:        in std_logic;
             Instr:      out std_logic_vector(31 downto 0)
         );
    end component;
    
------------------- INPUTS -----------------------------
    signal PC_Immed:   std_logic_vector(31 downto 0) := (others => '0');
    signal PC_sel:     std_logic := '0';
    signal PC_LdEn:    std_logic := '0';
    signal Reset:      std_logic := '0';
    signal Clk:        std_logic := '0';
    
---------------- OUTPUTS ------------------------------------
    signal Instr: std_logic_vector(31 downto 0);
    
------------------- CLOCK PERIOD DEFINITIONS -------------------
    constant Clk_period : time := 100 ns;
    
begin

    uut: IFSTAGE_TopModule
        port map(PC_Immed  =>  PC_Immed,
                 PC_sel    =>  PC_sel,
                 PC_LdEn   =>  PC_LdEn,
                 Reset     =>  Reset,
                 Clk       =>  Clk,
                 Instr      => Instr
                ); 
                
    Clk_process: process
    begin
            Clk <= '0';
            wait for Clk_period/2;
            
            Clk <= '1';
            wait for Clk_period/2;
   end process;
   
   -- Stimulus process
   stim_proc: process
   begin		

      -- hold reset state for 100 ns.		
	  PC_Immed <= "00000000000000000000000000000100";
      PC_Sel <= '0';
      PC_LdEn <= '0';
      Reset <= '1';
      wait for Clk_period;


	  PC_Immed <= "00000000000000000000000000001111";
      PC_Sel <= '0';
      PC_LdEn <= '1';
      Reset <= '0';
      wait for Clk_period;
			
			
	  PC_Immed <= "01010101010000011100000000000101";
      PC_Sel <= '1';
      PC_LdEn <= '1';
      Reset <= '0';
      wait for Clk_period;
		
		
	  PC_Immed <= "00001110100000001000001100001101";
      PC_Sel <= '1';
      PC_LdEn <= '1';
      Reset <= '1';
      wait for Clk_period;
			
				
	  PC_Immed <= "00000011100000001000010000001100";
      PC_Sel <= '0';
      PC_LdEn <= '1';
      Reset <= '0';
      wait for Clk_period;
			
				
	  PC_Immed <= "00000000000000000000000011111100";
      PC_Sel <= '0';
      PC_LdEn <= '1';
      Reset <= '0';
      wait for Clk_period;
			
				
	  PC_Immed <= "11111111000000000110000111111111";
      PC_Sel <= '1';
      PC_LdEn <= '1';
      Reset <= '0';
      wait for Clk_period;
		
		
	  PC_Immed <= "00000000000000000000001111110000";
      PC_Sel <= '1';
      PC_LdEn <= '1';
      Reset <= '0';
      wait for Clk_period;
		
		
	  PC_Immed <= "11111111111100001111111111111111";
      PC_Sel <= '1';
      PC_LdEn <= '1';
      Reset <= '0';
      wait for Clk_period;
		
		
	  PC_Immed <= "11111111111111111111111111111111";
      PC_Sel <= '0';
      PC_LdEn <= '1';
      Reset <= '1';
      wait for Clk_period;
		
		
	  wait;
			
   end process;
   
end Behavior;
