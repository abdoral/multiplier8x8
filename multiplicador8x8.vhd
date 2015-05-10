-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Arquivo: multiplicador8x8.vhd


library ieee;
use ieee.std_logic_1164.all;


entity multiplicador8x8 is
	port(
		A, B : in std_logic_vector(7 downto 0);
		start, reset, clk : in std_logic;
		result : out std_logic_vector(15 downto 0);
		seg: out std_logic_vector(6 downto 0);
		done_flag : out std_logic
	);
end multiplicador8x8;


architecture arch_multiplicador8x8 of multiplicador8x8 is

   --Inversora
	component inv
		port (
			X : in std_logic;
			Y : out std_logic
		);
	end component;
	
	--Multiplexador 4x4 
	component mux4
		port(
			A, B : in std_logic_vector(3 downto 0);
			sel: in std_logic;
			Y : out std_logic_vector(3 downto 0)
		);
	end component;
	
	--Contador
	component counter
		port ( 
			clk, clr : in std_logic;
			total : out std_logic_vector(1 downto 0)
		);
	end component;
	
	--Control
	component control
		port(
			clk, rst, start : in std_logic;
			count : in std_logic_vector(1 downto 0);
			in_sel, shift : out std_logic_vector(1 downto 0);
			state_out : out std_logic_vector(2 downto 0);
			done, clken, regclr : out std_logic
		);
	end component;
	
	--Multiplicador 4x4
	component mult4x4
		port(
			dataa		: in STD_LOGIC_VECTOR (3 downto 0);
			datab		: in STD_LOGIC_VECTOR (3 downto 0);
			result	: out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;
	
	--Registrador
	component reg
		port ( 
			in_reg : in std_logic_vector(15 downto 0);
			clk, clr, clken : in std_logic;
			out_reg : out std_logic_vector(15 downto 0)
		);
	end component;
	
	--Shifter
	component shifter
		port(
			input : in std_logic_vector(7 downto 0);
			cnt : in std_logic_vector(1 downto 0);
			result : out std_logic_vector(15 downto 0)
		);
	end component;
	
	--Somador
	component adder
		port(
			A, B : in std_logic_vector(15 downto 0);
			sum : out std_logic_vector(15 downto 0)
		);
	end component;
	
	--Display 7 segmentos
	component seven
		port(
			input : in std_logic_vector(2 downto 0);
			A, B, C, D, E, F, G : out std_logic
		);
	end component;
	
	-- ==>Fios com as ligações internas<==

	-- Fios do mutiplexador para o multiplicador
	signal fio_mux1_mult, fio_mux2_mult : std_logic_vector(3 downto 0);
	
	-- Fio do multiplicador para o shifter
	signal fio_mult_shifter : std_logic_vector(7 downto 0);
	
	-- Fio do control para o shifter
	signal fio_control_shifter : std_logic_vector(1 downto 0);
	
	-- Fio shifter para o somador
	signal fio_shifter_adder : std_logic_vector(15 downto 0);
	
	-- Fio somador para o registrador
	signal fio_adder_reg : std_logic_vector(15 downto 0);
	
	-- Fio registrador para o somador
	signal fio_reg_adder : std_logic_vector(15 downto 0);
	
	-- Fio contador para o control
	signal fio_counter_control : std_logic_vector(1 downto 0);
	
	-- Fio inversora para o contador
	signal fio_inv_counter : std_logic;
	
	-- Fio control para os multiplexadores
	signal fio_control_mux : std_logic_vector(1 downto 0);
	
	-- Fios control para o registrador
	signal fio_control_to_clken_reg, fio_control_to_clr_reg : std_logic;
	
	-- Fio control para o seven
	signal fio_control_seven : std_logic_vector(2 downto 0);
	
begin
	
	-- ==> Mapeamento dos componentes <==
	
	--Multiplexadores 1 e 2
	mux1 : mux4 port map (A => A(3 downto 0), B => A(7 downto 4), sel => fio_control_mux(1), Y => fio_mux1_mult);
	mux2 : mux4 port map (A => B(3 downto 0), B => B(7 downto 4), sel => fio_control_mux(0), Y => fio_mux2_mult);
	
	--Inversora
	inv1 : inv port map (X => start, Y => fio_inv_counter);
	
	--Contador
	--TODO: verificar o erro
	--counter1 : counter port map (clk => clk, clr => fio_inv_counter, total => fio_counter_control);
	
	--Multiplicador 
	mult : mult4x4 port map (dataa => fio_mux1_mult, datab => fio_mux2_mult, result => fio_mult_shifter);
	
	--Shifter
	shifter1 : shifter port map (input => fio_mult_shifter, cnt => fio_control_shifter, result => fio_shifter_adder);
	
	--Control
	control1 : control port map (clk => clk, rst => reset, start => start, count => fio_counter_control, in_sel => fio_control_mux,
	                             shift => fio_control_shifter, state_out => fio_control_seven, done => done_flag, clken => fio_control_to_clken_reg,
										  regclr => fio_control_to_clr_reg );
										  
	--Registrador
	reg1 : reg port map (clk => clk, clr => fio_control_to_clr_reg, clken => fio_control_to_clken_reg, in_reg => fio_adder_reg, out_reg => fio_reg_adder);
	
	--Somador
	adder1 : adder port map (A => fio_shifter_adder, B => fio_reg_adder, sum => fio_adder_reg);
	
	--Display sete segmentos
	seven1 : seven port map (input => fio_control_seven, A => seg(0), B => seg(1), C => seg(2), D => seg(3), E => seg(4),
	                         F => seg(5), G => seg(6));
									 
	result <= fio_reg_adder;
	
	
end arch_multiplicador8x8;