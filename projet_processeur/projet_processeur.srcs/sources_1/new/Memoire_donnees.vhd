----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 12:07:12
-- Design Name: 
-- Module Name: Memoire_donnees - Behavioral
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

entity Memoire_donnees is
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           Input : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end Memoire_donnees;

architecture Behavioral of Memoire_donnees is

type Memoire is array (0 to 16) of std_logic_vector (7 downto 0);
signal mem : Memoire;
signal clock : std_logic;

begin
    clock<=CLK;

    process --ecriture
        begin
        wait until clock'event and clock='1';
        if RST='0' then
            mem <= (others=> X"00");
        elsif (RW='0') then
            mem(to_integer(unsigned(adr)))<=Input;
        elsif (RW='1') then
            Output<=mem(to_integer(unsigned(adr)));
        end if;


    end process;


end Behavioral;