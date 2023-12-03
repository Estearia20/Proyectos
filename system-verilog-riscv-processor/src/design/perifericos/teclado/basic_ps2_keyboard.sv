`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name: PS/2 Keyboard interface
// Target Devices: Nexys4 y Basys 3
// Tool Versions: 
// Description: Basic interface for PS/2 keyboard. 
// 
// 
// Additional Comments: The device provides a 8 bit code each time a key is pressed.
//                      It also supports key - long pressing. Based on digilent example
// 
//////////////////////////////////////////////////////////////////////////////////


module basic_ps2_keyboard#(
        parameter integer CLK_FREQ = 10_000_000 //Hz
    )
    (
        input  logic        clk,
        input  logic        rst,
        input  logic        ps2_clk,
        input  logic        ps2_data,
        output logic [31:0] long_keycodeout,
        output logic        ps2_code_new,   //A new valid PS/2 code is available on ps2_code bus
        output logic [7:0]  ps2_code        //code received from PS/2
    );
    localparam real idle_delay = 500e-6; //Seconds
    localparam real idle_count_real = idle_delay*CLK_FREQ;
    localparam integer idle_count_w = $clog2($rtoi(idle_count_real));
    localparam [idle_count_w-1:0] count_idle_max = $rtoi(idle_count_real);//$ceil(12800000/18_000);

    logic           ps2_clkf;
    logic           ps2_dataf;
    logic           ps2_clkf_delayed;
    logic           ps2_dataf_delayed;
    logic [7:0]     datacur;
    logic [7:0]     dataprev;
    logic [3:0]     cnt;
    logic [31:0]    keycode;
    logic           flag;
    logic           flag_prev;
    
    
    logic [$clog2(count_idle_max)-1:0]  count_idle; //counter to determine PS/2 is idle

    
        
    debouncer_ps2 debounce(
        .clk_i (clk),
        .rst_i (rst),
        .I0_i  (ps2_clk),
        .I1_i  (ps2_data),
        .O0_o  (ps2_clkf),
        .O1_o  (ps2_dataf)
    );


    always_ff @(posedge clk)begin
        if(!rst) begin
            datacur     <= 0;
            flag        <= 0;
            cnt         <= 0;
        end else begin
            if( { ps2_clkf_delayed, ps2_clkf } == 2'b10) begin //negedge
                case(cnt)
                0:;//Start bit
                1:datacur[0] <= ps2_dataf;
                2:datacur[1] <= ps2_dataf;
                3:datacur[2] <= ps2_dataf;
                4:datacur[3] <= ps2_dataf;
                5:datacur[4] <= ps2_dataf;
                6:datacur[5] <= ps2_dataf;
                7:datacur[6] <= ps2_dataf;
                8:datacur[7] <= ps2_dataf;
                9:flag       <= 1'b1;
                10:flag      <= 1'b0;
                
                endcase
                if(cnt<=9)       cnt <= cnt + 1;
                else if(cnt==10) cnt <= 0;
            end
        end
    
    end


    always_ff @(posedge clk)begin
        if(!rst) begin
            flag_prev          <=0;
            ps2_clkf_delayed   <= 0;
            ps2_dataf_delayed  <= 0;
        end else begin
            flag_prev          <= flag;
            ps2_clkf_delayed   <= ps2_clkf;  
            ps2_dataf_delayed  <= ps2_dataf;
        end
    end

    
    always_ff @(posedge clk)begin
        if(!rst) begin
            keycode<=0;
            dataprev<=0;
        end else begin
            if(ps2_code_new) begin
                keycode<=0;
                dataprev<=0;
            end else begin 
                if(( {flag_prev, flag} == 2'b01) &&
                   ( dataprev != datacur ) ) begin
                   
                    keycode[31:24]<=keycode[23:16];
                    keycode[23:16]<=keycode[15:8];
                    keycode[15:8]<=dataprev;
                    keycode[7:0]<=datacur;
                    dataprev<=datacur;
                    
                end
            end
        end
    end


    always_ff @ (posedge clk) begin        
        if(!rst) begin
            count_idle <= 0;
            ps2_code_new <= 0;
            ps2_code <=0;
        end else begin
            if (ps2_clkf == 0)                       
                count_idle <= 0;                     
            else if(count_idle != count_idle_max - 1)
                count_idle <= count_idle + 1;
            
            if (count_idle == count_idle_max - 2) begin  
                if((keycode[15:8]!=8'hf0)||(keycode[31:24]==8'hf0)) begin
                    ps2_code_new <= 1;          
                    ps2_code <= keycode[7 : 0]; 
                end
            end else begin              
                ps2_code_new <= 0;      
            end
        end
    end
    
    assign long_keycodeout = keycode;
endmodule
