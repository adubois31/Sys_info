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
type int_array is array(0 to 3) of STD_LOGIC_VECTOR (7 downto 0);

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

signal LIDI_OP : STD_LOGIC_VECTOR (7 downto 0);
signal LIDI_A : STD_LOGIC_VECTOR (7 downto 0);
signal LIDI_B : STD_LOGIC_VECTOR (7 downto 0);
signal LIDI_C : STD_LOGIC_VECTOR (7 downto 0);

signal DIEX_OP : STD_LOGIC_VECTOR (7 downto 0);
signal DIEX_A : STD_LOGIC_VECTOR (7 downto 0);
signal DIEX_B : STD_LOGIC_VECTOR (7 downto 0);
signal DIEX_C : STD_LOGIC_VECTOR (7 downto 0);

signal EXMEM_OP : STD_LOGIC_VECTOR (7 downto 0);
signal EXMEM_A : STD_LOGIC_VECTOR (7 downto 0);
signal EXMEM_B : STD_LOGIC_VECTOR (7 downto 0);

signal MEMRE_OP : STD_LOGIC_VECTOR (7 downto 0);
signal MEMRE_A : STD_LOGIC_VECTOR (7 downto 0);
signal MEMRE_B : STD_LOGIC_VECTOR (7 downto 0);

signal LIDI_MUX : STD_LOGIC_VECTOR (7 downto 0);
signal DIEX_MUX : STD_LOGIC_VECTOR (7 downto 0);
signal MEMRE_MUX1 : STD_LOGIC_VECTOR (7 downto 0);
signal MEMRE_MUX2 : STD_LOGIC_VECTOR (7 downto 0);

signal Table_count : integer := 0;

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


Gestion_alea : process
variable Table_alea : int_array;
variable Alea : boolean;
begin
    Alea := false;
    wait until rising_edge (CLK_in) ;
    for index in 0 to 3 loop
        if (Table_alea(index)=Inst_out(15 downto 8) or Table_alea(index)=Inst_out(7 downto 0)) then
            Alea:=true;
        end if;
    end loop;
    if not Alea then
        LIDI_OP<=Inst_out(31 downto 24);
        Table_alea(Table_count):=Inst_out(23 downto 16);
        IP<=STD_LOGIC_VECTOR((UNSIGNED(IP)+1));
    else
        LIDI_OP<=X"00";
        Table_alea(Table_count):=X"00";
    end if;
    Table_count<=(Table_count+1) mod 4;
    LIDI_A<=Inst_out(23 downto 16);
    LIDI_B<=Inst_out(15 downto 8);
    LIDI_C<=Inst_out(7 downto 0);


end process;


Reg_A_in <= LIDI_B(3 downto 0);
LIDI_MUX <= QA_out when (LIDI_OP=X"05" or LIDI_OP=X"01"or LIDI_OP=X"02" or LIDI_OP=X"03" or LIDI_OP=X"08") else
            LIDI_B;
Reg_B_in<=LIDI_C(3 downto 0);
    

DI : process
    begin
    wait until rising_edge (CLK_in);
        DIEX_OP<=LIDI_OP;
        DIEX_A<=LIDI_A;
        DIEX_B<=LIDI_MUX;
        DIEX_C <=QB_out;

end process;

ALU_A_in <=DIEX_B;
ALU_B_in <= DIEX_C;
Ctrl_Alu_in <= "00" when DIEX_OP=X"01" else
               "10" when DIEX_OP=X"02" else
               "01" when DIEX_OP=X"03";

DIEX_MUX <= S_out when (DIEX_OP=X"01" or DIEX_OP=X"02" or DIEX_OP=X"03" ) else
            DIEX_B;
               

EX : process
    begin
        wait until rising_edge (CLK_in);
        EXMEM_OP<=DIEX_OP;
        EXMEM_A<=DIEX_A;
        EXMEM_B<=DIEX_MUX;
end process;


MEMRE_MUX1<= EXMEM_B when EXMEM_OP=X"07" else
             EXMEM_A when EXMEM_OP=X"08";
adr_data_in<=MEMRE_MUX1;
RW_in<='0' when EXMEM_OP=X"08" else
       '1' ;
Data_in <= EXMEM_B;
MEMRE_MUX2<= Data_out when (EXMEM_OP=X"07")else
             EXMEM_B;  



MEM : process
    begin
    wait until rising_edge (CLK_in);
    MEMRE_OP<=EXMEM_OP;
    MEMRE_A<=EXMEM_A;
    MEMRE_B<=MEMRE_MUX2;
end process;


-- MEMRE_MUX2



RE : process
    begin
    wait until rising_edge (CLK_in);
    case MEMRE_OP is
    when X"07"|X"06"|X"05"|X"03"|X"02"|X"01" => 
                 Write_in<='1';
                 W_in<=MEMRE_A(3 downto 0);
                 Registers_in<=MEMRE_B;
                 OUTPUT<=X"00000000";
                 
                 
    when X"08" => Write_in<='0';
                  W_in<=MEMRE_A(3 downto 0);
                  Registers_in<=MEMRE_B;
                  OUTPUT<=X"00000000";
    when X"00"=>OUTPUT<=X"00000002";
    when others => OUTPUT<=X"00000001";
    end case;
end process;









end Behavioral;
