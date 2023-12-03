//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Scoreboard: Este objeto se encarga de llevar un estado del comportamiento de la prueba y es capa de generar reportes //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class scoreboard #(parameter bits      = 1,
                   parameter drvrs     = 4,
                   parameter pkg_sz    = 16,
                   parameter broadcast = {8{1'b1}});

    //Variables declaration
    int  tamano_scb                 = 0;
    int  file;
    int  bw_file;
    int  csv_size                   = 0;
    int  transacciones_completadas  = 0;
    int  conteo;
    int  retardo_total              = 0;
    bit  file_inicializado          = 0;
    real min_bw                     = 1000;
    real max_bw                     = 0;
    real avg_bw                     = 0;
    real tot_bw                     = 0;
    shortreal retardo_promedio;
    event reporte_gen;

    // Mailboxes declaration
    trans_mbx_agt_scb #(.pkg_sz(pkg_sz)) mbx_agt_scb;
    trans_mbx_scb_chk #(.pkg_sz(pkg_sz)) mbx_scb_chk;
    trans_mbx_chk_scb #(.pkg_sz(pkg_sz)) mbx_chk_scb;
    trans_mbx_tst_scb mbx_tst_scb;

    // Packages definition  
    tipo_report orden; 
    pkg_agt_scb #(.pkg_sz(pkg_sz)) transaccion_entrante;
    pkg_agt_scb #(.pkg_sz(pkg_sz)) scoreboard[$]; // Estructura dinámica que maneja el scoreboard  
    pkg_agt_scb #(.pkg_sz(pkg_sz)) auxiliar_array[$]; // Estructura auxiliar usada para explorar el scoreboard;  
    pkg_agt_scb #(.pkg_sz(pkg_sz)) auxiliar_trans;
    pkg_scb_chk #(.pkg_sz(pkg_sz)) scb_chk_transaction;
    pkg_chk_scb #(.pkg_sz(pkg_sz)) chk_scb_transaction;

    // Packages for CSV
    pkg_chk_scb #(.pkg_sz(pkg_sz)) csv[$];
    pkg_chk_scb #(.pkg_sz(pkg_sz)) csv_array[$];
    pkg_chk_scb #(.pkg_sz(pkg_sz)) csv_aux;

    function print_agt();
        transaccion_entrante.print("El scoreboard recibe del agente esta transaccion: ");
    endfunction

    task run;
        $display("[%g] El scoreboard se inicializa", $time);
        forever begin
            #20
            // Reads instruction from agent and pushes it into the scoreboard
            // queue
            while(mbx_agt_scb.num > 0) begin
                mbx_agt_scb.get(transaccion_entrante);
                this.print_agt();
                scoreboard.push_back(transaccion_entrante);

                // The transaction received from the agent - scoreboard is sent to the golden reference of the checker
                scb_chk_transaction = new();
                scb_chk_transaction.data     = transaccion_entrante.data;
                scb_chk_transaction.id_ident = transaccion_entrante.id_ident;
                scb_chk_transaction.tipo     = transaccion_entrante.tipo;
                mbx_scb_chk.put(scb_chk_transaction);
                scb_chk_transaction.print("El scoreboard envia transaccion al checker para usar en el GR");
            end

            // Checks if any completed transaction from checker
            mbx_chk_scb.get(chk_scb_transaction);

            if(chk_scb_transaction.completado) begin
                retardo_total = retardo_total + chk_scb_transaction.latencia;
                tot_bw        = tot_bw + chk_scb_transaction.bw;

                // Conditions for storing the maximum or minimum bandwidth
                if (chk_scb_transaction.bw < min_bw) begin
                    min_bw = chk_scb_transaction.bw;
                end
                if (chk_scb_transaction.bw > max_bw) begin
                    max_bw = chk_scb_transaction.bw;
                end
                transacciones_completadas++;
            end

            chk_scb_transaction.cantidad_transacciones = transacciones_completadas; 
            // Pushes data from chk_scb for generating the csv file
            csv.push_back(chk_scb_transaction);

            if(mbx_tst_scb.num() > 0) begin
                -> reporte_gen;
            end

        end

    endtask
                		
    // Prints the report or the average delay
    task run_rep;
        @reporte_gen;
        if(mbx_tst_scb.num() > 0) begin
        #10000
        mbx_tst_scb.get(orden);
        case(orden)
            retraso_promedio: begin  //average delay
                $display("scoreboard: recibida orden retraso_promedio");
                retardo_promedio = retardo_total/transacciones_completadas;
                avg_bw           = tot_bw/transacciones_completadas;
                $display("[%g] scoreboard: el retardo promedio es: %0.3f s", $time, retardo_promedio);
                $display("[%g] scoreboard: el ancho de banda promedio es: %0.3f Gbps", $time, avg_bw);
                $display("[%g] scoreboard: el ancho de banda minimo es: %0.3f Gbps", $time, min_bw);
                $display("[%g] scoreboard: el ancho de banda maximo es: %0.3f Gbps", $time, max_bw);
            end
            reporte: begin  //report
                $display("scoreboard: recibida orden reporte");
                tamano_scb = scoreboard.size();
                for(int i = 0; i < tamano_scb; i++) begin
                    auxiliar_trans = scoreboard.pop_front;
                    auxiliar_trans.print("SCB_Report:");
                    auxiliar_array.push_back(auxiliar_trans);
                end
                scoreboard = auxiliar_array;

                // For generating the csv file
                $display("scoreboard: escribiendo en archivo csv");
                csv_size = csv.size();
                // Opens the file in write mode
                file = $fopen("Reportes/report.csv", "w");
                // Writes the header of the file
                $fwrite(file, "#,Dato,Fuente,Destino,Latencia(s),AnchoBanda(Gbps),Tiempo envio(s),Tiempo recibido (s)\n");
                for(int i = 0; i < csv_size; i++) begin
                    csv_aux = csv.pop_front();
                    csv_aux.print_rpt();
                    // Writes data into the file
                    $fwrite(file, "%0d,%h,%0d,%0d,%3d,%f,%3d,%3d\n",
                            csv_aux.cantidad_transacciones ,csv_aux.data, csv_aux.id_source,
                            csv_aux.id_dest, csv_aux.latencia,
                            csv_aux.bw, csv_aux.t_envio, csv_aux.t_recibo);
                    csv_array.push_back(csv_aux);
                end
                $fclose(file);
                csv = csv_array;

                bw_file = $fopen("Reportes/bw_report.csv", "r");
		        if (bw_file == 0) begin
		            bw_file = $fopen("Reportes/bw_report.csv", "w");
                    $fwrite(bw_file, "Cantidad drvrs ,Ancho de banda máximo (Gbps), Ancho de banda mínimo (Gbps)\n");
		            $fclose(bw_file);
		        end
		        bw_file = $fopen("Reportes/bw_report.csv", "a");
                $fwrite(bw_file, "%3d,%f,%f\n",
                        drvrs,max_bw, min_bw);
                $fclose(bw_file);
            end
        endcase
        end
    endtask
endclass
