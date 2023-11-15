----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:07:06 09/26/2023 
-- Design Name: 
-- Module Name:    VGA_TOP - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_TOP is PORT(
  CLOCK, RESET : IN STD_LOGIC;
--  RED, GREEN, BLUE : IN STD_LOGIC;
--  RGB : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
  RED_OUT, GREEN_OUT, BLUE_OUT : OUT STD_LOGIC;
  
  HSync, VSync : OUT STD_LOGIC);
end VGA_TOP;

architecture Behavioral of VGA_TOP is


  COMPONENT V_FSM is port(
    CLK, RESET : IN STD_LOGIC;
    VDataon, VSync : OUT STD_LOGIC);
  end COMPONENT V_FSM;

  COMPONENT H_FSM is port(
    CLK, RESET : IN STD_LOGIC;
    HDataon, HSync, rollover : OUT STD_LOGIC);
  end COMPONENT H_FSM;

  COMPONENT HelevenBitCounter is
    Port ( D : in std_logic_vector(10 downto 0):= "00000000000";
	        Clock : in STD_LOGIC;
	        Clear : in std_logic;
			  Count : in std_logic;
           Q : out STD_LOGIC_VECTOR(10 downto 0));
  end COMPONENT HelevenBitCounter;

  COMPONENT Velevenbitcounter is
    Port ( D : in std_logic_vector(10 downto 0):= "00000000000";
	        Clock : in STD_LOGIC;
	        Clear : in std_logic;
			  Count : in std_logic;
           Q : out STD_LOGIC_VECTOR(10 downto 0));
  end COMPONENT Velevenbitcounter;


  signal roll : std_logic;  
  signal HDataon, VDataon : std_logic;
  signal HCount, VCount : std_logic_vector(10 downto 0);
begin
   process(HCount, VCount,HDataon, VDataon)
	   begin
		 if(HDataon = '1' and VDataon = '1')then 
			 if (VCount >= "00000110001" and VCount <= "00100101100") then
				  if (HCount >= "00000110001" and HCount <= "00111110100") then
					  
							 RED_OUT <=  '1';
							 GREEN_OUT <=  '1';
							 BLUE_OUT <=  '1';
							 --RGB <= "011";
					  else
							 RED_OUT <= '1';
							 GREEN_OUT <= '0';
							 BLUE_OUT <= '0';
							 --RGB <= "111";
					  end if;
				  else
					  RED_OUT <= '0';
					  GREEN_OUT <= '0';
					  BLUE_OUT <= '0';
					  --RGB <= "100";
			  end if;	  
		 else
		     RED_OUT <= '0';
           GREEN_OUT <= '0';
           BLUE_OUT <= '0';
		
	  end if;  
	 end process;



	 
			     
  H1 : H_FSM PORT MAP(CLK => CLOCK,
                      RESET => RESET,
							 HDataon => HDataon ,
							 HSync => HSync,
							 rollover => roll);
							 
							 
  V1 : V_FSM PORT MAP(CLK => roll,
                      RESET => RESET,
							 VDataon => VDataon,
							 VSync => VSync);							 

  HDataCount : HelevenBitCounter PORT MAP(D => "00000000000",
                                      Clock => CLOCK,
												  Clear => RESET,
												  Count => HDataon,
												  Q => HCount);
												  
  VDataCount : Velevenbitcounter PORT MAP(D => "00000000000",
                                      Clock => roll,
												  Clear => RESET,
												  Count => VDataon,
												  Q => VCount);

												  
--     RED_OUT <= HDataon and VDataon and '1';
--     GREEN_OUT <= HDataon and VDataon and '1';
--     BLUE_OUT <= HDataon and VDataon and '0';
  

end Behavioral;

