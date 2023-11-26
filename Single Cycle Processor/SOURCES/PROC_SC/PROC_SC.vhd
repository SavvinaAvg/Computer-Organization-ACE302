----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 23:07:04
-- Design Name: 
-- Module Name: PROC_SC - Behavioral
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

entity PROC_SC is
--  Port ( );
    port(rst: in std_logic;
         clk: in std_logic
         );
end PROC_SC;

architecture Behavioral of PROC_SC is

------------------------------ DATAPATH ---------------------------------
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
    
------------------------------- CONTROL -----------------------------------
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
    
-------------------------------- RAM -----------------------------------
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

    signal PC_sel_temp: std_logic;
    signal PC_LdEn_temp: std_logic;
    signal PC_temp: std_logic_vector(31 downto 0);
    signal RF_WrEn_temp: std_logic;
    signal RF_WrData_sel_temp: std_logic;
    signal RF_B_sel_temp: std_logic;
    signal ImmExt_temp: std_logic_vector(1 downto 0);
    signal Instr_temp: std_logic_vector(31 downto 0);
    signal ALU_Bin_sel_temp : std_logic;
    signal ALU_func_temp: std_logic_vector(3 downto 0);
    signal ALU_zero_temp: std_logic;
    signal ByteOp_temp: std_logic;
    signal MEM_WrEn_temp: std_logic;
    signal MEM_WrEn_temp1: std_logic;
    --signal MM_WrEn_temp: std_logic;
    signal MM_Addr_temp: std_logic_vector(31 downto 0);
    signal MM_WrData_temp: std_logic_vector(31 downto 0);
    signal MM_RdData_temp: std_logic_vector(31 downto 0);

begin

------------------------------- DATAPATH ------------------------------------
    datapath_sc:
        DATAPATH port map(--IFSTAGE
                          PC_sel            =>  PC_sel_temp,
                          PC_LdEn           =>  PC_LdEn_temp,
                          PC                =>  PC_temp,
                          --DECSTAGE
                          RF_WrEn           =>  RF_WrEn_temp,
                          RF_WrData_sel     =>  RF_WrData_sel_temp,
                          RF_B_sel          =>  RF_B_sel_temp,
                          ImmExt            =>  ImmExt_temp,
                          Instr             =>  Instr_temp,
                          --EXSTAGE
                          ALU_Bin_sel       =>  ALU_Bin_sel_temp,
                          ALU_func          =>  ALU_func_temp,
                          ALU_zero          =>  ALU_zero_temp,
                          --MEMSTAGE
                          ByteOp            =>  ByteOp_temp,
                          Mem_WrEn          =>  MEM_WrEn_temp1,
                          MM_WrEn           =>  MEM_WrEn_temp,
                          MM_Addr           =>  MM_Addr_temp,
                          MM_WrData         =>  MM_WrData_temp,
                          MM_RdData         =>  MM_RdData_temp,
                          ---------
                          clk               =>  clk,
                          rst               =>  rst
                         );
                         
--------------------------------- CONTROL -----------------------------
    control_sc:
        CONTROL port map(Instr              =>  Instr_temp,
                         zero               =>  ALU_zero_temp,
                         rst                =>  rst,
                         --IFSTAGE
                         PC_sel             =>  PC_sel_temp,
                         PC_LdEn            =>  PC_LdEn_temp,
                          --DECSTAGE
                         ImmExt             =>  ImmExt_temp,
                         RF_WrEn            =>  RF_WrEn_temp,
                         RF_B_sel           =>  RF_B_sel_temp,
                         RF_WrData_sel      =>  RF_WrData_sel_temp,
                         --EXSTAGE
                         ALU_Bin_sel        =>  ALU_Bin_sel_temp,
                         ALU_func           =>  ALU_func_temp,
                         --MEMSTAGE
                         ByteOp             =>  ByteOp_temp,
                         Mem_WrEn           =>  MEM_WrEn_temp1
                        );

---------------------------------- RAM --------------------------------
    ram_sc:
        RAM port map(clk        =>  clk,
                     inst_addr  =>  PC_temp(12 downto 2),
                     inst_dout  =>  Instr_temp,
                     data_we    =>  MEM_WrEn_temp,
                     data_addr  =>  MM_Addr_temp(12 downto 2),
                     data_din   =>  MM_WrData_temp,
                     data_dout  =>  MM_RdData_temp
                    );

end Behavioral;
