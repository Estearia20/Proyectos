// Class for modelling the monitor
class monitor #(parameter drvrs     = 4,
                parameter pkg_sz    = 16,
                parameter fifo_dpth = 8,
		        parameter broadcast = {8{1'b1}});
    
    // Number of terminals 
    int terminal;

    // Required Mailboxes 
    trans_mbx_drv_mnt mbx_drv_mnt_array[drvrs]; // Driver -> Monitor
    trans_mbx_mnt_chk #(.drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_mnt_chk;

    // Creates packages
    pkg_drv_mnt drv_mnt_transaction;
    pkg_mnt_chk #(.drvrs(drvrs), .pkg_sz(pkg_sz)) mnt_chk_transaction;

    // Interface instance
    virtual if_dut #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast)) bus_if;

    // Queue for modelling FIFO OUT
    int fifo_out[$:fifo_dpth];

    // Print function
    function print_drv;
        $write("[%g] El monitor [%2d] recibe del driver [%2d]: ", $time, this.terminal, drv_mnt_transaction.fuente);
        drv_mnt_transaction.print();
    endfunction

    // Print function
    function print_dut;
        $write("[%g] El monitor [%2d] recibe del DUT el dato: ", $time, this.terminal);
        $display("%h",bus_if.d_out[0][this.terminal]);
    endfunction

    // Task for executing the module behavior
    task run();
        $display("[%g] El monitor [%2d] se inicializa", $time, this.terminal);
        @(posedge bus_if.clk);
        forever begin
            // Read mbx from drv
            mbx_drv_mnt_array[this.terminal].get(drv_mnt_transaction);
            this.print_drv();
	   
            // Waits for push to change to take instruction from DUT
            @(negedge bus_if.push[0][this.terminal]); 

            // Checks if the DUT has some data to pass
            // If it has then stores in the queue
            fifo_out.push_back(bus_if.d_out[0][this.terminal]);
            this.print_dut();

            // If elements in fifo_out pass them to checker
            if (fifo_out.size() > 0) begin
                mnt_chk_transaction = new();
                mnt_chk_transaction.dato_out[this.terminal] = fifo_out.pop_front();
                mnt_chk_transaction.id_source = drv_mnt_transaction.id_source;
                mnt_chk_transaction.t_envio   = drv_mnt_transaction.t_envio;
                mnt_chk_transaction.t_recibo  = $time;
                mnt_chk_transaction.latencia  = mnt_chk_transaction.calc_latencia();
                mnt_chk_transaction.tipo      = drv_mnt_transaction.tipo;
                mbx_mnt_chk.put(mnt_chk_transaction);
                $write("[%g] El monitor [%2d] envia transaccion al checker: ", $time, this.terminal);
                mnt_chk_transaction.print();
            end
            @(posedge bus_if.clk);
        end
    endtask
endclass

