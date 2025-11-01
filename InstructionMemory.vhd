library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_ARITH.all;
use IEEE.std_logic_UNSIGNED.all;

entity InstructionMemory is
    port(
        address: in std_logic_vector(31 downto 0); --read address from PC
        instruction: out std_logic_vector(31 downto 0) --output instruction
    );
    end InstructionMemory;

    architecture Behavioral of InstructionMemory is
        type memory_array is array (0 to 127) of STD_LOGIC_VECTOR(31 downto 0); --we have 128 words in memory
        signal memory : memory_array := (
            0  => "00100000000000010000000000001010", -- addi R1, R0, 10
            1  => "00100000000000100000000000000000", -- addi R2, R0, 0
            2  => "00100000000000110000000000000001", -- addi R3, R0, 1
            3  => "00100000000001010000000000000010", -- addi R5, R0, 2
            4  => "00010000101000010000000000010100", -- beq R5, R1, 0x28 --> 0x10
            5  => "00000000010000110010000000100000", -- add R4, R2, R3
            6  => "00100000110000100000000000000000", -- addi R2, R3, 0
            7  => "00100000100000110000000000000000", -- addi R3, R4, 0
            8  => "00100000101001010000000000000001", -- addi R5, R5, 1
            9  => "00001000000000000000000000010000", -- j 0x10 
            10 => "11111111111111111111111111111111", -- halt -->0x28
            others => (others => '0')                -- Fill the rest with zeros
        );
    begin
        process(address)
        begin
            instruction <= memory(to_integer(unsigned(address(6 downto 0))));
        end process;
    end Behavioral;
    
