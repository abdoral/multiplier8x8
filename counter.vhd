-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Matrícula: 371907
-- Arquivo: counter.vhd

Library IEEE;
Use IEEE.Std_logic_1164.ALL;
Use IEEE.Std_logic_unsigned.All;


ENTITY counter IS
	PORT ( 
		clk, clr : in std_logic;
		total : out std_logic_vector(1 downto 0)
	);
END counter;


Architecture arch_counter of counter is
Begin
	PROCESS (clk)
		variable count : std_logic_vector(1 downto 0); 
	Begin
		count := (others => '0');
		IF rising_edge(clk) then
			IF (clr = '1') then
					total <= (others => '0');
			ELSIF (clr = '0') then
					count := count+1;
			end IF;
		end IF;
	   total <= count;		
	End process;
END arch_counter;


