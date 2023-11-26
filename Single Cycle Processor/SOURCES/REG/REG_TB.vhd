----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2022 17:38:19
-- Design Name: 
-- Module Name: REG_TB - Behavior
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

entity REG_TB is
--  Port ( );
end REG_TB;

architecture Behavior of REG_TB is

component REG
    port(
        CLK: in std_logic;
        RST: in std_logic;
        WE: in std_logic;
        Datain: in std_logic_vector(31 downto 0);
        Dataout: out std_logic_vector(31 downto 0)
    );
    end component;

------- INPUTS ---------------
signal CLK : std_logic := '0';
signal RST : std_logic := '0';
signal WE : std_logic := '0';
signal Datain : std_logic_vector(31 downto 0) := (others => '0');

-------- OUTPUT ----------------
signal Dataout : std_logic_vector(31 downto 0);

-------- CLOCK PERIOD ------------
constant CLK_period : time := 100 ns;

begin

    uut: REG port map(
        CLK => CLK,
        RST => RST,
        WE => WE,
        Datain => Datain,
        Dataout => Dataout
        );
        
CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
		RST<='1';
		WE<='1';
		Datain<=x"0000aaaf";
      wait for CLK_period*10;
		RST<='0';
		WE<='0';
		Datain<=x"0000aaaf";
      wait for CLK_period*10;
		RST<='0';
		WE<='1';
		Datain<=x"0000aaaf";
      wait for CLK_period*10;
		RST<='0';
		WE<='1';
		Datain<=x"ffffffff";
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
