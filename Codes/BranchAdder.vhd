library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BranchAdder is
    Port (
        PC_plus_4     : in STD_LOGIC_VECTOR(31 downto 0); -- PC + 4
        Offset        : in STD_LOGIC_VECTOR(31 downto 0); -- Sign-extended and shifted offset
        BranchTarget  : out STD_LOGIC_VECTOR(31 downto 0) -- Branch target address
    );
end BranchAdder;

architecture Behavioral of BranchAdder is
begin
    process(PC_plus_4, Offset)
    begin
        BranchTarget <= PC_plus_4 + Offset;
    end process;
end Behavioral;
