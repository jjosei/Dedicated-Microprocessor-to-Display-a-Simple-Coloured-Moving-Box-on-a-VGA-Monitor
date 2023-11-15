----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:41:21 09/26/2023 
-- Design Name: 
-- Module Name:    H_FSM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity H_FSM is port(
  CLK, RESET : IN STD_LOGIC;
  HDataon, HSync, rollover : OUT STD_LOGIC);
end H_FSM;


architecture Behavioral of H_FSM is
  type state is (H_B, H_C, H_D, H_E);
  signal PS,NS : state;
  signal hcntcurr, hcntnext : std_logic_vector(10 downto 0);
  signal rollcurr, rollnext : std_logic;
begin
   process(CLK,RESET)
	  begin
	    
		   if(reset='1')then
			   PS <= H_B;
				hcntcurr <= "00000000000";
				rollcurr <= '0';
		   elsif (rising_edge(CLK))then
            PS <= NS;
				rollcurr <= rollnext;
            hcntcurr <= hcntnext;
         end if;
			
   end process;



   process(PS, hcntcurr, rollcurr)
   begin
     case (PS) is
       when H_B =>
          hcntnext <= hcntcurr + "00000000001";
          HDataon <= '0';
          HSync <= '0';
          if(hcntcurr = "00010111101")then
             NS <= H_C;
             rollnext <= '0';
          else
             NS <= PS;
				 rollnext <= '0';
          end if;
			 
			 
		 when H_C =>
          hcntnext <= hcntcurr + "00000000001";
          HDataon <= '0';
          HSync <= '1';
          if(hcntcurr = "00100010111")then
             NS <= H_D;
             rollnext <= '0';
          else
             NS <= PS;
				 rollnext <= '0';
          end if;	 


       when H_D =>
          hcntnext <= hcntcurr + "00000000001";
          HDataon <= '1';
          HSync <= '1';
          if(hcntcurr = "11000010100")then
             NS <= H_E;
             rollnext <= '0';
          else
             NS <= PS;
				 rollnext <= '0';
          end if;
			 
       when H_E =>
         
          HDataon <= '0';
          HSync <= '1';
          if(hcntcurr = "11000111111")then
					hcntnext <= (others => '0');
             NS <= H_B;
             rollnext <= '1';
          else
				hcntnext <= hcntcurr + "00000000001";
             NS <= PS;
				 rollnext <= '0';
          end if;
			 
	end case;
  end process;	
 
 rollover <= rollcurr;
end Behavioral;



