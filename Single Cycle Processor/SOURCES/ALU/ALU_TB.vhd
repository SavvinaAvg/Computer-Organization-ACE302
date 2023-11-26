----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2022 16:29:33
-- Design Name: 
-- Module Name: ALU_TB - Behavioral
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

entity ALU_TB is
--  Port ( );
end ALU_TB;

architecture Behavior of ALU_TB is

component ALU
    port(
        A : in std_logic_vector(31 downto 0);
        B : in std_logic_vector(31 downto 0);
        Op : in std_logic_vector(3 downto 0);
        Output : out std_logic_vector(31 downto 0);
        Zero : out std_logic;
        Cout : out std_logic;
        Ovf : out std_logic
        );
end component;
     
----------------INPUTS---------------
    signal A : std_logic_vector(31 downto 0) := (others => '0');
    signal B : std_logic_vector(31 downto 0) := (others => '0');
    signal Op: std_logic_vector(3 downto 0)  := (others => '0');

----------------OUTPUTS--------------
    signal Output : std_logic_vector(31 downto 0);
    signal Zero : std_logic;
    signal Cout : std_logic;
    signal Ovf : std_logic; 
    
begin

    uut: ALU port map(
        A => A,
        B => B,
        Op => Op,
        Output => Output,
        Zero => Zero,
        Cout => Cout,
        Ovf => Ovf
        );
        
    stim_proc: process
    begin
    
    -- 1 --
    A <= "00000000000000000000000000000000";
	B <= "00000000000000000000000000000000";
	Op <= "0000";
	wait for 100 ns;
	
	-- 2 --
	A <= "00000000000000000000000000000001";
	B <= "00000000000000000000000000000000";
	Op <= "0101";
	wait for 100 ns;
        
    -- 3 --
    A <= "00000000000000000000000000000000";
	B <= "00000000000000000000000000000001";
	Op <= "0010";
	wait for 100 ns;
	
	-- 4 --
	A <= "10000000000000000000000000000000";
	B <= "00000000000000000000000000000000";
	Op <= "1100";
	wait for 100 ns;
	
	-- 5 --
	A <= "00000000000000000000000000000000";
	B <= "10000000000000000000000000000000";
	Op <= "1001";
	wait for 100 ns;
	
	-- 6 --
	A <= "10000000000000000000000000000001";
	B <= "10000000000000000000000000000001";
	Op <= "1000";
	wait for 100 ns;
	 
	-- 7 --
	A <= "10000000000000000000000000000000";
	B <= "10000000000000000000000000000000";
	Op <= "0000";
	wait for 100 ns;
	
	-- 8 --
	A <= "00010000100000100000100001000000";
	B <= "01001000100011000000011010000000";
	Op <= "0011";
	wait for 100 ns;
	
    -- 9 --
	A <= "11111111111111111111111111111111";
	B <= "00010000000010010001001101000000";
	Op <= "1100";
	wait for 100 ns;
	
	-- 10 --
	A <= "10000000000000000000000000000000";
	B <= "11111111111111111111111111111111";
	Op <= "1010";
	wait for 100 ns;
	
	-- 11 --
	A <= "01111111111110000000000000000001";
	B <= "11111111111111111111111111111111";
	Op <= "0110";
	wait for 100 ns;
	
	-- 12 --
	A <= "00000000000000000000000000000000";
	B <= "01111111111111111111111111111111";
	Op <= "1101";
	wait for 100 ns;
	
	-- 13 --
	A <= "01111111111111111111111111111111";
	B <= "11111111111111111111111111111111";
	Op <= "0001";
	wait for 100 ns;
	
	-- 14 --
	A <= "11111111111111111111111111111111";
	B <= "00000000000000000000000000000000";
	Op <= "1010";
	wait for 100 ns;
	
	-- 15 --
	A <= "11111111111111111111111111111111";
	B <= "11111111111111111111111111111110";
	Op <= "0100";
	wait for 100 ns;
	
	-- 16 --
	A <= "11111111111111111111111111111111";
	B <= "11111111111111111111111111111111";
	Op <= "1001";
	wait for 100 ns;
	
	wait;
	
end process;
end;
