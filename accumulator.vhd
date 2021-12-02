-- accumulator

library ieee;
use ieee.std_logic_1164.all;


entity acc is
    port 
    (
        i_clock: in std_logic;
        i_reset: in bit;
        i_init: in std_logic_vector(32 downto 0);
        i_enable: in bit;
        i_input: std_logic_vector(32 downto 0); 
        b_ans: buffer std_logic_vector( 32 downto 0)
    );
end entity acc;


architecture accArch of acc is

begin
    acc_mux: process (i_clock,i_reset) is
        
        begin

            if(i_reset='1') then
                b_ans<=(others=>'0');
                elsif(rising_edge(i_clock) and i_enable='1') then 
                    b_ans<=i_input;
                elsif(i_init='1') then
                    b_ans<=(others=>'0');
            end if;
       
    end process acc_mux;

end accArch;    




/*--testbench

library ieee;
use ieee.std_logic_1164.all;


entity testAcc is
end testAcc;


architecture testAccArch of testAcc is

    signal s_clock:std_logic;
    signal s_enable: bit;
    signal s_init: std_logic_vector(32 downto 0);
    signal s_input : std_logic_vector(32 downto 0);
    signal s_reset: bit;
 

        begin
            accTest: entity work.acc port map (s_clock,s_reset,s_init,s_enable,s_input);

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
end architecture testAccArch;*/