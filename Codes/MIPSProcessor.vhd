library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MIPSProcessor is
    Port (
        CLK           : in  STD_LOGIC;                     -- Clock signal
        RESET         : in  STD_LOGIC;                     -- Reset signal
        Fibonacci_Out : out STD_LOGIC_VECTOR(31 downto 0) -- Output Fibonacci number*****?
    );
end MIPSProcessor;

architecture Behavioral of MIPSProcessor is

    -- Internal signals
    signal PC         : STD_LOGIC_VECTOR(31 downto 0); -- Program Counter
    signal NextPC     : STD_LOGIC_VECTOR(31 downto 0);
    signal Instruction: STD_LOGIC_VECTOR(31 downto 0); -- Fetched instruction
    
    -- Control signals
    signal RegDst     : STD_LOGIC;
    signal Branch     : STD_LOGIC;
    signal MemRead    : STD_LOGIC;
    signal MemtoReg   : STD_LOGIC;
    signal ALUOp      : STD_LOGIC_VECTOR(1 downto 0);
    signal MemWrite   : STD_LOGIC;
    signal ALUSrc     : STD_LOGIC;
    signal RegWrite   : STD_LOGIC;
    
    -- Register File signals
    signal ReadData1  : STD_LOGIC_VECTOR(31 downto 0);
    signal ReadData2  : STD_LOGIC_VECTOR(31 downto 0);
    signal WriteData  : STD_LOGIC_VECTOR(31 downto 0);--why the readreg1 and 2 are not define? because the related wire defined in instruction memory signals
    
    -- Immediate values and ALU connections
    signal SignExtImm   : STD_LOGIC_VECTOR(31 downto 0); --probably is the readdata1*****?
    signal ALUSrcMuxOut : STD_LOGIC_VECTOR(31 downto 0); --the second operand for ALU
    signal ALUResult    : STD_LOGIC_VECTOR(31 downto 0); --the resul of compute
    signal Zero         : STD_LOGIC; --for branch in ALU unit

    -- Data Memory signals
    signal MemData    : STD_LOGIC_VECTOR(31 downto 0);

    --Branch Address Signals
    signal BranchAddress: STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instantiate Program Counter
    PC_inst: entity work.ProgramCounter
        port map (
            CLK => CLK,
            RESET => RESET,
            PC_in => NextPC,
            PCWrite => (RegWrite or Branch and Zero),
            PC_out => PC
        );

    -- Instantiate Instruction Memory
    InstructionMemory_inst: entity work.InstructionMemory
        port map (
            Address => PC,
            Instruction => Instruction
        );

    -- Instantiate Control Unit
    ControlUnit_inst: entity work.ControlUnit
        port map (
            Opcode => Instruction(31 downto 26),
            RegDst => RegDst,
            Branch => Branch,
            MemRead => MemRead,
            MemtoReg => MemtoReg,
            ALUOp => ALUOp,
            MemWrite => MemWrite,
            ALUSrc => ALUSrc,
            RegWrite => RegWrite
        );

    -- Instantiate Register File
    RegisterFile_inst: entity work.RegisterFile
        port map (
            clk => CLK,
            RegWrite => RegWrite,
            ReadReg1 => Instruction(25 downto 21),
            ReadReg2 => Instruction(20 downto 16),
            WriteReg => Instruction(15 downto 11) when RegDst = '1' else Instruction(20 downto 16), --MUX2 before ALU
            WriteData => WriteData,
            ReadData1 => ReadData1,
            ReadData2 => ReadData2
        );

    -- Sign-Extend Immediate
    SignExt_inst: entity work.SignExtender
        port map (
            InstrIn => Instruction(15 downto 0),
            SignExtImm => SignExtImm
        );

    -- ALU Source MUX
    ALUSrcMux: entity work.MUX32
        port map (
            Sel => ALUSrc,
            Input0 => ReadData2,
            Input1 => SignExtImm,
            Output => ALUSrcMuxOut
        );

    -- Instantiate ALU Control Unit
    ALUControl_inst: entity work.ALUControl
        port map (
            ALUOp => ALUOp,
            FuncCode => Instruction(5 downto 0),
            ALUControl => ALUControl
        );

    -- Instantiate ALU
    ALU_inst: entity work.ALU
        port map (
            A => ReadData1,
            B => ALUSrcMuxOut,
            ALUControl => ALUControl,
            Result => ALUResult,
            Zero => Zero
        );

    -- Data Memory
    DataMemory_inst: entity work.DataMemory
        port map (
            CLK => CLK,
            MemWrite => MemWrite,
            MemRead => MemRead,
            Address => ALUResult,
            WriteData => ReadData2,
            ReadData => MemData
        );

    -- Write-back MUX
    MemtoRegMux: entity work.MUX32
        port map (
            Sel => MemtoReg,
            Input0 => ALUResult,
            Input1 => MemData,
            Output => WriteData
        );

    -- Branch Address Calculation
    BranchAdder: entity work.BranchAdder
        port map (
            PC_plus_4 => PC + 4,
            Offset => SignExtImm sll 2,
            BranchTarget => BranchAddress
        );

    -- Next PC MUX
    PCMux: entity work.MUX32
        port map (
            Sel => Branch and Zero,
            Input0 => PC + 4,
            Input1 => BranchAddress,
            Output => NextPC
        );

    -- Output Fibonacci sequence from a specific register (e.g., $t2)
    Fibonacci_Out <= WriteData; -- Register holding Fibonacci result
--ReadData1
end Behavioral;
