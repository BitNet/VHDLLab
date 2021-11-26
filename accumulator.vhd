-- accumulator

library ieee;
use ieee.std_logic_1164.all;


entity acc is
    port 
    (
        -- manca il reset
        i_input: std_logic_vector(32 downto 0); 
        i_enable: in bit;   
        i_clock: in bit;
        b_ans: buffer std_logic_vector( 32 downto 0)
    );
end entity acc;


architecture accArch of acc is

begin
    acc_mux: process (i_clock) is
        
        begin
            if(i_clock='1' and i_enable='1') then 
                b_ans<=i_input;
            else b_ans<=b_ans;
            end if;
       
    end process acc_mux;
 end architecture  accArch;
    
--testbench
library ieee;
use ieee.std_logic_1164.all;


entity testAcc is
end testAcc;


architecture testAccArch of testAcc is

    signal s_clock,s_enable: bit;
    signal s_init : std_logic_vector(32 downto 0);
 

        begin
            accTest: entity work.acc port map (s_init,s_enable,s_clock);

            test: process is

                

                begin 
                   
                s_init<=(others =>'0');


                s_clock<='0';
                s_enable<='1';
                s_init<=(others =>'1');
                wait for 30 ns;

                s_clock<='1';
                s_enable<='1';
                s_init<=(others => '1') ;
                wait for 30 ns;

                s_clock<='0';
                s_enable<='0';
                s_init<=(others =>'1');
                wait for 30 ns;

                s_clock<='1';
                s_enable<='0';
                s_init<=(others =>'0');
                wait;

            end process test;
end architecture testAccArch;
                


