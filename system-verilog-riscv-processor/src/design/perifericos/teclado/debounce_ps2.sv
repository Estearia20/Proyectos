`timescale 1ns / 1ps

module debouncer_ps2(
    input  logic clk_i,
    input  logic rst_i,
    input  logic I0_i,
    input  logic I1_i,
    output logic O0_o,
    output logic O1_o
    );
    
    logic [4:0] cnt0; 
    logic [4:0] cnt1;
    logic       Iv0;
    logic       Iv1;
    logic       out0;
    logic       out1;
    
    always_ff@(posedge(clk_i))begin
        if(!rst_i) begin
            cnt0 <= "00000";
            cnt1 <= "00000";
            O0_o <= I0_i;
            O1_o <= I1_i;
        end else begin
            if (I0_i == Iv0)begin
                if (cnt0 ==19) O0_o <=I0_i;
                else cnt0<=cnt0+1;
            end
            else begin
                cnt0 <= "00000";
                Iv0  <= I0_i;
            end
            
            if (I1_i==Iv1)begin
                if (cnt1==19)O1_o <= I1_i;
                else cnt1 <= cnt1 + 1;
            end
            else begin
                cnt1 <= "00000";
                Iv1 <= I1_i;
            end
        end
    end
    
endmodule
