    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_ARITH.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;
    
    entity RegisterFile is
        Port (
            clk         : in  STD_LOGIC;
            RegWrite    : in  STD_LOGIC;
            ReadReg1    : in  STD_LOGIC_VECTOR(4 downto 0);
            ReadReg2    : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteReg    : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteData   : in  STD_LOGIC_VECTOR(31 downto 0);
            ReadData1   : out STD_LOGIC_VECTOR(31 downto 0);
            ReadData2   : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end RegisterFile;
    
    architecture Behavioral of RegisterFile is
        -- Declare a memory array to hold 32 registers (32-bit wide each)
        type register_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
        signal registers : register_array := (others => (others => '0')); --first others is for cover 32reg and the second one cover the each 32 bit of registers.
    begin
        -- Read Data Process (combinational)
        process(ReadReg1, ReadReg2, registers)
        begin
            -- Read data from registers specified by ReadReg1 and ReadReg2
            ReadData1 <= registers(to_integer(unsigned(ReadReg1)));
            ReadData2 <= registers(to_integer(unsigned(ReadReg2)));
        end process;
    
        -- Write Data Process (synchronous)
        process(clk)
        begin
            if rising_edge(clk) then
                if RegWrite = '1' then
                    -- Write data to the register specified by WriteReg
                    registers(to_integer(unsigned(WriteReg))) <= WriteData;
                end if;
            end if;
        end process;
    end Behavioral;
    