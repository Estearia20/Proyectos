// Class for modeling the checker
class checker #(parameter drvrs     = 4,
                parameter pkg_sz    = 16,
                parameter broadcast = {8{1'b1}});

    // Associative array for storing things from scoreboard
    logic [pkg_sz-1:0] historial[logic [pkg_sz-1:0]];
    
    // Creates packages
    pkg_agt_chk agt_chk_transaction;
    pkg_chk_scb #(.pkg_sz(pkg_sz)) chk_scb_transaction;
    pkg_mnt_chk #(.drvrs(drvrs), .pkg_sz(pkg_sz)) mnt_chk_transaction;
    pkg_scb_chk #(.pkg_sz(pkg_sz)) scb_chk_transaction;

    // Mailboxes
    trans_mbx_mnt_chk #(.drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_mnt_chk;
    trans_mbx_scb_chk #(.pkg_sz(pkg_sz)) mbx_scb_chk;
    trans_mbx_chk_scb #(.pkg_sz(pkg_sz)) mbx_chk_scb;
    trans_mbx_agt_chk mbx_agt_chk;

    // Print function
    function print_mnt();
        $write("[%g] El checker recibe del monitor [%2d] esta instruccion: ", $time, mnt_chk_transaction.id_source);
        mnt_chk_transaction.print();
    endfunction

    // For printing the latency
    function print_delay();
        $write("[%g] La latencia corresponde a: ", $time);
        mnt_chk_transaction.calc_latencia();
        mnt_chk_transaction.show_latencia();
    endfunction
    
    //For printing bandwidth
    function print_bw();
        $write("[%g] El ancho de banda corresponde a: ", $time);
        mnt_chk_transaction.calc_bw(pkg_sz);
        mnt_chk_transaction.show_bw();
    endfunction

    // Task for executing the module behavior
    task run();
        $display("[%g] El checker se inicializa", $time);
        #10;
        forever begin
            // Receives some data from agent
            if(mbx_agt_chk.num() > 0) begin
                mbx_agt_chk.get(agt_chk_transaction);
                agt_chk_transaction.print();
            end
            // Initialize package scb-chk
            scb_chk_transaction = new();

            // Receives pkg from monitor and passes some data to scoreboard
            if(mbx_mnt_chk.num() > 0) begin
                mbx_mnt_chk.get(mnt_chk_transaction);
                this.print_mnt();
                print_delay();
                print_bw();
                // Gives to the scoreboard the delay and tells if an
                // instruction was completed
                chk_scb_transaction             = new();
                chk_scb_transaction.latencia    = mnt_chk_transaction.latencia; 
                chk_scb_transaction.bw          = mnt_chk_transaction.bw;
                chk_scb_transaction.completado  = 1;
                chk_scb_transaction.t_envio     = mnt_chk_transaction.t_envio;
                chk_scb_transaction.t_recibo    = mnt_chk_transaction.t_recibo;
                chk_scb_transaction.data        = mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:8];
                chk_scb_transaction.id_dest     = mnt_chk_transaction.id_source;
                chk_scb_transaction.id_source   = mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][7:0];
                mbx_chk_scb.put(chk_scb_transaction);

                $display("[%g] Esperando una instruccion del scoreboard para comparar con lo del monitor", $time);
                while(mbx_scb_chk.num() > 0) begin
                    mbx_scb_chk.get(scb_chk_transaction);

                    // Receives pkg from scoreboard
                    scb_chk_transaction.print("El checker recibe del scoreboard la siguiente instruccion y la almacena en una tabla: ");

                    // Stores what was received from scoreboard into a hash table
                    historial[scb_chk_transaction.data] = {scb_chk_transaction.id_ident, scb_chk_transaction.data};
                end

                // Golden reference
                case(mnt_chk_transaction.tipo)
                    0: begin // envio_aleatorio
                        if(historial.exists(mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0])) begin
                            $display("[%g] Transaccion correcta", $time);
                            $display("[%g] Almacenado en scoreboard: %h", $time, historial[mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0]]); 
                            $display("[%g] Recibido del monitor: %h", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                        else begin
                            $display("[%g] Transaccion incorrecta", $time);
                            $display("[%g] El dato [%h] no ha sido almacenado en el scoreboard", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                    end

                    1: begin // envio_especifico
                        if(historial.exists(mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0])) begin
                            $display("[%g] Transaccion correcta", $time);
                            $display("[%g] Almacenado en scoreboard: %h", $time, historial[mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0]]);
                            $display("[%g] Recibido del monitor: %h", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                        else begin
                            $display("[%g] Transaccion incorrecta", $time);
                            $display("[%g] El dato [%h] no ha sido almacenado en el scoreboard", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                    end

                    2: begin // broadcast
                        if(historial.exists(mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0])) begin
                            $display("[%g] Transaccion correcta", $time);
                            $display("[%g] Almacenado en scoreboard: %h", $time, historial[mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0]]);
                            $display("[%g] Recibido del monitor: %h", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                        else begin
                            $display("[%g] Transaccion incorrecta", $time);
                            $display("[%g] El dato [%h] no ha sido almacenado en el scoreboard", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                    end

                    3: begin // reset
                        if(historial.exists(mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source])) begin
                            $display("[%g] Transaccion incorrecta la instruccion es de tipo reset por lo que no debio haber llegado", $time);
                            $display("[%g] Almacenado en scoreboard: %h", $time, historial[mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]]);
                            $display("[%g] Recibido del monitor: %g", $time, mnt_chk_transaction.print_chk());
                        end
                        else begin
                            $display("[%g] Transaccion correcta era un reset", $time);
                        end
                    end

                    4: begin // envio especifico pero con dato aleatorio
                         if(historial.exists(mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0])) begin
                            $display("[%g] Transaccion correcta", $time);
                            $display("[%g] Almacenado en scoreboard: %h", $time, historial[mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source][pkg_sz-9:0]]);
                            $display("[%g] Recibido del monitor: %h", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                        else begin
                            $display("[%g] Transaccion incorrecta", $time);
                            $display("[%g] El dato [%h] no ha sido almacenado en el scoreboard", $time, mnt_chk_transaction.dato_out[mnt_chk_transaction.id_source]);
                        end
                    end
                endcase
            end
            #10;
        end
    endtask
endclass
