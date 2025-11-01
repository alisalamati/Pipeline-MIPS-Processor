library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        A         : in STD_LOGIC_VECTOR(31 downto 0); -- Operand 1
        B         : in STD_LOGIC_VECTOR(31 downto 0); -- Operand 2
        ALUControl: in STD_LOGIC_VECTOR(3 downto 0);  -- ALU operation control signal
        Result    : out STD_LOGIC_VECTOR(31 downto 0); -- Result of the operation
        Zero      : out STD_LOGIC                   -- Zero flag
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, ALUControl)
    begin
        case ALUControl is
            when "0010" => -- Addition
                Result <= A + B;
            when "0110" => -- Subtraction
                Result <= A - B;
            when "0000" => -- Logical AND
                Result <= A and B;
            when "0001" => -- Logical OR
                Result <= A or B;
            when "0111" => -- Set on Less Than (SLT)
                if A < B then
                    Result <= X"00000001";
                else
                    Result <= X"00000000";
                end if;
            when others => -- Default case
                Result <= (others => '0');
        end case;

        -- Set Zero flag if the result is all 0s
        if Result = X"00000000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end Behavioral;
