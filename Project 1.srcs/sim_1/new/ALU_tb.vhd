library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU_tb is
end ALU_tb;

architecture Test of ALU_tb is

    signal A, B : std_logic_vector(7 downto 0) := "00000000";
    signal Cin : std_logic := '0';
    signal Rslt : std_logic_vector(7 downto 0);
    signal Cout : std_logic;
    signal op : std_logic_vector(2 downto 0) := "000";
    
    component ALU is
    Port ( A, B : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           op : in std_logic_vector(2 downto 0);
           Rslt : out std_logic_vector(7 downto 0);
           Cout : out std_logic );
end component;

begin

DUT: ALU port map (A, B, Cin, op, Rslt, Cout);

process
begin

    for i in 0 to 4 loop
        case i is
            when 0 => op <= "000";  -- Add
            when 1 => op <= "001";  -- Addc
            when 2 => op <= "010";  -- XOR
            when 3 => op <= "011";  -- Load
            when 4 => op <= "100";  -- Hold
            when others => op <= "000";
        end case;
        
        
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

    end loop;
    

    wait;
end process;


end Test;
