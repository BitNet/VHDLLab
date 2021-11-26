
--debouncer

library ieee;
use ieee.std_logic_1164.all;


entity deb is
    port
    (
        i_bouncy : in bit;
        i_clock: in bit;
        i_reset: in bit;
        o_pulse: out std_logic
    );
end entity deb;



architecture debArch of deb is

    variable v_count: bit;begin
    debProc: process (i_clock, i_bouncy) is
        
        begin
            if(rising_edge(i_bouncy)) then
                if(v_count='0' and i_clock'event) 
                    then o_pulse<='1';
                    else v_count:='0'; --se avviene un evento sul bottone si resetta
                    end if;
                elsif(not i_bouncy'event and i_clock'event) 
                    then v_count:=v_count-1;     --se non cambia lo stato del bottone e passa un ciclo di clock segna
                       
                       
            end if;
    end process debProc;        

end architecture debArch;
