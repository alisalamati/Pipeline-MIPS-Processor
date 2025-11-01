library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder is
    Port (
        A       : in STD_LOGIC_VECTOR(31 downto 0); -- First input
        B       : in STD_LOGIC_VECTOR(31 downto 0); -- Second input
        Sum     : out STD_LOGIC_VECTOR(31 downto 0) -- Output sum
    );
end Adder;

architecture Behavioral of Adder is
begin
    process(A, B)
    begin
        Sum <= A + B; -- Simple addition
    end process;
end Behavioral;
