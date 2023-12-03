class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    int terminal;

    // Explicit monitor constructor
    function new(string name = "monitor", uvm_component parent = null);
        super.new(name, parent);
        terminal = terminal;
    endfunction

    // Delcare virtual interface
    virtual if_dut vif;

    // Analysis port that goes to the scoreboard
    uvm_analysis_port #(sequence_trans_2) mon_analysis_port;

    // Build phase, checks wheter the interface was stored on the db or not,
    // and creates the analysis port
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual if_dut)::get(this, "", "if_dut", vif))
            `uvm_fatal("MNT", "Could not get vif")
        mon_analysis_port = new("mon_analysis_port", this);
    endfunction

    // Manage DUT signals, to properly get the values at the monitor
    virtual task run_phase(uvm_phase phase);
        `uvm_info("MNT", $sformatf("[%0d] se crea", terminal), UVM_HIGH)
        super.run_phase(phase);
        forever begin
            // Creates the transaction
            sequence_trans_2 trans = sequence_trans_2::type_id::create("trans");
            
            // Waits for pndng to happen, once it occurs, set pop to 1, and
            // after 1 clk cicle set it to 0
            @(posedge vif.pndng[this.terminal]);
            vif.pop[this.terminal] = 1;
            `ASSERT_MNT_POP_ONE(vif);
            @(posedge vif.clk);
            vif.pop[this.terminal] = 0;
            `ASSERT_MNT_POP_ZERO(vif);
            // Register receiving time, and get the data
            trans.t_recibo = $time;
            trans.dato_pkg = vif.data_out[this.terminal];

            // Send info to throught the analysis port
            mon_analysis_port.write(trans);
        end
    endtask
endclass
