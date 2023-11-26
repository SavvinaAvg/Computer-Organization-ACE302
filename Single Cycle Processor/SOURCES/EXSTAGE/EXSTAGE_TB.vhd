----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 14:10:42
-- Design Name: 
-- Module Name: EXSTAGE_TB - Behavior
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

entity EXSTAGE_TB is
--  Port ( );
end EXSTAGE_TB;

architecture Behavior of EXSTAGE_TB is

    component EXSTAGE is
        port(RF_A: in std_logic_vector(31 downto 0);
             RF_B: in std_logic_vector(31 downto 0);
             Immed: in std_logic_vector(31 downto 0);
             ALU_Bin_sel: in std_logic;
             ALU_func: in std_logic_vector(3 downto 0);
             ALU_out: out std_logic_vector(31 downto 0);
             ALU_zero: out std_logic
            );
    end component;
    
--------------------------- INPUTS ------------------------------
    signal RF_A: std_logic_vector(31 downto 0) := (others => '0');
    signal RF_B: std_logic_vector(31 downto 0) := (others => '0');
    signal Immed: std_logic_vector(31 downto 0) := (others => '0');
    signal ALU_Bin_sel: std_logic := '0';
    signal ALU_func: std_logic_vector(3 downto 0) := (others => '0');
         
---------------------------- OUTPUTS ------------------------------
    signal ALU_out: std_logic_vector(31 downto 0);
    signal ALU_zero: std_logic;

begin

    uut: EXSTAGE port map(RF_A          =>  RF_A,
                          RF_B          =>  RF_B,
                          Immed         =>  Immed,
                          ALU_Bin_sel   =>  ALU_Bin_sel,
                          ALU_func      =>  ALU_func,
                          ALU_out       =>  ALU_out,
                          ALU_zero      =>  ALU_zero
                         );
                         
   stim_proc: process
        begin
        
        wait for 100ns;
        RF_A  <= "00000000000000000000000000000000";
		RF_B  <= "00000000000000000000000000000000";
		Immed <= "00000000000000000000000001000011";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0000";
	wait for 100 ns;  
	
	    RF_A  <= "00000000000000000000000000000000";
		RF_B  <= "00000000000000000000000000000111";
		Immed <= "00000000000000000000000000000011";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0000";
	wait for 100 ns; 
	
	    RF_A  <= "00000000000000000000000000000000";
		RF_B  <= "00010000111100001000101000011000";
		Immed <= "00000000000000000000000001000011";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0001";
	wait for 100 ns;
		
		RF_A  <= "10000000000000000000000000000000";
		RF_B  <= "01111111111111111111111111111111";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0001";
	wait for 100 ns;  
	
	    RF_A  <= "00000000000000000000000000000000";
		RF_B  <= "11111111111111111111111111111110";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0010";
	wait for 100 ns;
		
		RF_A  <= "00000000000000000000000000000000";
		RF_B  <= "11111111111111111111111111111111";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0010";
	wait for 100 ns;
	
	    RF_A  <= "00000000000000000000000111111111";
		RF_B  <= "11111111111111111111111111111100";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0110";
	wait for 100 ns;
	
	    RF_A  <= "00000000000000000000000000001111";
		RF_B  <= "00011111111111111111111111111111";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0110";
	wait for 100 ns;
	
	    RF_A  <= "00000000000000000000000000000011";
		RF_B  <= "00000111111111111111111111111111";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0100";
	wait for 100 ns;
	
	    RF_A  <= "00000000000000000000000011111111";
		RF_B  <= "01111111111111111111111111111110";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0100";
	wait for 100 ns;
	
	    RF_A  <= "00000000000000000000000000000000";
		RF_B  <= "01111111111111111111111111111110";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0011";
	wait for 100 ns;
	   
	    RF_A  <= "00000000000000000000000011111111";
		RF_B  <= "01111111111111111111111111111000";
		Immed <= "00000000000000000000000001000000";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0011";
	wait for 100 ns;
	
	wait;
	end process;

end;
