----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 09:41:59
-- Design Name: 
-- Module Name: Banc_Registres - Behavioral
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

entity Banc_Registres is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC_VECTOR (3 downto 0);
           Write : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_Registres;

architecture Behavioral of Banc_Registres is

type Banc is array (0 to 15) of std_logic_vector (7 downto 0);
signal reg : Banc;
signal clock : std_logic;

begin
    clock<=CLK;

    process --ecriture
        begin
        wait until clock'event and clock='1';
        if RST='0' then
            reg <= (others=> X"00");
        elsif (Write='1') then
            reg(to_integer(unsigned(W)))<=DATA;
        end if;


    end process;

    QA <= reg(to_integer(unsigned(A)));
    QB <= reg(to_integer(unsigned(B)));


end Behavioral;