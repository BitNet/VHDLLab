

entity HalfComparator is

    port(
        i_a,i_b : in bit;
        o_exit :out bit_Vector(1 downto 0)

    );

end entity HalfComparator;



architecture HalfCOmparatorArch of HalfComparator is


begin


    o_exit(0)<=i_a XOR i_b;
    o_exit(1)<=i_a AND (not i_b);



end architecture HalfComparatorArch;








entity HCTest is
end entity HCTest;

architecture HCTArch of HCTest is


    signal s_a,s_b: bit;
    signal s_exit : bit_vector(1 downto 0);

begin

    HC: entity work.HalfComparator port map(i_a=>s_a,i_b=>s_b,o_exit(0)=>s_exit(0),o_exit(1)=>s_exit(1));




    testBench :
    process  is
        begin


    s_a<='0';
    s_b<='0';

    wait for 10 ns;

    s_a<='1';

    wait for 10 ns;

    s_b<='1';

    wait for 10 ns;

    s_a<='0';

    wait;
    
    end process;


end architecture HCTArch;