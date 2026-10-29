library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_8b is
  Port ( A, B : in std_logic_vector(7 downto 0);
         Cin : in std_logic;
         Sum : out std_logic_vector(7 downto 0);
         Cout : out std_logic );
end Adder_8b;

architecture Behavioral of Adder_8b is
    signal c : std_logic_vector(8 downto 0);
begin

    c(0) <= Cin;
    
    gen_adder: for i in 0 to 7 generate
    
       Sum(i) <= A(i) xor B(i) xor c(i);

       c(i+1) <= (A(i) and B(i)) or (A(i) and c(i)) or (B(i) and c(i));

    end generate;
    
    Cout <= c(8);

end Behavioral;