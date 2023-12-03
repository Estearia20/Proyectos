// This class generates the required signals by the driver, to be able to
// tell which terminal has to send data
class agente #(parameter bits      = 1,
               parameter drvrs     = 4,
               parameter pkg_sz    = 16,
               parameter broadcast = {8{1'b1}});

    // DUT instance
    virtual if_dut #(.pkg_sz(pkg_sz), .drvrs(drvrs), .broadcast(broadcast)) bus_if;

    // Mailboxes declaration
    trans_mbx_gen_agt #(.pkg_sz(pkg_sz)) mbx_gen_agt;
    trans_mbx_agt_drv #(.bits(bits), .drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_agt_drv_array[drvrs]; // Agente -> Driver
    trans_mbx_agt_chk mbx_agt_chk;
    trans_mbx_agt_scb #(.pkg_sz(pkg_sz)) mbx_agt_scb;

    // Packages definition
    pkg_gen_agt #(.pkg_sz(pkg_sz)) transaction_gen_agt;
    pkg_agt_drv #(.bits(bits), .drvrs(drvrs), .pkg_sz(pkg_sz)) transaction_agt_drv;
    pkg_agt_chk transaction_agt_chk;
    pkg_agt_scb #(.pkg_sz(pkg_sz)) transaction_agt_scb;

    // Print function
    function void print;
        $write("[%g] El agente envia al driver: ", $time);
        transaction_agt_drv.print();
    endfunction

    // Gets pkg from generator, and generates the required signals, such as
    // push for the terminal that is going to be used
    task run();
        $display("[%g] El agente se inicializa", $time);
        @(posedge bus_if.clk);
        forever begin
            // Reads mbx from tst
            mbx_gen_agt.get(transaction_gen_agt);
            $write("[%g] El agente recibe del generador: ", $time);
            transaction_gen_agt.print();

            // Passes to the checker the id of the transaction
            transaction_agt_chk = new();
            transaction_agt_chk.id = transaction_gen_agt.id_ident;
            mbx_agt_chk.put(transaction_agt_chk);

            // Case statement for the type of transaction required
            case(transaction_gen_agt.tipo)
                envio_aleatorio: begin // Randomizes everything
                    transaction_agt_drv = new;
                    transaction_agt_drv.id_ident                               = transaction_gen_agt.id_ident;
                    transaction_agt_drv.data                                   = transaction_gen_agt.data;
                    transaction_agt_drv.push[0][transaction_agt_drv.data[7:0]] = 1;
                    transaction_agt_drv.retardo                                = transaction_gen_agt.retardo;
                    transaction_agt_drv.tipo                                   = transaction_gen_agt.tipo;  
                    
                    this.print();
                    mbx_agt_drv_array[transaction_agt_drv.data[7:0]].put(transaction_agt_drv);
                    
                    //Se colocan los paquetes que se le van a enviar al scoreboard
		            transaction_agt_scb = new;
                    transaction_agt_scb.data = transaction_agt_drv.data;
                    transaction_agt_scb.id_ident = transaction_agt_drv.id_ident;
                    transaction_agt_scb.tipo = transaction_agt_drv.tipo; 
                    //Se envia el paquete del agente al scoreboard
                    mbx_agt_scb.put(transaction_agt_scb);  
                end

                envio_especifico: begin // Sets specific data according to test
                    transaction_agt_drv = new;
                    transaction_agt_drv.id_ident                               = transaction_gen_agt.id_ident;
                    transaction_agt_drv.data                                   = transaction_gen_agt.data;
                    transaction_agt_drv.push[0][transaction_agt_drv.data[7:0]] = 1;
                    transaction_agt_drv.retardo                                = transaction_gen_agt.retardo;
                    transaction_agt_drv.tipo                                   = transaction_gen_agt.tipo;  
                    
                    this.print();
                    mbx_agt_drv_array[transaction_agt_drv.data[7:0]].put(transaction_agt_drv);
                
                    //Se colocan los paquetes que se le van a enviar al scoreboard
		            transaction_agt_scb = new;
                    transaction_agt_scb.data = transaction_agt_drv.data;
                    transaction_agt_scb.id_ident = transaction_agt_drv.id_ident;
                    transaction_agt_scb.tipo = transaction_agt_drv.tipo; 
                    //Se envia el paquete del agente al scoreboard
                    mbx_agt_scb.put(transaction_agt_scb);  
                end

                reset: begin // Setups reset
                    transaction_agt_drv = new;
                    transaction_agt_drv.id_ident                               = transaction_gen_agt.id_ident;
                    transaction_agt_drv.data                                   = 0;
                    transaction_agt_drv.push[0][transaction_agt_drv.data[7:0]] = 0;
                    transaction_agt_drv.retardo                                = transaction_gen_agt.retardo;
                    transaction_agt_drv.tipo                                   = transaction_gen_agt.tipo;  
                    
                    this.print();
                    mbx_agt_drv_array[transaction_agt_drv.data[7:0]].put(transaction_agt_drv);
                
                    //Se colocan los paquetes que se le van a enviar al scoreboard
		            transaction_agt_scb = new;
                    transaction_agt_scb.data = transaction_agt_drv.data;
                    transaction_agt_scb.id_ident = transaction_agt_drv.id_ident;
                    transaction_agt_scb.tipo = transaction_agt_drv.tipo; 
                    //Se envia el paquete del agente al scoreboard
                    mbx_agt_scb.put(transaction_agt_scb);  
                end

                broadcast_type: begin // Setups broadcast
                    transaction_agt_drv = new;
                    transaction_agt_drv.id_ident                               = transaction_gen_agt.id_ident;
                    transaction_agt_drv.data                                   = transaction_gen_agt.data;
                    transaction_agt_drv.push[0][transaction_agt_drv.data[7:0]] = 1;
                    transaction_agt_drv.retardo                                = transaction_gen_agt.retardo;
                    transaction_agt_drv.tipo                                   = transaction_gen_agt.tipo;  
                    
                    this.print();
                    mbx_agt_drv_array[transaction_agt_drv.data[7:0]].put(transaction_agt_drv);
                    
                    //Se colocan los paquetes que se le van a enviar al scoreboard
		            transaction_agt_scb = new;
                    transaction_agt_scb.data = transaction_agt_drv.data;
                    transaction_agt_scb.id_ident = transaction_agt_drv.id_ident;
                    transaction_agt_scb.tipo = transaction_agt_drv.tipo; 
                    //Se envia el paquete del agente al scoreboard
                    mbx_agt_scb.put(transaction_agt_scb);  
                end

                envio_spcf_rand: begin // Setups the signals for this type of transaction
                    transaction_agt_drv = new;
                    transaction_agt_drv.id_ident                               = transaction_gen_agt.id_ident;
                    transaction_agt_drv.data                                   = transaction_gen_agt.data;
                    transaction_agt_drv.push[0][transaction_agt_drv.data[7:0]] = 1;
                    transaction_agt_drv.retardo                                = transaction_gen_agt.retardo;
                    transaction_agt_drv.tipo                                   = transaction_gen_agt.tipo;  
                    
                    this.print();
                    mbx_agt_drv_array[transaction_agt_drv.data[7:0]].put(transaction_agt_drv);
                    
                    //Se colocan los paquetes que se le van a enviar al scoreboard
		            transaction_agt_scb = new;
                    transaction_agt_scb.data = transaction_agt_drv.data;
                    transaction_agt_scb.id_ident = transaction_agt_drv.id_ident;
                    transaction_agt_scb.tipo = transaction_agt_drv.tipo; 
                    //Se envia el paquete del agente al scoreboard
                    mbx_agt_scb.put(transaction_agt_scb);  
                end

                default: $display("No se recibe un tipo de transaccion valida");
            endcase
        end
    endtask
endclass
