----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ali Jafri
-- 
-- Create Date: 02/09/2021 11:25:51 PM
-- Design Name: 
-- Module Name: low_pass - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_signed.all ;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
--use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;
--use ieee_proposed.math_utility_pkg.all;
entity low_pass is
  Port ( a : in STD_LOGIC_VECTOR ( 31 downto 0 );
        bdl : in STD_LOGIC_VECTOR ( 31 downto 0 );
        d : out STD_LOGIC_VECTOR ( 31 downto 0 );
        edl : out STD_LOGIC_VECTOR ( 31 downto 0 ));
end low_pass;

architecture Behavioral of low_pass is

begin
process(a,bdl)
		variable AA , AAA , BB , CC , DD : float32; --sfixed(20 downto -11) :=to_sfixed(0.0,20,-11);
		variable Vo1 , Vo2 , Vo3 , temp1 : float32; --sfixed(20 downto -11):= to_sfixed(0.0,20,-11);
-- 			variable temp1 : std_ulogic_vector(31 downto 0);
		variable temp2,b1,b, pi : real;
		variable DL , DL1 : float32 := to_float( 0.0 , 8 , 23 );
-- 		variable temp3 : std_logic_vector(15 downto 0);
begin
-- 		if(clk'event and clk = '1')then
		b := 4000.0 ;
		b1 := 44100.0 ;
		pi := 3.14159 ;
-- 			temp1 := to_sfixed(a,20,-11);
-- 			DL := to_float(b);
		DL := to_float(bdl, 8 , 23 );
		AA := add(multiply(to_float( 3.14159 , 8 , 23 ),to_float(b, 8 , 23 )),to_float(b1, 8 , 23 ));
-- 			AA := to_sfixed(((pi * b) + b1),20,-11);
-- 			AA := AAA + b1; --to_sfixed(b1,20,-11);
		
		BB := subtract (multiply(to_float( 3.14159 , 8 , 23 ),to_float(b, 8 , 23 )),to_float(b1, 8, 23 ));
-- 			BB := to_sfixed(((pi * b) - b1),20,-11);
--to_sfixed(b,20,-11)) - to_sfixed(b1,20,-11);
		
		CC := divide( BB , AA );
-- 			temp2 := conv_integer(a);
		Vo1 := subtract (to_float(a, 8 , 23 ),multiply( CC , DL ));
-- 			Vo1 := to_sfixed(to_integer(a - (CC * DL)),20,-11);
--to_sfixed(to_real(a - to_sfixed(to_std_ulogic_vector(CC *DL),20,-11)),20,-11);

		DD := divide(multiply(to_float( 3.14159 , 8 , 23 ),to_float(b, 8 , 23 )), AA );
-- 			DD := to_sfixed(to_real(divide(to_sfixed((pi * b),20,-11),AA)),20,-11); --to_sfixed(b,20,-11)) / AA;

		Vo2 := add( Vo1 , DL );
-- 			Vo2 := to_sfixed(to_integer(Vo1 + DL),20,-11);
		Vo3 := multiply( Vo2 , DD );
-- 			Vo3 := to_sfixed(to_integer(Vo2 * DD),20,-11);
		DL1 := Vo1 ;
-- 			temp1 := to_slv(Vo3);
-- 			temp2 := conv_integer(temp1);
-- 			temp3 := conv_std_logic_vector(temp2,16);
		d <= to_slv( Vo3 );
		edl <= to_slv( DL1 );
-- 	e <= to_slv(Vo1);
-- end if;
end process;
end Behavioral;
