library verilog;
use verilog.vl_types.all;
entity seg7x16 is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        i_data          : in     vl_logic_vector(31 downto 0);
        o_seg           : out    vl_logic_vector(7 downto 0);
        o_sel           : out    vl_logic_vector(7 downto 0)
    );
end seg7x16;
