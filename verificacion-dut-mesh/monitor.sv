// This class models the monitor, it will read the DUT output and pass it to
// the checker
class monitor #(parameter pckg_sz = 25);
    int terminal;

    // Required mailboxes handlers
  	trans_2_mbx #(.pckg_sz(pckg_sz)) mbx_mnt_chk; //Monitor-Checker
  	trans_mbx_drv_mnt mbx_drv_mnt[16]; //Driver-Monitor


    // Packages handlers
    // this pkg containt the info that will be send to the checker
    pkg_trans_2 #(.pckg_sz(pckg_sz)) transaction;
    drv_mnt transaction_drv_mnt;

    // Virtual interface, this is used for connecting with DUT
    virtual if_dut #(.pckg_sz(pckg_sz)) vif;

    virtual task run();
        `ifdef DEBUG_BUILD
            $display("[%g] El monitor (%2d) se inicia", $time, this.terminal);
        `endif
        @(posedge vif.clk);
        forever begin
            // Waits for the driver to set the pop signal to 1, and when it
            // does, monitor will read the data from DUT and store it at the
            // transaction that goes to checker
            transaction = new();
          	//transaction_drv_mnt = new();
          	//mbx_drv_mnt[this.terminal].get (transaction_drv_mnt);
            `ifdef DEBUG_MNT
                $display("[%g] El monitor (%2d) espera algo del DUT", $time, this.terminal);
            `endif

            @(posedge vif.pndng[this.terminal]);
            vif.pop[this.terminal] = 1;
            `ASSERT_MNT_POP_ONE(vif);
            @(posedge vif.clk);
            vif.pop[this.terminal] = 0;
            `ASSERT_MNT_POP_ZERO(vif);
			transaction.t_recibo = $time;
            `ifdef DEBUG_MNT
                $display("[%g] El monitor (%2d) recibe algo del DUT, ahora esto se envia al checker", $time, this.terminal);
            `endif
            transaction.dato_pkg = vif.data_out[this.terminal];
            `ifdef DEBUG_MNT
                transaction.print();
            `endif

            // Once it has the data now monitor has to send it to checker
            mbx_mnt_chk.put(transaction);
        end
    endtask
endclass
