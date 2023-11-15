----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:08:04 09/27/2023 
-- Design Name: 
-- Module Name:    Helevenbitcounter - Behavioral 
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

entity HelevenBitCounter is
    Port ( D : in std_logic_vector(10 downto 0):= "00000000000";
	        Clock : in STD_LOGIC;
	        Clear : in std_logic;
			  Count : in std_logic;
           Q : out STD_LOGIC_VECTOR(10 downto 0));
end HelevenBitCounter;

architecture Behavioral of HelevenBitCounter is
    signal elevenBitCounter_value : STD_LOGIC_VECTOR(10 downto 0):=(others=>'0');
begin
     
    process (Clock, Clear, D)
    begin
        if Clear = '1' then
            elevenBitCounter_value <= D; 
            				
        elsif rising_edge(Clock) then
		    if (Count = '1') then
			    elevenBitCounter_value <= elevenBitCounter_value + 1; 
			 else
             elevenBitCounter_value <= D; 			 
           end if;    
         end if;   
    
			 

    end process;

    Q <= elevenBitCounter_value;  
end Behavioral;

