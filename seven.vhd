-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Matrícula: 371907
-- Arquivo: seven.vhd

library ieee;
use ieee.std_logic_1164.all;


entity seven is
	port(
		input : in std_logic_vector(2 downto 0);
		A, B, C, D, E, F, G : out std_logic
	);
end seven;


architecture arch_seven of seven is
begin
	process(input)
	begin
		case input is
			when "000" =>
				A <= '1';
				B <= '1';
				C <= '1';
				D <= '1';
				E <= '1';
				F <= '1';
				G <= '1';
			when "001" =>
				A <= '1';
				B <= '0';
				C <= '0';
				D <= '1';
				E <= '1';
				F <= '1';
				G <= '1';
			when "010" =>
				A <= '0';
				B <= '0';
				C <= '1';
				D <= '0';
				E <= '0';
				F <= '1';
				G <= '0';
			when "100" =>
				A <= '0';
				B <= '0';
				C <= '0';
				D <= '0';
				E <= '1';
				F <= '1';
				G <= '0';
			when others =>
				A <= '0';
				B <= '1';
				C <= '1';
				D <= '0';
				E <= '0';
				F <= '0';
				G <= '0';
			end case;
	end process;
end arch_seven;