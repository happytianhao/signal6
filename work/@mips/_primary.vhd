library verilog;
use verilog.vl_types.all;
entity Mips is
    port(
        o_seg           : out    vl_logic_vector(7 downto 0);
        o_sel           : out    vl_logic_vector(7 downto 0)
    );
end Mips;
