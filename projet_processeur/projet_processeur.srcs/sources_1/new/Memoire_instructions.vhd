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
           Output : in STD_LOGIC_VECTOR (31 downto 0));
end Memoire_instructions;

architecture Behavioral of Memoire_instructions is

begin


end Behavioral;
