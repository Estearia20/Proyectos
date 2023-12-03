// Interface for connecting DUT
interface if_dut #(parameter bits      = 1,
                   parameter drvrs     = 4,
                   parameter pkg_sz    = 16,
                   parameter byte broadcast = {8{1'b1}}) 
                   (input clk);

    // DUT signals
    logic                         rst;
    logic   [pkg_sz-1:0]          d_out [bits-1:0][drvrs-1:0];
    logic   [pkg_sz-1:0]          d_in  [bits-1:0][drvrs-1:0];
    logic                         push  [bits-1:0][drvrs-1:0];
    logic                         pop   [bits-1:0][drvrs-1:0];
    logic                         pndng [bits-1:0][drvrs-1:0];

endinterface
