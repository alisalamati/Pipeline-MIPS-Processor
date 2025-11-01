library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX32 is
    Port (
        Sel    : in  STD_LOGIC;                  -- Control signal for mux
        Input0 : in  STD_LOGIC_VECTOR(31 downto 0); -- First 32-bit input
        Input1 : in  STD_LOGIC_VECTOR(31 downto 0); -- Second 32-bit input
        Output : out STD_LOGIC_VECTOR(31 downto 0) -- Output
    );
end MUX32;

architecture Behavioral of MUX32 is
begin
    process(Sel, Input0, Input1)
    begin
        if Sel = '0' then
            Output <= Input0; -- If Sel is 0, output Input0
        else
            Output <= Input1; -- If Sel is 1, output Input1
        end if;
    end process;
end Behavioral;
