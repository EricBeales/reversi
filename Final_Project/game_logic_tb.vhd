----------------------------------------------------------------------------------
-- FPGA Design Using VHDL
-- Final Project
--
-- Authors: Eric Beales &  James Frank
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.final_project_lib.all;
use work.final_project_test_package.all;
 
ENTITY game_logic_tb IS
END game_logic_tb;
 
ARCHITECTURE behavior OF game_logic_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT game_logic
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         play : IN  std_logic;
         game_board_out : OUT  byte_array(63 downto 0);
         current_position : IN  unsigned(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal play : std_logic := '0';
   signal current_position : unsigned(5 downto 0) := (others => '0');

 	--Outputs
   signal game_board : byte_array(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns; -- 50 MHz
	constant process_period : time := 20 us; -- Processing completes within 20 microseconds
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: game_logic PORT MAP (
          clk => clk,
          reset => reset,
          play => play,
          game_board_out => game_board,
          current_position => current_position
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
      wait for process_period;
		
		-- verify starting center squares
		check_square(game_board, 27, SPACE_WHITE);
		check_square(game_board, 28, SPACE_BLACK);
		check_square(game_board, 35, SPACE_BLACK);
		check_square(game_board, 36, SPACE_WHITE);
		
		-- end
		assert false
			report "End of testbench, ended normally"
			severity failure;
      wait;
   end process;

END;