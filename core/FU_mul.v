`timescale 1ns / 1ps

module FU_mul(
    input clk, EN,
    input[31:0] A, B,
    output[31:0] res,
    output finish
);

    reg[6:0] state;
    assign finish = state[0] == 1'b1;
    initial begin
        state = 0;
    end

    wire [63:0] mulres;
    reg[31:0] A_reg, B_reg;

    always @(posedge clk)
    begin
        if(EN & ~state) begin
            A_reg <= A;
            B_reg <= B;
            state <= 7'b1000000;
        end
        else if(state == 7'b1000000) begin
            state <= 7'b1100000;
        end
        else if(state == 7'b1100000) begin
            state <= 7'b1110000;
        end
        else if(state == 7'b1110000) begin
            state <= 7'b1111000;
        end
        else if(state == 7'b1111000) begin
            state <= 7'b1111100;
        end
        else if(state == 7'b1111100) begin
            state <= 7'b1111110;
        end
        else if(state == 7'b1111110) begin
            state <= 7'b1111111;
        end        
        else if(state == 7'b1111111) begin
            state <= 7'b0000000;
        end         
        
    
    
    end         //to fill sth.in

    mult_gen_0 mul(.CLK(clk),.A(A_reg),.B(B_reg),.P(mulres));

    assign res = mulres[31:0];

endmodule