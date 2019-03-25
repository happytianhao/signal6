library verilog;
use verilog.vl_types.all;
entity IM is
    port(
        OpCode          : out    vl_logic_vector(31 downto 0);
        ImAdress        : in     vl_logic_vector(9 downto 0)
    );
end IM;
