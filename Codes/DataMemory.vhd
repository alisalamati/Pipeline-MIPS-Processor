library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port (
        Address    : in STD_LOGIC_VECTOR(31 downto 0); -- Memory address
        WriteData  : in STD_LOGIC_VECTOR(31 downto 0); -- Data to be written
        MemWrite   : in STD_LOGIC;                     -- Write enable signal
        MemRead    : in STD_LOGIC;                     -- Read enable signal
        ReadData   : out STD_LOGIC_VECTOR(31 downto 0) -- Data read from memory
    );
end DataMemory;

architecture Behavioral of DataMemory is
    type MemoryArray is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal Memory : MemoryArray := (others => (others => '0')); -- Initialize memory
begin
    process(Address, WriteData, MemWrite, MemRead)
    begin
        if MemWrite = '1' then
            -- Writing to memory
            Memory(to_integer(unsigned(Address(7 downto 0)))) <= WriteData;
        end if;

        if MemRead = '1' then
            -- Reading from memory
            ReadData <= Memory(to_integer(unsigned(Address(7 downto 0))));
        else
            ReadData <= (others => '0'); -- Default value
        end if;
    end process;
end Behavioral;
