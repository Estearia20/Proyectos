class agent extends uvm_agent;
    `uvm_component_utils(agent)
    function new(string name = "agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    driver  drv[16]; // Driver handler
    monitor mnt[16]; // Monitor handler
    uvm_sequencer #(sequence_trans) seq[16]; //Sequencer handler

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        // Create multiple sequencers
        foreach(seq[i]) begin
            seq[i] = uvm_sequencer#(sequence_trans)::type_id::create($sformatf("seq[%0d]", i), this);
        end

        // Create multiple drivers
        foreach(drv[i]) begin
            //drv[i] = driver::type_id::create($sformatf("drv[%0d]", i), this, i);
            drv[i] = driver::type_id::create($sformatf("drv[%0d]", i), this);
            drv[i].terminal = i;
        end

        // Create multiple monitors
        foreach(mnt[i]) begin
            mnt[i] = monitor::type_id::create($sformatf("mnt[%0d]", i), this);
            mnt[i].terminal = i;
        end

    endfunction    

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // Connect each driver with the sequencer item_port
        foreach(drv[i]) begin
            drv[i].seq_item_port.connect(seq[i].seq_item_export);
        end
    endfunction
endclass
