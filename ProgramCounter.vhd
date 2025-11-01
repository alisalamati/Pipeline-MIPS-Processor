library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_ARITH.all;
use IEEE.std_logic_UNSIGNED.all;

entity ProgramCounter is
    port(
        clk :     in std_logic; --Clock Signal
        reset:    in std_logic; --reset Signal
        PC_in :   in std_logic_vector (31 downto 0); --New PC value
        PCWrite : in std_logic; --Enable to write next instruction on PC
        PC_out:   out std_logic_vector(31 downto 0) --Current Instrcution
    );
    end ProgramCounter;

    architecture Behavioral of ProgramCounter is
        signal PC_reg : std_logic_vector(31 downto 0) := (others => '0'); --Internal Register
        begin
            process(clk, reset)
            begin
                if reset = '1' then
                    PC_reg <= (others => '0');
                elsif rising_edge(clk)then
                    if PCWrite = '1' then
                        --Update PC with PC_in
                        PC_reg <= PC_in;
                    end if;
                end if;
            end process;

        -- Assign internal PC register to output
        PC_out <= PC_reg;
        end Behavioral;