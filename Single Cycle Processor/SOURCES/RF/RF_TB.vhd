----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2022 23:40:41
-- Design Name: 
-- Module Name: RF_TB - behavior
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

entity RF_TB is
--  Port ( );
end RF_TB;

architecture behavior of RF_TB is

component RF
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

-------------- INPUTS ---------------------------
    signal Ard1: std_logic_vector(4 downto 0) := (others => '0');
    signal Ard2: std_logic_vector(4 downto 0) := (others => '0');
    signal Awr: std_logic_vector(4 downto 0) := (others => '0');
    signal Din: std_logic_vector(31 downto 0) := (others => '0');
    signal WrEn: std_logic := '0';
    signal Clk: std_logic := '0';
    signal Rst: std_logic := '0';
    
------------- OUTPUTS -------------------------------
    signal Dout1: std_logic_vector(31 downto 0);
    signal Dout2: std_logic_vector(31 downto 0);

--------------- CLOCK PERIOD -----------------------
    constant clk_period : time := 100ns;

begin

   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
		  Rst => Rst,
          Dout1 => Dout1,
          Dout2 => Dout2
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;

  stim_proc: process
   begin		
      Ard1 <= "00000";
      Ard2 <= "00100";
      Awr <= "00010";
      Din <= "11110000111100001111000011110000";
      WrEn <= '0';
	  Rst <= '1';
      wait for clk_period;	
		
	  Ard1 <= "01000";
      Ard2 <= "11000";
      Awr <= "00110";
      Din <= "00011000111100001111000011110000";
      WrEn <= '1';
	  Rst <= '0';
      wait for clk_period;
		
	  Ard1 <= "00100";
      Ard2 <= "00110";
      Awr <= "00010";
      Din <= "11111111111100001111000011111111";
      WrEn <= '1';
	  Rst <= '0';
      wait for clk_period;
		
	  Ard1 <= "00010";
      Ard2 <= "01100";
      Awr <= "00010";
      Din <= "11110000111100001111000011110000";
      WrEn <= '0';
	  Rst <= '0';
      wait for clk_period;
		 -- hold reset state for 100 ns.
	  Ard1 <= "00000";
      Ard2 <= "00100";
      Awr <= "00010";
      Din <= "11110000111100001111000011110000";
      WrEn <= '0';
	  Rst <= '1';
      wait for clk_period;
		
	  Ard1 <= "01000";
      Ard2 <= "11000";
      Awr <= "00110";
      Din <= "00000011111100001111000011110000";
      WrEn <= '1';
	  Rst <= '0';
      wait for clk_period;
		
	  Ard1 <= "00000";
      Ard2 <= "00110";
      Awr <= "00010";
      Din <= "11110000111100001111000011110000";
      WrEn <= '1';
	  Rst <= '0';
      wait for clk_period;
		
	  Ard1 <= "00010";
      Ard2 <= "00100";
      Awr <= "00010";
      Din <= "11110000111100001111000011110000";
      WrEn <= '0';
	  Rst <= '0';
      wait for clk_period;

      --wait for Clk_period*10;	

wait;
end process;

end;
