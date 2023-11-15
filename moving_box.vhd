----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:15:08 09/28/2023 
-- Design Name: 
-- Module Name:    moving_box - Behavioral 
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

entity moving_box is PORT(
  CLOCK, RESET : IN STD_LOGIC;
--  RED, GREEN, BLUE : IN STD_LOGIC;
--  RGB : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
  RED_OUT, GREEN_OUT, BLUE_OUT : OUT STD_LOGIC;
  HSync, VSync : OUT STD_LOGIC);
end moving_box;

architecture Behavioral of moving_box is


  COMPONENT V_FSM is port(
    CLK, RESET : IN STD_LOGIC;
    VDataon, VSync, rollover : OUT STD_LOGIC);
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





	component b1counter is port(
	  clk : in std_logic;
	--  set : in std_logic;
	  en : in std_logic;
	  enOUT : out std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(10 downto 0));
	end component b1counter;



   component c1counter is port(
	  clk : in std_logic;
	--  set : in std_logic;
	  en : in std_logic;
	  enOUT : out std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(10 downto 0));
	end component c1counter;


	component b2counter is port(
	  clk : in std_logic;
	--  set : in std_logic;
	  en : in std_logic;
	  enOUT : out std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(10 downto 0));
	end component b2counter;







	component c2counter is port(
	  clk : in std_logic;
	--  set : in std_logic;
	  en : in std_logic;
	  enOUT : out std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(10 downto 0));
	end component c2counter;





  signal roll1, roll2: std_logic;  
  signal HDataon, VDataon : std_logic;
  signal HCount, VCount : std_logic_vector(10 downto 0);
  
  signal b1enable : std_logic;
  signal c1enable : std_logic;
  signal b2enable : std_logic;
  signal c2enable : std_logic;
  signal b1out, b2out, c1out, c2out : std_logic_vector(10 downto 0);
begin
 

   process(HCount, VCount,HDataon, VDataon,b1out,c1out,c2out,b2out)
	   begin
		 if(HDataon = '1' and VDataon = '1')then 
			 if (VCount >= c1out and VCount <= b1out) then
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
			 elsif(VCount >= c2out and VCount <= b2out) then
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
							 rollover => roll1);
							 
							 
  V1 : V_FSM PORT MAP(CLK => roll1,
                      RESET => RESET,
							 VDataon => VDataon,
							 rollover => roll2,
							 VSync => VSync);							 

  HDataCount : HelevenBitCounter PORT MAP(D => "00000000000",
                                      Clock => CLOCK,
												  Clear => RESET,
												  Count => HDataon,
												  Q => HCount);
												  
  VDataCount : Velevenbitcounter PORT MAP(D => "00000000000",
                                      Clock => roll1,
												  Clear => RESET,
												  Count => VDataon,
												  Q => VCount);


  b1 : b1counter port map(clk => roll2,
	                 --       set =>   , 
	                        en => b2enable  ,
									enOUT => b1enable,
	                        reset => RESET ,
									count => b1out);
	

  c1 : c1counter port map(clk => roll2,
	                --        set =>   , 
	                        en => c2enable   ,
									enOUT => c1enable,
	                        reset => RESET ,
									count => c1out);
	


  b2 : b2counter port map(clk => roll2,
	                      --  set =>   , 
	                        en => b1enable  ,
									enOUT => b2enable,
	                        reset => RESET ,
									count => b2out);
	


  c2 : c2counter port map(clk => roll2,
	                    --    set =>   , 
	                        en => c1enable  ,
									enOUT => c2enable,
	                        reset => RESET  ,
									count => c2out);
	
	
--     RED_OUT <= HDataon and VDataon and '1';
--     GREEN_OUT <= HDataon and VDataon and '1';
--     BLUE_OUT <= HDataon and VDataon and '0';
  

end Behavioral;












-- b1 := "00011001000";
--	c1 := "00001100100";
--	b2 := "00000000000";
--	c2 := "00000000000";
--	
--   processs(CLOCK)
--	BEGIN
--	  if (b1 = "00011001000" and b1 /= "00111011111") then
--	     b1 := b1 + 1;
--		  c1 := c1 + 1;
--		  b2 := "00000000000";
--	     c2 := "00000000000";
--	  elsif(b1 = "00111011111")  then
--	     b1 = "00111011111";
--		  c1 := c1 + 1;
--		  b2 := b2 + 1;
--		  c2 := "00000000000";
--	  elsif(c1 = "00111011111")  then
--        b1 := "00000000000";
--        c1 := "00000000000"; 	  
--        b2 := b2 + 1;
--		  c2 := c2 + 1;
--	  elsif(b2 = "00111011111") then
--    	  b2 = "00111011111";
--		  c2 = c2 + 1;
--		  b1 = b1 + 1;
--		  c1 := "00000000000";
--	  elsif(c2 = "00111011111") then
--	     b2 := "00000000000";
--        c2 := "00000000000"; 	  
--        b1 := b1 + 1;
--		  c1 := c1 + 1;
--	  else
--  	      b1 := "00011001000";
--			c1 := "00001100100";
--			b2 := "00000000000";
--			c2 := "00000000000";
--     end if;
--
--
--
