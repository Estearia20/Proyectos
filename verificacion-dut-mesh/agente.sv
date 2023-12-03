// This class is to do the work of the agent, its work is focused on a
// activating the signals necessary for the operation of the FIFO in of the driver
class agente #(parameter pckg_sz   = 25,
               parameter fifo_dpth = 8);

    int terminal;

    // Instances of the mailbox required
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_gen_agt;     // Generator -> Agent
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_agt_drv[16]; // Agent -> Driver
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_agt_scb;     // Agent -> Scoreboard
    

    // Packages instances
    // this pkg contains all the transaction info
    pkg_trans #(.pckg_sz(pckg_sz)) transaction;

    // Virtual interface, this is used for connecting with DUT
    virtual if_dut #(.pckg_sz(pckg_sz)) vif;

    // Print function
    function void print;
        $write("[%g] El agente envia al driver: ", $time);
        transaction.print();
    endfunction

    // Gets pkg from generator, and generates the required signals, such as
    // push for the terminal that is going to be used

    task run();
        `ifdef DEBUG_BUILD
            $display("[%g] El agente se inicia", $time);
        `endif
        @(posedge vif.clk);
        // Read from the generator and generate the necessary signals for the driver to operate and send the transaction to the scoreboard
        // works correctly: reads data and activates push signal
        forever begin
            transaction = new ();
            `ifdef DEBUG_AGT
                $display("[%g] El agente espera por una instruccion del generador", $time);
            `endif
            // Reads mbx from generator
            mbx_gen_agt.get(transaction);
            `ifdef DEBUG_AGT
                $write("[%g] El agente recibe del generador: ", $time);
                transaction.print();
            `endif

            // Case statement for the type of transaction required
            if (transaction.tipo == reset_type) begin
                transaction.push[transaction.dato_pkg.src] = 0;
                `ifdef DEBUG_AGT
                    this.print();
                `endif
                // Send transaction to driver
                mbx_agt_drv[transaction.dato_pkg.src].put(transaction);
                //Send transaction to scoreboard
                mbx_agt_scb.put(transaction);
            end

            else begin
                if({transaction.dato_pkg.target.row, transaction.dato_pkg.target.col} inside {8'h10,8'h15,8'h25,8'h30,8'h35,8'h40,8'h45,8'h51,8'h52,8'h53,8'h54,8'h01,8'h02,8'h03,8'h04,8'h20}) begin
                    transaction.push[transaction.dato_pkg.src]= 1;
                    `ifdef DEBUG_AGT
                        this.print();
                    `endif
                    // Send transaction to driver
                    mbx_agt_drv[transaction.dato_pkg.src].put(transaction);
                    //Send transaction to scoreboard
                    mbx_agt_scb.put(transaction);
                end
                else begin
                    $fatal("[FAIL] Target no se encuentra dentro del rango valido");
                end
            end
        end
    endtask
endclass
