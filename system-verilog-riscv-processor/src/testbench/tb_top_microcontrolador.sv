module tb_top_microcontrolador ;


    logic              clk_pi;
    logic              reset_pi;
    logic  [ 15 : 0 ]  switches_pi;
    logic              ps2_clk_pi;
    logic              ps2_data_pi;
    logic              miso_pi;
    logic              sclk_po;
    logic              mosi_po;
    logic              cs_po;
    logic  [  6 : 0 ]  hex_number_po;
    logic  [  7 : 0 ]  an_o;
    logic              uart_tx_po;
    logic  [ 15 : 0 ]  leds_po;

    top_microcontrolador DUT(
        .clk_pi         (clk_pi),
        .reset_pi       (reset_pi),
        .switches_pi    (switches_pi),
        .ps2_clk_pi     (ps2_clk_pi),
        .ps2_data_pi    (ps2_data_pi),
        .miso_pi        (miso_pi),
        .sclk_po        (sclk_po),
        .mosi_po        (mosi_po),
        .cs_po          (cs_po),
        .hex_number_po  (hex_number_po),
        .an_po          (an_o),
        .uart_tx_po     (uart_tx_po),
        .leds_po        (leds_po));

//Se inicializa el reloj de 100MHz del sistema
    initial begin
        clk_pi      = 0;
        reset_pi    = 1;
        switches_pi = 0;
        ps2_clk_pi  = 0;
        ps2_data_pi = 0;
        miso_pi     = 0;
        #3000
        reset_pi    = 0;
    end

//Se crea el reloj de 100MHz
    always begin
        #5
        clk_pi = ~clk_pi;
    end
    
endmodule