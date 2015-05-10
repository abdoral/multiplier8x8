-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Matrícula: 371907
-- Arquivo: reg.vhd


Library IEEE;
Use IEEE.Std_logic_1164.ALL;
Use IEEE.Std_logic_unsigned.All;


ENTITY reg IS
	PORT ( 
		in_reg : in std_logic_vector(15 downto 0);
		clk, clr, clken : in std_logic;
		out_reg : out std_logic_vector(15 downto 0)
	);
END reg;


Architecture arch_reg of reg is
	--signal a,b,e,f : std_logic;
Begin
	PROCESS (clk)
	   Begin
		IF rising_edge(clk) then
		   IF (clken = '1') then
				IF (clr = '1') then
						out_reg <= in_reg;
				ELSIF (clr = '0') then
						out_reg <= (others => '0');
				end IF;
			end IF;	
		end IF;
	End process;
END arch_reg;


