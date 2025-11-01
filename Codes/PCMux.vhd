library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCMux is
    Port (
        PC_plus_4     : in STD_LOGIC_VECTOR(31 downto 0); -- PC + 4
        BranchTarget  : in STD_LOGIC_VECTOR(31 downto 0); -- Branch target address
        PCSrc         : in STD_LOGIC;                    -- Control signal for branch
        PC_next       : out STD_LOGIC_VECTOR(31 downto 0) -- Next PC value
    );
end PCMux;

architecture Behavioral of PCMux is
begin
    process(PC_plus_4, BranchTarget, PCSrc)
    begin
        if PCSrc = '1' then
            PC_next <= BranchTarget; -- Branch address
        else
            PC_next <= PC_plus_4; -- Sequential address
        end if;
    end process;
end Behavioral;
