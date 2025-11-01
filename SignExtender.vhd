library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SignExtender is
    Port (
        InstrIn   : in  STD_LOGIC_VECTOR(15 downto 0);  -- 16-bit immediate from instruction
        SignExtImm: out STD_LOGIC_VECTOR(31 downto 0)   -- 32-bit sign-extended result
    );
end SignExtender;

architecture Behavioral of SignExtender is
begin
    process(InstrIn)
    begin
        -- If the 16th bit (MSB) of InstrIn is '1', extend the sign (negative number)
        if InstrIn(15) = '1' then
            SignExtImm <= "1111111111111111" & InstrIn; -- Sign extension for negative numbers
        else
            SignExtImm <= "0000000000000000" & InstrIn; -- Zero extension for positive numbers
        end if;
    end process;
end Behavioral;
