----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 18:27:47
-- Design Name: 
-- Module Name: DATAPATH_TB - Behavior
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

entity DATAPATH_TB is
--  Port ( );
end DATAPATH_TB;

architecture Behavior of DATAPATH_TB is

    component DATAPATH is
        port(--IFSTAGE
             PC_sel: in std_logic;
             PC_LdEn: in std_logic;
             PC: out std_logic_vector(31 downto 0);
             --DECSTAGE
             RF_WrEn: in std_logic;
             RF_WrData_sel: in std_logic;
             RF_B_sel: in std_logic;
             ImmExt: in std_logic_vector(1 downto 0);
             Instr: in std_logic_vector(31 downto 0);
             --EXSTAGE
             ALU_Bin_sel: in std_logic;
             ALU_func: in std_logic_vector(3 downto 0);
             ALU_zero: out std_logic;
             --MEMSTAGE
             ByteOp: in std_logic;
             Mem_WrEn: in std_logic;
             MM_WrEn: out std_logic;
             MM_Addr: out std_logic_vector(31 downto 0);
             MM_WrData: out std_logic_vector(31 downto 0);
             MM_RdData: in std_logic_vector(31 downto 0);
             ---------
             clk: in std_logic;
             rst: in std_logic
            );
            
    end component;
    
------------------------------ INPUTS -------------------------------------
    signal PC_sel: std_logic := '0';
    signal PC_LdEn: std_logic := '0';
    signal RF_WrEn: std_logic := '0';
    signal RF_WrData_sel: std_logic := '0';
    signal RF_B_sel: std_logic := '0';
    signal ImmExt: std_logic_vector(1 downto 0) := (others => '0');
    signal Instr: std_logic_vector(31 downto 0) := (others => '0');
    signal ALU_Bin_sel: std_logic := '0';
    signal ALU_func: std_logic_vector(3 downto 0) := (others => '0');
    signal ByteOp: std_logic := '0';
    signal Mem_WrEn: std_logic := '0';
    signal MM_RdData: std_logic_vector(31 downto 0) := (others => '0');
    signal clk: std_logic := '0';
    signal rst: std_logic := '0';
    
----------------------------- OUTPUTS -----------------------------------
    signal PC: std_logic_vector(31 downto 0);
    signal ALU_zero: std_logic;
    signal MM_WrEn: std_logic;
    signal MM_Addr: std_logic_vector(31 downto 0);
    signal MM_WrData: std_logic_vector(31 downto 0);

--------------------- CLOCK PERIOD DEFINITIONS ----------------------
    constant clk_period: time := 100ns;
        
    begin
    
        uut: DATAPATH port map(--IFSTAGE
                               PC_sel           =>  PC_sel,
                               PC_LdEn          =>  PC_LdEn,
                               PC               =>  PC,
                               --DECSTAGE
                               RF_WrEn          =>  RF_WrEn,
                               RF_WrData_sel    =>  RF_WrData_sel,
                               RF_B_sel         =>  RF_B_sel,
                               ImmExt           =>  ImmExt,
                               Instr            =>  Instr,
                               --EXSTAGE
                               ALU_Bin_sel      =>  ALU_Bin_sel,
                               ALU_func         =>  ALU_func,
                               ALU_zero         =>  ALU_zero,
                               --MEMSTAGE
                               ByteOp           =>  ByteOp,
                               Mem_WrEn         =>  Mem_WrEn,
                               MM_WrEn          =>  MM_WrEn,
                               MM_Addr          =>  MM_Addr,
                               MM_WrData        =>  MM_WrData,
                               MM_RdData        =>  MM_RdData,
                               ---------
                               clk              =>  clk,
                               rst              =>  rst
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
        
            rst <= '1';
            wait for 100ns;
            
            rst <= '0';
            
            PC_sel <= '0';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '1'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '1'; 	
		    ALU_func <= "0000"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "01"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "00000000000000001010101111001101";			
        wait for clk_period;
            
            PC_sel <= '0';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '1'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '1'; 	
		    ALU_func <= "0101"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "10"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "00000000000000001010101111001101";				
        wait for clk_period;
        
            PC_sel <= '0';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '0'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '1'; 	
		    ALU_func <= "0011"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "00"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "00000000000000001010101111001101";				
        wait for clk_period;
        
            PC_sel <= '0';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '0'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '0'; 	
		    ALU_func <= "0100"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "00"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "00000000000000001010101111001101";				
        wait for clk_period;
        
            PC_sel <= '0';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '0'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '0'; 	
		    ALU_func <= "0001"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "00"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "00000000000000001010101111001101";				
        wait for clk_period;
            
            PC_sel <= '0';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '0'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '0'; 	
		    ALU_func <= "0100"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "01"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "00000000000000001010101111001101";				
        wait for clk_period;
            
            PC_sel <= '1';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '1'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '0';
		    ALU_Bin_sel <= '0'; 	
		    ALU_func <= "0001"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "10"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "11111111000000001010101111001101";				
        wait for clk_period;
            
            PC_sel <= '1';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '1'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '0';
		    ALU_Bin_sel <= '0'; 	
		    ALU_func <= "0001"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "00"; 
		    Instr <= "00001100000100000000000000000100";
		    MM_RdData <= "00000000000000000000000000000000";				
        wait for clk_period;
            
            PC_sel <= '0';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '1'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '0'; 	
		    ALU_func <= "0110"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '0';
		    ImmExt <= "01";
		    Instr <= "00001100000100000000111100000100";
		    MM_RdData <= "00000000000000001010101111001101";	 			
        wait for clk_period;
        
            PC_sel <= '1';
	        PC_LdEn <= '1'; 
		    RF_B_sel <= '1'; 
		    RF_WrData_sel <= '0';
		    RF_WrEn <= '1';
		    ALU_Bin_sel <= '0'; 	
		    ALU_func <= "0001"; 	
		    Mem_WrEn <= '0';
		    ByteOp <= '1';
		    ImmExt <= "10"; 
		    Instr <= "00001100000100000000000000011100";
		    MM_RdData <= "00000000000000000000000000000000";				
        wait for clk_period;
            
        wait;
        end process;
    end;
