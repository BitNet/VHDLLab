--ALU

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port
    (
        i_num: in std_logic_vector( 32 downto 0);
        i_sum, i_mult, i_sub: in bit;
        b_resPrec: buffer std_logic_vector(32 downto 0);
        o_out: out std_logic_vector( 32 downto 0) 
    );

end entity alu;

architecture aluArch of alu is

    signal s_enable: bit;
    signal s_reset: bit;
    signal s_op: bit;
    signal s_trigger:bit;

    begin
    
        aluProc :process (i_num,i_sum,i_sub, i_mult) is

        begin

            s_op<=i_sum or i_sub or i_mult;
            s_trigger<=s_op and s_enable;
            if(s_trigger='1') then

                if(i_sum='1') then o_out<=std_logic_vector(signed(i_num)+signed(b_resPrec));
                    elsif (i_sub='1') then o_out<=std_logic_vector(signed(i_num)-signed(b_resPrec));
                    else o_out<=std_logic_vector(signed(i_num)*signed(b_resPrec));
                end if;

            end if;

        end process aluProc;

end architecture aluArch;
