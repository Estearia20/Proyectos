// Class for modeling the checker
class checker #(parameter pckg_sz   = 25,
                parameter fifo_dpth = 8);

    // Associative array for storing things from scoreboard
    int historial[logic [pckg_sz-1:0]];
    bit [7:0] chk_try[logic [pckg_sz-1:0]];

    // For the path
  	bit [7:0] byte_value;
    bit [7:0] path_array[logic [pckg_sz-1:0]];
  	bit [55:0] path_hist[logic [pckg_sz-1:0]];
    bit [7:0] path_tmp[$], path_tmp_2[$], path_tmp_3[$], path_tmp_3_dato[$];
    bit [7:0] rowcol, rowcol_2;
    bit [7:0] tray_chk;
    bit [7:0] path_chk;
  	bit [55:0] path_conca;
 	bit [55:0] path_conca_tmp;
    int 	  cont, cont_aux;

    // Creates packages
    pkg_trans #(.pckg_sz(pckg_sz))  scb_chk_transaction;
    pkg_trans_2 #(.pckg_sz(pckg_sz)) mnt_chk_transaction;
    pkg_chk_scb #(.pckg_sz(pckg_sz)) chk_scb_transaction;

    // Mailboxes
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_scb_chk;   		  // Scoreboard -> Checker
    trans_mbx_chk_scb #(.pckg_sz(pckg_sz)) mbx_chk_scb;   // Checker -> Scoreboard
    trans_2_mbx #(.pckg_sz(pckg_sz)) mbx_mnt_chk; 		  // Monitor -> Checker


    // Print function
    function print_mnt();
        $write("[%g] El checker recibe del monitor [%2d] esta instruccion: ", $time, mnt_chk_transaction.dato_pkg.src );
        mnt_chk_transaction.print();
    endfunction

    function void print_chk_try();
        foreach (chk_try[key]) begin
            $display("Clave: %h, Valor: %h", key, chk_try[key]);
        end
  endfunction

    // Task for executing the module behavior
    task run();
        `ifdef DEBUG_BUILD
            $display("[%g] El checker se inicia", $time);
        `endif
        #10;
        forever begin
          // Receives pkg from monitor and passes some data to scoreboard
          if(mbx_mnt_chk.num() > 0) begin
            mbx_mnt_chk.get(mnt_chk_transaction);

            `ifdef DEBUG_CHK
              this.print_mnt();
              $display("[%g] Esperando una instruccion del scoreboard para comparar con lo del monitor", $time);
            `endif

            while(mbx_scb_chk.num() > 0) begin
              scb_chk_transaction = new();
              mbx_scb_chk.get(scb_chk_transaction);

              // Receives pkg from scoreboard
              `ifdef DEBUG_CHK
                $display("El checker recibe del scoreboard la siguiente instruccion y la almacena en una tabla: ");
                scb_chk_transaction.print();
              `endif

              // Stores what was received from scoreboard into a hash table for the tenvio
              historial[{scb_chk_transaction.dato_pkg.target.row, scb_chk_transaction.dato_pkg.target.col, scb_chk_transaction.dato_pkg.payload}] = scb_chk_transaction.t_envio;

              // Stores the path received from scb into a hash table for checking the trayctory in the GR
              path_tmp = scb_chk_transaction.path;

              while(path_tmp.size() > 0) begin
                rowcol = path_tmp.pop_back();
                path_array[{rowcol[7:4], rowcol[3:0], scb_chk_transaction.dato_pkg.payload}] = rowcol; 
              end

              // Stores the hole path received from scb
              path_tmp_3 = scb_chk_transaction.path;
              path_tmp_3.pop_back();
              path_tmp_3.pop_front();
              path_conca = 0;
              for (int i = 0; i < path_tmp_3.size(); i = i + 1) begin
                path_conca = {path_conca, path_tmp_3[i]};
              end

              path_hist[{scb_chk_transaction.dato_pkg.target.row, scb_chk_transaction.dato_pkg.target.col, scb_chk_transaction.dato_pkg.payload}] = path_conca;
            end

            `ifdef DEBUG_CHK
                //Imprime la tabla de Hash
                foreach (path_hist[key]) begin
                    $display("Clave: %h, Valor: %h", key, path_hist[key]);
                end  
 
                //Imprime la tabla de Hash
                foreach (chk_try[key]) begin
                    $display("Clave: %h, Valor: %h", key, chk_try[key]);
                end
                $display("");

                //Imprime la tabla de Hash
                foreach (path_array[key]) begin
                    $display("Clave: %h, Valor: %h", key, path_array[key]);
                end
            `endif

            // Golden reference
            $display("-----------------------");
            $display("Revision de las pruebas");
            $display("-----------------------");
            if(historial.exists({mnt_chk_transaction.dato_pkg.target.row, mnt_chk_transaction.dato_pkg.target.col, mnt_chk_transaction.dato_pkg.payload})) begin

              path_conca_tmp = path_hist[{mnt_chk_transaction.dato_pkg.target.row, mnt_chk_transaction.dato_pkg.target.col, mnt_chk_transaction.dato_pkg.payload}];

              for (int i = 0; i < $size(path_conca_tmp) / 8; i = i + 1) begin

                // Extraer un byte de 8 bits de path_conca_tmp
                byte_value = path_conca_tmp[i * 8 +: 8];
                if (byte_value != 'h00) begin
                  path_tmp_2.push_front(byte_value);
                end
              end

                // Stores the number of elements on queue
                cont = path_tmp_2.size();
                cont_aux = 0;


                while(path_tmp_2.size() > 0) begin
                    rowcol_2 = path_tmp_2.pop_back();
                    tray_chk = chk_try[{rowcol_2[7:4], rowcol_2[3:0], mnt_chk_transaction.dato_pkg.payload}];
                    path_chk = path_array[{rowcol_2[7:4], rowcol_2[3:0], mnt_chk_transaction.dato_pkg.payload}];

                    if(tray_chk == path_chk) begin
                        cont_aux++;
                    end
                end

                // Condition if the element has taken the same trayectory
                if(cont_aux == cont) begin
                    $display("[%g] Transaccion y trayectoria correcta", $time);
                    $display("[%g] El dato [%h] ha sido almacenado en el scoreboard", $time, mnt_chk_transaction.dato_pkg.payload);

                    // Gives to the scoreboard the delay and tells if an
                    // instruction was completed
                    chk_scb_transaction               = new();
                    chk_scb_transaction.completado    = 1;
                    chk_scb_transaction.t_envio       = historial[{mnt_chk_transaction.dato_pkg.target.row, mnt_chk_transaction.dato_pkg.target.col, mnt_chk_transaction.dato_pkg.payload}];
                    chk_scb_transaction.t_recibo      = mnt_chk_transaction.t_recibo;

                    // Calculates latency and bandwidth
                    chk_scb_transaction.calc_latencia;
                    chk_scb_transaction.calc_bw(pckg_sz);

                    // Gives some more data to the pkg
                    chk_scb_transaction.data          = mnt_chk_transaction.dato_pkg.payload;
                    chk_scb_transaction.row_id        = mnt_chk_transaction.dato_pkg.target.row;
                    chk_scb_transaction.col_id        = mnt_chk_transaction.dato_pkg.target.col;
                    chk_scb_transaction.src     	  = mnt_chk_transaction.dato_pkg.src;

                    // Sends the pkg to the scoreboard
                    mbx_chk_scb.put(chk_scb_transaction);
                end

                // Condition in case the pkg has taken a diff trayectory
                else begin
                    $display("[%g] Trayectoria incorrecta", $time);
                    $display("[%g] El dato [%h] ha tomado una trayectoria incorrecta", $time, mnt_chk_transaction.dato_pkg.payload);
                end
              end

              // Condition in case the pkg was not even stored in the scoreboard, ie, does not exists, or was changed
              else begin
                $display("[%g] Transaccion incorrecta", $time);
                $display("[%g] El dato [%h] no ha sido almacenado en el scoreboard", $time, mnt_chk_transaction.dato_pkg.payload);
              end
            end
            #10;
        end
    endtask

  task dut_signals();
      forever begin
          // ROUTER 11 all terminals
          if (tb.dut._rw_[1]._clm_[1].rtr._nu_[0].rtr_ntrfs_.popin) begin
              chk_try[{4'h1,4'h1,tb.dut._rw_[1]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h11;
          end

          if (tb.dut._rw_[1]._clm_[1].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h1,tb.dut._rw_[1]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h11;
          end

          if (tb.dut._rw_[1]._clm_[1].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h1,tb.dut._rw_[1]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h11;
          end

          if (tb.dut._rw_[1]._clm_[1].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h1,tb.dut._rw_[1]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h11;
          end

          // ROUTER 12 all terminals
          if (tb.dut._rw_[1]._clm_[2].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h2,tb.dut._rw_[1]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h12;
          end

          if (tb.dut._rw_[1]._clm_[2].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h2,tb.dut._rw_[1]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h12;
          end

          if (tb.dut._rw_[1]._clm_[2].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h2,tb.dut._rw_[1]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h12;
          end

          if (tb.dut._rw_[1]._clm_[2].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h2,tb.dut._rw_[1]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h12;
          end

          // ROUTER 13 all terminals
          if (tb.dut._rw_[1]._clm_[3].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h3,tb.dut._rw_[1]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h13;
          end

          if (tb.dut._rw_[1]._clm_[3].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h3,tb.dut._rw_[1]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h13;
          end

          if (tb.dut._rw_[1]._clm_[3].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h3,tb.dut._rw_[1]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h13;
          end

          if (tb.dut._rw_[1]._clm_[3].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h3,tb.dut._rw_[1]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h13;
          end

          // ROUTER 14 all terminals
          if (tb.dut._rw_[1]._clm_[4].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h4,tb.dut._rw_[1]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h14;
          end

          if (tb.dut._rw_[1]._clm_[4].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h4,tb.dut._rw_[1]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h14;
          end

          if (tb.dut._rw_[1]._clm_[4].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h4,tb.dut._rw_[1]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h14;
          end

          if (tb.dut._rw_[1]._clm_[4].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h1,4'h4,tb.dut._rw_[1]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h14;
          end

          // ROUTER 21 all terminals
          if (tb.dut._rw_[2]._clm_[1].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h1,tb.dut._rw_[2]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h21;
          end

          if (tb.dut._rw_[2]._clm_[1].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h1,tb.dut._rw_[2]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h21;
          end

          if (tb.dut._rw_[2]._clm_[1].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h1,tb.dut._rw_[2]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h21;
          end

          if (tb.dut._rw_[2]._clm_[1].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h1,tb.dut._rw_[2]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h21;
          end

          // ROUTER 22 all terminals
          if (tb.dut._rw_[2]._clm_[2].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h2,tb.dut._rw_[2]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h22;
          end

          if (tb.dut._rw_[2]._clm_[2].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h2,tb.dut._rw_[2]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h22;
          end

          if (tb.dut._rw_[2]._clm_[2].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h2,tb.dut._rw_[2]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h22;
          end

          if (tb.dut._rw_[2]._clm_[2].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h2,tb.dut._rw_[2]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h22;
          end

          // ROUTER 23 all terminals
          if (tb.dut._rw_[2]._clm_[3].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h3,tb.dut._rw_[2]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h23;
          end

          if (tb.dut._rw_[2]._clm_[3].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h3,tb.dut._rw_[2]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h23;
          end

          if (tb.dut._rw_[2]._clm_[3].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h3,tb.dut._rw_[2]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h23;
          end

          if (tb.dut._rw_[2]._clm_[3].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h3,tb.dut._rw_[2]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h23;
          end

          // ROUTER 24 all terminals
          if (tb.dut._rw_[2]._clm_[4].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h4,tb.dut._rw_[2]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h24;
          end

          if (tb.dut._rw_[2]._clm_[4].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h4,tb.dut._rw_[2]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h24;
          end

          if (tb.dut._rw_[2]._clm_[4].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h4,tb.dut._rw_[2]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h24;
          end

          if (tb.dut._rw_[2]._clm_[4].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h2,4'h4,tb.dut._rw_[2]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h24;
          end

          // ROUTER 31 all terminals
          if (tb.dut._rw_[3]._clm_[1].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h1,tb.dut._rw_[3]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h31;
          end

          if (tb.dut._rw_[3]._clm_[1].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h1,tb.dut._rw_[3]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h31;
          end

          if (tb.dut._rw_[3]._clm_[1].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h1,tb.dut._rw_[3]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h31;
          end

          if (tb.dut._rw_[3]._clm_[1].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h1,tb.dut._rw_[3]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h31;
          end

          // ROUTER 32 all terminals
          if (tb.dut._rw_[3]._clm_[2].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h2,tb.dut._rw_[3]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h32;
          end

          if (tb.dut._rw_[3]._clm_[2].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h2,tb.dut._rw_[3]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h32;
          end

          if (tb.dut._rw_[3]._clm_[2].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h2,tb.dut._rw_[3]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h32;
          end

          if (tb.dut._rw_[3]._clm_[2].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h2,tb.dut._rw_[3]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h32;
          end

          // ROUTER 33 all terminals
          if (tb.dut._rw_[3]._clm_[3].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h3,tb.dut._rw_[3]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h33;
          end

          if (tb.dut._rw_[3]._clm_[3].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h3,tb.dut._rw_[3]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h33;
          end

          if (tb.dut._rw_[3]._clm_[3].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h3,tb.dut._rw_[3]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h33;
          end

          if (tb.dut._rw_[3]._clm_[3].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h3,tb.dut._rw_[3]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h33;
          end


          // ROUTER 34 all terminals
          if (tb.dut._rw_[3]._clm_[4].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h4,tb.dut._rw_[3]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h34;
          end

          if (tb.dut._rw_[3]._clm_[4].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h4,tb.dut._rw_[3]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h34;
          end

          if (tb.dut._rw_[3]._clm_[4].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h4,tb.dut._rw_[3]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h34;
          end

          if (tb.dut._rw_[3]._clm_[4].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h3,4'h4,tb.dut._rw_[3]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h34;
          end

          // ROUTER 41 all terminals
          if (tb.dut._rw_[4]._clm_[1].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h1,tb.dut._rw_[4]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h41;
          end

          if (tb.dut._rw_[4]._clm_[1].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h1,tb.dut._rw_[4]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h41;
          end

          if (tb.dut._rw_[4]._clm_[1].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h1,tb.dut._rw_[4]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h41;
          end

          if (tb.dut._rw_[4]._clm_[1].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h1,tb.dut._rw_[4]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h41;
          end

          // ROUTER 42 all terminals
          if (tb.dut._rw_[4]._clm_[2].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h2,tb.dut._rw_[4]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h42;
          end

          if (tb.dut._rw_[4]._clm_[2].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h2,tb.dut._rw_[4]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h42;
          end

          if (tb.dut._rw_[4]._clm_[2].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h2,tb.dut._rw_[4]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h42;
          end

          if (tb.dut._rw_[4]._clm_[2].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h2,tb.dut._rw_[4]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h42;
          end

          // ROUTER 43 all terminals
          if (tb.dut._rw_[4]._clm_[3].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h3,tb.dut._rw_[4]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h43;
          end

          if (tb.dut._rw_[4]._clm_[3].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h3,tb.dut._rw_[4]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h43;
          end

          if (tb.dut._rw_[4]._clm_[3].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h3,tb.dut._rw_[4]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h43;
          end

          if (tb.dut._rw_[4]._clm_[3].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h3,tb.dut._rw_[4]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h43;
          end

          // ROUTER 44 all terminals
          if (tb.dut._rw_[4]._clm_[4].rtr._nu_[0].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h4,tb.dut._rw_[4]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h44;
          end

          if (tb.dut._rw_[4]._clm_[4].rtr._nu_[1].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h4,tb.dut._rw_[4]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h44;
          end

          if (tb.dut._rw_[4]._clm_[4].rtr._nu_[2].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h4,tb.dut._rw_[4]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h44;
          end

          if (tb.dut._rw_[4]._clm_[4].rtr._nu_[3].rtr_ntrfs_.popin) begin 
              chk_try[{4'h4,4'h4,tb.dut._rw_[4]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out_i_in[pckg_sz-22:0]}] = 8'h44;
          end
          #1;
      end
  endtask
endclass
