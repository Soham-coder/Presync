`timescale 1ps/1fs

module clk_div 
#(parameter
  THRESHOLD=24// divides i_clk by 24 to obtain ck_stb which is the divided clock signal
  )
  (i_clk, ck_stb);
  
  input i_clk;
  output reg ck_stb = 0;
  
  reg [($clog2(THRESHOLD >> 1)-1):0] counter = 0;
  reg counter_reset = 0;
  
  //output reg ck_stb = 0;
  
  always @(posedge i_clk)
    counter_reset <= (counter == (THRESHOLD >> 1) - 1'b1);
  
  always @(posedge i_clk)
  begin
    if(counter_reset)
      counter <= 1;    
    else
      counter <= counter + 1;
  end
  
  always @(posedge i_clk)
    if(counter_reset)
      ck_stb <= ~ck_stb;
  
endmodule

//Clock generator module
module clk_gen
  #(
  parameter THRESHOLD_FOR_CLOCK = 24
)
  (clk_0_1ps,clk_out);
input clk_0_1ps;
output clk_out; 

 // reg clk_0_1ns;
  wire clk_out;
  clk_div #(.THRESHOLD(THRESHOLD_FOR_CLOCK)) cd (.i_clk(clk_0_1ps), .ck_stb(clk_out));
  
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//File Name: Multiplication.v
//Created By: Sheetal Swaroop Burada
//Date: 62-04-2019
//Project Name: Design of 64 Bit Floating Point ALU Based on Standard IEEE-754 in Verilog and its implementation on FPGA.
//University: Dayalbagh Educational Institute
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Multiplication64(
    input clk,
		input [63:0] a_operand,
		input [63:0] b_operand,
		output reg Exception,Overflow,Underflow,
		output reg [63:0] result
		);



reg sign,product_round,normalised,zero;
reg [11:0] exponent,sum_exponent;
reg [51:0] product_mantissa;
reg [52:0] operand_a,operand_b;
reg [105:0] product,product_normalised; 

wire sign1,product_round1,normalised1,zero1;////
wire [11:0] exponent1,sum_exponent1;//
wire [51:0] product_mantissa1;
wire [52:0] operand_a1,operand_b1;//
wire [105:0] product1,product_normalised1;//
wire Exception1,Overflow1,Underflow1;//
wire [63:0] result1;
reg [63:0] res1,res2,res3;

assign sign1 = a_operand[63] ^ b_operand[63];

//Exception flag sets 1 if either one of the exponent is 255.
assign Exception1 = (&a_operand[62:52]) | (&b_operand[62:52]);

//Assigining significand values according to Hidden Bit.
//If exponent is equal to zero then hidden bit will be 0 for that respective significand else it will be 1

assign operand_a1 = (|a_operand[62:52]) ? {1'b1,a_operand[51:0]} : {1'b0,a_operand[51:0]};

assign operand_b1 = (|b_operand[62:52]) ? {1'b1,b_operand[51:0]} : {1'b0,b_operand[51:0]};

assign product1 = operand_a * operand_b;			//Calculating Product

assign product_round1 = |product_normalised[51:0];  //Ending 51 bits are OR'ed for rounding operation.

assign normalised1 = product[105] ? 1'b1 : 1'b0;	

assign product_normalised1 = normalised ? product : product << 1;	//Assigning Normalised value based on 48th bit

//Final Manitssa.
assign product_mantissa1 = product_normalised[104:53] + {50'b0,(product_normalised[52] & product_round)};

assign zero1 = Exception ? 1'b0 : (product_mantissa == 52'd0) ? 1'b1 : 1'b0;

assign sum_exponent1 = a_operand[62:52] + b_operand[62:52];

assign exponent1 = sum_exponent - 11'd1023 + normalised;


assign Overflow1 = ((exponent[11] & !exponent[10]) & !zero) ; //If overall exponent is greater than 2047 then Overflow condition.


//Exception Case when exponent reaches its maximu value that is 384.

//If sum of both exponents is less than 127 then Underflow condition.
assign Underflow1 = ((exponent[11] & exponent[10]) & !zero) ? 1'b1 : 1'b0; 


assign result1 = Exception ? 64'd0 : zero ? {sign,63'd0} : Overflow ? {sign,11'b11111111111,52'd0} : Underflow ? {sign,63'd0} : {sign,exponent[10:0],product_mantissa};
always@(posedge clk)
begin
  sign<=sign1;
  Exception<=Exception1;
  operand_a<=operand_a1;
  operand_b<=operand_b1;
  product<=product1;
  product_round<=product_round1;
  normalised<=normalised1;
  product_normalised<=product_normalised1;
  product_mantissa<=product_mantissa1;
  zero<=zero1;
  sum_exponent<=sum_exponent1;
  exponent<=exponent1;
  Overflow<=Overflow1;
  Underflow<=Underflow1;
  
  res1<=result1;
  res2<=res1;
  res3<=res2;
  result<=res3;
end


endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//File Name: Iteration.v
//Created By: Sheetal Swaroop Burada
//Date: 62-04-2019
//Project Name: Design of 64 Bit Floating Point ALU Based on Standard IEEE-754 in Verilog and its implementation on FPGA.
//University: Dayalbagh Educational Institute
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module Iteration64(
  input clk,
	input [63:0] operand_1,
	input [63:0] operand_2,
	output reg [63:0] solution
	);

wire [63:0] Intermediate_Value11,Intermediate_Value2;
wire [63:0] solution1;
reg [63:0] Intermediate_Value1;


Multiplication64 M1(clk,operand_1,operand_2,,,,Intermediate_Value11);

//64'h4000_0000 -> 2.
Addition_Subtraction64 A1(clk,64'b0100000000000000000000000000000000000000000000000000000000000000,{1'b1,Intermediate_Value1[62:0]},1'b0,,Intermediate_Value2);

Multiplication64 M2(clk,operand_1,Intermediate_Value2,,,,solution1);
always@(posedge clk)
begin
  Intermediate_Value1<=Intermediate_Value11;
  solution<=solution1; 
end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//File Name: Additon_Subtraction.v
//Created By: Sheetal Swaroop Burada
//Date: 62-04-2019
//Project Name: Design of 64 Bit Floating Point ALU Based on Standard IEEE-754 in Verilog and its implementation on FPGA.
//University: Dayalbagh Educational Institute
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




module Addition_Subtraction64(
input clk,
input [63:0] a_operand,b_operand, //Inputs in the format of IEEE-754 Representation.
input AddBar_Sub,				  //If Add_Sub is low then Addition else Subtraction.
output reg Exception,
output reg [63:0] result              //Outputs in the format of IEEE-754 Representation.
);

reg operation_sub_addBar;
wire Comp_enable;
reg output_sign;
wire [63:0] operand_a,operand_b;
reg [52:0] significand_a,significand_b;
reg [10:0] exponent_diff;
reg [52:0] significand_b_add_sub;
reg [10:0] exponent_b_add_sub;
reg [53:0] significand_add;
wire [62:0] add_sum;
reg [52:0] significand_sub_complement;
reg [53:0] significand_sub;
wire [62:0] sub_diff;
reg [53:0] subtraction_diff; 
reg [10:0] exponent_sub;

wire operation_sub_addBar1;
wire Comp_enable1;
wire output_sign1;
wire [63:0] operand_a1,operand_b1;
wire [52:0] significand_a1,significand_b1;
wire [10:0] exponent_diff1;
wire [52:0] significand_b_add_sub1;
wire [10:0] exponent_b_add_sub1;
wire [53:0] significand_add1;
wire [62:0] add_sum1;
wire [52:0] significand_sub_complement1;
wire [53:0] significand_sub1;
wire [62:0] sub_diff1;
wire [53:0] subtraction_diff1; 
wire [10:0] exponent_sub1;
wire Exception1;
wire [63:0] result1;
wire perform;
wire [10:0] exp_a,exp_b;

//for operations always operand_a must not be less than b_operand
assign {Comp_enable,operand_a,operand_b} = (a_operand[62:0] < b_operand[62:0]) ? {1'b1,b_operand,a_operand} : {1'b0,a_operand,b_operand};


assign exp_a = operand_a[62:52];


assign exp_b = operand_b[62:52];


//Exception flag sets 1 if either one of the exponent is 255.
assign Exception1 = (&operand_a[62:52]) | (&operand_b[62:52]);

assign output_sign1 = AddBar_Sub ? Comp_enable ? !operand_a[63] : operand_a[63] : operand_a[63] ;

assign operation_sub_addBar1 = AddBar_Sub ? operand_a[63] ^ operand_b[63] : ~(operand_a[63] ^ operand_b[63]);

//Assigining significand values according to Hidden Bit.
//If exponent is equal to zero then hidden bit will be 0 for that respective significand else it will be 1
assign significand_a1 = (|operand_a[62:52]) ? {1'b1,operand_a[51:0]} : {1'b0,operand_a[51:0]};

assign significand_b1 = (|operand_b[62:52]) ? {1'b1,operand_b[51:0]} : {1'b0,operand_b[51:0]};

//Evaluating Exponent Difference
assign exponent_diff1 = operand_a[62:52] - operand_b[62:52];

//Shifting significand_b according to exponent_diff
assign significand_b_add_sub1 = significand_b >> exponent_diff;

assign exponent_b_add_sub1 = operand_b[62:52] + exponent_diff; 

//Checking exponents are same or not
assign perform = (operand_a[62:52] == exponent_b_add_sub);

///////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------ADD BLOCK------------------------------------------//

assign significand_add1 = (perform & operation_sub_addBar) ? (significand_a + significand_b_add_sub) : 25'd0; 

//Result will be equal to Most 52 bits if carry generates else it will be Least 51 bits.
assign add_sum[51:0] = significand_add[53] ? significand_add[52:1] : significand_add[51:0];


//If carry generates in sum value then exponent must be added with 1 else feed as it is.
assign add_sum[62:52] = significand_add[53] ? (1'b1 + operand_a[62:52]) : operand_a[62:52];


///////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------SUB BLOCK------------------------------------------//

assign significand_sub_complement1 = (perform & !operation_sub_addBar) ? ~(significand_b_add_sub) + 53'd1 : 53'd0 ; 

assign significand_sub1 = perform ? (significand_a + significand_sub_complement) : 25'd0;

priority_encoder64 pe(significand_sub,operand_a[62:52],subtraction_diff,exponent_sub);

assign sub_diff[62:52] = exponent_sub;


assign sub_diff[51:0] = subtraction_diff[51:0];


///////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------OUTPUT--------------------------------------------//

//If there is no exception and operation will evaluate


assign result1 = Exception ? 64'b0 : ((!operation_sub_addBar) ? {output_sign,sub_diff} : {output_sign,add_sum});
always@(posedge clk)
begin  
  Exception<=Exception1;
  output_sign<=output_sign1;
  operation_sub_addBar<=operation_sub_addBar1;
  significand_a<=significand_a1;
  significand_b<=significand_b1;
  exponent_diff<=exponent_diff1;
  significand_b_add_sub<=significand_b_add_sub1;
  exponent_b_add_sub<=exponent_b_add_sub1;
  significand_add<=significand_add1;
  significand_sub_complement<=significand_sub_complement1;
  significand_sub<=significand_sub1;
  result<=result1;
end

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//File Name: Priority Encoder.v
//Created By: Sheetal Swaroop Burada
//Date: 62-04-2019
//Project Name: Design of 64 Bit Floating Point ALU Based on Standard IEEE-754 in Verilog and its implementation on FPGA.
//University: Dayalbagh Educational Institute
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module priority_encoder64(
			input [53:0] significand,
			input [10:0] Exponent_a,
			output reg [53:0] Significand,
			output [10:0] Exponent_sub
			);

reg [5:0] shift;

always @(significand)
begin
	casex (significand)
		54'b1_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x :	begin
													Significand = significand;
									 				shift = 5'd0;
								 			  	end
		54'b1_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
										 			Significand = significand << 1;
									 				shift = 5'd1;
								 			  	end

		54'b1_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
										 			Significand = significand << 2;
									 				shift = 5'd2;
								 				end

		54'b1_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin 							
													Significand = significand << 3;
								 	 				shift = 5'd3;
								 				end

		54'b1_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
									 				Significand = significand << 4;
								 	 				shift = 5'd4;
								 				end

		54'b1_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
									 				Significand = significand << 5;
								 	 				shift = 5'd5;
								 				end

		54'b1_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h020000
									 				Significand = significand << 6;
								 	 				shift = 5'd6;
								 				end

		54'b1_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h010000
									 				Significand = significand << 7;
								 	 				shift = 5'd7;
								 				end

		54'b1_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h008000
									 				Significand = significand << 8;
								 	 				shift = 5'd8;
								 				end

		54'b1_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h004000
									 				Significand = significand << 9;
								 	 				shift = 5'd9;
								 				end

		54'b1_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h002000
									 				Significand = significand << 10;
								 	 				shift = 5'd10;
								 				end

		54'b1_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h001000
									 				Significand = significand << 11;
								 	 				shift = 5'd11;
								 				end

		54'b1_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000800
									 				Significand = significand << 12;
								 	 				shift = 5'd12;
								 				end

		54'b1_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000400
									 				Significand = significand << 13;
								 	 				shift = 5'd13;
								 				end

		54'b1_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000200
									 				Significand = significand << 14;
								 	 				shift = 5'd14;
								 				end

		54'b1_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x  : 	begin						// 53'h000100
									 				Significand = significand << 15;
								 	 				shift = 5'd15;
								 				end

		54'b1_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000080
									 				Significand = significand << 16;
								 	 				shift = 5'd16;
								 				end

		54'b1_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000040
											 		Significand = significand << 17;
										 	 		shift = 5'd17;
												end

		54'b1_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000020
									 				Significand = significand << 18;
								 	 				shift = 5'd18;
								 				end

		54'b1_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000010
									 				Significand = significand << 19;
								 	 				shift = 5'd19;
												end

		54'b1_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x :	begin						// 53'h000008
									 				Significand = significand << 20;
								 					shift = 5'd20;
								 				end

		54'b1_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000004
									 				Significand = significand << 21;
								 	 				shift = 5'd21;
								 				end

		54'b1_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000002
									 				Significand = significand << 22;
								 	 				shift = 5'd22;
								 				end

		54'b1_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000001
									 				Significand = significand << 23;
								 	 				shift = 5'd23;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000000
								 					Significand = significand << 24;
							 	 					shift = 5'd24;
								 				end
		54'b1_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x :	begin
													Significand = significand << 25;
									 				shift = 5'd25;
								 			  	end
		54'b1_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
										 			Significand = significand << 26;
									 				shift = 5'd26;
								 			  	end

		54'b1_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
										 			Significand = significand << 27;
									 				shift = 5'd27;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin 							
													Significand = significand << 28;
								 	 				shift = 5'd28;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
									 				Significand = significand << 29;
								 	 				shift = 5'd29;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						
									 				Significand = significand << 30;
								 	 				shift = 5'd30;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h020000
									 				Significand = significand << 31;
								 	 				shift = 5'd31;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h010000
									 				Significand = significand << 32;
								 	 				shift = 5'd32;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h008000
									 				Significand = significand << 33;
								 	 				shift = 5'd33;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h004000
									 				Significand = significand <<34;
								 	 				shift = 5'd34;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h002000
									 				Significand = significand << 35;
								 	 				shift = 5'd35;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_x : 	begin						// 53'h001000
									 				Significand = significand << 36;
								 	 				shift = 5'd36;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_x : 	begin						// 53'h000800
									 				Significand = significand << 37;
								 	 				shift = 5'd37;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_x : 	begin						// 53'h000400
									 				Significand = significand << 38;
								 	 				shift = 5'd38;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_x : 	begin						// 53'h000200
									 				Significand = significand << 39;
								 	 				shift = 5'd39;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_x  : 	begin						// 53'h000100
									 				Significand = significand << 40;
								 	 				shift = 5'd40;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_x : 	begin						// 53'h000080
									 				Significand = significand << 41;
								 	 				shift = 5'd41;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_x : 	begin						// 53'h000040
											 		Significand = significand << 42;
										 	 		shift = 5'd42;
												end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_x : 	begin						// 53'h000020
									 				Significand = significand << 43;
								 	 				shift = 5'd43;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_x : 	begin						// 53'h000010
									 				Significand = significand << 44;
								 	 				shift = 5'd44;
												end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_x :	begin						// 53'h000008
									 				Significand = significand << 45;
								 					shift = 5'd45;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_x : 	begin						// 53'h000004
									 				Significand = significand << 46;
								 	 				shift = 5'd46;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_x : 	begin						// 53'h000002
									 				Significand = significand << 47;
								 	 				shift = 5'd47;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_x : 	begin						// 53'h000001
									 				Significand = significand << 48;
								 	 				shift = 5'd48;
								 				end

		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_x : 	begin						// 53'h000000
								 					Significand = significand << 49;
							 	 					shift = 5'd49;
								 				end
		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_x : 	begin						// 53'h000000
								 					Significand = significand << 50;
							 	 					shift = 5'd50;
								 				end
		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_x : 	begin						// 53'h000000
								 					Significand = significand << 51;
							 	 					shift = 5'd51;
								 				end
		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1 : 	begin						// 53'h000000
								 					Significand = significand << 52;
							 	 					shift = 5'd52;
								 				end
		54'b1_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0 : 	begin						// 53'h000000
								 					Significand = significand << 53;
							 	 					shift = 5'd53;
								 				end						 										 										 										 	
		default : 	begin
						Significand = (~significand) + 1'b1;
						shift = 11'd0;
					end

	endcase
end
assign Exponent_sub = Exponent_a - shift;

endmodule

// Code your design here
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//File Name: Division.v
//Created By: Sheetal Swaroop Burada
//Date: 62-04-2019
//Project Name: Design of 64 Bit Floating Point ALU Based on Standard IEEE-754 in Verilog and its implementation on FPGA.
//University: Dayalbagh Educational Institute
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module Division64(
  input clk,
	input [63:0] a_operand,
	input [63:0] b_operand,
	output Exception,
	output [63:0] result
);

wire sign1;
wire [10:0] shift1;
wire [10:0] exponent_a1;
wire [63:0] divisor1;
wire [63:0] operand_a1;
wire [63:0] Intermediate_X01;
wire [63:0] Iteration_X01;
wire [63:0] Iteration_X11;
wire [63:0] Iteration_X21;
wire [63:0] Iteration_X31;
wire [63:0] solution1;

wire [63:0] denominator1;
wire [63:0] operand_a_change1;

reg sign;//
reg [10:0] shift;//
reg [10:0] exponent_a;//
reg [63:0] divisor;//
reg [63:0] operand_a;//
reg [63:0] Intermediate_X0;//
reg [63:0] Iteration_X0;//
reg [63:0] Iteration_X1;//
reg [63:0] Iteration_X2;//
reg [63:0] Iteration_X3;//
reg [63:0] solution;//

reg [63:0] denominator;//
reg [63:0] operand_a_change;//

assign Exception = (&a_operand[62:52]) | (&b_operand[62:52]);

assign sign1 = a_operand[63] ^ b_operand[63];

assign shift1 = 11'd1022 - b_operand[62:52];

assign divisor1 = {1'b0,11'd1022,b_operand[51:0]};

assign denominator1 = divisor;

assign exponent_a1 = a_operand[62:52] + shift;

assign operand_a1 = {a_operand[63],exponent_a,a_operand[51:0]};

assign operand_a_change1 = operand_a;

//64'hC00B_4B4B = (-37)/17
Multiplication64 x0(clk,64'b1100000000000001011010010110100101101001101001100000101111101101,divisor,,,,Intermediate_X01);

//64'h4034_B4B5 = 48/17
Addition_Subtraction64 X0(clk,Intermediate_X0,64'b0100000000000110100101101001011010010110010110011111010000010010,1'b0,,Iteration_X01);

Iteration64 X1(clk,Iteration_X0,divisor,Iteration_X11);

Iteration64 X2(clk,Iteration_X1,divisor,Iteration_X21);

Iteration64 X3(clk,Iteration_X2,divisor,Iteration_X31);

Multiplication64 END(clk,Iteration_X3,operand_a,,,,solution1);
always@(posedge clk)
begin
  sign<=sign1;
  shift<=shift1;
  divisor<=divisor1;
  denominator<=denominator1;
  exponent_a<=exponent_a1;
  operand_a<=operand_a1;
  operand_a_change<=operand_a_change1;
  Intermediate_X0<=Intermediate_X01;
  Iteration_X0<=Iteration_X01;
  Iteration_X1<=Iteration_X11;
  Iteration_X2<=Iteration_X21;
  Iteration_X3<=Iteration_X31;
  solution<=solution1;
end

assign result = {sign,solution[62:0]};


endmodule

// Code your design here
/* Name: Suhas Sunil Raut    SJSU ID: 011432980
   Verilog Code For IEEE 754 Single Precision (32 bit) Floating Point Adder
   
   This is a reduced complexity floating point adder.   
   NaN, overflow, underflow and infinity values not processed
   
   Format for IEEE 754 SP FP:
   S    Exp     Mantissa
   31   30:23   22:0     
   Note: Number = 0 for exp=0 and mantissa=0
*/
module fpadd64( input reset, input [63:0]Number1, input [63:0]Number2,input clk, output [63:0]Result);
    
    reg    [63:0] Num_shift_80,Num_shift_pipe2_80; 
    reg    [10:0]  Larger_exp_80,Larger_exp_pipe1_80,Larger_exp_pipe2_80,Larger_exp_pipe3_80,Larger_exp_pipe4_80,Larger_exp_pipe5_80,Final_expo_80;
    reg    [51:0] Small_exp_mantissa_80,Small_exp_mantissa_pipe2_80,S_exp_mantissa_pipe2_80,S_exp_mantissa_pipe3_80,Small_exp_mantissa_pipe3_80;
    reg    [51:0] S_mantissa_80,L_mantissa_80;
    reg    [51:0] L1_mantissa_pipe2_80,L1_mantissa_pipe3_80,Large_mantissa_80,Final_mant_80;
    reg    [51:0] Large_mantissa_pipe2_80,Large_mantissa_pipe3_80,S_mantissa_pipe4_80,L_mantissa_pipe4_80;
    reg    [52:0] Add_mant_80,Add1_mant_80,Add_mant_pipe5_80;
    reg    [10:0]  e1_80,e1_pipe1_80,e1_pipe2_80,e1_pipe3_80,e1_pipe4_80,e1_pipe5_80;
    reg    [10:0]  e2_80,e2_pipe1_80,e2_pipe2_80,e2_pipe3_80,e2_pipe4_80,e2_pipe5_80;
    reg    [51:0] m1_80,m1_pipe1_80,m1_pipe2_80,m1_pipe3_80,m1_pipe4_80,m1_pipe5_80;
    reg    [51:0] m2_80,m2_pipe1_80,m2_pipe2_80,m2_pipe3_80,m2_pipe4_80,m2_pipe5_80;

    reg           s1_80,s2_80,Final_sign_80,s1_pipe1_80,s1_pipe2_80,s1_pipe3_80,s1_pipe4_80,s1_pipe5_80;
    reg           s2_pipe1_80,s2_pipe2_80,s2_pipe3_80,s2_pipe4_80,s2_pipe5_80;
    reg    [4:0]     renorm_shift_80,renorm_shift_pipe5_80;
    integer signed   renorm_exp_80;

    //:w
    //reg    [3:0]  renorm_exp_80,renorm_exp_pipe5_80;
    reg    [63:0] Result_80;

    assign Result = Result_80;

    always @(*) begin
        ///////////////////////// Combinational stage1 ///////////////////////////
	e1_80 = Number1[62:52];
	e2_80 = Number2[62:52];
        m1_80 = Number1[51:0];
	m2_80 = Number2[51:0];
	s1_80 = Number1[63];
	s2_80 = Number2[63];
        
        if (e1_80  > e2_80) begin
            Num_shift_80           = e1_80 - e2_80;              // determine number of mantissa shift
            Larger_exp_80           = e1_80;                     // store higher exponent
            Small_exp_mantissa_80  = m2_80;
            Large_mantissa_80      = m1_80;
        end 
        else begin
            Num_shift_80           = e2_80 - e1_80;
            Larger_exp_80           = e2_80;
            Small_exp_mantissa_80  = m1_80;
            Large_mantissa_80      = m2_80;
        end

	if (e1_80 == 0 | e2_80 ==0) begin
	    Num_shift_80 = 0;
	end
	else begin
	    Num_shift_80 = Num_shift_80;
	end	
        ///////////////////////// Combinational stage2 ///////////////////////////
        //right shift mantissa of smaller exponent
	if (e1_pipe2_80 != 0) begin
            S_exp_mantissa_pipe2_80  = {1'b1,Small_exp_mantissa_pipe2_80[51:1]};
	    S_exp_mantissa_pipe2_80  = (S_exp_mantissa_pipe2_80 >> Num_shift_pipe2_80);
        end
	else begin
	    S_exp_mantissa_pipe2_80 = Small_exp_mantissa_pipe2_80;
	end

	if (e2_80!= 0) begin
            L1_mantissa_pipe2_80      = {1'b1,Large_mantissa_pipe2_80[51:1]};
	end
	else begin
	    L1_mantissa_pipe2_80 = Large_mantissa_pipe2_80;
	end	
        ///////////////////////// Combinational stage3 ///////////////////////////
	//compare which is smaller mantissa
        if (S_exp_mantissa_pipe3_80  < L1_mantissa_pipe3_80) begin
                S_mantissa_80 = S_exp_mantissa_pipe3_80;
		L_mantissa_80 = L1_mantissa_pipe3_80;
        end
        else begin 
		S_mantissa_80 = L1_mantissa_pipe3_80;
		L_mantissa_80 = S_exp_mantissa_pipe3_80;
        end       
	///////////////////////// Combinational stage4 ///////////////////////////      
        //add the two mantissa's
	if (e1_pipe4_80!=0 & e2_pipe4_80!=0) begin
		if (s1_pipe4_80 == s2_pipe4_80) begin
        		Add_mant_80 = S_mantissa_pipe4_80 + L_mantissa_pipe4_80;
		end else begin
			Add_mant_80 = L_mantissa_pipe4_80 - S_mantissa_pipe4_80;
		end
	end	
	else begin
		Add_mant_80 = L_mantissa_pipe4_80;
	end      
	//determine shifts for renormalization for mantissa and exponent
	if (Add_mant_80[52]) begin
		renorm_shift_80 = 5'd1;
		renorm_exp_80 = 5'd1;
	end
	else if (Add_mant_80[51])begin
		renorm_shift_80 = 5'd2;
		renorm_exp_80 = 0;		
	end
	else if (Add_mant_80[50])begin
		renorm_shift_80 = 5'd3; 
		renorm_exp_80 = -1;
	end 
	else if (Add_mant_80[49])begin
		renorm_shift_80 = 5'd4; 
		renorm_exp_80 = -2;		
	end  
	else if (Add_mant_80[48])begin
		renorm_shift_80 = 5'd5; 
		renorm_exp_80 = -3;		
	end     
	else if (Add_mant_80[47])begin
		renorm_shift_80 = 5'd6; 
		renorm_exp_80 = -4;		
	end
	else if (Add_mant_80[46])begin
		renorm_shift_80 = 5'd7; 
		renorm_exp_80 = -5;		
	end
else if (Add_mant_80[45])begin
		renorm_shift_80 = 5'd8; 
		renorm_exp_80 = -6;		
	end		
	else if (Add_mant_80[44])begin
		renorm_shift_80 = 5'd9; 
		renorm_exp_80 = -7;		
	end		
        else begin
		renorm_exp_80 = 0;
	end	
	///////////////////////// Combinational stage5 /////////////////////////////
	//Shift the mantissa as required; re-normalize exp; determine sign
        Final_expo_80 =  Larger_exp_pipe5_80 + renorm_exp_80;
	if (renorm_shift_pipe5_80 != 0) begin	
		Add1_mant_80 = Add_mant_pipe5_80 << renorm_shift_pipe5_80;
	end
	else begin
		Add1_mant_80 = Add_mant_pipe5_80;
	end
	Final_mant_80 = Add1_mant_80[52:1];  	      
	if (s1_pipe5_80 == s2_pipe5_80) begin
		Final_sign_80 = s1_pipe5_80;
	end 
	if (e1_pipe5_80 > e2_pipe5_80) begin
		Final_sign_80 = s1_pipe5_80;	
	end else if (e2_80 > e1_80) begin
		Final_sign_80 = s2_pipe5_80;
	end
	else begin
		if (m1_pipe5_80 > m2_pipe5_80) begin
			Final_sign_80 = s1_pipe5_80;		
		end else begin
			Final_sign_80 = s2_pipe5_80;
		end
	end	
	Result_80 = {Final_sign_80,Final_expo_80,Final_mant_80}; 
    end
    
    always @(posedge clk) begin
            if(reset) begin                           //reset all reg at reset signal
                s1_pipe2_80 <=   0;
		s2_pipe2_80 <=   0;
		e1_pipe2_80 <=   0;
		e2_pipe2_80 <=   0;	
		m1_pipe2_80 <=   0;
		m2_pipe2_80 <=   0;
		Larger_exp_pipe2_80 <=   0;
		//stage2
		Small_exp_mantissa_pipe2_80 <=   0;
	        Large_mantissa_pipe2_80     <=   0;
		Num_shift_pipe2_80          <=   0;
		s1_pipe3_80 <=   0;
		s2_pipe3_80 <=   0;
		e1_pipe3_80 <=   0;
		e2_pipe3_80 <=   0;	
		m1_pipe3_80 <=   0;
		m2_pipe3_80 <=   0;
		Larger_exp_pipe3_80 <=   0; 
		s1_pipe4_80 <=   0;
		s2_pipe4_80 <=   0;
		e1_pipe4_80 <=   0;
		e2_pipe4_80 <=   0;	
		m1_pipe4_80 <=   0;
		m2_pipe4_80 <=   0;
		Larger_exp_pipe4_80 <=  0; 
		s1_pipe5_80 <=   0;
		s2_pipe5_80 <=   0;
		e1_pipe5_80 <=   0;
		e2_pipe5_80 <=   0;	
		m1_pipe5_80 <=   0;
		m2_pipe5_80 <=   0;
		Larger_exp_pipe5_80 <= 0; 
		//stage3	
		S_exp_mantissa_pipe3_80  <= 0;
	       	L1_mantissa_pipe3_80     <= 0;
		//stage4
		S_mantissa_pipe4_80       <= 0;
		L_mantissa_pipe4_80       <= 0;	
		//stage5	
		Add_mant_pipe5_80 <= 0;
		renorm_shift_pipe5_80 <= 0;
		Result_80 <=0;
            end
	    else begin        
		///////////////////////////////PIPELINE STAGES and VARIABLES/////////////////
         	//propogate pipelined variables to next stages
		s1_pipe2_80 <=   s1_80;
		s2_pipe2_80 <=   s2_80;
		e1_pipe2_80 <=   e1_80;
		e2_pipe2_80 <=   e2_80;	
		m1_pipe2_80 <=   m1_80;
		m2_pipe2_80 <=   m2_80;
		Larger_exp_pipe2_80 <=   Larger_exp_80;
		//stage2
		Small_exp_mantissa_pipe2_80 <=   Small_exp_mantissa_80;
	        Large_mantissa_pipe2_80     <=   Large_mantissa_80;
		Num_shift_pipe2_80          <=   Num_shift_80;
		s1_pipe3_80 <=   s1_pipe2_80;
		s2_pipe3_80 <=   s2_pipe2_80;
		e1_pipe3_80 <=   e1_pipe2_80;
		e2_pipe3_80 <=   e2_pipe2_80;	
		m1_pipe3_80 <=   m1_pipe2_80;
		m2_pipe3_80 <=   m2_pipe2_80;
		Larger_exp_pipe3_80 <=   Larger_exp_pipe2_80; 
		s1_pipe4_80 <=   s1_pipe3_80;
		s2_pipe4_80 <=   s2_pipe3_80;
		e1_pipe4_80 <=   e1_pipe3_80;
		e2_pipe4_80 <=   e2_pipe3_80;	
		m1_pipe4_80 <=   m1_pipe3_80;
		m2_pipe4_80 <=   m2_pipe3_80;
		Larger_exp_pipe4_80 <=   Larger_exp_pipe3_80; 
		s1_pipe5_80 <=   s1_pipe4_80;
		s2_pipe5_80 <=   s2_pipe4_80;
		e1_pipe5_80 <=   e1_pipe4_80;
		e2_pipe5_80 <=   e2_pipe4_80;	
		m1_pipe5_80 <=   m1_pipe4_80;
		m2_pipe5_80 <=   m2_pipe4_80;
		Larger_exp_pipe5_80 <=   Larger_exp_pipe4_80; 
		//stage3	
		S_exp_mantissa_pipe3_80  <= S_exp_mantissa_pipe2_80;
	       	L1_mantissa_pipe3_80     <= L1_mantissa_pipe2_80;
		//stage4
		S_mantissa_pipe4_80         <=   S_mantissa_80;
		L_mantissa_pipe4_80         <=   L_mantissa_80;	
		//stage5	
		Add_mant_pipe5_80 <= Add_mant_80;
		renorm_shift_pipe5_80 <= renorm_shift_80;
		//renorm_exp_pipe5_80 <= renorm_exp_80;		
	   end
    end
    
endmodule


module sign_bit(
output wire sign,
input wire[63:0] in1,
input wire[63:0] in2
);
xor(sign,in1[63],in2[63]);
endmodule

//1 bit Full Adder
module full_adder(
input wire clk,
output reg sum1,
output reg cout1,
input wire in1,
input wire in2,
input wire cin
);

wire sum;
wire cout;

wire temp1;
wire temp2;
wire temp3;
xor(sum,in1,in2,cin);
and(temp1,in1,in2);
and(temp2,in1,cin);
and(temp3,in2,cin);
or(cout,temp1,temp2,temp3);

always@(posedge clk)
begin
  sum1<=sum;
  cout1<=cout;
end

endmodule

//11 bit Ripple-carry adder
module ripple_8(
  input wire clk,
output reg[10:0] sum1,
output reg cout1,
input wire[10:0] in1,
input wire[10:0] in2,
input wire cin
);

wire[10:0] sum;
wire cout;

wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10;
full_adder FA1(clk,sum[0],c1,in1[0],in2[0],cin);
full_adder FA2(clk,sum[1],c2,in1[1],in2[1],c1);
full_adder FA3(clk,sum[2],c3,in1[2],in2[2],c2);
full_adder FA4(clk,sum[3],c4,in1[3],in2[3],c3);
full_adder FA5(clk,sum[4],c5,in1[4],in2[4],c4);
full_adder FA6(clk,sum[5],c6,in1[5],in2[5],c5);
full_adder FA7(clk,sum[6],c7,in1[6],in2[6],c6);
full_adder FA8(clk,sum[7],c8,in1[7],in2[7],c7);
full_adder FA9(clk,sum[8],c9,in1[8],in2[8],c8);
full_adder FA10(clk,sum[9],c10,in1[9],in2[9],c9);
full_adder FA11(clk,sum[10],cout,in1[10],in2[10],c10);

always@(posedge clk)
begin
  sum1<=sum;
  cout1<=cout;
end
endmodule

//1 bit subtractor with subtrahend = 1
module full_subtractor_sub1(
  input wire clk,
output reg diff1, //difference
output reg bout1, //borrow out
input wire min, //minuend
input wire bin //borrow in

);
wire diff;
wire bout;

//Here, the subtrahend is always 1. We can implement it as:
xnor(diff,min,bin);
or(bout,~min,bin);

always@(posedge clk)
begin
  diff1<=diff;
  bout1<=bout;
end

endmodule

//1 bit subtractor with subtrahend = 0
module full_subtractor_sub0(
  input wire clk,
output reg diff1, //difference
output reg bout1, //borrow out
input wire min, //minuend
input wire bin //borrow in
);
wire diff;
wire bout;

//Here, the subtrahend is always 0.We can implement it as:
xor(diff,min,bin);
and(bout,~min,bin);

always@(posedge clk)
begin
  diff1<=diff;
  bout1<=bout;
end

endmodule

//12 bit subtractor
module subtractor_9(
  input wire clk,
output reg [11:0] diff1,
output reg bout1,
input wire [11:0] min,
input wire bin
);

wire [11:0] diff;
wire bout;

wire b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11;
full_subtractor_sub1 sub1(clk,diff[0],b1,min[0],bin);
full_subtractor_sub1 sub2(clk,diff[1],b2,min[1],b1);
full_subtractor_sub1 sub3(clk,diff[2],b3,min[2],b2);
full_subtractor_sub1 sub4(clk,diff[3],b4,min[3],b3);
full_subtractor_sub1 sub5(clk,diff[4],b5,min[4],b4);
full_subtractor_sub1 sub6(clk,diff[5],b6,min[5],b5);
full_subtractor_sub1 sub7(clk,diff[6],b7,min[6],b6);
full_subtractor_sub1 sub8(clk,diff[7],b8,min[7],b7);
full_subtractor_sub1 sub9(clk,diff[8],b9,min[8],b8);
full_subtractor_sub1 sub10(clk,diff[9],b10,min[9],b9);
full_subtractor_sub0 sub11(clk,diff[10],b11,min[10],b10); //Two most significand subtrahends are 0 in 001111111111.
full_subtractor_sub0 sub12(clk,diff[11],bout,min[11],b11);

always@(posedge clk)
begin
  diff1<=diff;
  bout1<=bout;
end
endmodule

module block(
  input wire clk,
output reg ppo1, //output partial product term
output reg cout1, //output carry out
output reg mout1, //output multiplicand term
input wire min, //input multiplicand term
input wire ppi, //input partial product term
input wire q, //input multiplier term
input wire cin //input carry in
);

wire ppo;
wire cout;
wire mout;

wire temp;
and(temp,min,q);
full_adder FA(clk,ppo,cout,ppi,temp,cin);
or(mout,min,1'b0);

always@(posedge clk)
begin
  ppo1<=ppo;
  cout1<=cout;
  mout1<=mout; 
  
end

endmodule

module row(
  input wire clk,
output reg[52:0] ppo1,
output reg[52:0] mout1,
output reg sum1,
input wire[52:0] min,
input wire[52:0] ppi,
input wire q
);

wire[52:0] ppo;
wire[52:0] mout;
wire sum;

wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10;
wire c11,c12,c13,c14,c15,c16,c17,c18,c19,c20;
wire c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43;
wire c44,c45,c46,c47,c48,c49,c50,c51,c52;
block b1 (clk,sum,c1,mout[0],min[0],ppi[0],q,1'b0);
block b2 (clk,ppo[0], c2, mout[1], min[1], ppi[1], q, c1);
block b3 (clk,ppo[1], c3, mout[2], min[2], ppi[2], q, c2);
block b4 (clk,ppo[2], c4, mout[3], min[3], ppi[3], q, c3);
block b5 (clk,ppo[3], c5, mout[4], min[4], ppi[4], q, c4);
block b6 (clk,ppo[4], c6, mout[5], min[5], ppi[5], q, c5);
block b7 (clk,ppo[5], c7, mout[6], min[6], ppi[6], q, c6);
block b8 (clk,ppo[6], c8, mout[7], min[7], ppi[7], q, c7);
block b9 (clk,ppo[7], c9, mout[8], min[8], ppi[8], q, c8);
block b10(clk,ppo[8], c10, mout[9], min[9], ppi[9], q, c9);
block b11(clk,ppo[9], c11, mout[10], min[10], ppi[10], q, c10);
block b12(clk,ppo[10], c12, mout[11], min[11], ppi[11], q, c11);
block b13(clk,ppo[11], c13, mout[12], min[12], ppi[12], q, c12);
block b14(clk,ppo[12], c14, mout[13], min[13], ppi[13], q, c13);
block b15(clk,ppo[13], c15, mout[14], min[14], ppi[14], q, c14);
block b16(clk,ppo[14], c16, mout[15], min[15], ppi[15], q, c15);
block b17(clk,ppo[15], c17, mout[16], min[16], ppi[16], q, c16);
block b18(clk,ppo[16], c18, mout[17], min[17], ppi[17], q, c17);
block b19(clk,ppo[17], c19, mout[18], min[18], ppi[18], q, c18);
block b20(clk,ppo[18], c20, mout[19], min[19], ppi[19], q, c19);
block b21(clk,ppo[19], c21, mout[20], min[20], ppi[20], q, c20);
block b22(clk,ppo[20], c22, mout[21], min[21], ppi[21], q, c21);
block b23(clk,ppo[21], c23, mout[22], min[22], ppi[22], q, c22);
block b24(clk,ppo[22], c24, mout[23], min[23], ppi[23], q, c23);
block b25(clk,ppo[23], c25, mout[24], min[24], ppi[24], q, c24);
block b26(clk,ppo[24], c26, mout[25], min[25], ppi[25], q, c25);
block b27(clk,ppo[25], c27, mout[26], min[26], ppi[26], q, c26);
block b28(clk,ppo[26], c28, mout[27], min[27], ppi[27], q, c27);
block b29(clk,ppo[27], c29, mout[28], min[28], ppi[28], q, c28);
block b30(clk,ppo[28], c30, mout[29], min[29], ppi[29], q, c29);
block b31(clk,ppo[29], c31, mout[30], min[30], ppi[30], q, c30);
block b32(clk,ppo[30], c32, mout[31], min[31], ppi[31], q, c31);
block b33(clk,ppo[31], c33, mout[32], min[32], ppi[32], q, c32);
block b34(clk,ppo[32], c34, mout[33], min[33], ppi[33], q, c33);
block b35(clk,ppo[33], c35, mout[34], min[34], ppi[34], q, c34);
block b36(clk,ppo[34], c36, mout[35], min[35], ppi[35], q, c35);
block b37(clk,ppo[35], c37, mout[36], min[36], ppi[36], q, c36);
block b38(clk,ppo[36], c38, mout[37], min[37], ppi[37], q, c37);
block b39(clk,ppo[37], c39, mout[38], min[38], ppi[38], q, c38);
block b40(clk,ppo[38], c40, mout[39], min[39], ppi[39], q, c39);
block b41(clk,ppo[39], c41, mout[40], min[40], ppi[40], q, c40);
block b42(clk,ppo[40], c42, mout[41], min[41], ppi[41], q, c41);
block b43(clk,ppo[41], c43, mout[42], min[42], ppi[42], q, c42);
block b44(clk,ppo[42], c44, mout[43], min[43], ppi[43], q, c43);
block b45(clk,ppo[43], c45, mout[44], min[44], ppi[44], q, c44);
block b46(clk,ppo[44], c46, mout[45], min[45], ppi[45], q, c45);
block b47(clk,ppo[45], c47, mout[46], min[46], ppi[46], q, c46);
block b48(clk,ppo[46], c48, mout[47], min[47], ppi[47], q, c47);
block b49(clk,ppo[47], c49, mout[48], min[48], ppi[48], q, c48);
block b50(clk,ppo[48], c50, mout[49], min[49], ppi[49], q, c49);
block b51(clk,ppo[49], c51, mout[50], min[50], ppi[50], q, c50);
block b52(clk,ppo[50], c52, mout[51], min[51], ppi[51], q, c51);
block b53(clk,ppo[51], ppo[52], mout[52], min[52], ppi[52], q, c52);

always@(posedge clk)
begin
  ppo1<=ppo;
  mout1<=mout;
  sum1<=sum;
end

endmodule
///////////////////////////////////
///////////////////////////////////
///////////////////////////////////
///////////////////////////////////
module product(
  input wire clk,
output reg[105:0] sum1,
input wire[52:0] min,
input wire[52:0]q
);

wire[105:0] sum;

wire [52:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10; //diagonal m
wire [52:0] temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19,temp20;
wire [52:0] temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28,temp29,temp30;
wire [52:0] temp31,temp32,temp33,temp34,temp35,temp36,temp37,temp38,temp39,temp40;
wire [52:0] temp41,temp42,temp43,temp44,temp45,temp46,temp47,temp48,temp49,temp50;
wire [52:0] temp51,temp52,temp53;

wire [52:0] ptemp1,ptemp2,ptemp3,ptemp4,ptemp5,ptemp6,ptemp7,ptemp8,ptemp9,ptemp10;
//vertical p
wire [52:0] ptemp11,ptemp12,ptemp13,ptemp14,ptemp15,ptemp16,ptemp17,ptemp18,ptemp19,ptemp20;
wire [52:0] ptemp21,ptemp22,ptemp23,ptemp24,ptemp25,ptemp26,ptemp27,ptemp28,ptemp29,ptemp30;
wire [52:0] ptemp31,ptemp32,ptemp33,ptemp34,ptemp35,ptemp36,ptemp37,ptemp38,ptemp39,ptemp40;
wire [52:0] ptemp41,ptemp42,ptemp43,ptemp44,ptemp45,ptemp46,ptemp47,ptemp48,ptemp49,ptemp50;
wire [52:0] ptemp51,ptemp52;
row r1 (clk,ptemp1, temp1, sum[0], min, 53'b00000000000000000000000000000000000000000000000000000, q[0]);
row r2 (clk,ptemp2, temp2, sum[1], temp1, ptemp1, q[1]);
row r3 (clk,ptemp3, temp3, sum[2], temp2, ptemp2, q[2]);
row r4 (clk,ptemp4, temp4, sum[3], temp3, ptemp3, q[3]);
row r5 (clk,ptemp5, temp5, sum[4], temp4, ptemp4, q[4]);
row r6 (clk,ptemp6, temp6, sum[5], temp5, ptemp5, q[5]);
row r7 (clk,ptemp7, temp7, sum[6], temp6, ptemp6, q[6]);
row r8 (clk,ptemp8, temp8, sum[7], temp7, ptemp7, q[7]);
row r9 (clk,ptemp9, temp9, sum[8], temp8, ptemp8, q[8]);
row r10(clk,ptemp10, temp10, sum[9], temp9, ptemp9, q[9]);
row r11(clk,ptemp11, temp11, sum[10], temp10, ptemp10, q[10]);
row r12(clk,ptemp12, temp12, sum[11], temp11, ptemp11, q[11]);
row r13(clk,ptemp13, temp13, sum[12], temp12, ptemp12, q[12]);
row r14(clk,ptemp14, temp14, sum[13], temp13, ptemp13, q[13]);
row r15(clk,ptemp15, temp15, sum[14], temp14, ptemp14, q[14]);
row r16(clk,ptemp16, temp16, sum[15], temp15, ptemp15, q[15]);
row r17(clk,ptemp17, temp17, sum[16], temp16, ptemp16, q[16]);
row r18(clk,ptemp18, temp18, sum[17], temp17, ptemp17, q[17]);
row r19(clk,ptemp19, temp19, sum[18], temp18, ptemp18, q[18]);
row r20(clk,ptemp20, temp20, sum[19], temp19, ptemp19, q[19]);
row r21(clk,ptemp21, temp21, sum[20], temp20, ptemp20, q[20]);
row r22(clk,ptemp22, temp22, sum[21], temp21, ptemp21, q[21]);
row r23(clk,ptemp23, temp23, sum[22], temp22, ptemp22, q[22]);
row r24(clk,ptemp24, temp24, sum[23], temp23, ptemp23, q[23]);
row r25(clk,ptemp25, temp25, sum[24], temp24, ptemp24, q[24]);
row r26(clk,ptemp26, temp26, sum[25], temp25, ptemp25, q[25]);
row r27(clk,ptemp27, temp27, sum[26], temp26, ptemp26, q[26]);
row r28(clk,ptemp28, temp28, sum[27], temp27, ptemp27, q[27]);
row r29(clk,ptemp29, temp29, sum[28], temp28, ptemp28, q[28]);
row r30(clk,ptemp30, temp30, sum[29], temp29, ptemp29, q[29]);
row r31(clk,ptemp31, temp31, sum[30], temp30, ptemp30, q[30]);
row r32(clk,ptemp32, temp32, sum[31], temp31, ptemp31, q[31]);
row r33(clk,ptemp33, temp33, sum[32], temp32, ptemp32, q[32]);
row r34(clk,ptemp34, temp34, sum[33], temp33, ptemp33, q[33]);
row r35(clk,ptemp35, temp35, sum[34], temp34, ptemp34, q[34]);
row r36(clk,ptemp36, temp36, sum[35], temp35, ptemp35, q[35]);
row r37(clk,ptemp37, temp37, sum[36], temp36, ptemp36, q[36]);
row r38(clk,ptemp38, temp38, sum[37], temp37, ptemp37, q[37]);
row r39(clk,ptemp39, temp39, sum[38], temp38, ptemp38, q[38]);
row r40(clk,ptemp40, temp40, sum[39], temp39, ptemp39, q[39]);
row r41(clk,ptemp41, temp41, sum[40], temp40, ptemp40, q[40]);
row r42(clk,ptemp42, temp42, sum[41], temp41, ptemp41, q[41]);
row r43(clk,ptemp43, temp43, sum[42], temp42, ptemp42, q[42]);
row r44(clk,ptemp44, temp44, sum[43], temp43, ptemp43, q[43]);
row r45(clk,ptemp45, temp45, sum[44], temp44, ptemp44, q[44]);
row r46(clk,ptemp46, temp46, sum[45], temp45, ptemp45, q[45]);
row r47(clk,ptemp47, temp47, sum[46], temp46, ptemp46, q[46]);
row r48(clk,ptemp48, temp48, sum[47], temp47, ptemp47, q[47]);
row r49(clk,ptemp49, temp49, sum[48], temp48, ptemp48, q[48]);
row r50(clk,ptemp50, temp50, sum[49], temp49, ptemp49, q[49]);
row r51(clk,ptemp51, temp51, sum[50], temp50, ptemp50, q[50]);
row r52(clk,ptemp52, temp52, sum[51], temp51, ptemp51, q[51]);

row r53(clk,sum[105:53], temp53, sum[52], temp52, ptemp52, q[52]);

always@(posedge clk)
begin
  sum1<=sum;
end


endmodule

module normalize(
  input wire clk,
output reg[51:0] adj_mantissa1, //adjusted mantissa (after extracting out required part)
output reg norm_flag1,
input wire[105:0] prdt
); //returns norm =1 if normalization needs to be done.

wire[51:0] adj_mantissa;
wire norm_flag;

and(norm_flag,prdt[105],1'b1); //sel = 1 if leading one is at 47... needs normalization



//if sel = 0, leading zero not at 47... no need of normalization
wire [51:0] results0,results1;
assign results0 = prdt[103:52];
assign results1 = prdt[104:53]; 
assign adj_mantissa = norm_flag?results1:results0;

always@(posedge clk)
begin
  adj_mantissa1<=adj_mantissa;
  norm_flag1<=norm_flag;
end

endmodule

module controlx64(
  input wire clk,
input [63:0] inp1,inp2,
output wire[63:0] out,
output wire underflow,
output wire overflow
);

wire sign;
wire [10:0] exp1;
wire [10:0] exp2;
wire [10:0] exp_out;
wire [10:0] test_exp;
wire [51:0] mant1;
wire [51:0] mant2;
wire [51:0] mant_out;
sign_bit sign_bit1(sign,inp1,inp2);
wire [10:0]temp1;
wire dummy; //to connect unused cout ports of adder wire carry;
wire [11:0] sub_temp1;
reg [11:0] sub_temp;
ripple_8 rip1(clk,temp1,carry,inp1[62:52],inp2[62:52],1'b0);
subtractor_9 sub1(clk,sub_temp1,underflow,{carry,temp1},1'b0);

//if there is a carry out => underflow
always@(*)
if(underflow)
begin 
sub_temp<=11'b00000000001;
end
else
begin 
sub_temp<=sub_temp1;
end

and(overflow,sub_temp[11],1'b1); //if the exponent has more than 8 bits: overflow
//taking product of mantissa:
wire [105:0] prdt;
product p1(clk,prdt,{1'b1,inp1[51:0]},{1'b1,inp2[51:0]});
wire norm_flag;
wire [51:0] adj_mantissa;
normalize norm1(clk,adj_mantissa,norm_flag,prdt);
ripple_8 ripple_norm(clk,test_exp,dummy,sub_temp[10:0],{10'b0,norm_flag},1'b0);
assign out[63] = sign;
assign out[62:52] = test_exp;
assign out[51:0] = adj_mantissa;
endmodule



module comparator64(
  input[63:0] a,
  input clk,
  input reset,
  output comp);
  reg[63:0] neg_b,pos_b;
  reg out_temp;
  wire[63:0] out;
always@(posedge clk)begin
if(reset)begin
  neg_b <= 64'b0011111111110000000000000000000000000000000000000000000000000000; //0.02
  pos_b <= 64'b1011111111110000000000000000000000000000000000000000000000000000; //0.02
end
else begin
end
end
fpadd64 add (reset,a,neg_b,clk,out);
always@(negedge clk)
    begin
      if(a==pos_b)begin
        out_temp <= 1'b1; //1 a>=b
      end
      else if (out[63] == 1'b1)begin
        out_temp <= 1'b0; //0 a<b
       
      end
      else if (out[63] == 1'b0)begin
       out_temp <= 1'b1; //1 a >=b
      end
      end
assign comp = out_temp;
endmodule

module comparator64xx(
  input[63:0] a,
  input clk,
  input reset,
  output comp);
  reg[63:0] neg_b,pos_b;
  reg out_temp;
  wire[63:0] out;
always@(posedge clk)begin
if(reset)begin
  neg_b <= 64'b1011111111010000000000000000000000000000000000000000000000000000; //-0.25
  pos_b <= 64'b0011111111010000000000000000000000000000000000000000000000000000; //0.25
end
else begin
end
end
fpadd64 add (reset,a,neg_b,clk,out);
always@(negedge clk)
    begin
      if(a==pos_b)begin
        out_temp <= 1'b0; //1 a>=b
      end
      else if (out[63] == 1'b1)begin
        out_temp <= 1'b0; //0 a<b
       
      end
      else if (out[63] == 1'b0)begin
       out_temp <= 1'b1; //1 a >=b
      end
      end
assign comp = out_temp;
endmodule

module comparatorNEW(
  input[63:0] a,
  input clk,
  input reset,
  output comp);
  reg[63:0] neg_b,pos_b;
  reg out_temp;
  wire[63:0] out;
always@(posedge clk)begin
if(reset)begin
  neg_b <= 64'b1011111100010011101010010010101000110000010101010011001001100001; //0.25
  pos_b <= 64'b0011111100010011101010010010101000110000010101010011001001100001; //0.25
end
else begin
end
end
fpadd64 add (reset,a,neg_b,clk,out);
always@(negedge clk)
    begin
      if(a==pos_b)begin
        out_temp <= 1'b0; //1 a>=b
      end
      else if (out[63] == 1'b1)begin
        out_temp <= 1'b1; //0 a<b
       
      end
      else if (out[63] == 1'b0)begin
       out_temp <= 1'b0; //1 a >=b
      end
      end
assign comp = out_temp;
endmodule



// Module for w[n]
module SYNC1(
	clkm,clk, reset, enable,clkx,
	 del,
	 Prel,
	 A,
	D,
	 W
	
);

  input clkm,clk, reset, enable,clkx;
	input [63:0] del;
	input [63:0] Prel;
	input [63:0] A;
	input [63:0] D;
	output [63:0] W;
	
	reg [63:0] W;

wire[63:0] a,b,c,d;
wire underflow1,overflow1,underflow2,overflow2,underflow3,overflow3;
reg [63:0] ax,bx,cx;

integer counter;

controlx64 MM2(clkm,D,A,a,underflow1,overflow1);//D*A
controlx64 MM3(clkm,ax,Prel, b,underflow2,overflow2);//Prel*(D*A)
controlx64 MM4(clkm,bx,del,c,underflow3,overflow3);//del*(Prel*(D*A))
fpadd64 AA99(reset,W,cx,clkm,d);//W+(del*(Prel*(D*A)))


always@(posedge clk)

begin
 if (reset) begin
	
	W<= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	counter<=0;
 end 
 else if (enable) begin
	
	

	if(overflow1||underflow1)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ax<=a;end

	if(overflow2||underflow2)
	begin
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	bx<=b;end

	if(overflow3||underflow3)
	begin
	cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	cx<=c;end
	
	 if(counter<990)
	begin 
	  counter<=counter+1;
	  W<=64'b0011110011010010000000111010111110011110111001110101011000010101;
	  end
	else
	  begin
	   W <= d;
	   end
 end	
end

endmodule

// Module for D[n]
module Neuro(
	 clkm,clk1, reset, enable,clkx,td,
	C0,
	C1,
	D
);
  input clkm,clk1, reset, enable,clkx,td;
	input [63:0] C0;
	input [63:0] C1;
	output [63:0] D;
	
	reg [63:0] D;


reg [63:0] S,ax,bx,D1,D11;
reg [63:0] const1,const0_1;
wire [63:0] a,b,c,d;	

wire underflow1,overflow1,underflow2,overflow2;

controlx64 MM6(clkm,C0,D, a,underflow1,overflow1);//C0*D
controlx64 MM7(clkm,S,C1, b,underflow2,overflow2);//S*C1
fpadd64 AA2(reset,ax,bx,clkm,c); //a+b

fpadd64 ADD1(reset,S,const0_1,clkm,d);


always@(posedge clk1)
begin
 if (reset) begin
	D<= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	D1<= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	D11<= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
  const1<=64'b0011111111110000000000000000000000000000000000000000000000000000;
  const0_1<=64'b0011111110111001100110011001100110011001100110011001100110011001;
  
 end 
 else if (enable) begin
	begin
		
	        if(td)
	        	begin
	        		 S<=d;
	        	end
		else
			begin
	        		 S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	        	end
		
	end
	if(overflow1||underflow1)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ax<=a;end

	if(overflow2||underflow2)
	begin
  bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	bx<=b;end
  
  D <= c;
 end
end

endmodule



// Module for RMtr[n]
module RMtrace_ar(
	clkm,clkb, reset, enable,clkx,
	C0,
	 RM1,
	 RMtr
);

  input clkm,clkb;
  input reset;
  input enable;
  input clkx;
	input [63:0] C0;
	input [63:0] RM1;
	output [63:0] RMtr;
	
	reg [63:0] RMtr;


wire [63:0] a,b,c;
wire underflow1,overflow1,underflow2,overflow2;
reg [63:0] ax,cx;
reg [63:0] C1;
controlx64 MM1(clkm,C0,RMtr, a,underflow1,overflow1);//C0*RMtr
controlx64 MMMM1(clkm,C1,RM1, c,underflow2,overflow2);//C1*RM

fpadd64 AA1(reset,ax,cx,clkm,b);//a+c



always@(posedge clkb)
begin
 if (reset) begin
	
	RMtr<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	C1<=64'b0011111101010000011000100100110111010010111100011010100111111011;//0.001
 end 
 else if (enable) begin

	if(overflow1||underflow1)
	begin
   ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 ax<=a;end

	if(overflow2||underflow2)
	begin
	 cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 cx<=c;end

	 RMtr <= b;//RMtr=(C0*RMtr)+(C1*RM)
 end
end
endmodule

// Module for k[n]
module K(
	clkm,clk, reset, enable,clkx,tp,
    C0,
    K,
	Sk,ak,counter1,gk,kk,qk,xk
);
input clkm,clk;
input reset;
input enable;
input clkx;
input tp;
input [63:0] C0;
output [63:0] K, Sk, ak, counter1, gk,kk,qk,xk;	
integer counter;

wire [63:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z;
wire [63:0] Sk, ak, counter1, gk,kk,qk,xk;
reg  [63:0] K;
wire underflow1,overflow1,underflow2,overflow2,underflow3,overflow3,underflow4,overflow4,underflow5,overflow5,underflow6,overflow6,underflow7,overflow7,underflow8,overflow8,underflow9,overflow9,underflow10,overflow10,underflow11,overflow11,underflow12,overflow12,underflow13,overflow13;


reg [63:0] const1;
reg [63:0] const2;
reg [63:0] const0_5;
reg [63:0] consta;
reg [63:0] const16;
reg [63:0] const6;
reg [63:0] const6m;
reg [63:0] constb;
reg [63:0] const256;
reg [63:0] const114m;
reg [63:0] const18;
reg [63:0] const1m;
reg [63:0] constc;

reg [63:0] S,ax,bx,ex,fx,hx,kx,lx,mx,qx,rx,sx,tx,xx,gx;
wire [63:0] b1;
//reg [31:0] tt=32'b00100010000000000000000000000001;

assign Sk=S;
assign ak=ax;
assign counter1=counter;
assign gk=g;
assign kk=kx;
assign qk=qx;
assign xk=xx;
	
controlx64 MM8(clkm,C0,S, a, underflow1,overflow1);//C0*S      {x}
controlx64 MM9(clkm,ax,ax,b, underflow2,overflow2);//x2
controlx64 MMN1(clkm,bx,ax,e,underflow3,overflow3 );//x3

controlx64 MMN2(clkm,ex,const0_5,f,underflow4,overflow4 );//(x3)/2
controlx64 MMN3(clkm,ax,const2,h,underflow5,overflow5);//2x

fpadd64 SS1(reset,ax,b1,clkx,c);//x-x2
fpadd64 ADDN1(reset,c,fx,clkx,g);//F(x)1


fpadd64 ADDN2(reset,const1,c,clkx,i);//1+x-x2
fpadd64 ADDN9(reset,i,ax,clkx,j);//1+2x-x2
controlx64 MMN4(clkm,j,consta,k, underflow6,overflow6);//F(x)2


controlx64 MMN5(clkm,ax,const6,l,underflow7,overflow7 );//6x
controlx64 MMN6(clkm,bx,const6m,m,underflow8,overflow8 );//-6x2
fpadd64 ADDN3(reset,const16,lx,clkx,n);//16+6x
fpadd64 ADDN4(reset,n,m,clkx,o);//16+6x-6x2
fpadd64 ADDN5(reset,o,ex,clkx,p);//16+6x-6x2+x3
controlx64 MMN7(clkm,p,constb,q,underflow9,overflow9 );//F(x)3

controlx64 MMN8(clkm,ax,const114m,r, underflow10,overflow10);//-114x
controlx64 MMN9(clkm,bx,const18,s,underflow11,overflow11);//18x2
controlx64 MMN10(clkm,ex,const1m,t,underflow12,overflow12 );//-x3
fpadd64 ADDN6(reset,const256,rx,clkx,u);//256-114x
fpadd64 ADDN7(reset,u,sx,clkx,v);//256-114x+18x2
fpadd64 ADDN8(reset,v,tx,clkx,w);//256-114x+18x2-x3
controlx64 MMN11(clkm,w,constc,x, underflow13,overflow13);//F(x)4

fpadd64 ADD3(reset,S,const1,clkx,d);

assign b1={~bx[63],bx[62:0]};

always@(posedge clk)
begin	
	
	 

	

 if (reset) begin
	 K<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 ex<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 fx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 hx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 kx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 lx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 mx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 qx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 rx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 sx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 tx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 xx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	gx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	counter<=0;
	 const1<=64'b0011111111110000000000000000000000000000000000000000000000000000;
 const2<=64'b0100000000000000000000000000000000000000000000000000000000000000;
 const0_5<=64'b0011111111100000000000000000000000000000000000000000000000000000;
 consta<=64'b0011111111000111100010110101011000100000000000000000000000000000;
 const16<=64'b0100000000110000000000000000000000000000000000000000000000000000;
 const6<=64'b0100000000011000000000000000000000000000000000000000000000000000;
 const6m<=64'b1100000000011000000000000000000000000000000000000000000000000000;
 constb<=64'b0011111110010111000110001110001110000000000000000000000000000000;
 const256<=64'b0100000001110000000000000000000000000000000000000000000000000000;
const114m<=64'b1100000001011100100000000000000000000000000000000000000000000000;
const18<=64'b0100000000110010000000000000000000000000000000000000000000000000;
 const1m<=64'b1011111111110000000000000000000000000000000000000000000000000000;
 constc<=64'b0011111101101001000000011100011110011111111111111111111111111111;

 end 
 else if(enable) begin
	

	if(tp)
	begin
	 S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 counter<=0;
	end

	else
	begin
	 S<=d;
	 counter<=counter+1;
	end

	if(overflow1||underflow1)
	begin
	 ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 ax<=a;end

	if(overflow2||underflow2)
	begin
	 bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 bx<=b;end

	if(overflow3||underflow3)
	begin
	 ex<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 ex<=e;end

	if(overflow4||underflow4)
	begin
	 fx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 fx<=f;end

	if(overflow5||underflow5)
	begin
	 hx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 hx<=h;end

	if(overflow6||underflow6)
	begin
	 kx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 kx<=k;end

	if(overflow7||underflow7)
	begin
	 lx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 lx<=l;end

	if(overflow8||underflow8)
	begin
	mx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 mx<=m;end

	if(overflow9||underflow9)
	begin
	qx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	qx<=q;end

	if(overflow10||underflow10)
	begin
	rx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	rx<=r;end

	if(overflow11||underflow11)
	begin
	sx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	sx<=s;end

	if(overflow12||underflow12)
	begin
	tx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	tx<=t;end

	if(overflow13||underflow13)
	begin
	 xx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 xx<=x;end


//change limit
		
	if(counter>=3&&counter<=5)
		begin
		 K<=g;
		end	
	else if(counter>=6&&counter<=13)
		begin
		 K<=kx;
		end
	else if(counter>=14&&counter<=26)
		begin
		 K<=qx;
		end
	else if(counter>=27&&counter<=63)
		begin
		 K<=xx;
		end
	else 
		begin
		  K<=64'b0011110000111111111111111111101111001100001111001011111010100000;
		end
	end
end
endmodule

// Module for S[n]
module S(
	clkm,clk, reset, enable,clkx,tp,
    C0,Isyn,
    SS
    );
input clkm,clk;
input reset;
input enable;
input clkx;
input tp;
input [63:0] C0;
input [63:0] Isyn;
output [63:0] SS;	
integer counter;

reg [63:0] SS;
wire [63:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z;
reg  [63:0] K;

wire underflow1,overflow1,underflow2,overflow2,underflow3,overflow3,underflow4,overflow4,underflow5,overflow5,underflow6,overflow6,underflow7,overflow7,underflow8,overflow8,underflow9,overflow9,underflow10,overflow10,underflow11,overflow11,underflow12,overflow12,underflow13,overflow13,underflow14,overflow14;


reg [63:0] const1;
reg [63:0] const2;
reg [63:0] const0_5;
reg [63:0] consta;
reg [63:0] const16;
reg [63:0] const6;
reg [63:0] const6m;
reg [63:0] constb;
reg [63:0] const256;
reg [63:0] const114m;
reg [63:0] const18;
reg [63:0] const1m;
reg [63:0] constc;
reg [63:0] Is;

reg [63:0] S,ax,bx,ex,fx,hx,kx,lx,mx,qx,rx,sx,tx,xx,gx,zx;
wire [63:0] b1;
//reg [31:0] tt=32'b00100010000000000000000000000001;

	
controlx64 MM8(clkm,C0,S, a, underflow1,overflow1);//C0*S      {x}
controlx64 MM9(clkm,ax,ax,b, underflow2,overflow2);//x2
controlx64 MMN1(clkm,bx,ax,e,underflow3,overflow3 );//x3

controlx64 MMN2(clkm,ex,const0_5,f,underflow4,overflow4 );//(x3)/2
controlx64 MMN3(clkm,ax,const2,h,underflow5,overflow5);//2x

fpadd64 SS1(reset,ax,b1,clkx,c);//x-x2
fpadd64 ADDN1(reset,c,fx,clkx,g);//F(x)1


fpadd64 ADDN2(reset,const1,c,clkx,i);//1+x-x2
fpadd64 ADDN9(reset,i,ax,clkx,j);//1+2x-x2
controlx64 MMN4(clkm,j,consta,k, underflow6,overflow6);//F(x)2


controlx64 MMN5(clkm,ax,const6,l,underflow7,overflow7 );//6x
controlx64 MMN6(clkm,bx,const6m,m,underflow8,overflow8 );//-6x2
fpadd64 ADDN3(reset,const16,lx,clkx,n);//16+6x
fpadd64 ADDN4(reset,n,m,clkx,o);//16+6x-6x2
fpadd64 ADDN5(reset,o,ex,clkx,p);//16+6x-6x2+x3
controlx64 MMN7(clkm,p,constb,q,underflow9,overflow9 );//F(x)3

controlx64 MMN8(clkm,ax,const114m,r, underflow10,overflow10);//-114x
controlx64 MMN9(clkm,bx,const18,s,underflow11,overflow11);//18x2
controlx64 MMN10(clkm,ex,const1m,t,underflow12,overflow12 );//-x3
fpadd64 ADDN6(reset,const256,rx,clkx,u);//256-114x
fpadd64 ADDN7(reset,u,sx,clkx,v);//256-114x+18x2
fpadd64 ADDN8(reset,v,tx,clkx,w);//256-114x+18x2-x3
controlx64 MMN11(clkm,w,constc,x, underflow13,overflow13);//F(x)4

fpadd64 ADD3(reset,S,const1,clkx,d);


controlx64 MASMN11(clkm,Is,K,z, underflow14,overflow14);//F(x)4

assign b1={~bx[63],bx[62:0]};

always@(posedge clk)
begin	
	
	 

	

 if (reset) begin
	 K<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 SS<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 ex<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 fx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 hx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 kx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 lx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 mx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 qx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 rx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 sx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 tx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 xx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	gx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	zx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	Is<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	counter<=0;
	 const1<=64'b0011111111110000000000000000000000000000000000000000000000000000;
 const2<=64'b0100000000000000000000000000000000000000000000000000000000000000;
 const0_5<=64'b0011111111100000000000000000000000000000000000000000000000000000;
 consta<=64'b0011111111000111100010110101011000100000000000000000000000000000;
 const16<=64'b0100000000110000000000000000000000000000000000000000000000000000;
 const6<=64'b0100000000011000000000000000000000000000000000000000000000000000;
 const6m<=64'b1100000000011000000000000000000000000000000000000000000000000000;
 constb<=64'b0011111110010111000110001110001110000000000000000000000000000000;
 const256<=64'b0100000001110000000000000000000000000000000000000000000000000000;
const114m<=64'b1100000001011100100000000000000000000000000000000000000000000000;
const18<=64'b0100000000110010000000000000000000000000000000000000000000000000;
 const1m<=64'b1011111111110000000000000000000000000000000000000000000000000000;
 constc<=64'b0011111101101001000000011100011110011111111111111111111111111111;

 end 
 else if(enable) begin
	

	if(tp)
	begin
	 S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 counter<=0;
	 Is<=Isyn;
	end

	else
	begin
	 S<=d;
	 counter<=counter+1;
	end

	if(overflow1||underflow1)
	begin
	 ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 ax<=a;end

	if(overflow2||underflow2)
	begin
	 bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 bx<=b;end

	if(overflow3||underflow3)
	begin
	 ex<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 ex<=e;end

	if(overflow4||underflow4)
	begin
	 fx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 fx<=f;end

	if(overflow5||underflow5)
	begin
	 hx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 hx<=h;end

	if(overflow6||underflow6)
	begin
	 kx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 kx<=k;end

	if(overflow7||underflow7)
	begin
	 lx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 lx<=l;end

	if(overflow8||underflow8)
	begin
	mx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 mx<=m;end

	if(overflow9||underflow9)
	begin
	qx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	qx<=q;end

	if(overflow10||underflow10)
	begin
	rx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	rx<=r;end

	if(overflow11||underflow11)
	begin
	sx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	sx<=s;end

	if(overflow12||underflow12)
	begin
	tx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	tx<=t;end

	if(overflow13||underflow13)
	begin
	 xx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 xx<=x;end
	 
	 if(overflow14||underflow14)
	begin
	 zx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 zx<=z;end


  

//change limit
		
	if(counter>=3&&counter<=5)
		begin
		 K<=g;
		end	
	else if(counter>=6&&counter<=13)
		begin
		 K<=kx;
		end
	else if(counter>=14&&counter<=26)
		begin
		 K<=qx;
		end
	else if(counter>=27&&counter<=63)
		begin
		 K<=xx;
		end
	else 
		begin
		  K<=64'b0011110000111111111111111111101111001100001111001011111010100000;
		end
		
		SS<=zx;
	end
end
endmodule

// Module for Isyn[n]
module SYNC2(
	 clkm,clk, reset, enable,clkx,
	 W,
	 Xn,
	 tp,
	 Isyn,
	 aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q
	
);

  input clkm,clk, reset, enable,clkx;
	input [63:0] W;
	input [63:0] Xn;
	input tp;
	
	output [63:0] Isyn;
	output [63:0] aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;

reg [63:0] Isyn;
wire [63:0] Xn,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;

wire underflow1,overflow1,underflow2,overflow2,underflow3,overflow3,underflow4,overflow4,underflow5,overflow5;
wire [63:0] a,b,c,d,e,f,g,h,i,j,z;
reg [63:0] dx_actual,fx_actual;
reg [63:0] const1;
reg [63:0] k0,S,S1,S11,ax,fx,gx,dx,jx;
reg [63:0] CONST;

fpadd64 AA99(reset,W,k0,clkm,c); //W+k0
controlx64 MM99(clkm,Xn,c,d,underflow2,overflow2);//(W+k0)K

fpadd64 AA98(reset,S,S11,clkm,e); 
controlx64 MM98(clkm,S,CONST,f,underflow3,overflow3);//S*time const
controlx64 MM97(clkm,fx,dx,g,underflow4,overflow4);//Isyn


fpadd64 ADD2(reset,S,const1,clkm,h);
fpadd64 ADD8(reset,S1,const1,clkm,i);

//fpadd ADD811(SS,gx,clkx,z);


assign aq=ax;
assign bq=b;
assign cq=c;
assign dq=dx;
assign eq=e;
assign fq=fx;
assign gq=gx;
assign hq=h;
assign iq=i;
assign Sq=S;
assign S1q=S1;
assign S11q=S11;
assign k0q=k0;

/*always@(posedge tp)
begin
 if(reset) begin
	S1=32'b00101011100011001011110011001100;
 end
 else if(enable) begin
	S1=i;
 end
end
*/

always@(posedge clk)
begin
	

 if (reset) begin
	Isyn<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	k0<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	dx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	fx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	gx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	jx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	dx_actual<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	fx_actual<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	const1<=64'b0011111111110000000000000000000000000000000000000000000000000000;
	CONST<=64'b0011111101010000011000100100110111010010111100011010100111111011;
 end 
 else if (enable) begin	

	if(overflow1|underflow1)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ax<=a;end
	
	if(overflow2|underflow2)
	begin
	dx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	dx<=d;end

	if(overflow3|underflow3)
	begin
	fx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	fx<=f;
	end
	
	if(overflow4|underflow4)
	begin
	gx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	gx<=g;end

	if(overflow5|underflow5)
	begin
	jx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	jx<=j;end

	begin
			if(tp)
				begin
				S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
				k0<=Isyn;
				begin
				Isyn<=gx;
				end
				end
			else
				begin
				Isyn<=gx;
				k0<=k0;
				S<=h;
				end
			
		end
 end
end
endmodule

// Module for A[n]
module ActSpike(
	clkm,clkb, reset, enable,clkx,
	 C0,
	 del,
	 in1,in2,in3,
	tp,
	 out,
	 A1
);

  input clkm,clkb, reset, enable,clkx;
	input [63:0] C0;
	input [63:0] del;
	input [63:0] in1,in2,in3;
	input tp;
	output  [63:0] out;
	output  [63:0] A1;
	
	reg [63:0] A1;
	reg[63:0] out;

wire overflow1,overflow2,underflow1,underflow2,underflow3,overflow3;
reg [1:0]sel;
reg [63:0] S,f,g,ax,AA;
reg [63:0] const1,const0_1;
reg [63:0] consta;
wire[63:0] a,b,c,d,e;
wire h1;
reg h;



//comparator1 CCCN(C,consta,clkx,h1);//checking if a>b

controlx64 MM11(clkm,C0,AA,a,underflow3,overflow3);//C0*A
controlx64 MM12(clkm,out,S,b,underflow1,overflow1);//capital_del*S
controlx64 MM13(clkm,f,del,c,underflow2,overflow2);//b*del
fpadd64 AA3(reset,ax,g,clkm,d);//a+c 

fpadd64 ADD4(reset,S,const0_1,clkm,e);




always@(posedge clkb)
begin


	begin
		//if(tp&h)
		if(tp)
		sel<=2'b00;
		else //if(tp^h)
		sel<=2'b10;
		//else
		//sel<=2'b01;
	end

		case(sel)
			2'b00: out<=in1;//1
			2'b01: out<=in2;//0
			2'b10: out<=in3;//-1
		  2'b11: out<=in2;//0
		endcase
 if (reset) begin
	
	AA <= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	A1 <= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	f<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	g<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	const1<=64'b0011111111110000000000000000000000000000000000000000000000000000;
	consta<=64'b0011111011001111101110111110111000011111111111111111111111111111;
	h<=1'b1;
	const0_1<=64'b0011111110111001100110011001100110011001100110011001100110011001;
	
 end 
 else if (enable) begin
	
		
		 begin
			if(tp)
				begin
					 S<=e;
				end
			else
				begin
					 S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
				end
		 end
	

	if(overflow1||underflow1)
	begin
	 f<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 f<=b;end
	
	if(overflow2||underflow2)
	begin
	g<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	g<=c;end
	
	if(overflow3||underflow3)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
  	ax<=a;end

	AA<=d;
	
	if(AA[63]==1)
	begin
	A1<={~AA[63],AA[62:0]};
	end

	else
	begin
	A1<=AA;
	end
 end
end
endmodule

// Module for Prel[n]
module Prel(
	clkm,clk, reset, enable,clkx,clkxy,
	 Inh1,
  Prel,
	aq,bq,cq,dq,eq,iq,jq,kq,mq,nq,n1q,pq,qq,uq,u1q,vq,Pxy
);

  input clkm,clk, reset, enable,clkx,clkxy;
	input [63:0] Inh1;
	output [63:0] Prel;
	output [63:0] aq,bq,cq,dq,eq,iq,jq,kq,mq,nq,n1q,pq,qq,uq,u1q,vq,Pxy;
	
	reg [63:0] Prel;
	wire [63:0] aq,bq,cq,dq,eq,iq,jq,kq,mq,nq,n1q,pq,qq,uq,u1q,vq,Pxy;
	

reg [63:0] xn;
reg [63:0] y;
reg [63:0] C0;
//reg [31:0] const6 = 32'b01000000110000000000000000000000;
//reg [31:0] const4 = 32'b01000000100000000000000000000000 ;
reg [63:0] const1 ;
reg [63:0] constm1;
//reg[ 31:0] const10=32'b01000100011110100000000000000000;
reg[ 63:0] const10;
reg [63:0] const025;
reg [63:0] const1001;
reg [63:0] constm011;
reg [63:0] constm001;
reg [63:0] conste8;
reg [63:0] conste16;
reg [63:0] constm_00001;
reg [63:0] constm_00007;
reg [63:0] const1_1;
reg [63:0] const1000;
//reg [31:0] constm001=32'b10111010100000110001001001101110;

wire [63:0] u1;

wire [63:0] a,b,c,d,e,i,j,k,m,n,p,q,r,u,v,w,o,z,con1,con2,o1,Inh,k1;
wire overflow1,overflow2,underflow1,underflow2,underflow3,overflow3,overflow4,overflow5,underflow4,underflow5,underflow6,overflow6,underflow7,overflow7,underflow8,overflow8,underflow9,overflow9;
reg [63:0] ax,bx,cx,dx,ex,px,kx,m1,n1,ox,zx,nx,kkx;
//reg [31:0] const0=32'b00101011100011001011110011001100;
wire compare;
assign aq=px;
assign bq=bx;
assign cq=cx;
assign dq=dx;
assign eq=ex;
assign iq=i;
assign jq=j;
assign kq=kx;
assign mq=m;
assign nq=n;
assign n1q=n1;
assign pq=px;
assign qq=q;
assign uq=u;
assign u1q=u1;
assign vq=v;
assign Pxy=n;


fpadd64 AddInh(reset,Inh1,constm_00001,clkm,Inh);//Inh

controlx64 MM17xx(clkm,const1000,Inh,a,underflow1,overflow1);
controlx64 MM18xx(clkm,k1,const1000,k,underflow2,overflow2);
//controlx MM20xx(clkm,bx,i,c,underflow3,overflow3);//((10*Inh)-1)^3//

//fpadd AA5xx(constm1,ax,clkm,i);//(10*Inh)-1;//
//fpadd AA6xx(const1,bx,clkm,j);//1+square//
//fpadd AA7xx(i,cx,clkm,u);//linear+cubic//

//fpadd SS3xx(j,u1,clkm,v);//xn/10//

//controlx MM77xx(clkm,const10,v,k,underflow6,overflow6);//xn//


//controlx MM22xx(clkm,kx,dx,e,underflow5,overflow5);//x3

//controlx MM21xsssx(clkm,dx,conste8,o,underflow4,overflow4);//x2				xx
//controlx MM22xsssx(clkm,ex,conste16,z,underflow5,overflow5);//x3				xx

controlx64 MM21xx(clkm,kkx,constm_00007,d,underflow4,overflow4);
fpadd64 AA444xx(reset,dx,const1_1,clkm,n);//       {Pinh}

//fpadd AA445xx(o1,m,clkx,n);

fpadd64 SS99xx(reset,const1,n1,clkm,q);//1-Pinh

wire res1,res2,res3;

Division64 DUT(clkm,const1,ax,Exception,k1);

controlx64 D1xx(clkm,q,const025,p,underflow7,overflow7);//0.25(1-Pinh)

comparator64 VFFytF(px,clkm,reset,res1);
comparator64xx VGFHG(Prel,clkm,reset,res2);
comparatorNEW SDF(Inh1,clkm,reset,res3);
//comparator2 VDG2(Inh,clkm,reset,res2,con2);

	assign u1={~u[63],u[62:0]};
	assign o1={~ox[63],ox[62:0]};
	assign compare=res1&&px[63];



always@(posedge clkx)
begin  
  
  
  
	  if(n[63]==1'b0)
	begin
	  n1<={~n[63],n[62:0]};
	end
 	 else if (n[63]==1'b1)
	begin
	 n1<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	
	if(res3)
    begin
    Prel<=64'b0011111111010000000000000000000000000000000000000000000000000000;
    end
    
	else if(res1&&px[63])
    begin
    Prel<=64'b0011111100011010001101101110001011101011000111000100001100101100;
    end
  else if(res2)
    begin
    Prel<=64'b0011111100011010001101101110001011101011000111000100001100101100;
    end
  else if(px[63]==1'b1)
   begin
    Prel<=64'b0011111111010000000000000000000000000000000000000000000000000000;
    end
  else
    begin
    Prel<=px;
  end
  
end



always@(posedge clk)
begin
 if (reset) begin
Prel<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	xn<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	y<= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	dx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	ex<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	px<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	ox<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	zx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	nx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
kkx<= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	C0 <=    64'b0011111111110000000000000000000000000000000000000000000000000000;
  const1<= 64'b0011111111110000000000000000000000000000000000000000000000000000;
  constm1<= 64'b1011111111110000000000000000000000000000000000000000000000000000;
	const025 <= 64'b0011111111010000000000000000000000000000000000000000000000000000;
  const1001<=64'b0011111111110000000001000001100010010011011101001011110001101010;
  constm011<=64'b1011111110000110100001110010101100000010000011000100100110111010;
  constm001<=64'b1011111101010000011000100100110111010010111100011010100111111011;
  conste8<=64'b0011111001000101011110011000111011100010001100001000110000111001;
  conste16<=64'b0011110010011100110100101011001010010111110110001000100110111100;
  constm_00001<=64'b1011111011100100111110001011010110001000111000110110100011110000;
  constm_00007<=64'b1011111100010010010110011001111011010111110001101111101111010010;
  const1_1<=64'b0011111111110001100110011001100110011001100110011001100110011001;
  const1000<=64'b0100000010001111010000000000000000000000000000000000000000000000;
	
 end 
 
 else if (enable) begin
	if(overflow1||underflow1)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ax<=a;end
	
	if(overflow2||underflow2)
	begin
	kkx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	kkx<=k;end
	
	if(overflow3||underflow3)
	begin
	cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	cx<=c;end

	if(overflow4||underflow4)
	begin
	dx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	dx<=d;end
	
	if(overflow5||underflow5)
	begin
	ex<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ex<=e;end

	if(Exception)
	begin
	kx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	kx<=k;end
	

	if(overflow7||underflow7)
	begin
	px<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	px<=p;end

	if(overflow8||underflow8)
	begin
	ox<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ox<=o;end
	

	if(overflow9||underflow9)
	begin
	 zx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	 zx<=z;end
	 
	 

  end
end
endmodule



// Module for Inh[n]
module Inh(
	clkm,clk, reset, enable,clkx,
	C0,
	C1,
	 RMtr,
	A,
	Inh,
	aq,bq,cq,dq,eq,fq,gq
);

  input clkm,clk, reset, enable,clkx;
	input [63:0] C0;
	input [63:0]C1;
	input [63:0] RMtr;
	input [63:0] A;
	output[63:0] Inh;
	output [63:0] aq,bq,cq,dq,eq,fq,gq;

wire[63:0] aq,bq,cq,dq,eq,fq,gq;
reg [63:0] Inh;

wire [63:0] a,b,c,d;
reg [63:0] ax,bx,cx;
wire underflow1,overflow1,underflow2,overflow2,underflow3,overflow3;

controlx64 MM14(clkm,RMtr,A,a,underflow1,overflow1);//RMtr*A
controlx64 MM15(clkm,ax,C1,b,underflow2,overflow2);//del*(RMtr*A)
controlx64 MM16(clkm,C0,Inh,c,underflow3,overflow3);//C0*Inh
fpadd64 AA4(reset,bx,cx,clkm,d);//b+c

assign aq=ax;
assign bq=bx;
assign cq=cx;
assign dq=d;
assign eq=a;
assign fq=b;
assign gq=c;

always@(posedge clk)

begin
 if (reset) begin
	Inh <= 64'b0011111011100100111110001011010110001000111000110110100011110000;
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
 end 
 else if (enable) begin
	if(overflow1||underflow1)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ax<=a;end
	
	if(overflow2||underflow2)
	begin
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	bx<=b;end

	if(overflow3||underflow3)
	begin
	cx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	cx<=c;end

	Inh<=d;

 end
end
endmodule

// Module for Y[n]
module Y(
	clkm,clk, reset, enable,clkx,
	tp,Yn,Sy
);

  input clkm,clk, reset, enable,clkx,tp;
  output[63:0] Yn,Sy;
	

reg [63:0] Yn;

reg[63:0] const0_9,const1,consty,const0_1;
wire [63:0] a,b,c,d;
reg [63:0] ax,bx,S;
wire underflow1,overflow1,underflow2,overflow2,underflow3,overflow3;

controlx64 YY14(clkm,const0_9,Yn,a,underflow1,overflow1);//0.9*Y
//fpadd64 YYYY1(S,const0_1,clkx,d);//S+1
controlx64 YY15(clkm,S,consty,b,underflow2,overflow2);//1.397*delta


fpadd64 YYYY3(reset,bx,ax,clkm,c);

assign Sy=S;

always@(posedge clk)

begin
 if (reset) begin
	Yn <= 64'b0011111111110000000000000000000000000000000000000000000000000000;
	const0_9<=64'b0011111111101111101011100001010001111010111000010100011110101110;//0.99
	const1<=64'b0011111111110000000000000000000000000000000000000000000000000000;
	S<= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
  bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
  consty<=64'b0011111111110000000000000000000000000000000000000000000000000000;
  const0_1<=64'b0011111110111001100110011001100110011001100110011001100110011001;
 end 
 
 else if (enable) begin
   
   if(tp)
	begin
	 	 S<=const0_1;
	end

	else
	begin
	 S<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	 //S<=S;
	 
	 
	end
  
   
	if(overflow1||underflow1)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ax<=a;end
	
	if(overflow2||underflow2)
	begin
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	bx<=b;end
	
	
	Yn<=c;

 end
end
endmodule

// Module for X[n]
module X(
	clkm,clk, reset, enable,clkx,
	tp,Yn,Xn,axx,bxx,cxx
);

  input clkm,clk, reset, enable,clkx,tp;
  input[63:0] Yn;
  output [63:0] Xn,axx,bxx,cxx;
	

reg [63:0] Xn;

reg[63:0] const0_9,const0_1;
wire [63:0] a,b,c;
reg [63:0] ax,bx;
wire underflow1,overflow1,underflow2,overflow2,underflow3,overflow3;

controlx64 XX14(clkm,const0_9,Xn,a,underflow1,overflow1);
controlx64 XX15(clkm,const0_1,Yn,b,underflow2,overflow2);
fpadd64 XRREEX4(reset,bx,ax,clkm,c);

assign axx=ax;
assign bxx=bx;
assign cxx=c;

always@(posedge clk)

begin
 if (reset) begin
	Xn <= 64'b0011110000111111111111111111101111001100001111001011111010100000;
	const0_9<=64'b0011111111101111101011100001010001111010111000010100011110101110;//0.99
	const0_1<=64'b0011111110000100011110101110000101000111101011100001010001111010;//0.01
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
 end 
 
 else if (enable) begin
   
	if(overflow1||underflow1)
	begin
	ax<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	ax<=a;end
	
	
	if(overflow2||underflow2)
	begin
	bx<=64'b0011110000111111111111111111101111001100001111001011111010100000;
	end
	else begin
	bx<=b;end
	
	
	Xn<=c;

 end
end
endmodule





module PreSynapse(input clkm,clkxy,clkb, reset1, enable1,clkx1,
	input tp1,
	
	input clkd, reset2, enable2,clkx2,

	
	
	input clkc, reset3, enable3,clkx3,
	input [63:0] RM1,

	input clka, reset4, enable4,clkx4,td4,


	input clkp, reset6, enable6,clkxp,

	input clk5, reset5, enable5,clkx5,
	
	

	input clk8, reset8, enable8,clkx7,
	

	input clks, reset7, enable7,clkx8,tp2,
	output [63:0] Isyn7,WWx,Ax,Dx,RMtrx,KKx,Prelx,Inhx,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,ax,bx,cx,dx,ex,fx,gx,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq, Sk,ak,counter1,gk,Pxy,kk,qk,xk,SS,Xn,Yn,axx,bxx,cxx,Sy
);
wire [63:0] out1;



reg [63:0] C01;//
reg [63:0] del1;//
reg[63:0]in1;//1
reg[63:0]in2;//0
reg[63:0]in3;//-1

reg [63:0] C02;//
reg [63:0]C12;//



reg [63:0] C04;//
reg[63:0] C14;//

reg [63:0] del5;//

reg [63:0] C08;//

reg [63:0] C03;//


wire [63:0] ACTtoINHtoSYNC1,RMTtoINH,INHtoPREL,SYNC1toPREL,NEUROtoSYNC1,StoS2,KtoSYNC2;

assign WWx=StoS2;
assign Ax=ACTtoINHtoSYNC1;
assign Dx=NEUROtoSYNC1;
assign RMtrx=RMTtoINH;
assign Prelx=SYNC1toPREL;
assign KKx=KtoSYNC2;
assign Inhx=INHtoPREL;

ActSpike AC1(clkm,clkb,reset1,enable1,clkx1,C01,del1,in1,in2,in3,tp1,out1,ACTtoINHtoSYNC1);
RMtrace_ar RMtr(clkm,clkc,reset3,enable3,clkx3,C03,RM1,RMTtoINH);
Inh inh1(clkm,clkd,reset2,enable2,clkx2,C02,C12,RMTtoINH,ACTtoINHtoSYNC1,INHtoPREL,ax,bx,cx,dx,ex,fx,gx);


Neuro N(clkm,clka,reset4,enable4,clkx4,td4,C04,C14,NEUROtoSYNC1);
Prel p(clkm,clkp,reset6,enable6,clkxp,clkxy,INHtoPREL,SYNC1toPREL,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq,Pxy);


SYNC1 S(clkm,clk5,reset5,enable5,clkx5,del5,SYNC1toPREL,ACTtoINHtoSYNC1,NEUROtoSYNC1,StoS2);

//K K1(clkm,clk8,reset8,enable8,clkx8,tp1,C08,KtoSYNC2, Sk,ak,counter1,gk,kk,qk,xk);
SYNC2 S2(clkm,clks,reset7,enable7,clkx7,StoS2,Xn,tp2,Isyn7,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q);

//S  SAsdd(clkm,clkb, reset8, enable8,clkx8,tp1,C08,Isyn7,SS);

Y Yn1(clkm,clkb,reset8,enable8,clkx8,tp1,Yn,Sy);
X Xn1(clkm,clkb,reset8,enable8,clkx8,tp1,Yn,Xn,axx,bxx,cxx);

always@(posedge clka)begin
if(reset2)begin
  
C01<=64'b0011111111101111101011100001010001111010111000010100011110101110;//0.99
del1<=64'b0011111110000100011110101110000101000111101011100001010001111010;//0.01
in1<=64'b0011111111110000000000000000000000000000000000000000000000000000;//1
in2<=64'b0011110000111111111111111111101111001100001111001011111010100000;//0
in3<=64'b1011111111110000000000000000000000000000000000000000000000000000;//-1

C02<=64'b0011111111101111101011100001010001111010111000010100011110101110;//0.99
C12<=64'b0011111101010000011000100100110111010010111100011010100111111011;//0.001

C04<=64'b0011111111101110011001100110011001100110011001100110011001100110;//0.95
C14<=64'b0011111110101001100110011001100110011001100110011001100110011001;//0.05

del5<=64'b0011111101010000011000100100110111010010111100011010100111111011;//0.001

C08<=64'b0011111110111001100110011001100110011001100110011001100110011001;//

C03<=64'b0011111111101111111010111000010100011110101110000101000111101011;//0.9975

    end
else
    begin
    end
end


endmodule 


module MODEL64(
	input clkm,clks,clkp,clkxp,clka,clkb,clkxy,clk, reset, enable,clkx,
	input tp1,	td4,
	output[63:0] Isyn1,RMx,Cx,WWx,Ax,Dx,RMtrx,KKx,Prelx,Inhx,Sx,Mx,Vpostx1,Wpostx1,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,ax,bx,cx,dx,ex,fx,gx,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq, Sk,ak,counter1,gk,Pxy,kk,qk,xk,SS,Xn,Yn,axx,bxx,cxx,Sy);


reg [63:0] RM;

assign RMx=RM;

PreSynapse PS1(clkm,clkxy,clkb, reset, enable,clkx, tp1,clkb, reset, enable, clkx,clkb, reset, enable,clkx, RMx, clka, reset, enable,clkx,td4,clkp, reset, enable,clkxp,clk, reset, enable,clkx,clk, reset, enable,clkx, clks, reset, enable,clkx,tp1,Isyn1,WWx,Ax,Dx,RMtrx,KKx,Prelx,Inhx,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,ax,bx,cx,dx,ex,fx,gx,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq, Sk,ak,counter1,gk,Pxy,kk,qk,xk,SS,Xn,Yn,axx,bxx,cxx,Sy);


always@(posedge clk)begin
if(reset)begin
RM<=64'b0011111111100110000111001010110000001000001100010010011011101001;
end
else 
  begin
    end

end

endmodule


//(Please add the clock clm=0.1ps and make necessary changes)




//Top level design module with all instances
module top64(
clk_0_1ps,reset,enable,td4,tp1,Isyn1,RMx,Cx,WWx,Ax,Dx,RMtrx,KKx,Prelx,Inhx,Sx,Mx,Vpostx1,Wpostx1,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,ax,bx,cx,dx,ex,fx,gx,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq, Sk,ak,counter1,gk,Pxy,kk,qk,xk,SS,Xn,Yn,axx,bxx,cxx,Sy
);
  //Input declaration
  input clk_0_1ps;
  input reset;
  input enable;
  input td4;
  input tp1;
  //Output declarations
  output [63:0]       Isyn1,RMx,Cx,WWx,Ax,Dx,RMtrx,KKx,Prelx,Inhx,Sx,Mx,Vpostx1,Wpostx1,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,ax,bx,cx,dx,ex,fx,gx,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq, Sk,ak,counter1,gk,Pxy,kk,qk,xk,SS,Xn,Yn,axx,bxx,cxx,Sy;
  //Reg variables
  //reg clk,reset,enable,clkx,td4,tp1,clkxy,clka,clkb,clkp,clkxp,clks; //inputs 
  //reg clk_1ps;
  reg clk,clkxy,clka,clkb,clkp,clkxp,clks; //inputs 
  //wire variables
 wire [63:0] Isyn1,RMx,Cx,WWx,Ax,Dx,RMtrx,KKx,Prelx,Inhx,Sx,Mx,Vpostx1,Wpostx1,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,ax,bx,cx,dx,ex,fx,gx,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq, Sk,ak,counter1,gk,Pxy,kk,qk,xk,SS,X,Y,axx,bxx,cxx,Sy;
  parameter THRESHOLD_FOR_5NS_CLOCK = 50000;//Always should be even//(0.1ps=0.0001ns)*50000=5ns
  parameter THRESHOLD_FOR_2_5NS_CLOCK = 25000;//Always should be even//(0.1ps=0.0001ns)*25000=2.5ns
  parameter THRESHOLD_FOR_0_1NS_CLOCK = 1000;//Always should be even//(0.1ps=0.0001ns)*1000=0.1ns
  //parameter THRESHOLD_FOR_0_1PS_CLOCK = 100;//Always should be even//(1fs=0.0001ns)*100=(0.0001ns=0.1ps)
  MODEL64 SynNeur1(.clkm(clk_0_1ps),.clks(clks),.clkp(clks),.clkxp(clkxp),.clka(clks),.clkb(clks),.clkxy(clkxp),.clk(clk),.reset(reset), .enable(enable),.clkx(clkxp), .tp1(tp1),.td4(td4), .Isyn1(Isyn1),.RMx(RMx),.Cx(Cx),.WWx(WWx),.Ax(Ax),.Dx(Dx),.RMtrx(RMtrx),.KKx(KKx),.Prelx(Prelx),.Inhx(Inhx),.Sx(Sx),.Mx(Mx),.Vpostx1(Vpostx1),.Wpostx1(Wpostx1),.aq(aq),.bq(bq),.cq(cq),.dq(dq),.eq(eq),.fq(fq),.gq(gq),.hq(hq),.iq(iq),.Sq(Sq),.S1q(S1q),.S11q(S11q),.k0q(k0q),.ax(ax),.bx(bx),.cx(cx),.dx(dx),.ex(ex),.fx(fx),.gx(gx),.anq(anq),.bnq(bnq),.cnq(cnq),.dnq(dnq),.enq(enq),.inq(inq),.jnq(jnq),.knq(knq),.mnq(mnq),.nnq(nnq),.n1nq(n1nq),.pnq(pnq),.qnq(qnq),.unq(unq),.u1nq(u1nq),.vnq(vnq),.Sk(Sk),.ak(ak),.counter1(counter1),.gk(gk),.Pxy(Pxy),.kk(kk),.qk(qk),.xk(xk),.SS(SS),.Xn(Xn),.Yn(Yn),.axx(axx),.bxx(bxx),.cxx(cxx),.Sy(Sy)); //instantiate
  ///////////////////////Clocks coming from top level clkgen module./////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
  clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_5NS_CLOCK))
  gen_instance5 (.clk_0_1ps(clk_0_1ps),.clk_out(clk));
  
  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
  //gen_instance2_5a (.clk_0_1ps(clk_0_1ps),.clk_out(clka));
  //
  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
  //gen_instance2_5b (.clk_0_1ps(clk_0_1ps),.clk_out(clkb));
  //
  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
  //gen_instance2_5p (.clk_0_1ps(clk_0_1ps),.clk_out(clkp));
  
  
  clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
  gen_instance2_5s (.clk_0_1ps(clk_0_1ps),.clk_out(clks));
  
  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_0_1NS_CLOCK))
  //gen_instance0_1xy (.clk_0_1ps(clk_0_1ps),.clk_out(clkxy));
  //
  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_0_1NS_CLOCK))
  //gen_instance0_1x (.clk_0_1ps(clk_0_1ps),.clk_out(clkx));
  
  clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_0_1NS_CLOCK))
  gen_instance0_1xp (.clk_0_1ps(clk_0_1ps),.clk_out(clkxp));

  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_0_1PS_CLOCK))
  //gen_instance0_1m (.clk_1fs(clk_1fs),.clk_out(clkm));
endmodule









