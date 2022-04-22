----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 10:44:18
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is

signal A_in : std_logic_vector(15 downto 0);
signal B_in : std_logic_vector(15 downto 0);
signal S_out : std_logic_vector(15 downto 0);

begin

A_in <= "00000000"&A ;
B_in<= "00000000"&B;

S_out<= A_in+B_in when  Ctrl_Alu="00" else
        A_in - B_in when Ctrl_Alu="01" else
        A * B when Ctrl_Alu="10";

C<=S_out(8) when Ctrl_Alu="00" else
    '0';
N<= S_out(7) when Ctrl_Alu="01" else
    '0';
O<='1' when (Ctrl_Alu="10") and ((S_out and "1111111100000000") /= 0) else
   '0';

Z<='1' when S_out=0 else 
   '0';
    
S<=S_out(7 downto 0);

end Behavioral;