library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
  Port (A, B : in std_logic_vector(7 downto 0);
        Cin : in std_logic;
        op : in std_logic_vector(2 downto 0);
        Rslt : out std_logic_vector(7 downto 0);
        Cout : out std_logic );
end ALU;

architecture Behavioral of ALU is

component Adder_8b is
    Port ( A, B : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           Sum : out std_logic_vector(7 downto 0);
           Cout : out std_logic );
end component;

signal add_result : std_logic_vector(7 downto 0);
signal add_carry, adder_cin : std_logic;

begin

    UUT: Adder_8b port map (A => A, B => B, Cin => adder_cin, Sum => add_result, Cout => add_carry );

    adder_cin <= Cin when op = "001" else '0';

    Rslt <= add_result when op = "000" or op = "001" else
            A XOR B when op = "010" else
            B when op = "011" else
            A;

    Cout <= add_carry when op = "000" or op = "001" else Cin;
    
end Behavioral;
