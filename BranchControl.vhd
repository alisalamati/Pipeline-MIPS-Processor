library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BranchControl is
    Port (
        Zero    : in STD_LOGIC; -- Zero flag from ALU
        Branch  : in STD_LOGIC; -- Branch control signal
        PCSrc   : out STD_LOGIC -- PC source: 1 for branch, 0 for sequential
    );
end BranchControl;

architecture Behavioral of BranchControl is
begin
    process(Zero, Branch)
    begin
        if Branch = '1' and Zero = '1' then
            PCSrc <= '1'; -- Take the branch
        else
            PCSrc <= '0'; -- Sequential execution
        end if;
    end process;
end Behavioral;
