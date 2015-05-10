-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Arquivo: inv.vhd

library ieee;
use ieee.std_logic_1164.all;


entity inv is
	port (
		X : in std_logic;
		Y : out std_logic
	);
end inv;

architecture arc_inv of inv is
begin
	Y <= not X; 
end arc_inv;