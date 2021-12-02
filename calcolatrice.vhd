--calcolatrice che lavora tramite i componenti debouncer,alu ed accumulator

    --fatti rispiegare init ed enable in accumulator
    --come cazzo si usano i driver per l'oled ?



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc is
    port
    (
        rst : in std_logic;
        clck : in std_logic;
        upbutton,downbutton,leftbutton,rightbutton,centerbutton :in std_logic;
        i_num: in signed(31 downto 0);
        LED : out std_logic_vector( 7 downto 0 );
        SW : in std_logic_vector( 7 downto 0 );
 
       
    -- Outputs to the OLED module
        -- OLED SPI data out
        oled_sdin : out std_logic;
        -- OLED SPI clock
        oled_sclk : out std_logic;
        -- OLED data/command signal
        oled_dc : out std_logic;
        -- OLED reset signal
        oled_res : out std_logic;
        -- OLED Vbat enable
        oled_vbat : out std_logic;
        -- OLED Vdd enable
        oled_vdd : out std_logic

    );           
end entity calc;


--architettura di tipo strutturale

architecture calcArch of calc is

    signal s_result: signed(31 downto 0);
    signal upedge,downedge,leftedge,rightedge,centeredge : bit;
     -- The output of the accumulator is translated into std_logic_vector in this signal
    signal display_value : std_logic_vector( 31 downto 0 );
    -- The input from the switches is sign extended here
    signal sw_input : std_logic_vector( 31 downto 0 );

   
begin
    
    -- Instantiate the OLED driver
  thedriver:entity work.oled_driver
  port map 
  (
      clock => clck,
      reset => '1',
      poweroff => downedge,
      display_in => display_value,
      oled_sdin => oled_sdin,
      oled_sclk => oled_sclk,
      oled_dc => oled_dc,
      oled_res => oled_res,
      oled_vbat => oled_vbat,
      oled_vdd => oled_vdd
  );

LED <= SW;

-- Sign extended switches (32bit - extension)
sw_input <= SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) &
    SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) &
    SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW;


    UpDeb:entity work.debouncer 
        port map
            (
                clock=>clck,
                reset=>rst,
                bounce=>upbutton,
                pulse=>upedge
            );

    DownDeb:entity work.debouncer 
        port map
            (
                clock=>clck,
                reset=>rst,
                bounce=>downbutton,
                pulse=>downedge
            );

   LeftDeb:entity work.debouncer 
        port map
            (
                clock=>clck,
                reset=>rst,
                bounce=>leftbutton,
                pulse=>leftedge
            );
            
            
    RightDeb:entity work.debouncer 
        port map
            (
                clock=>clck,
                reset=>rst,
                bounce=>rightbutton,
                pulse=>rightedge
            );
    
    CenterDeb:entity work.debouncer 
        port map
            (
                clock=>clck,
                reset=>rst,
                bounce=>centerbutton,
                pulse=>centeredge
            );



    ALU:entity work.alu 
        port map
            (
                i_num=>i_num,
                i_sum=>upedge,
                i_mult=>rightedge,
                i_sub=>leftedge,
                o_out=>s_result
            );



    ACC:entity work.accumulator 
        port map
            (

                i_clock=>clck,
                i_reset=>rst,
                i_init=>upedge or downedge or leftedge or rightedge,
                i_enable=>centeredge,
                i_input=>s_result
               
            );

    display_value <= std_logic_vector(s_result);
  

end architecture calcArch;
    
   