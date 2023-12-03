`include "fifo.sv"  //Fifo module definition

// Class for modelling the driver
class driver #(parameter bits      = 1,
               parameter drvrs     = 4,
               parameter pkg_sz    = 16,
               parameter fifo_dpth = 8,
               parameter broadcast = {8{1'b1}});

    // Ownership declaration
    int espera;
    int terminal;

    // Mailbox instances
    trans_mbx_agt_drv #(.bits(bits), .drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_agt_drv;
    trans_mbx_drv_mnt mbx_drv_mnt_array[drvrs]; // Driver -> Monitor
    
    // Packages definition
	pkg_agt_drv #(.bits(bits), .drvrs(drvrs), .pkg_sz(pkg_sz)) transaction_agt_drv;
    pkg_drv_mnt transaction_drv_mnt;

    //Interface to connect driver-dut
    virtual if_dut #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast)) vif;

    // FIFO IN
    int fifo_in[$:fifo_dpth];

    // Print function
    function print_agt();
        $write("[%g] El driver [%2d] recibe del agente: ", $time, this.terminal);
	    transaction_agt_drv.print();
    endfunction

    // Print function
    function print_drv();
        $write("[%g] El driver [%2d] envia al monitor [%2d]: ", $time, this.terminal, transaction_drv_mnt.id_source);
        transaction_drv_mnt.print();
    endfunction

    //Task for executing the driver module
    task run();
        $display("[%g] El driver  [%2d] se inicializa", $time, this.terminal);
        @(posedge vif.clk);
        forever begin
            // Package initialization
            transaction_drv_mnt = new;
            espera = 0;
            // Waiting for item, once received from mbx_agt_drv notifies it
            $display("[%g] El driver [%2d]  está esperando por un item ...", $time, this.terminal);
            @(negedge vif.clk);
            mbx_agt_drv.get(transaction_agt_drv); // Reads agent transaction
            this.print_agt();
	        vif.pndng[0][transaction_agt_drv.data[7:0]] = 0;
            @(negedge vif.clk);

	        // Gives id to mbx_drv_mnt
	        transaction_drv_mnt.id_source = transaction_agt_drv.id_ident;

            // In case of any delay driver will wait
            $display("[%g] Esperando retardo de %2d ciclos de reloj", $time, transaction_agt_drv.retardo);
            while(espera < transaction_agt_drv.retardo)begin
                @(posedge vif.clk);
                espera = espera + 1;
	        end
            $display("[%g] Retardo de %2d ciclos de reloj ha terminado", $time, transaction_agt_drv.retardo);

	        // Depending on transaction it will do something with the signals
            // for the DUT
            if ((transaction_agt_drv.tipo == envio_aleatorio)  ||
                (transaction_agt_drv.tipo == envio_especifico) ||
                (transaction_agt_drv.tipo == envio_spcf_rand)  ||
                (transaction_agt_drv.tipo == broadcast_type)) begin

                // Pushes something into the queue 
                if (transaction_agt_drv.push[0][transaction_agt_drv.data[7:0]]) begin
                    fifo_in.push_back({transaction_agt_drv.id_ident, transaction_agt_drv.data});
                    transaction_drv_mnt.t_envio = $time;
                    vif.d_in[0][transaction_agt_drv.data[7:0]] = fifo_in.pop_front();
                    /* transaction_drv_mnt.t_envio = $time; */
                    vif.pndng[0][transaction_agt_drv.data[7:0]] = 1; // Puts pndng signal in 1
                end

                // Once the data is processed then do a pop to remove it from
                // queue
                @(negedge vif.pop[0][transaction_agt_drv.data[7:0]]);

                if (fifo_in.size() > 0) begin // If queue empty then set pndng to 0
                    vif.pndng[0][transaction_agt_drv.data[7:0]] = 0;
                end

                // Sends transaction driver - monitor
		        transaction_drv_mnt.tipo   = transaction_agt_drv.tipo;
		        transaction_drv_mnt.fuente = transaction_agt_drv.data[7:0];
                if (transaction_agt_drv.tipo == broadcast_type) begin
                    for (int i = 0; i < drvrs; i++) begin
		    	        if (transaction_agt_drv.data[7:0] != i) begin
                    	    transaction_drv_mnt = new;
                    	    transaction_drv_mnt.id_source = i;
                    	    mbx_drv_mnt_array[i].put(transaction_drv_mnt);
                    	    this.print_drv();
			            end
                    end
                end

                else begin
                    mbx_drv_mnt_array[transaction_agt_drv.id_ident].put(transaction_drv_mnt);
                    this.print_drv();
                end

            end
            // If transaction is a reset
            else begin
                vif.rst = 1;
                #10;
                vif.rst = 0;
            end
        end
    endtask
endclass
