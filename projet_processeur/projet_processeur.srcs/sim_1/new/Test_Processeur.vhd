----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 10:41:18
-- Design Name: 
-- Module Name: Test_Processeur - Behavioral
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

entity Test_Processeur is
--  Port ( );
end Test_Processeur;

architecture Behavioral of Test_Processeur is

COMPONENT processeur is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

signal CLK_in : STD_LOGIC :='0';
signal RST_in : STD_LOGIC;
signal Output_out : STD_LOGIC_VECTOR (31 downto 0);

constant CLK_period : time := 10ns;

begin

Label_uut: processeur port map (
    CLK=>CLK_in,
    RST=>RST_in,
    OUTPUT => Output_out
);

CLK_process : process 
    begin
        CLK_in<= not (CLK_in);
        wait for CLK_period/2;
    end process;


end Behavioral;
