----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 14:40:10
-- Design Name: 
-- Module Name: MEMSTAGE - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
--  Port ( );
    port(ByteOp: in std_logic;
         Mem_WrEn: in std_logic;
         ALU_MEM_Addr: in std_logic_vector(31 downto 0);
         MEM_DataIn: in std_logic_vector(31 downto 0);
         MEM_DataOut: out std_logic_vector(31 downto 0);
         MM_WrEn: out std_logic;
         MM_Addr: out std_logic_vector(31 downto 0);
         MM_WrData: out std_logic_vector(31 downto 0);
         MM_RdData: in std_logic_vector(31 downto 0)
        );
        
end MEMSTAGE;


architecture Behavioral of MEMSTAGE is
    signal MM_WrData_temp: std_logic_vector(7 downto 0);
    signal MEM_DataOut_temp: std_logic_vector(7 downto 0);
    
begin

    process(ALU_MEM_Addr, Mem_WrEn, MEM_DataIn, MM_RdData, MM_WrData_temp, MEM_DataOut_temp, ByteOp)
    begin
        
        MM_WrEn <= MEM_WrEn;
        MM_Addr <= ALU_MEM_Addr + x"400"; -- offset
        
        if ByteOp = '0' then -- sw/lw
            MM_WrData <= MEM_DataIn; 
            MEM_DataOut <= MM_RdData;
            
        else -- sb/lb
            MM_WrData_temp <= MEM_DataIn(7 downto 0);
            MM_WrData <= ("000000000000000000000000" & MM_WrData_temp);
            
            MEM_DataOut_temp <= MM_RdData(7 downto 0);
            MEM_DataOut <= ("000000000000000000000000" & MEM_DataOut_temp);
            
       end if;
   end process;
   
   
end Behavioral;
