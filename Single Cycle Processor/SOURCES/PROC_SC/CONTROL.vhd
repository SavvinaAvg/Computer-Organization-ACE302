----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 14:03:48
-- Design Name: 
-- Module Name: CONTROL - Behavioral
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

entity CONTROL is
--  Port ( );
    port(Instr: in std_logic_vector(31 downto 0);
         --Op: in std_logic_vector(5 downto 0);
         --func: in std_logic_vector(5 downto 0);
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
end CONTROL;

architecture Behavioral of CONTROL is

    signal Rs: std_logic_vector(4 downto 0);
    signal Rd: std_logic_vector(4 downto 0);
    signal Op: std_logic_vector(5 downto 0);
    signal func: std_logic_vector(5 downto 0);
    

begin

    process(Instr, zero)
    begin
    
    Op <= Instr(31 downto 26);
    Rd <= Instr(25 downto 21);
    Rs <= Instr(20 downto 16);
    
    --  R Type --
        if Op = "100000" then  
           PC_sel <= '0';
           PC_LdEn <= '1';         -- write to register
           RF_B_sel <= '0';        -- Instr(15-11)        
           RF_WrEn <= '1';         -- write to rf
           RF_WrData_sel <= '0';   -- ALU  
           ImmExt <= "00";
           ALU_Bin_sel <= '0';     -- RF_B
           func <= Instr(5 downto 0);  -- func from ALU
                
                   if func = "110000" then ALU_func <= "0000"; -- add
                elsif func = "110001" then ALU_func <= "0001"; -- sub
                elsif func = "110010" then ALU_func <= "0010"; -- and
                elsif func = "110011" then ALU_func <= "0011"; -- or
                elsif func = "110100" then ALU_func <= "0100"; -- not
                elsif func = "110101" then ALU_func <= "0101"; -- nand
                elsif func = "110110" then ALU_func <= "0110"; -- nor
                elsif func = "111000" then ALU_func <= "1000"; -- sra
                elsif func = "111001" then ALU_func <= "1001"; -- srl
                elsif func = "111010" then ALU_func <= "1010"; -- sll
                elsif func = "111100" then ALU_func <= "1100"; -- rol
                elsif func = "111101" then ALU_func <= "1101"; -- ror
                end if;
                              
            Mem_WrEn <= '0';        
            ByteOp <= '0';          -- dont care
--------------------------------------------------------------------------------            
    
    -- li --
        elsif Op = "111000" then    
              PC_sel <= '0';
              PC_LdEn <= '1';         -- write to register
              RF_B_sel <= '0';        -- Instr(15-11)
              RF_WrEn <= '1';         -- write to rf
              RF_WrData_sel <= '0';   -- ALU   
              ImmExt <= "10";         -- sign extend
              ALU_Bin_sel <= '1';     -- immed
              ALU_func <= "0000";
              Mem_WrEn <= '0';        
              ByteOp <= '0';          -- dont care
         
    -- lui --   
        elsif Op = "111001" then    
              PC_sel <= '0';
              PC_LdEn <= '1';          -- write to register
              RF_B_sel <= '0';         -- Instr(15-11)
              RF_WrEn <= '1';
              RF_WrData_sel <= '0';    -- ALU
              ImmExt <= "01";          -- zero filling with shift
              ALU_Bin_sel <= '1';      -- immed           
              ALU_func <= "0000";
              Mem_WrEn <= '0';
              ByteOp <= '0';           -- dont care  
--------------------------------------------------------------------------------         
    -- addi --
        elsif Op = "110000" then    
              PC_sel <= '0';
              PC_LdEn <= '1';
              RF_B_sel <= '0';        -- Instr(15-11)
              RF_WrEn <= '1';
              RF_WrData_sel <= '0';   -- ALU
              ImmExt <= "10";         -- sign extend
              ALU_Bin_sel <= '1';     -- immed
              ALU_func <= "0000";     -- ADD in ALU
              Mem_WrEn <= '0';
              ByteOp <= '0';          -- dont care  
    
    -- nandi --  
        elsif Op = "110010" then    
              PC_sel <= '0';
              PC_LdEn <= '1';
              RF_B_sel <= '0';         -- Instr(15-11)
              RF_WrEn <= '1';
              RF_WrData_sel <= '0';    -- ALU
              ImmExt <= "00";          -- zero filling
              ALU_Bin_sel <= '1';      -- immed
              ALU_func <= "0101";      -- NAND in ALU
              Mem_WrEn <= '0';
              ByteOp <= '0';           -- dont care     
         
    -- ori --
        elsif Op = "110011" then    
              PC_sel <= '0';
              PC_LdEn <= '1';
              RF_B_sel <= '0';         -- Instr(15-11)
              RF_WrEn <= '1';
              RF_WrData_sel <= '0';    -- ALU
              ImmExt <= "00";          -- zero filling
              ALU_Bin_sel <= '1';      -- immed
              ALU_func <= "0011";      -- OR in ALU
              Mem_WrEn <= '0';
              ByteOp <= '0';           -- dont care  
------------------------------------------------------------------------------------
    -- b --
        elsif Op = "111111" then    
              PC_sel <= '1';         -- PC + 4
              PC_LdEn <= '1';
              RF_B_sel <= '1';       -- Instr(20-16)
              RF_WrEn <= '0';
              RF_WrData_sel <= '0';  -- ALU
              ImmExt <= "11";        -- sign extend with shift
              ALU_Bin_sel <= '0';    
              ALU_func <= "0000";    -- add
              Mem_WrEn <= '0';
              ByteOp <= '0';         -- dont care
             
    -- beq --
        elsif Op = "111111" then    
             if Rs = Rd then
                PC_sel <= '1';         -- PC + 4
             else
                PC_sel <= '0';
             end if;
             PC_LdEn <= '1';
             RF_B_sel <= '1';       -- Instr(20-16)
             RF_WrEn <= '1';
             RF_WrData_sel <= '0';  -- ALU
             ImmExt <= "11";        -- sign extend with shift
             ALU_Bin_sel <= '0';    
             ALU_func <= "0001";    -- sub
             Mem_WrEn <= '0';
             ByteOp <= '0';         -- dont care 
        
        
    -- bne --
        elsif Op = "111111" then    
             if Rs = Rd then
                PC_sel <= '0';         -- PC + 4
             else
                PC_sel <= '1';
             end if;
             PC_LdEn <= '1';
             RF_B_sel <= '1';       -- Instr(20-16)
             RF_WrEn <= '1';
             RF_WrData_sel <= '0';  -- ALU
             ImmExt <= "11";        -- sign extend with shift
             ALU_Bin_sel <= '0';    
             ALU_func <= "0001";    -- sub
             Mem_WrEn <= '0';
             ByteOp <= '0';         -- dont care
                 
----------------------------------------------------------------------------------       
    -- lb --
        elsif Op = "000011" then    
              PC_sel <= '0';
              PC_LdEn <= '1';
              RF_B_sel <= '0';        -- Instr(15-11)
              RF_WrEn <= '1';
              RF_WrData_sel <= '1';   -- MEM
              ImmExt <= "10";         -- sign extend
              ALU_Bin_sel <= '1';     -- immed
              ALU_func <= "0000";     
              Mem_WrEn <= '0';
              ByteOp <= '1';          -- lb/sb = 1
        
    -- sb --    
        elsif Op = "000111" then    
              PC_sel <= '0';
              PC_LdEn <= '1';
              RF_B_sel <= '1';        -- Instr(20-16)
              RF_WrEn <= '0';
              RF_WrData_sel <= '1';   -- MEM 
              ImmExt <= "10";         -- sign extend
              ALU_Bin_sel <= '1';     -- immed
              ALU_func <= "0000";
              Mem_WrEn <= '1';        -- write to memory
              ByteOp <= '1';          -- lb/sb = 1
-----------------------------------------------------------------------------        
    -- lw --
        elsif Op = "000011" then    
              PC_sel <= '0';
              PC_LdEn <= '1';
              RF_B_sel <= '0';        -- Instr(15-11)
              RF_WrEn <= '1';
              RF_WrData_sel <= '1';   -- MEM
              ImmExt <= "10";         -- sign extend
              ALU_Bin_sel <= '1';     -- immed
              ALU_func <= "0000";     
              Mem_WrEn <= '0';
              ByteOp <= '0';          -- lw/sw = 0
        
    -- sw --   
        elsif Op = "011111" then    
              PC_sel <= '0';
              PC_LdEn <= '1';
              RF_B_sel <= '1';        -- Instr(20-16)
              RF_WrEn <= '0';
              RF_WrData_sel <= '1';   -- MEM
              ImmExt <= "01";         -- sign extend
              ALU_Bin_sel <= '1';     -- immed
              ALU_func <= "0000";     
              Mem_WrEn <= '1';        -- write to memory
              ByteOp <= '0';          -- lw/sw = 0
            
        else    
            PC_sel <= '0';
            PC_LdEn <= '1';
            RF_B_sel <= '0';        
            RF_WrEn <= '0';
            RF_WrData_sel <= '0';   
            ImmExt <= "10";         -- sign extend
            ALU_Bin_sel <= '0';
            ALU_func <= "0000";     
            Mem_WrEn <= '0';        
            ByteOp <= '0';          -- dont care
        
        end if;
    end process;

end Behavioral;
