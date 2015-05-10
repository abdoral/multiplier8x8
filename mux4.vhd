-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Matrícula: 371907
-- Arquivo: mux.vhd

library ieee;
use ieee.std_logic_1164.all;


entity mux4 is
	port(
		A, B : in std_logic_vector(3 downto 0);
		sel: in std_logic;
		Y : out std_logic_vector(3 downto 0)
	);
end mux4;


architecture arch_mux4 of mux4 is
begin
	with sel select
		Y <= A when '0',
		     B when '1',
			  "0000" when others;
end arch_mux4;