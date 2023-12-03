class driver #(parameter fifo_dpth = `FF_DPTH) extends uvm_driver #(sequence_trans);
    `uvm_component_utils(driver)

    // Fifo depth parameter for the fifo in depth
    int terminal;
    int espera;
    int fifo_in[$:fifo_dpth];

    // Explicit driver constructor
    //function new(string name = "driver", uvm_component parent = null, int index = -1);
    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
        terminal = terminal;
    endfunction

    // Declare virtual interface
    //virtual if_dut #(.pckg_sz(pckg_sz)) vif;
    virtual if_dut vif;

    // Analysis port that goes to the scoreboard
    uvm_analysis_port #(sequence_trans) drv_analysis_port;

    // Build phase, checks wheter the interface was stored on the db or not
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual if_dut)::get(this, "", "if_dut", vif))
            `uvm_fatal("DRV", "Could not get vif")
        //if (!uvm_config_db #(int)::get(this, "", "FF_DPTH", FF_DPTH))
            //`uvm_fatal("DRV", "Could not get FF_DPTH parameter")
        drv_analysis_port = new("drv_analysis_port", this);
    endfunction

    // Run phase, gets items from sequencer and manages them throught
    // drive_item() task
    virtual task run_phase(uvm_phase phase);
        `uvm_info("DRV", $sformatf("[%0d] se crea", terminal), UVM_HIGH)
        super.run_phase(phase);

        // Calls the drive_item task for collectiong information about the
        // fifo in and drive signals with the DUT
        fork
            drive_item();
        join_none

        forever begin
            sequence_trans trans;
            `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_HIGH)
            seq_item_port.get_next_item(trans);

            // If the trans type is reset, then do a reset at DUT
            if(trans.tipo == reset_type) begin
                vif.reset = 1;
                @(posedge vif.clk);
                @(posedge vif.clk);
                vif.reset = 0;
            end else begin // Whenever the instruction that comes is not reset type
                // Waits for retardo to be done
                espera = 0;
                while(espera < trans.retardo) begin
                    @(posedge vif.clk);
                    espera = espera + 1;
                end

                // puts data at fifo in, and records send time
                trans.t_envio = $time;
                fifo_in.push_back(trans.dato_pkg);
            end

            // tells the sequencer that the item is already done, and can
            // continue with new data
            drv_analysis_port.write(trans);
            seq_item_port.item_done();
        end
    endtask

    // Drives signals with the DUT
    virtual task drive_item();
        //vif.data_out_i_in[this.terminal] = 0;
        forever begin
            vif.pndng_i_in[this.terminal] = 0;
            // if no elements in fifo_in then everything should be zero
            if(fifo_in.size == 0) begin
                vif.pndng_i_in[this.terminal] = 0;
                `ASSERT_DRV_PNDG_IN_ZERO(vif);
                vif.data_out_i_in[this.terminal] = 0;
            end else begin // if elements in fifo_in then pending should be set to 1 and fifo_in must pop its first value
                vif.pndng_i_in[this.terminal] = 1;
                `ASSERT_DRV_PNDG_IN(vif);
                vif.data_out_i_in[this.terminal] = fifo_in.pop_front();
                `ASSERT_DRV_DATA_IN(vif);
                // Waits for popin to continue
                @(negedge vif.popin[this.terminal]);
            end
            @(posedge vif.clk);
        end
    endtask
endclass