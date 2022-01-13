

entity FullComparator is
    port(

        i_exit: in bit_vector(1 downto 0);
        i_a : in  bit;
        i_b : in bit;
        o_exit: out bit_vector(1 downto 0)
    );
end entity FullComparator;



architecture FullComparatorArch of FullComparator is

    signal s_a,s_b :bit ;
    signal s_exit : bit_vector(1 downto 0);

begin

    HC : entity work.HalfComparator port map(i_a=>s_a,i_b=>s_b,o_exit=>s_exit);

        FullComparison: process (i_a, i_b,i_exit) is
        begin

            if(i_exit = "00") then

                o_exit<=s_exit;


            else
            
                o_exit<=i_exit;
            
            end if;
        end process FullComparison;

end architecture FullComparatorArch;








entity FCTest is
end entity FCTest;

architecture FCTArch of FCTest is

    signal s_a,s_b: bit;
    signal s_precExit : bit_vector(1 downto 0);

begin

    FC: entity work.FullComparator port map(i_a=>s_a,i_b=>s_b,i_exit=>s_precExit);

    FCtesting:
     process is 

    begin
        s_precExit<="00";
        s_a<='0';
        s_b<='0';
   
        wait for 10 ns;

        s_precExit<="11";
        s_a<='0';
        s_b<='0';
        

        wait for 10 ns;

        s_precExit<="10";
        s_a<='0';
        s_b<='1';
        

        wait for 10 ns;

        s_precExit<="01";
        s_a<='1';
        s_b<='0';
        

        wait ;

    end process FCtesting;


end architecture FCTArch;

