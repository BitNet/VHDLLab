
entity termostato is
    port (

        i_sensore : in bit_vector(3 downto 0);
        o_red,o_blue : out bit;
        o_error: out bit
    );
    end entity termostato;


architecture termArch of termostato is

    signal s_red, s_blue,s_a,s_b,s_c,s_d : bit;
    signal s_helper: bit;

begin

    
    s_a<=i_sensore(0);
    s_b<=i_sensore(1);
    s_c<=i_sensore(2);
    s_d<=i_sensore(3);
    s_helper<=(not s_a) and (not s_b) and (not s_c) and (not s_d);
    
    --s_red<=i_sensore(3);
    s_red<=(not s_a) and (not s_b) and (not s_c);

    --s_blue<=s_a or s_b;
    s_blue<=(not s_c) and (not s_d) and (not s_a or not s_c);

    o_red<=s_red;
    o_blue<=s_blue;

    o_error<=((s_c or s_d) 
            and (s_a or s_b))
            or s_helper;


end architecture termArch;





entity termostatoTest is
end entity termostatoTest;

architecture termostatoTestArch of termostatoTest is

    signal s_sensore : bit_vector(3 downto 0);

begin

    T: entity work.termostato port map (i_sensore=>s_sensore);


    s_sensore <="0000",
                "0001" after 20 ns,
                "0010" after 40 ns,
                "1000" after 60 ns,
                "0010" after 80 ns,
                "0001" after 100 ns,
                "1010" after 120 ns,
                "1001" after 140 ns,
                "0010" after 160 ns;

end architecture termostatoTestArch;



