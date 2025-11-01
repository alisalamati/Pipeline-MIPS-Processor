library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port (
        Opcode    : in STD_LOGIC_VECTOR(5 downto 0);  -- Opcode from instruction
        RegDst    : out STD_LOGIC;                   -- Destination register selection
        ALUSrc    : out STD_LOGIC;                   -- ALU operand source selection, the second operand is register or immidiate address
        MemtoReg  : out STD_LOGIC;                   -- Memory-to-register selection
        RegWrite  : out STD_LOGIC;                   -- Enable register write
        MemRead   : out STD_LOGIC;                   -- Enable memory read
        MemWrite  : out STD_LOGIC;                   -- Enable memory write
        Branch    : out STD_LOGIC;                   -- Enable branch decision
        ALUOp     : out STD_LOGIC_VECTOR(1 downto 0) -- ALU operation type
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(Opcode)
    begin
        case Opcode is
            -- R-type Instructions
            when "000000" =>
                RegDst    <= '1';
                ALUSrc    <= '0';
                MemtoReg  <= '0';
                RegWrite  <= '1';
                MemRead   <= '0';
                MemWrite  <= '0';
                Branch    <= '0';
                ALUOp     <= "10"; -- R-type operations
            
            -- Load Word (lw)
            when "100011" =>
                RegDst    <= '0';
                ALUSrc    <= '1';
                MemtoReg  <= '1';
                RegWrite  <= '1';
                MemRead   <= '1';
                MemWrite  <= '0';
                Branch    <= '0';
                ALUOp     <= "00"; -- Load/Store uses ADD
            
            -- Store Word (sw)
            when "101011" =>
                RegDst    <= 'X'; -- Don't care
                ALUSrc    <= '1';
                MemtoReg  <= 'X'; -- Don't care
                RegWrite  <= '0';
                MemRead   <= '0';
                MemWrite  <= '1';
                Branch    <= '0';
                ALUOp     <= "00"; -- Load/Store uses ADD
            
            -- Branch Equal (beq)
            when "000100" =>
                RegDst    <= 'X'; -- Don't care
                ALUSrc    <= '0';
                MemtoReg  <= 'X'; -- Don't care
                RegWrite  <= '0';
                MemRead   <= '0';
                MemWrite  <= '0';
                Branch    <= '1';
                ALUOp     <= "01"; -- BEQ uses SUB
            
            -- Default case
            when others =>
                RegDst    <= '0';
                ALUSrc    <= '0';
                MemtoReg  <= '0';
                RegWrite  <= '0';
                MemRead   <= '0';
                MemWrite  <= '0';
                Branch    <= '0';
                ALUOp     <= "00"; -- Default to ADD
        end case;
    end process;
end Behavioral;
