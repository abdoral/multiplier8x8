-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Matrícula: 371907
-- Arquivo: shifter.vhd

library ieee;
use ieee.std_logic_1164.all;


entity shifter is
	port(
		input : in std_logic_vector(7 downto 0);
		cnt : in std_logic_vector(1 downto 0);
		result : out std_logic_vector(15 downto 0)
	);

end shifter;

architecture logic_shifter of shifter is
begin
	process(input, cnt)
		variable shiter_var : std_logic_vector(15 downto 0);
	begin
		case cnt is
			when "00" =>
				for i in 15 downto 8 loop
					shiter_var(i) := '0';
					shiter_var(i-8) := input(i-8);
				end loop;	
			when "01" =>
	         for i in 15 downto 12 loop
					shiter_var(i) := '0';
				end loop;	
				for i in 11 downto 4 loop
					shiter_var(i) := input(i-4);
				end loop;
				for i in 3 downto 0 loop
					shiter_var(i) := '0';
				end loop;
			when "10" =>
				for i in 15 downto 8 loop
					shiter_var(i) := input(i-8);
					shiter_var(i-8) := '0';
				end loop;	
			when "11" =>
				for i in 15 downto 8 loop
					shiter_var(i) := '0';
					shiter_var(i-8) := input(i-8);
				end loop;	
			end case;
			result <= shiter_var;
   end process;	
end logic_shifter;
