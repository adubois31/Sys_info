----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 11:51:36
-- Design Name: 
-- Module Name: Test_ALU - Behavioral
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

entity Test_ALU is
end Test_ALU;

architecture Behavioral of Test_ALU is

COMPONENT ALU
PORT(
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Z : out STD_LOGIC;
           O : out STD_LOGIC;
           C : out STD_LOGIC;
           N : out STD_LOGIC
);
END COMPONENT;

signal A_in : STD_LOGIC_VECTOR(7 downto 0):=(others=>'0');
signal B_in : STD_LOGIC_VECTOR(7 downto 0):=(others=>'0');
signal Ctrl_Alu_in : STD_LOGIC_VECTOR(1 downto 0):=(others=>'0');

signal Z_out : STD_LOGIC;
signal O_out : STD_LOGIC;
signal C_out : STD_LOGIC;
signal N_out : STD_LOGIC;
signal S_out : STD_LOGIC_VECTOR(7 downto 0);


begin
Label_uut: ALU PORT MAP (
    A => A_in,
    B => B_in,
    Ctrl_Alu => Ctrl_Alu_in,
    Z => Z_out,
    C => C_out,
    O => O_out,
    N => N_out,
    S => S_out
    );

Ctrl_Alu_in <= "00" after 10 ns;
A_in <= "00000001" after 10 ns;
B_in <= "00000010" after 10 ns;
end Behavioral;
