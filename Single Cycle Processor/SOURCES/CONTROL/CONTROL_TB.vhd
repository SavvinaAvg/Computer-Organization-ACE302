----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 20:37:38
-- Design Name: 
-- Module Name: CONTROL_TB - Behavior
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

entity CONTROL_TB is
--  Port ( );
end CONTROL_TB;

architecture Behavior of CONTROL_TB is

    component CONTROL is
        port(Instr: in std_logic_vector(31 downto 0);
             zero: in std_logic;
             rst: in std_logic;
             --IFSTAGE
             PC_sel: out std_logic;
             PC_LdEn: out std_logic;
             --DECSTAGE
             ImmExt: out std_logic_vector(1 downto 0);
             RF_WrEn: out std_logic;
             RF_B_sel: out std_logic;
             RF_WrData_sel: out std_logic;
             --EXSTAGE
             ALU_Bin_sel: out std_logic;
             ALU_func: out std_logic_vector(3 downto 0);
             --MEMSTAGE
             ByteOp: out std_logic;
             Mem_WrEn: out std_logic
           );
    end component;
    
---------------------------- INPUTS -------------------------------
    signal Instr: std_logic_vector(31 downto 0) := (others => '0');
    signal zero: std_logic := '0';
    signal rst: std_logic := '0';
    
----------------------------- OUTPUTS -----------------------------
    signal PC_sel: std_logic;
    signal PC_LdEn: std_logic;
    signal ImmExt: std_logic_vector(1 downto 0);
    signal RF_WrEn: std_logic;
    signal RF_B_sel: std_logic;
    signal RF_WrData_sel: std_logic;
    signal ALU_Bin_sel: std_logic;
    signal ALU_func: std_logic_vector(3 downto 0);
    signal ByteOp: std_logic;
    signal Mem_WrEn: std_logic;
      
    
begin

    uut: CONTROL port map(Instr         =>  Instr,
                          zero          =>  zero,
                          rst           =>  rst,
                          --IFSTAGE
                          PC_sel        =>  PC_sel,
                          PC_LdEn       =>  PC_LdEn,
                          --DECSTAGE
                          ImmExt        =>  ImmExt,
                          RF_WrEn       =>  RF_WrEn,
                          RF_B_sel      =>  RF_B_sel,
                          RF_WrData_sel =>  RF_WrData_sel,
                          --EXSTAGE
                          ALU_Bin_sel   =>  ALU_Bin_sel,
                          ALU_func      =>  ALU_func,
                          --MEMSTAGE
                          ByteOp        =>  ByteOp,
                          Mem_WrEn      =>  Mem_WrEn
                        );
                        
                        
    stim_proc: process
        begin
        
        rst <= '1';
        wait for 100ns;
        
        rst <= '0';
        
        Instr <= "10000000000000000000000000110000"; -- add
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110000"; -- add
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110001"; -- sub
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110001"; -- sub
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110010"; -- and
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110010"; -- and
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110011"; -- or
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110011"; -- or
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110100"; -- not
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110100"; -- not
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110101"; -- nand
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110101"; -- nand
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110110"; -- nor
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000110110"; -- nor
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111000"; -- sra
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111000"; -- sra
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111001"; -- srl
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111001"; -- srl
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111010"; -- sll
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111010"; -- sll
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111100"; -- rol
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111100"; -- rol
        zero <= '1';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111101"; -- ror
        zero <= '0';
        wait for 100ns;
        
        Instr <= "10000000000000000000000000111101"; -- ror
        zero <= '1';
        wait for 100ns;
        
-------------------------------------------------------------------------------------
        
        Instr <= "11100000000000000000000000110100"; -- li
        zero <= '0';
        wait for 100ns;
        
        Instr <= "11100000000000000000000000110100"; -- li
        zero <= '1';
        wait for 100ns;
        
        Instr <= "11100100000000000000000000110100"; -- lui
        zero <= '0';
        wait for 100ns;
        
        Instr <= "11100100000000000000000000110100"; -- lui
        zero <= '1';
        wait for 100ns;
        
        Instr <= "11000000000000000000000000110100"; -- addi
        zero <= '0';
        wait for 100ns;
        
        Instr <= "11000000000000000000000000110100"; -- addi
        zero <= '1';
        wait for 100ns;
        
        Instr <= "11001000000000000000000000110100"; -- nandi
        zero <= '0';
        wait for 100ns;
        
        Instr <= "11001000000000000000000000110100"; -- nandi
        zero <= '1';
        wait for 100ns;
        
        Instr <= "11001100000000000000000000110100"; -- ori
        zero <= '0';
        wait for 100ns;
        
        Instr <= "11001100000000000000000000110100"; -- ori
        zero <= '1';
        wait for 100ns;
        
        Instr <= "11111100000000000000000000110100"; -- b
        zero <= '0';
        wait for 100ns;
        
        Instr <= "11111100000000000000000000110100"; -- b
        zero <= '1';
        wait for 100ns;
        
        Instr <= "00000000000000000000000000110100"; -- beq
        zero <= '0';
        wait for 100ns;
        
        Instr <= "00000000000000000000000000110100"; -- beq
        zero <= '1';
        wait for 100ns;
        
        Instr <= "00000100000000000000000000110100"; -- bne
        zero <= '0';
        wait for 100ns;
        
        Instr <= "00000100000000000000000000110100"; -- bne
        zero <= '1';
        wait for 100ns;
        
        Instr <= "00001100000000000000000000110100"; -- lb
        zero <= '0';
        wait for 100ns;
        
        Instr <= "00001100000000000000000000110100"; -- lb
        zero <= '1';
        wait for 100ns;
        
        Instr <= "00011100000000000000000000110100"; -- sb
        zero <= '0';
        wait for 100ns;
        
        Instr <= "00011100000000000000000000110100"; -- sb
        zero <= '1';
        wait for 100ns;
        
        Instr <= "00111100000000000000000000110100"; -- lw
        zero <= '0';
        wait for 100ns;
        
        Instr <= "00111100000000000000000000110100"; -- lw
        zero <= '1';
        wait for 100ns;
        
        Instr <= "01111100000000000000000000110100"; -- sw
        zero <= '0';
        wait for 100ns;
        
        Instr <= "01111100000000000000000000110100"; -- sw
        zero <= '1';
        wait for 100ns;
    
    wait;   
    end process;

end;
