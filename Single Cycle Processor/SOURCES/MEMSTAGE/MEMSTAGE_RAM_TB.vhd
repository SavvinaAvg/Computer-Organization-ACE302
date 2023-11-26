----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 16:13:11
-- Design Name: 
-- Module Name: MEMSTAGE_TB - Behavior
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

entity MEMSTAGE_RAM_TB is
--  Port ( );
end MEMSTAGE_RAM_TB;

architecture Behavior of MEMSTAGE_RAM_TB is

    component MEMSTAGE_TopModule is
        port(ByteOp: in std_logic;
             Mem_WrEn: in std_logic;
             ALU_MEM_Addr: in std_logic_vector(31 downto 0);
             MEM_DataIn: in std_logic_vector(31 downto 0);
             MEM_DataOut: out std_logic_vector(31 downto 0);
             clk: in std_logic
            );
    end component;
    
------------------------- INPUTS ------------------------------
    signal ByteOp: std_logic :=  '0';
    signal Mem_WrEn: std_logic := '0';
    signal ALU_MEM_Addr: std_logic_vector(31 downto 0) := (others => '0');
    signal MEM_DataIn: std_logic_vector(31 downto 0) := (others => '0');
    signal clk: std_logic := '0';     
    
------------------------- OUTPUT ----------------------------------     
    signal MEM_DataOut: std_logic_vector(31 downto 0);
        
------------------- CLOCK PERIOD DEFINITIONS --------------------
    constant clk_period: time := 100ns;
    
begin

    uut: MEMSTAGE_TopModule port map(ByteOp         => ByteOp,
                                     Mem_WrEn       =>  Mem_WrEn,
                                     ALU_MEM_Addr   =>  ALU_MEM_Addr,
                                     MEM_DataIn     =>  MEM_DataIn,
                                     MEM_DataOut    =>  MEM_DataOut,
                                     clk            =>  clk
                                    );
                                    
   clk_process: process
   begin
        clk <= '0';
        wait for clk_period/2;
        
        clk <= '1';
        wait for clk_period/2;
   end process;
   
   stim_proc: process
   begin
   
        ByteOp  <= '0'; --lw
        Mem_WrEn <= '0';
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn <= "00000000000001111111111111111111";
      wait for clk_period;
      
        ByteOp  <= '0'; --sw
        Mem_WrEn <= '1';
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn <= "11111111111111111000000000000000";
      wait for clk_period;
      
        ByteOp  <= '0'; --lw
        Mem_WrEn <= '0';
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn <= "00000000000000111111000000000000";
      wait for clk_period;
      
        ByteOp  <= '0'; --sw
        Mem_WrEn <= '1';
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn <= "00000001111111111100000000000000";
      wait for clk_period;
      
        ByteOp  <= '1'; --lb
        Mem_WrEn <= '0';
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn <= "11111111111111111111111111111111";
      wait for clk_period;
      
        ByteOp  <= '1'; --sb
        Mem_WrEn <= '1';
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn <= "11111111111111111111111111111111";
      wait for clk_period;
      
        ByteOp  <= '1'; --lb
        Mem_WrEn <= '0';
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn <= "00000001111111111111111111111111";
      wait for clk_period;
      
        ByteOp  <= '1'; --sb
        Mem_WrEn <= '1';
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn <= "11111111111111111111111000000000";
      wait for clk_period;
      
        ByteOp  <= '0'; --lw
        Mem_WrEn <= '0';
        ALU_MEM_Addr <= "00000000000000000000000000010000";
        MEM_DataIn <= "00000000000000111111000000000000";
      wait for clk_period;
      
        ByteOp  <= '0'; --sw
        Mem_WrEn <= '1';
        ALU_MEM_Addr <= "00000000000000000000000000010000";
        MEM_DataIn <= "00000001111111111100000000000000";
      wait for clk_period;
      
        ByteOp  <= '1'; --lb
        Mem_WrEn <= '0';
        ALU_MEM_Addr <= "00000000000000000000000000010000";
        MEM_DataIn <= "00000001111111111111111111110000";
      wait for clk_period;
      
        ByteOp  <= '1'; --sb
        Mem_WrEn <= '1';
        ALU_MEM_Addr <= "00000000000000000000000000010000";
        MEM_DataIn <= "00000111111111111111111000000000";
      wait for clk_period;
         
   wait;
   end process;
   
end;
