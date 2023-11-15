----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:55 09/28/2023 
-- Design Name: 
-- Module Name:    c1counter - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity c1counter is port(
  clk : in std_logic;
--  set : in std_logic;
  en : in std_logic:='1';
  enOUT : out std_logic;
  reset : in std_logic;
  count : out std_logic_vector(10 downto 0));
end c1counter;

architecture Behavioral of c1counter is
   signal c1 : std_logic_vector(10 downto 0); 
   signal wait_count : std_logic_vector(10 downto 0):= "00000000000"; 	
begin
 PROCESS(clk,reset)
  BEGIN
   if(reset = '1') then 
	     c1 <= "00000000000";
   elsif(rising_edge(clk)) then
	  if(en = '1') then
      -- if(set = '1') then 
             c1 <= "00001100100";	  
      -- else
		    if(c1 = "00111011111") then
			    if wait_count = "00001100100"  then
                 c1 <= "00000000000";
					  wait_count <= "00000000000";
				 else
                 wait_count <= wait_count + '1';
             end if;					  
		    else 	  
	   	    c1 <= c1 + "00000000001";
		    end if;
		  end if;	   
	   end if;
   --end if;		
 END PROCESS; 

 enOUT <= '1' WHEN c1 = "00111011111" ELSE
          '0'; 
 count <= c1;
end Behavioral;

