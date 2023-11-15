----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:33 09/28/2023 
-- Design Name: 
-- Module Name:    b2counter - Behavioral 
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

entity b2counter is port(
  clk : in std_logic;
  --set : in std_logic;
  en : in std_logic;
  enOUT : out std_logic;
  reset : in std_logic;
  count : out std_logic_vector(10 downto 0));
end b2counter;

architecture Behavioral of b2counter is
   signal b2 : std_logic_vector(10 downto 0); 
   signal wait_count : std_logic_vector(10 downto 0):= "00000000000"; 	
begin
 PROCESS(clk,reset)
  BEGIN
   if(reset = '1') then 
	     b2 <= "00000000000";
   elsif(rising_edge(clk)) then
	  if(en = '1') then
     --  if(set = '1') then 
            b2 <= "00000000000";	  
      -- else
		    if(b2 = "00111011111") then
			    if wait_count = "00001100100"  then
                 b2 <= "00000000000";
					  wait_count <= "00000000000";
				 else
                 wait_count <= wait_count + '1';
             end if;					  
		    else 	  
	   	    b2 <= b2 + "00000000001";
		    end if;
		  end if;	   
	   end if;
  -- end if;		
 END PROCESS;   

 enOUT <= '1' WHEN b2 = "00111011111" ELSE
          '0';  
 count <= b2;
end Behavioral;

