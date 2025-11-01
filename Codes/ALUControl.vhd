library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port (
        ALUOp       : in STD_LOGIC_VECTOR(1 downto 0); -- ALU operation field
        FuncCode    : in STD_LOGIC_VECTOR(5 downto 0); -- Function code from instruction
        ALUControl  : out STD_LOGIC_VECTOR(3 downto 0) -- ALU control signal
    );
end ALUControl;

architecture Behavioral of ALUControl is
begin
    process(ALUOp, FuncCode)
    begin
        case ALUOp is
            when "00" => -- Load/Store instructions
                ALUControl <= "0010"; -- Add
            when "01" => -- Branch instructions
                ALUControl <= "0110"; -- Subtract
            when "10" => -- R-type instructions
                case FuncCode is
                    when "100000" => ALUControl <= "0010"; -- Add
                    when "100010" => ALUControl <= "0110"; -- Subtract
                    when "100100" => ALUControl <= "0000"; -- AND
                    when "100101" => ALUControl <= "0001"; -- OR
                    when "101010" => ALUControl <= "0111"; -- SLT
                    when others => ALUControl <= "0000"; -- Default
                end case;
            when others =>
                ALUControl <= "0000"; -- Default
        end case;
    end process;
end Behavioral;
