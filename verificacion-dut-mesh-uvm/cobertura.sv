// This module grants access to the router_bus_interface for doing coverage of
// the popin
class cobertura extends uvm_subscriber #(sequence_trans_2);
    `uvm_component_utils(cobertura)

    //sequence_trans_2 trans_mnt;
    bit [7:0] tgt;
    bit [3:0] src;

    // Covergroup for checking that every device has been a src
    covergroup check_mnt;
        //coverpoint trans_mnt.dato_pkg.src;
        coverpoint src;
        coverpoint tgt {
        //coverpoint trans_mnt.dato_pkg.target {
            bins values [] = {8'h01, 8'h02, 8'h03, 8'h04, 8'h10, 8'h20, 8'h30, 8'h40, 8'h51, 8'h52, 8'h53, 8'h54, 8'h15, 8'h25, 8'h35, 8'h45};
        }
    endgroup

    // Explicit class constructor
    function new(string name = "cobertura", uvm_component parent = null);
        super.new(name, parent);
        check_mnt = new();
    endfunction

    // Write function, it is called every time the analysis port is used
    virtual function void write(sequence_trans_2 trans_mnt);
        `uvm_info("COV", $sformatf("Transaction received sampling..."), UVM_HIGH)

        src = trans_mnt.dato_pkg.src;
        tgt = trans_mnt.dato_pkg.target;

        check_mnt.sample();
    endfunction
endclass
