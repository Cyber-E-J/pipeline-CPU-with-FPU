`timescale 1ns / 1ps

module FU_jump(
	input clk, EN, JALR,
	input[2:0] cmp_ctrl,
	input[31:0] rs1_data, rs2_data, imm, PC,
	output[31:0] PC_jump, PC_wb,
	output cmp_res, finish
);

    reg state;
    assign finish = state == 1'b1;
	initial begin
        state = 0;
    end

	reg JALR_reg;
	reg[2:0] cmp_ctrl_reg;
	reg[31:0] rs1_data_reg, rs2_data_reg, imm_reg, PC_reg;

	always@(posedge clk)
	begin
	   if(EN & ~state) begin
	       cmp_ctrl_reg <= cmp_ctrl;
	       JALR_reg <= JALR;
	       rs1_data_reg <= rs1_data;
	       rs2_data_reg <= rs2_data;
	       imm_reg <= imm;
	       PC_reg <= PC;
	       state<=1;
	       
	   end
	   
	   else begin
	       state <=0;
	   end
	end
	
	
	
	cmp_32 cmp(.a(rs1_data_reg), .b(rs2_data_reg ) , .ctrl(cmp_ctrl_reg) , .c(cmp_res));
	
	wire[31:0] result;
	assign PC_jump = result + imm_reg;
	assign PC_wb = PC_reg + 4;
	
	MUX2T1_32 mux(.I0(PC_reg) , .I1(rs1_data_reg) , .s(JALR_reg) , .o(result));
	
	            //to fill sth.in

endmodule