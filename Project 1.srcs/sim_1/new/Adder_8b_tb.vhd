library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_8b_tb is
end Adder_8b_tb;

architecture Test of Adder_8b_tb is
    signal A, B : std_logic_vector(7 downto 0) := "00000000";
    signal Cin : std_logic := '0';
    signal Sum : std_logic_vector(7 downto 0);
    signal Cout : std_logic;
    
component Adder_8b is
    Port ( A, B : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           Sum : out std_logic_vector(7 downto 0);
           Cout : out std_logic );
end component;
    
begin
    DUT: Adder_8b port map (A, B, Cin, Sum, Cout);

process
begin
    -- Test 1
    A <= x"00";
    B <= x"00";
    Cin <= '1';
    wait for 10 ns;

    -- Test 2
    A <= x"7F";
    B <= x"81";
    Cin <= '0';
    wait for 10 ns;

    -- Test 3
    A <= x"9A";
    B <= x"65";
    Cin <= '1';
    wait for 10 ns;

    -- Test 4
    A <= x"6B";
    B <= x"8F";
    Cin <= '1';
    wait for 10 ns;

    wait;
end process;
    
end Test;
