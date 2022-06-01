----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 12:09:14
-- Design Name: 
-- Module Name: Memoire_instructions - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memoire_instructions is
    Port ( adr_inst : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (31 downto 0));
end Memoire_instructions;

architecture Behavioral of Memoire_instructions is
type Memoire is array (0 to 255) of std_logic_vector (31 downto 0);
constant mem : Memoire:=(0=>X"06010ABA",1=>X"080401BA",2=>X"0502010A",3=>X"01030201",4=>X"070504BA",others=>X"0A162636");

begin
    Output<=mem(to_integer(unsigned(adr_inst)));
      
end Behavioral;
