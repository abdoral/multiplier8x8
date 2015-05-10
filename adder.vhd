-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Matrícula: 371907
-- Arquivo: adder.vhd


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity adder is
	port(
		A, B : in std_logic_vector(15 downto 0);
		sum : out std_logic_vector(15 downto 0)
	);
end adder;


architecture arch_adder of adder is
begin
	process(A, B)
		variable temp_sum : unsigned(16 downto 0);
	begin
		temp_sum := to_unsigned(to_integer(unsigned(A)) + to_integer(unsigned(B)), 17);
		if temp_sum > 65535 then
			sum <=(others => '1');
		else
			sum <= std_logic_vector(temp_sum(15 downto 0));
		end if;
	end process;
end arch_adder;