class ambiente extends uvm_env;
    `uvm_component_utils(ambiente)
    
    // Explicit constructor
    function new(string name = "ambiente", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    agent agt; // Create handler for agent
    scoreboard scb; // Create handler for scoreboard
    cobertura cov; // Create hanlder for coverage

    // Creates the elements that are part of the environment
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = agent::type_id::create("agt", this);
        scb = scoreboard::type_id::create("scb", this);
        cov = cobertura::type_id::create("cov", this);
    endfunction
    
    // Connects elements, such as analysis port
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        for(int i = 0; i < 16; i++) begin
            // Connecting analysis ports inside monitor and driver
            agt.mnt[i].mon_analysis_port.connect(scb.m_analysis_imp);
            agt.drv[i].drv_analysis_port.connect(scb.d_analysis_imp);

            // Connecting analysis ports for doing coverage
            agt.mnt[i].mon_analysis_port.connect(cov.analysis_export);
        end
    endfunction
endclass
