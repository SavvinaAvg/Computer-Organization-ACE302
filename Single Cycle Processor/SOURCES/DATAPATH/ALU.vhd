----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2021 14:28:47
-- Design Name: 
-- Module Name: Phase_1 - Behavioral
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

use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;
 
use ieee.std_logic_arith.all; 
use ieee.numeric_bit.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
--  Port ( );
port (
        A : in std_logic_vector(31 downto 0);
        B : in std_logic_vector(31 downto 0);
        Op : in std_logic_vector(3 downto 0);
        Output : out std_logic_vector(31 downto 0);
        Zero : out std_logic;
        Cout : out std_logic;
        Ovf : out std_logic
    );
    
end ALU;

architecture Behavioral of ALU is

signal outTemp : std_logic_vector(31 downto 0);
signal temp : std_logic_vector(32 downto 0);
signal ovfTemp, zeroTemp, coutTemp : std_logic;


begin
    Process (A, B, Op, outTemp, ovfTemp, zeroTemp, coutTemp, temp)
    
begin
    temp <= "000000000000000000000000000000000";
	ovfTemp <= '0';
	zeroTemp <= '0';
   
    case Op is
    
    ----- ADDITION -------    
        when "0000" =>
            outTemp <= (A + B);
            temp <= ('0' & A) + ('0' & B);
            coutTemp <= temp(32);
    
    ------ SUBTRACTION -------    
        when "0001" =>
            outTemp <= (A - B);
            temp <= ('0' & A) - ('0' & B);
            coutTemp <= temp(32);
     
     ------- AND GATE --------  
        when "0010" =>
            outTemp <= (A AND B);
      
      -------- OR GATE --------  
        when "0011" =>
            outTemp <= (A OR B);
      
      -------- NOT GATE ------- 
        when "0100" =>
            outTemp <= NOT A;
       
       -------- NAND GATE ----------     
        when "0101" =>
            outTemp <= NOT(A AND B);
       
      --------- NOR GATE ----------- 
        when "0110" =>
            outTemp <= NOT(A OR B);
     
     -------- ARITHMETIC RIGHT SHIFT ------------   
        when "1000" =>
            outTemp(31) <= A(31);
            outTemp(30 downto 0) <= A(31 downto 1);
     
     -------- LOGIC RIGHT SHIFT ----------------   
        when "1001" =>
            outTemp(31) <= '0';
            outTemp(30 downto 0) <= A(31 downto 1);
    
    --------- LOGIC LEFT  SHIFT -----------------    
        when "1010" =>
            outTemp(0) <= '0';
            outTemp(31 downto 1) <= A(30 downto 0);
     
     --------- LEFT ROTATE ----------------   
        when "1100" =>
            outTemp(0) <= A(31);
            outTemp(31 downto 1) <= A(30 downto 0);
     
     ---------- RIGHT ROTATE -----------   
        when "1101" =>
            outTemp(31) <= A(0);
            outTemp(30 downto 0) <= A(31 downto 1);
        
        when others =>
            null;
           
    end case;
    
    --------------------- ZERO --------------------------
    if (outTemp = "00000000000000000000000000000000") then
        zeroTemp <= '1';
    else
        zeroTemp <= '0';
    end if;
    
    ----------------------- OVF -------------------------------
    if(((A(31) = '0') and (B(31)= '0') and (outTemp(31) = '1')) OR ((A(31) ='1') and (B(31)='1') and (outTemp(31)='0')))  then
        ovfTemp <= '1';
    else
        ovfTemp <= '0';
    end if;
    

Output <= outTemp   after 10ns;
Zero <= zeroTemp    after 10ns;
Cout <= coutTemp    after 10ns;
Ovf <= ovfTemp      after 10ns;

end Process;
end Behavioral;

