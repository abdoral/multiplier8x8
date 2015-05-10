-- ==========================================
-- =======  Multiplicador 8x8  =======
-- Disciplina de Microeletrônica
-- Engenharia da Computação - Universidade Federal do Ceará
-- Professor: Alexandre Coelho
-- Aluno: Abdoral Timóteo de Sousa Neto
-- Matrícula: 371907
-- Arquivo: control.vhd

library ieee;

use ieee.std_logic_1164.all;
use IEEE.Std_logic_unsigned.All;
use IEEE.Std_logic_arith.All; 

--Definição da entidade control;
entity control is
	port(
		clk, rst, start : in std_logic;
		count : in std_logic_vector(1 downto 0);
		in_sel, shift : out std_logic_vector(1 downto 0);
		state_out : out std_logic_vector(2 downto 0);
		done, clken, regclr : out std_logic
	);
end control;

--Definiçao da arquitetura da entidade control;
architecture arch_control of control is 
	type state_type is (idle, lsb, mid, msb, err);
	signal code : state_type;
begin
   -- Com a variaçao do clock e reset há a variação dos estados
	process(clk, rst)
	begin
		if rst = '1' then
			code <= idle;
		elsif rising_edge(clk) then
			case code is
			   -- Condições pra o estado idle;
				when idle =>
					if start = '0' and count = "XX" then
						code <= idle;
					elsif start = '1' and count = "XX" then
						code <= lsb;
					end if;
				-- Condições pra o estado lsb;
				when lsb =>
					if start = '0' and count = "00" then
						code <= mid;
					else
						code <= err;
					end if;
				-- Condições pra o estado mid;
				when mid =>
					if start = '0' and count = "01" then
						code <= mid;
					elsif start = '0' and count = "10" then
						code <= msb;
					else
						code <= err;
					end if;
				-- Condições pra o estado msb;
				when msb =>
					if start = '0' and count = "11" then
						code <= idle;
					else
						code <= err;
					end if;
				-- Condições pra o estado err;
				when err =>
					if start = '1' and count = "XX" then
						code <= lsb;
					else
						code <= err;
					end if;
			end case;
		end if;	
	end process;
	
	process(code, start, count)
   begin 
		case code is
			when idle =>
				in_sel <= "XX";
				shift <= "XX";
				done <= '0';
				clken <= '1';
				regclr <= '1';
				state_out <= "000";
			when lsb =>
				in_sel <= "XX";
				shift <= "XX";
				done <= '0';
				clken <= '1';
				regclr <= '0';
				state_out <= "001";
			when mid =>
				if count = "00" then
					in_sel <= "00";
					shift <= "00";
					done <= '0';
					clken <= '0';
					regclr <= '1';
					state_out <= "010";
				elsif count = "01" then
					in_sel <= "01";
					shift <= "01";
					done <= '0';
					clken <= '0';
					regclr <= '1';
					state_out <= "010";
				end if;
			when msb =>
				in_sel <= "10";
				shift <= "01";
				done <= '0';
				clken <= '0';
				regclr <= '1';
				state_out <= "011";
			when err =>
				in_sel <= "XX";
				shift <= "XX";
				done <= '0';
				clken <= '1';
				regclr <= '1';
				state_out <= "100";
			end case;
					
	end process;
			
	
end arch_control;