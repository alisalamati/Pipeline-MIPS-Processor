library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MIPSProcessor_tb is
-- No ports for the testbench
end MIPSProcessor_tb;

architecture Behavioral of MIPSProcessor_tb is

    -- Component under test (CUT)
    component MIPSProcessor
        Port (
            CLK           : in  STD_LOGIC;
            RESET         : in  STD_LOGIC;
            Fibonacci_Out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Testbench signals
    signal CLK           : STD_LOGIC := '0';            -- Clock signal
    signal RESET         : STD_LOGIC := '1';            -- Reset signal
    signal Fibonacci_Out : STD_LOGIC_VECTOR(31 downto 0); -- Output Fibonacci number

    constant CLOCK_PERIOD : time := 10 ns;              -- Clock period for simulation

begin

    -- Instantiate the processor (CUT)
    CUT: MIPSProcessor
        port map (
            CLK           => CLK,
            RESET         => RESET,
            Fibonacci_Out => Fibonacci_Out
        );

    -- Clock generation process
    Clock_Process: process
    begin
        while true loop
            CLK <= '1';
            wait for CLOCK_PERIOD / 2;
            CLK <= '0';
            wait for CLOCK_PERIOD / 2;
        end loop;
    end process;

    -- Test sequence process
    Stimulus_Process: process
    begin
        -- Apply Reset
        RESET <= '1';
        wait for 20 ns;  -- Hold reset for 20 ns
        RESET <= '0';

        -- Wait for the processor to execute instructions
        wait for 2000 ns; -- Adjust this time based on your Fibonacci program length

        -- End simulation
        assert false report "Simulation completed" severity note;
        wait;
    end process;

end Behavioral;
