

entity calendar is
    port(
        i_a,i_b,i_c,i_d : in bit;
        o_a,o_b,o_c,o_d,o_e : out bit
    );

end entity calendar;



architecture calendarArch of calendar is

      
begin

    o_a<='1';
    o_b<='1';
    o_c<='1';

    o_d<=i_a or i_b or (not i_c) or i_d;
    o_e<=(i_a and (not i_d) and ((not i_c) or (not i_b))) or (not i_a and i_d);

end architecture calendarArch;





entity calendarTest is
end entity calendarTest;

architecture calendarTestArch of calendarTest is

    signal s_month : bit_vector(3 downto 0);
    signal s_days : bit_vector(4 downto 0);

begin

    C: entity work.calendar port map (i_a=>s_month(3),i_b=>s_month(2),i_c=>s_month(1),i_d=>s_month(0),
                                      o_a=>s_days(4),o_b=>s_days(3),o_c=>s_days(2),o_d=>s_days(1),o_e=>s_days(0));


    s_month<="0001",
             "0010" after 30 ns,
             "0011" after 40 ns,
             "0100" after 50 ns,
             "0101" after 60 ns,
             "0110" after 70 ns,
             "0111" after 80 ns,
             "1000" after 90 ns,
             "1001" after 100 ns,
             "1010" after 110 ns,
             "1011" after 120 ns,
             "1100" after 130 ns;

end architecture calendarTestArch;