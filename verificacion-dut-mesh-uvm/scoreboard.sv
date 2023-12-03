// Allows the scoreboard to have multiple analysis ports, each with
// a different write function
`uvm_analysis_imp_decl(_DRV)
`uvm_analysis_imp_decl(_MNT)
class scoreboard #(parameter pckg_sz = `PCKG_SZ, parameter fifo_dpth = `FF_DPTH) extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
    //Variables declaration
    string filename                 = "report.csv";
    string filename_bw              = "report_bw.csv";
    int file_handle;
    int file_handle_bw;
    int retardo_total               = 0; 
    real pkg                        = pckg_sz;
    real min_bw                     = 1000;
    real max_bw                     = 0;
    real avg_bw                     = 0;
    real tot_bw                     = 0;
    shortreal retardo_promedio;
    int  transacciones_completadas  = 0;
    
    // Assoc array for storing pkgs that come from the analysis port
    int       mnt_reg  [logic [pckg_sz-1:0]]; // type: int, key: [pckg_sz-1:0]
    int       drv_reg  [logic [pckg_sz-1:0]]; // type: int, key: [pckg_sz-1:0]
    bit [7:0] path_reg [logic [pckg_sz-1:0]]; // type: bit [7:0], key: [pckg_sz-1:0]
    bit [7:0] chk_try  [logic [pckg_sz-1:0]]; // type: bit [7:0], key: [pckg_sz-1:0]

    // Variables for counting if an instruction passes or is an error
    int pass_count = 0;
    int error_count = 0;
    int repetidas = 0;

    // Variables required for generating path from instructions that are feed
    // into DUT
    path_gen path;
    bit [7:0] path_ref[$];
    bit [7:0] rowcol;

    // Queue for storing elements that are send by the monitor for later use
    // under report phase
    sequence_trans_2 trans_reg[$];

    // Class constructor
    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Declare analysis port for receiving information
    uvm_analysis_imp_MNT #(sequence_trans_2, scoreboard) m_analysis_imp; // monitor
    uvm_analysis_imp_DRV #(sequence_trans, scoreboard) d_analysis_imp; // driver

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Create the ports
        m_analysis_imp = new("m_analysis_imp", this);
        d_analysis_imp = new("d_analysis_imp", this);

        // Open CSV file for report 
        file_handle = $fopen(filename, "w");
        if (file_handle == 0) begin
            `uvm_fatal("SCOREBOARD_ERROR", $sformatf("No se pudo abrir el archivo: %s", filename))
        end
        else begin
            // Write the title of each value
            $fwrite(file_handle, "#,Dato,Fila,Columna,Fuente,Latencia (ns), Ancho de Banda (Gbps)\n");
        end

        // Open CSV file for report of BW
        file_handle_bw = $fopen(filename_bw, "r");
		    if (file_handle_bw == 0) begin
		      file_handle_bw = $fopen(filename_bw, "w");
          // Write the title of each value
          $fwrite(file_handle_bw, "Profundidad FIFO, Ancho de banda máximo (Gbps), Ancho de banda mínimo (Gbps)\n");
		      $fclose(file_handle_bw);
		    end

    endfunction

    //This virtual function takes a sequence of transactions, along with the send and
    //receive timestamps, calculates latency and bandwidth, updates total latency and
    //bandwidth statistics, and writes the transaction details to a CSV file. It also
    //tracks the minimum and maximum bandwidth encountered during the simulation.
    virtual function void write_to_csv(sequence_trans_2 trans, int t_envio, int t_recibo);
        trans.latencia = t_recibo - t_envio;
	      trans.bw = pkg/trans.latencia;


        retardo_total = retardo_total + trans.latencia;
        tot_bw        = tot_bw + trans.bw;

        // Conditions for storing the maximum or minimum bandwidth
        if (trans.bw < min_bw) begin
            min_bw = trans.bw;
          end
        if (trans.bw > max_bw) begin
            max_bw = trans.bw;
        end

        // Escribir los datos en el archivo CSV
        $fwrite(file_handle, "%3d,%h,%h,%h,%0d,%3d,%0.3f\n",
		            trans.cantidad_transacciones,
                trans.dato_pkg.payload,
                trans.dato_pkg.target.row,
                trans.dato_pkg.target.col,
                trans.dato_pkg.src,
                trans.latencia,
                trans.bw);
    endfunction

    //This virtual function opens a CSV file, appends the current maximum and minimum
    //bandwidth along with a specified FIFO depth, and then closes the file. The data
    //is formatted and written in a way suitable for analyzing and visualizing
    //bandwidth-related statistics.
    virtual function void write_to_csv_bw;
      file_handle_bw = $fopen(filename_bw, "a");
      $fwrite(file_handle_bw, "%2d,%f,%f\n",
              fifo_dpth,max_bw, min_bw);
      $fclose(file_handle_bw);
    endfunction
    
    // When receiving something from DRV analysis port generate the path for
    // the instruction sent, and store the path into an assoc array for later
    // comparison with the DUT path
    virtual function write_DRV(sequence_trans trans_drv);//, sequence_trans_2 trans_mnt);
        // Handle the analysis port from driver, and store what is sent to the
        // DUT in an assoc array
        `uvm_info("write", $sformatf("Se recibe = %h", trans_drv), UVM_HIGH)
        drv_reg[{trans_drv.dato_pkg.target.row, trans_drv.dato_pkg.target.col, trans_drv.dato_pkg.payload}] = trans_drv.t_envio;
        // Calculate the path for each instruction that is sent into the DUT
        path = new(trans_drv.dato_pkg.mode, trans_drv.path);
        path.src = trans_drv.dato_pkg.src;
        path.destiny = {trans_drv.dato_pkg.target.row, trans_drv.dato_pkg.target.col};
        path.run();
        trans_drv.path = path.path;
        path_ref = trans_drv.path;

        // For storing the path into a hash table
        while(path_ref.size() > 0) begin
            rowcol = path_ref.pop_back();
            path_reg[{rowcol[7:4], rowcol[3:0], trans_drv.dato_pkg.payload}] = rowcol;
        end
    endfunction

    // What to do when receiving something from an analysis port from monitor
    virtual function write_MNT(sequence_trans_2 trans_mnt);
        // Handle the analysis port from monitor, it stores it into an assoc
        // array and creates some sort of data base of the info that the
        // monitor sees
        `uvm_info("write", $sformatf("Se recibe = %h", trans_mnt), UVM_HIGH)

        // Condition to check when spc instructions are send, to this allow to
        // count them for generating report correctly
        if (mnt_reg.exists({trans_mnt.dato_pkg.target.row, trans_mnt.dato_pkg.target.col, trans_mnt.dato_pkg.payload})) begin
            repetidas++;
        end

        mnt_reg[{trans_mnt.dato_pkg.target.row, trans_mnt.dato_pkg.target.col, trans_mnt.dato_pkg.payload}] = trans_mnt.t_recibo;
        
        // Add 1 transaction count
        transacciones_completadas++;

        //Assign the number of transaccions completed to cantidad_transacciones
        trans_mnt.cantidad_transacciones = transacciones_completadas;
        trans_mnt.t_envio = drv_reg[{trans_mnt.dato_pkg.target.row, trans_mnt.dato_pkg.target.col, trans_mnt.dato_pkg.payload}];
        // Call the function to write de CSV with all the params 
        write_to_csv(trans_mnt, trans_mnt.t_envio, trans_mnt.t_recibo);

        // Store at a queue to have a register of the instrucions that have
        // taken place
        //trans_mnt_cp = trans_mnt.clone(); // Clone the element
        //trans_mnt.print();

        trans_reg.push_back(trans_mnt); // Store the copied element at the queue
    endfunction

    virtual task run_phase(uvm_phase phase);
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

    // Comment about what this is gonna do
    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);

        // Makes a comparison only between what was received at the monitor
        // with the values sent
        foreach (mnt_reg[mnt_key]) begin
            if (!drv_reg.exists(mnt_key)) begin
                error_count++;
                `uvm_error("SCB_ERROR", $sformatf("The key: %0h was not stored in the reference", mnt_key))
            end else begin
                pass_count++;
            end
        end

        // Makes a commparison in the path taken by each transaction, with the
        // one generated at the path generator
        foreach (chk_try[chk_key]) begin
            if (!path_reg.exists(chk_key)) begin
                `uvm_error("SCB_ERROR", $sformatf("The package with key: %0h didn't follow the proper trajectory", chk_key))
            end
        end

        // Close the CSV file
        $fclose(file_handle);
        // Call the function to write the CSV report with all the BW params
        //write_to_csv_bw();
    endfunction

    // Report phase, in this phase, the elements that were processed are shown
    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("Received %0d items", trans_reg.size()), UVM_LOW)
        
        // Generates the report that shows all the instructions that were
        // received by the monitor
        foreach (trans_reg[i]) begin
//            trans_reg[i].print();
        end

        // Generates a report to show the amount of correct transaction in
        // comparison with the ones with error
        `uvm_info(get_type_name(), $sformatf("\n\n\n*** TEST RESULTS - %0d instr proc, %0d instr passed, %0d instr errors ***\n", transacciones_completadas, pass_count+repetidas, error_count), UVM_LOW)
	write_to_csv_bw();
    endfunction

endclass
