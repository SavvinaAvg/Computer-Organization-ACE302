----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 15:52:42
-- Design Name: 
-- Module Name: MEMSTAGE_TopModule - Behavioral
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

entity MEMSTAGE_TopModule is
--  Port ( );
    port(ByteOp: in std_logic;
         Mem_WrEn: in std_logic;
         ALU_MEM_Addr: in std_logic_vector(31 downto 0);
         MEM_DataIn: in std_logic_vector(31 downto 0);
         MEM_DataOut: out std_logic_vector(31 downto 0);
         clk: in std_logic
        );
end MEMSTAGE_TopModule;

architecture Behavioral of MEMSTAGE_TopModule is
    
--------------------------- MEMSTAGE ------------------------------------
    component MEMSTAGE is
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
    end component;
--------------------------------- RAM -------------------------------------
    component RAM is
        port(clk        :  in std_logic;
             inst_addr  :  in std_logic_vector(10 downto 0);
             inst_dout  :  out std_logic_vector(31 downto 0);
             data_we    :  in std_logic;
             data_addr  :  in std_logic_vector(10 downto 0);
             data_din   :  in std_logic_vector(31 downto 0);
             data_dout  :  out std_logic_vector(31 downto 0)
            );
   end component;
   
   signal MM_WrEn_temp: std_logic;
   signal MM_Addr_temp: std_logic_vector(31 downto 0);
   signal MM_WrData_temp: std_logic_vector(31 downto 0);
   signal MM_RdData_temp: std_logic_vector(31 downto 0);
   
begin

------------------------------- MEMSTAGE ----------------------------------
mem_stage:
    MEMSTAGE port map(ByteOp         =>  ByteOp,
                      Mem_WrEn       =>  Mem_WrEn,
                      ALU_MEM_Addr   =>  ALU_MEM_Addr,
                      MEM_DataIn     =>  MEM_DataIn,
                      MEM_DataOut    =>  MEM_DataOut,
                      MM_WrEn        =>  MM_WrEn_temp,
                      MM_Addr        =>  MM_Addr_temp,
                      MM_WrData      =>  MM_WrData_temp,
                      MM_RdData      =>  MM_RdData_temp
                     );
                     
--------------------------------- RAM -------------------------------------
ram_mem:
    RAM port map(clk        =>  clk,
                 inst_addr  =>  "00000000000",
                 inst_dout  =>  open,
                 data_we    =>  MM_WrEn_temp,
                 data_addr  =>  MM_Addr_temp(12 downto 2),
                 data_din   =>  MM_WrData_temp,
                 data_dout  =>  MM_RdData_temp
                );
                
end Behavioral;
