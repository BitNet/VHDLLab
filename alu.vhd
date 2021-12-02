--ALU

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port
    (
        i_num: in signed( 32 downto 0);
        i_sum, i_mult, i_sub: in bit;
        b_resPrec: buffer signed(32 downto 0);
        o_out: out signed( 32 downto 0) 
    );

end entity alu;

architecture aluArch of alu is

    signal s_prod: signed(63 downto 0);



    begin
    
        aluProc :process (i_num,i_sum,i_sub, i_mult) is

        begin

            o_out<=i_num;
                if(i_sum='1') then o_out<=std_logic_vector(signed(i_num)+signed(b_resPrec));
                    elsif (i_sub='1') then o_out<=std_logic_vector(signed(i_num)-signed(b_resPrec));
                    else o_out<=std_logic_vector(signed(i_num)*signed(b_resPrec));
                end if;


        end process aluProc;

end architecture aluArch;
