----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 12:58:20
-- Design Name: 
-- Module Name: DECSTAGE_TB - Behavior
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

entity DECSTAGE_TB is
--  Port ( );
end DECSTAGE_TB;

architecture Behavior of DECSTAGE_TB is

    component DECSTAGE is
        port( Instr:            in std_logic_vector(31 downto 0);
              RF_WrEn:          in std_logic;
              ALU_out:          in std_logic_vector(31 downto 0);
              MEM_out:          in std_logic_vector(31 downto 0);
              RF_WrData_sel:    in std_logic;
              RF_B_sel:         in std_logic;
              ImmExt:           in std_logic_vector(1 downto 0);
              Clk:              in std_logic;
              Rst:              in std_logic;
              Immed:            out std_logic_vector(31 downto 0);
              RF_A:             out std_logic_vector(31 downto 0);
              RF_B:             out std_logic_vector(31 downto 0)
           );
   end component;
   
---------------------------- INPUTS ---------------------------------
   signal Instr: std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn: std_logic := '0';
   signal ALU_out: std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out: std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel: std_logic := '0';
   signal RF_B_sel: std_logic := '0';
   signal ImmExt: std_logic_vector(1 downto 0) := (others => '0');
   signal Clk: std_logic := '0';
   signal Rst: std_logic := '0';
   
--------------------------- OUTPUTS ------------------------------
   signal Immed: std_logic_vector(31 downto 0);
   signal RF_A: std_logic_vector(31 downto 0);
   signal RF_B: std_logic_vector(31 downto 0);

------------------- CLOCK PERIOD DEFINITIONS -------------------------
    constant clk_period: time := 100ns;
    
begin

    uut: DECSTAGE port map(Instr            =>  Instr,
                           RF_WrEn          =>  RF_WrEn,
                           ALU_out          =>  ALU_out,
                           MEM_out          =>  MEM_out,
                           RF_WrData_sel    =>  RF_WrData_sel,
                           RF_B_sel         =>  RF_B_sel,
                           ImmExt           =>  ImmExt,
                           Clk              =>  Clk,
                           Rst              =>  Rst,
                           Immed            =>  Immed,
                           RF_A             =>  RF_A,
                           RF_B             =>  RF_B
                          );
                          
   clk_process: process
   begin
        Clk <= '0';
        wait for clk_period/2;
        
        Clk <= '1';
        wait for clk_period/2;
   end process;
   
   stim_proc: process
   begin
   
        rst <= '1';
        wait for clk_period;
        
        rst <= '0';
        
        Instr <= "00001100010000010000000000000000"; 
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '0'; -- alu 
		RF_B_sel <= '1'; -- Instr(20-16)
		ImmExt <= "00";   
      wait for clk_period;    
        
        Instr <= "00001100010000010000000000000000"; 
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '0'; -- alu 
		RF_B_sel <= '1'; -- Instr(20-16)
		ImmExt <= "00";   
      wait for clk_period;                         

        Instr <= "00000000000000000000000000000000"; 
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '1'; -- mem 
		RF_B_sel <= '0'; -- Instr(15-11)
		ImmExt <= "00";   
      wait for clk_period;  
        
        Instr <= "00000000001000111111111111111111"; 
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '1'; -- mem 
		RF_B_sel <= '1'; -- Instr(20-16) 
		ImmExt <= "00";   
      wait for clk_period; 
        
        Instr <= "11100000011001000010011111000000"; 
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '0'; -- alu 
		RF_B_sel <= '1'; -- Instr(20-16)
		ImmExt <= "00";   
      wait for clk_period;     
        
        Instr <= "11100000011001000010011111000000"; 
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '1'; -- mem 
		RF_B_sel <= '0'; -- Instr(15-11)
		ImmExt <= "00";   
      wait for clk_period;     
        
        Instr <= "00001100010000100000000000000000"; 
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '0'; -- alu 
		RF_B_sel <= '0'; -- Instr(15-11)
		ImmExt <= "00";   
      wait for clk_period;         
        
        Instr <= "00001100010000100000000000000000"; 
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '0'; -- alu 
		RF_B_sel <= '1'; -- Instr(20-16)
		ImmExt <= "01";   
      wait for clk_period;     
        
        Instr <= "00000000001000111111111111111111"; 
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '1'; -- mem 
		RF_B_sel <= '0'; -- Instr(15-11)
		ImmExt <= "10";   
      wait for clk_period;     
        
        Instr <= "00000000001000111111111111111111"; 
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000001";
		RF_WrData_sel <= '1'; -- mem 
		RF_B_sel <= '1'; -- Instr(20-16)
		ImmExt <= "11";   
      wait for clk_period;     
        
      wait;
    end process; 
end;
