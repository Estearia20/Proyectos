// This module grants access to the router_bus_interface for doing coverage of
// the popin
module cobertura #(parameter [7:0] ntrfs_id = 0, parameter id_c = 0, parameter id_r = 0) (
    input   clk,
    input   reset,
    input   [7:0] target,
    input   [3:0] src,
    input   popin);

    // This covergroup checks for popin signal of each terminal to be one at
    // least once
    covergroup check_popin @(posedge popin);
        option.per_instance = 1;
        coverpoint popin {
            bins one = {1};
        }
    endgroup

    // This covergroup checks for targets inside each terminal, it makes sure
    // that every terminal is trying to send to every target
    covergroup check_target @(posedge popin);
        option.per_instance = 1;
        coverpoint target {
            bins values [] = {8'h01, 8'h02, 8'h03, 8'h04, 8'h10, 8'h20, 8'h30, 8'h40, 8'h51, 8'h52, 8'h53, 8'h54, 8'h15, 8'h25, 8'h35, 8'h45};
        }
    endgroup

    // This covergroup checks for sources inside each terminal, it makes sure
    // that every source is beeing viewed by each terminal
    covergroup check_src @(posedge popin);
        option.per_instance = 1;
        coverpoint src {
            bins values [] = {4'h0, 4'h1, 4'h2, 4'h3, 4'h4, 4'h5, 4'h6, 4'h7, 4'h8, 4'h9, 4'ha, 4'hb, 4'hc, 4'hd, 4'he, 4'hf};
        }
    endgroup

    initial begin
        check_popin cg      = new();
        #3000;
        $display("Coverage para terminal: %g en router %g %g es: %0.2f", ntrfs_id, id_r, id_c, cg.get_inst_coverage());
    end

    initial begin
        check_target cg1    = new();
        #3100;
        $display("Coverage para target en router %g %g es: %0.2f", id_r, id_c, cg1.get_inst_coverage());
    end

    initial begin
        check_src cg2       = new();
        #3200;
        $display("Coverage para source en router %g %g es: %0.2f", id_r, id_c, cg2.get_inst_coverage());
    end
endmodule
