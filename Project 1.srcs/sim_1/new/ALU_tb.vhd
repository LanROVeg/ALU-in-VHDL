library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;
entity ALU_tb is end;
architecture Test of ALU_tb is
    signal A, B, Rslt : std_logic_vector(7 downto 0);
    signal Cin, Cout : std_logic;
    signal op : std_logic_vector(2 downto 0);
begin
    DUT: entity work.ALU port map(A, B, Cin, op, Rslt, Cout);
    process
        variable full, expected : integer;
        variable carry : std_logic;
        variable checked : integer := 0;
    begin
        for s in 0 to 7 loop
            for x in 0 to 255 loop
                for y in 0 to 255 loop
                    for c in 0 to 1 loop
                        A <= std_logic_vector(to_unsigned(x,8));
                        B <= std_logic_vector(to_unsigned(y,8));
                        op <= std_logic_vector(to_unsigned(s,3));
                        if c=0 then Cin <= '0'; carry := '0';
                        else Cin <= '1'; carry := '1'; end if;
                        case s is
                            when 0 | 1 =>
                                full := x+y;
                                if s=1 then full := full+c; end if;
                                expected := full mod 256;
                                if full>=256 then carry := '1'; else carry := '0'; end if;
                            when 2 => expected := to_integer(to_unsigned(x,8) xor to_unsigned(y,8));
                            when 3 => expected := y;
                            when others => expected := x;
                        end case;
                        wait for 1 ns;
                        assert Rslt=std_logic_vector(to_unsigned(expected,8))
                            report "ALU result mismatch op=" & integer'image(s) &
                                   " A=" & integer'image(x) & " B=" & integer'image(y) & " Cin=" & integer'image(c)
                            severity failure;
                        assert Cout=carry report "ALU carry mismatch" severity failure;
                        checked := checked+1;
                    end loop;
                end loop;
            end loop;
        end loop;
        report "PASS: ALU " & integer'image(checked) & " exhaustive binary cases";
        finish;
    end process;
end;
