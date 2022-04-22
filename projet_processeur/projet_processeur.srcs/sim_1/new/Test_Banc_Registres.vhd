----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 10:25:17
-- Design Name: 
-- Module Name: Test_Banc_Registres - Behavioral
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

entity Test_Banc_Registres is
--  Port ( );
end Test_Banc_Registres;

architecture Behavioral of Test_Banc_Registres is

COMPONENT Banc_Registres is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC_VECTOR (3 downto 0);
           Write : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

signal A_in : STD_LOGIC_VECTOR (3 downto 0);
signal B_in : STD_LOGIC_VECTOR (3 downto 0);
signal W_in : STD_LOGIC_VECTOR (3 downto 0);
signal Write_in : STD_LOGIC;
signal DATA_in : STD_LOGIC_VECTOR (7 downto 0);
signal RST_in : STD_LOGIC;
signal CLK_in : STD_LOGIC:='0';
signal QA_out : STD_LOGIC_VECTOR (7 downto 0);
signal QB_out : STD_LOGIC_VECTOR (7 downto 0);

constant CLK_period : time := 10ns;

begin

Label_uut: Banc_Registres port map (
    A => A_in,
    B => B_in,
    W => W_in,
    Write => Write_in,
    DATA => DATA_in,
    RST => RST_in,
    CLK => CLK_in,
    QA => QA_out,
    QB => QB_out
);


CLK_process : process 
    begin
        CLK_in<= not (CLK_in);
        wait for CLK_period/2;
    end process;

RST_in<='0','1' after 15 ns;
Write_in <= '1' after 20 ns,'0' after 30 ns ;
W_in <= X"3" after 20 ns, X"5" after 30 ns;
DATA_IN <= X"09" after 19 ns, X"01" after 29 ns; 
A_in <= X"3" after 22 ns, X"5" after 31ns;


end Behavioral;