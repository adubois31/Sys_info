----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 09:58:10
-- Design Name: 
-- Module Name: processeur - Behavioral
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

entity processeur is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end processeur;

architecture Behavioral of processeur is


--section memoire donnees
COMPONENT Memoire_donnees is
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           Input : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

signal Adr_data_in: STD_LOGIC_VECTOR (7 downto 0);
signal Data_in : STD_LOGIC_VECTOR (7 downto 0);
signal RW_in : STD_LOGIC;
signal RST_Data_in : STD_LOGIC;
signal Data_out : STD_LOGIC_VECTOR (7 downto 0);


--section memoire instruction
COMPONENT Memoire_instructions is
    Port ( adr_inst : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

signal Adr_inst_in : STD_LOGIC_VECTOR (7 downto 0);
signal Inst_out : STD_LOGIC_VECTOR (31 downto 0);

-- section banc de registre
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


signal Reg_A_in : STD_LOGIC_VECTOR (3 downto 0);
signal Reg_B_in : STD_LOGIC_VECTOR (3 downto 0);
signal W_in : STD_LOGIC_VECTOR (3 downto 0);
signal Write_in : STD_LOGIC;
signal Registers_in : STD_LOGIC_VECTOR (7 downto 0);
signal RST_registers_in : STD_LOGIC;
signal QA_out : STD_LOGIC_VECTOR (7 downto 0);
signal QB_out : STD_LOGIC_VECTOR (7 downto 0);


COMPONENT ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;


signal ALU_A_in : STD_LOGIC_VECTOR(7 downto 0);
signal ALU_B_in : STD_LOGIC_VECTOR(7 downto 0);
signal Ctrl_Alu_in : STD_LOGIC_VECTOR(1 downto 0);

signal Z_out : STD_LOGIC;
signal O_out : STD_LOGIC;
signal C_out : STD_LOGIC;
signal N_out : STD_LOGIC;
signal S_out : STD_LOGIC_VECTOR(7 downto 0);

signal CLK_in : STD_LOGIC:='0';
signal IP : STD_LOGIC_VECTOR (7 downto 0):=X"00";
signal OP : STD_LOGIC_VECTOR (7 downto 0);
signal A : STD_LOGIC_VECTOR (7 downto 0);
signal B : STD_LOGIC_VECTOR (7 downto 0);
signal C : STD_LOGIC_VECTOR (7 downto 0);


begin
Label_Banc_registres: Banc_Registres port map (
    A => Reg_A_in,
    B => Reg_B_in,
    W => W_in,
    Write => Write_in,
    DATA => Registers_in,
    RST => RST_registers_in,
    CLK => CLK_in,
    QA => QA_out,
    QB => QB_out
);

Label_Memoire_donnees : Memoire_donnees port map(

    adr => adr_data_in,
    Input=>Data_in,
    RW=>RW_in,
    RST=>RST_Data_in,
    CLK=>CLK_in,
    Output=>Data_out
);

Label_Memoire_inst : Memoire_instructions port map(
    adr_inst=>Adr_inst_in,
    CLK=>CLK_in,
    Output=>Inst_out
);

Label_ALU: ALU PORT MAP (
    A => ALU_A_in,
    B => ALU_B_in,
    Ctrl_Alu => Ctrl_Alu_in,
    N => N_out,
    O => O_out,
    Z => Z_out,
    C => C_out,
    S => S_out
    );

CLK_in<=CLK;
Adr_inst_in<=IP;
OP<=Inst_out(31 downto 24);
A<=Inst_out(23 downto 16);
B<=Inst_out(15 downto 8);
C<=Inst_out(7 downto 0);

process
    begin
    wait until OP'event;
    case OP is 
    when X"01" => Reg_A_in<=B(3 downto 0);Reg_B_in<=C(3 downto 0);
    when X"02" => Reg_A_in<=B(3 downto 0);Reg_B_in<=C(3 downto 0);
    when X"03" => Reg_A_in<=B(3 downto 0);Reg_B_in<=C(3 downto 0);
    when X"04" => Reg_A_in<=B(3 downto 0);Reg_B_in<=C(3 downto 0);
    when X"05" => Reg_B_in<=B(3 downto 0);
    when others => null;
    end case;
    end process;
    
process
    variable temp_cpy : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    variable res_alu : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    begin
    wait until rising_edge(CLK_in);
    case OP is
    when X"01" => ALU_A_in<=QA_out ;ALU_B_in <= QB_out;Ctrl_Alu_in<="00";Write_in<='1';W_in<=A(3 downto 0);Registers_in<=S_out;OUTPUT<=X"00000000";
    when X"05" => temp_cpy:=QB_out;Write_in<='1';W_in<=A(3 downto 0);Registers_in<=temp_cpy;OUTPUT<=X"00000000";
    when X"06" => Write_in<='1';W_in<=A(3 downto 0);Registers_in<=B;OUTPUT<=X"00000000";
    when others => OUTPUT<=X"00000001";
    end case;
    IP<=STD_LOGIC_VECTOR((UNSIGNED(IP)+1));
    
    
end process;

end Behavioral;
