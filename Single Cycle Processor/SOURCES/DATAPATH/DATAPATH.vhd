----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 15:58:16
-- Design Name: 
-- Module Name: DATAPATH - Behavioral
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

entity DATAPATH is
--  Port ( );
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
        
end DATAPATH;

architecture Behavioral of DATAPATH is

----------------------------- IFSTAGE -----------------------------------
    component IFSTAGE is
        port(PC_Immed:   in std_logic_vector(31 downto 0);
             PC_sel:     in std_logic;
             PC_LdEn:    in std_logic;
             Reset:      in std_logic;
             Clk:        in std_logic;
             PC:         out std_logic_vector(31 downto 0)
         );
    end component;
    
------------------------------ DECSTAGE --------------------------------------
    component DECSTAGE is
        port(Instr:            in std_logic_vector(31 downto 0);
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
    
-------------------------------- EXSTAGE --------------------------------
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

------------------------------- MEMSTAGE ---------------------------------
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
    
------------------------------- SIGNALS ------------------------------
    signal ALU_out_temp: std_logic_vector(31 downto 0);
    signal MEM_out_temp: std_logic_vector(31 downto 0);
    signal RF_A_temp: std_logic_vector(31 downto 0);
    signal RF_B_temp: std_logic_vector(31 downto 0);
    signal Immed_temp: std_logic_vector(31 downto 0);
    
begin

--------------------------- IFSTAGE -----------------------------------
if_stage:
    IFSTAGE port map(PC_Immed   =>  Immed_temp,
                     PC_sel     =>  PC_sel,
                     PC_LdEn    =>  PC_LdEn,
                     Reset      =>  rst,
                     Clk        =>  clk,
                     PC         =>  PC
                   );
                   
--------------------------- DECSTAGE -----------------------------------
dec_stage:
    DECSTAGE port map(Instr          =>  Instr,
                      RF_WrEn        =>  RF_WrEn,
                      ALU_out        =>  ALU_out_temp,
                      MEM_out        =>  MEM_out_temp,
                      RF_WrData_sel  =>  RF_WrData_sel,
                      RF_B_sel       =>  RF_B_sel,
                      ImmExt         =>  ImmExt,
                      Clk            =>  clk,
                      Rst            =>  rst,
                      Immed          =>  Immed_temp,
                      RF_A           =>  RF_A_temp,
                      RF_B           =>  RF_B_temp
                     );
                     
----------------------------- EXSTAGE -----------------------------------
ex_stage:
    EXSTAGE port map(RF_A          =>  RF_A_temp,
                     RF_B          =>  RF_B_temp,
                     Immed         =>  Immed_temp,
                     ALU_Bin_sel   =>  ALU_Bin_sel,
                     ALU_func      =>  ALU_func,
                     ALU_out       =>  ALU_out_temp,
                     ALU_zero      =>  ALU_zero
                    );
                    
--------------------------- MEMSTAGE ----------------------------------
mem_stage:
    MEMSTAGE port map(ByteOp        =>  ByteOp,
                      Mem_WrEn      =>  Mem_WrEn,
                      ALU_MEM_Addr  =>  ALU_out_temp,
                      MEM_DataIn    =>  RF_B_temp,
                      MEM_DataOut   =>  MEM_out_temp,
                      MM_WrEn       =>  MM_WrEn,           
                      MM_Addr       =>  MM_Addr,
                      MM_WrData     =>  MM_WrData,
                      MM_RdData     =>  MM_RdData
                     );
                     
  
end Behavioral;
