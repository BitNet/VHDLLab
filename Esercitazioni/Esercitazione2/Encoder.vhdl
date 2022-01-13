

entity Encoder is

port
    (
        i_input: in bit_vector(2 downto 0);
        o_output: out bit_vector(2 downto 0)

    );
end entity Encoder;


architecture EncoderArch of Encoder is

begin

    o_output(0)<=((not i_input(0)) AND (not i_input(1)))
              OR ((not i_input(2)) and (not i_input(1)))
              OR ((not i_input(0)) and (not i_input(2)));
    
    o_output(1)<=((not i_input(1)) and i_input(0));
    o_output(2)<=i_input(1) and (not i_input(2));


end architecture EncoderArch;







entity EncoderTest is
end entity EncoderTest;

architecture EncoderTestArch of EncoderTest is

    signal s_input : bit_vector(2 downto 0);
    signal s_exit : bit_vector(2 downto 0);

begin

    Encoder : entity work.Encoder port map(i_input=>s_input,o_output=>s_exit);


    EncoderTesting: process is

    begin

        s_input<="110";

        wait for 10 ns;

        s_input<="100";

        wait for 10 ns;
        
        s_input<="101";

        wait for 10 ns;
        
        s_input<="011";

        wait for 10 ns;
        
        s_input<="010";

        wait for 10 ns;

        s_input<="001";

        wait;


    end process EncoderTesting;




end architecture EncoderTestArch;