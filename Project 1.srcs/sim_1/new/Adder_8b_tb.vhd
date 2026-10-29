library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;
entity Adder_8b_tb is end;
architecture Test of Adder_8b_tb is
    signal A, B, Sum : std_logic_vector(7 downto 0);
    signal Cin, Cout : std_logic;
begin
    DUT: entity work.Adder_8b port map(A, B, Cin, Sum, Cout);
    process
        variable expected : unsigned(8 downto 0);
    begin
        for x in 0 to 255 loop
            for y in 0 to 255 loop
                for c in 0 to 1 loop
                    A <= std_logic_vector(to_unsigned(x,8));
                    B <= std_logic_vector(to_unsigned(y,8));
                    if c=0 then Cin <= '0'; else Cin <= '1'; end if;
                    expected := to_unsigned(x+y+c,9);
                    wait for 1 ns;
                    assert Sum=std_logic_vector(expected(7 downto 0)) report "Adder sum mismatch" severity failure;
                    assert Cout=expected(8) report "Adder carry mismatch" severity failure;
                end loop;
            end loop;
        end loop;
        report "PASS: 8-bit adder 131072 exhaustive binary cases";
        finish;
    end process;
end;
