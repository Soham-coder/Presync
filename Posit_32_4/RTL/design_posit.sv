// Code your design here
`timescale 1ps / 1fs
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////large sized 29 bit Wallace Multiplier//////////////////////////////////////
///////////////////////Pipelined////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module product(
  input wire clk,
  output reg[57:0] sum1,
  input wire[28:0] min,
  input wire[28:0]q
);

  wire[57:0] sum;

  wire [28:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10; //diagonal m
  wire [28:0] temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19,temp20;
  wire [28:0] temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28,temp29;

  wire [28:0] ptemp1,ptemp2,ptemp3,ptemp4,ptemp5,ptemp6,ptemp7,ptemp8,ptemp9,ptemp10;
//vertical p
  wire [28:0] ptemp11,ptemp12,ptemp13,ptemp14,ptemp15,ptemp16,ptemp17,ptemp18,ptemp19,ptemp20;
  wire [28:0] ptemp21,ptemp22,ptemp23,ptemp24,ptemp25,ptemp26,ptemp27,ptemp28;
row r1 (clk,ptemp1, temp1, sum[0], min, 29'b00000000000000000000000000000, q[0]);
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
row r29(clk,sum[57:29], temp29, sum[28], temp28, ptemp28, q[28]);

always@(posedge clk)
begin
  sum1<=sum;
end


endmodule
module row(
input wire clk,
output reg[28:0] ppo1,
output reg[28:0] mout1,
output reg sum1,
input wire[28:0] min,
input wire[28:0] ppi,
input wire q
);

wire[28:0] ppo;
wire[28:0] mout;
wire sum;

wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10;
wire c11,c12,c13,c14,c15,c16,c17,c18,c19,c20;
wire c21,c22,c23,c24,c25,c26,c27,c28;
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
block b29(clk,ppo[27], ppo[28], mout[28], min[28], ppi[28], q, c28);


always@(posedge clk)
begin
  ppo1<=ppo;
  mout1<=mout;
  sum1<=sum;
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
//////////////////////////////////////////////////////////////
////////////////Below Does Posit<32,4> Multiplication/////////
////////////////Pipelined to 5 stages//////////////////////////
//////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module posit_mult(clk, in1, in2, start, out, inf, zero, done);
/*function [31:0] log2;
input reg [31:0] value;
	begin
    value = value-1;
	for (log2=0; value>0; log2=log2+1)
        	value = value>>1;
      	end
endfunction*/

parameter N = 16;
parameter Bs = $clog2(N); 
parameter es = 3;

input clk;
input [N-1:0] in1, in2;
input start; 
output reg [N-1:0] out;
output reg inf, zero;
output reg done;

wire start0= start;
wire s1 = in1[N-1];
wire s2 = in2[N-1];
wire zero_tmp1 = |in1[N-2:0];
wire zero_tmp2 = |in2[N-2:0];
wire inf1 = in1[N-1] & (~zero_tmp1),
	inf2 = in2[N-1] & (~zero_tmp2);
wire zero1 = ~(in1[N-1] | zero_tmp1),
	zero2 = ~(in2[N-1] | zero_tmp2);
wire inf_t = inf1 | inf2,
	zero_t = zero1 & zero2;

//Data Extraction
wire rc1, rc2;
wire [Bs-1:0] regime1, regime2;
wire [es-1:0] e1, e2;
wire [N-es-1:0] mant1, mant2;
wire [N-1:0] xin1 = s1 ? -in1 : in1;
wire [N-1:0] xin2 = s2 ? -in2 : in2;
  data_extract_N32_ES4_mult #(.N(N),.es(es)) uut_de1(.clk(clk), .in(xin1), .rc(rc1), .regime(regime1), .exp(e1), .mant(mant1));
  data_extract_N32_ES4_mult #(.N(N),.es(es)) uut_de2(.clk(clk), .in(xin2), .rc(rc2), .regime(regime2), .exp(e2), .mant(mant2));

wire [N-es:0] m1 = {zero_tmp1,mant1}, 
	m2 = {zero_tmp2,mant2};

reg start_r00; 
reg s1_r00, s2_r00, inf_r00, zero_r00, rc1_r00, rc2_r00;
reg [Bs-1:0] regime1_r00, regime2_r00;
reg [es-1:0] e1_r00, e2_r00;
reg [N-es:0] m1_r00, m2_r00;
reg start_r0; 
reg s1_r0, s2_r0, inf_r0, zero_r0, rc1_r0, rc2_r0;
reg [Bs-1:0] regime1_r0, regime2_r0;
reg [es-1:0] e1_r0, e2_r0;
reg [N-es:0] m1_r0, m2_r0;
always @(posedge clk) begin
start_r0 <= start0; s1_r0 <= s1; s2_r0 <= s2; 
inf_r0 <= inf_t; zero_r0 <= zero_t; rc1_r0 <= rc1; rc2_r0 <= rc2;
regime1_r0 <= regime1; regime2_r0 <= regime2; 
e1_r0 <= e1; e2_r0 <= e2;
m1_r0 <= m1; m2_r0 <= m2;
end



reg start_r1; 
reg s1_r1, s2_r1, inf_r1, zero_r1, rc1_r1, rc2_r1;
reg [Bs-1:0] regime1_r1, regime2_r1;
reg [es-1:0] e1_r1, e2_r1;
reg [N-es:0] m1_r1, m2_r1;
reg start_r2; 
reg s1_r2, s2_r2, inf_r2, zero_r2, rc1_r2, rc2_r2;
reg [Bs-1:0] regime1_r2, regime2_r2;
reg [es-1:0] e1_r2, e2_r2;
reg [N-es:0] m1_r2, m2_r2;

always @(posedge clk) begin
start_r1 <= start_r0; s1_r1 <= s1_r0; s2_r1 <= s2_r0; 
inf_r1 <= inf_r0; zero_r1 <= zero_r0; rc1_r1 <= rc1_r0; rc2_r1 <= rc2_r0;
regime1_r1 <= regime1_r0; regime2_r1 <= regime2_r0; 
e1_r1 <= e1_r0; e2_r1 <= e2_r0;
m1_r1 <= m1_r0; m2_r1 <= m2_r0;

start_r2 <= start_r1; s1_r2 <= s1_r1; s2_r2 <= s2_r1; 
inf_r2 <= inf_r1; zero_r2 <= zero_r1; rc1_r2 <= rc1_r1; rc2_r2 <= rc2_r1;
regime1_r2 <= regime1_r1; regime2_r2 <= regime2_r1; 
e1_r2 <= e1_r1; e2_r2 <= e2_r1;
m1_r2 <= m1_r1; m2_r2 <= m2_r1;
end
/*//Stage 3//
  reg [N-es:0] m1_r3, m2_r3;
always @(posedge clk) begin
m1_r3 <= m2_r2; m2_r3 <= m2_r2;
end
//Stage 4//
  reg [N-es:0] m1_r4, m2_r4;
always @(posedge clk) begin
m1_r4 <= m1_r3; m2_r4 <= m2_r3;
end
//Stage 5//
  reg [N-es:0] m1_r5, m2_r5;
always @(posedge clk) begin
m1_r5 <= m1_r4; m2_r5 <= m2_r4;
end
//Stage 6//
  reg [N-es:0] m1_r6, m2_r6;
always @(posedge clk) begin
m1_r6 <= m1_r5; m2_r6 <= m2_r5;
end
//Stage 7//
  reg [N-es:0] m1_r7, m2_r7;
always @(posedge clk) begin
m1_r7 <= m1_r6; m2_r7 <= m2_r6;
end
//Stage 8//
  reg [N-es:0] m1_r8, m2_r8;
always @(posedge clk) begin
m1_r8 <= m1_r7; m2_r8 <= m2_r7;
end*/
//wire [53:0] mult_m_r2;
//wire [47:0] mult_P;
//mult24x24bit_dsp48_lat2 m24 (.clk(clk), .a(m1_r0[N-es:3]), .b(m2_r0[N-es:3]), .c(mult_P));????????????
//assign mult_m_r2 = {mult_P,6'b0};?????????????
  //wire [2*(N-es)+1:0] mult_m_r2 = m1_r2*m2_r2;//DSP block not available
  wire [2*(N-es)+1:0] mult_m_r2;
  //Multiplier #(.m(N-es+1),.n(N-es+1)) mult_inst (mult_m_r2,m1_r2,m2_r2,clk);
  product p1 (clk, mult_m_r2, m1_r2, m2_r2);
  //Multiplier #(.N(N-es+1)) mult_inst (.clk(clk), .y(m1_r2), .x(m2_r2), .result(mult_m_r2));
  //multiplier #(.N(N),.es(es)) mult_inst (clk, m1_r2,m2_r2,mult_m_r2);
//Pipeline Stage 1//
  reg [2*(N-es)+1:0] mult_m_r2_R1;
  always@(posedge clk)begin
    mult_m_r2_R1 <= mult_m_r2;
  end
  //Pipeline Stage 2//
  reg [2*(N-es)+1:0] mult_m_r2_R2;
  always@(posedge clk)begin
    mult_m_r2_R2 <= mult_m_r2_R1;
  end
  //Pipeline Stage 3//
  reg [2*(N-es)+1:0] mult_m_r2_R3;
  always@(posedge clk)begin
    mult_m_r2_R3 <= mult_m_r2_R2;
  end
  //Pipeline Stage 3//
  reg [2*(N-es)+1:0] mult_m_r2_R4;
  always@(posedge clk)begin
    mult_m_r2_R4 <= mult_m_r2_R3;
  end
  wire [2*(N-es)+1:0] mult_m_r2_pipe = mult_m_r2_R4;
//Sign, Exponent and Mantissa Computation
wire mult_s = s1_r2 ^ s2_r2;

wire mult_m_ovf = mult_m_r2_pipe[2*(N-es)+1];
  wire [2*(N-es)+1:0] mult_mN = ~mult_m_ovf ? mult_m_r2_pipe << 1'b1 : mult_m_r2_pipe;

wire [Bs+1:0] r1 = rc1_r2 ? {2'b0,regime1_r2} : -regime1_r2;
wire [Bs+1:0] r2 = rc2_r2 ? {2'b0,regime2_r2} : -regime2_r2;
//wire [Bs+es+1:0] mult_e  =  {r1, e1_r2} + {r2, e2_r2} + mult_m_ovf;
wire [Bs+es+1:0] mult_e;
add_N_Cin_mult #(.N(Bs+es+1)) uut_add_exp (clk,{r1,e1_r2}, {r2,e2_r2}, mult_m_ovf, mult_e);

//Exponent and Regime Computation
//wire [es+Bs:0] mult_eN = mult_e[es+Bs+1] ? -mult_e : mult_e;
//wire [es-1:0] e_o = mult_e[es-1:0];
//wire [Bs:0] r_o = (~mult_e[es+Bs+1] || (|mult_e[es-1:0])) + mult_eN[es+Bs:es];
wire [es-1:0] e_o;
wire [Bs:0] r_o;
reg_exp_op_mult #(.es(es), .Bs(Bs)) uut_reg_ro (clk,mult_e[es+Bs+1:0], e_o, r_o);


//Exponent and Mantissa Packing
wire [2*N-1+3:0]tmp_o = {{N{~mult_e[es+Bs+1]}},mult_e[es+Bs+1],e_o,mult_mN[2*(N-es):2*(N-es)-(N-es-1)+1], mult_mN[2*(N-es)-(N-es-1):2*(N-es)-(N-es-1)-1], |mult_mN[2*(N-es)-(N-es-1)-2:0] }; 

reg start_r3, mult_s_r3, inf_r3, zero_r3;
reg [2*N-1+3:0] tmp_o_r3;
reg [Bs:0] r_o_r3;
reg [2*(N-es)+1:0] mult_mN_r3;
always @(posedge clk) begin
start_r3 <= start_r2; mult_s_r3 <= mult_s; inf_r3 <= inf_r2; zero_r3 <= zero_r2;
r_o_r3 <= r_o;
tmp_o_r3 <= tmp_o;
mult_mN_r3 <= mult_mN;
end

//Including Regime bits in Exponent-Mantissa Packing
wire [3*N-1+3:0] tmp1_o;
 DSR_right_N_S_mult #(.N(3*N+3), .S(Bs+1)) dsr2 (.clk(clk),.a({tmp_o_r3,{N{1'b0}}}), .b(r_o_r3[Bs] ? {Bs{1'b1}} : r_o_r3), .c(tmp1_o));


//Rounding RNE : ulp_add = G.(R + S) + L.G.(~(R+S))
wire L = tmp1_o[N+4], G = tmp1_o[N+3], R = tmp1_o[N+2], St = |tmp1_o[N+1:0],
     ulp = ((G & (R | St)) | (L & G & ~(R | St)));
wire [N-1:0] rnd_ulp = {{N-1{1'b0}},ulp};
wire [N:0] tmp1_o_rnd_ulp;
  add_N_mult #(.N(N)) uut_add_ulp (clk,tmp1_o[2*N-1+3:N+3], rnd_ulp, tmp1_o_rnd_ulp);
wire [N-1:0] tmp1_o_rnd = (r_o_r3 < N-es-2) ?  tmp1_o_rnd_ulp[N-1:0]: tmp1_o[2*N-1+3:N+3];


//Final Output
wire [N-1:0] tmp1_oN = mult_s_r3 ? -tmp1_o_rnd : tmp1_o_rnd;
wire [N-1:0] out_tmp = inf_r3|zero_r3|(~mult_mN_r3[2*(N-es)+1]) ? {inf_r3,{N-1{1'b0}}} : {mult_s_r3, tmp1_oN[N-1:1]};
//Pipeline Stage 1//
reg[N-1:0] out_r4;
reg inf_r4, zero_r4;
reg done_r4;  
always @(posedge clk) begin
out_r4 <= out_tmp;
done_r4 <= start_r3;
inf_r4 <= inf_r3;
zero_r4 <= zero_r3;
end
//Final Stage//
always @(posedge clk) begin
out <= out_r4;
done <= done_r4;
inf <= inf_r4;
zero <= zero_r4;
end
  
endmodule

/////////////////////////
module add_N_mult (clk,a,b,c);
parameter N=10;
input clk;
input [N-1:0] a,b;
output [N:0] c;
//Stage 1//
  reg [N:0] c_r1;
  always@(posedge clk)begin
    c_r1 <= {1'b0,a} + {1'b0,b}; 
  end
  //Stage 2//
  reg [N:0] c_r2;
  always@(posedge clk)begin
    c_r2 <= c_r1;
  end
  //Stage 3//
  reg [N:0] c_r3;
  always@(posedge clk)begin
    c_r3 <= c_r2;
  end
  //Stage 4//
  reg [N:0] c_r4;
  always@(posedge clk)begin
    c_r4 <= c_r3;
  end
assign c = c_r4;
endmodule


/////////////////////////
module reg_exp_op_mult (clk,exp_o, e_o, r_o);
parameter es=3;
parameter Bs=5;
input clk;
input [es+Bs+1:0] exp_o;
output [es-1:0] e_o;
output [Bs:0] r_o;

//Pipeline Stage 1//
reg[es-1:0] e_o_r1;
  always@(posedge clk)begin
    e_o_r1<= exp_o[es-1:0];
  end
//Pipeline Stage 2//
  reg[es-1:0] e_o_r2;
  always@(posedge clk)begin
    e_o_r2<= e_o_r1;
  end
//Pipeline Stage 3//
  reg[es-1:0] e_o_r3;
  always@(posedge clk)begin
    e_o_r3<= e_o_r2;
  end
//Pipeline Stage 4//
  reg[es-1:0] e_o_r4;
  always@(posedge clk)begin
    e_o_r4<= e_o_r3;
  end
  
  assign e_o = e_o_r4;


wire [es+Bs:0] exp_oN_tmp;
  conv_2c_mult_mult #(.N(es+Bs)) uut_conv_2c1 (clk,~exp_o[es+Bs:0],exp_oN_tmp);
wire [es+Bs:0] exp_oN = exp_o[es+Bs+1] ? exp_oN_tmp[es+Bs:0] : exp_o[es+Bs:0];

//assign r_o = (~exp_o[es+Bs+1] || |(exp_oN[es-1:0])) ? exp_oN[es+Bs:es] + 1 : exp_oN[es+Bs:es];
//Pipeline Stage 1
reg [Bs:0] r_o_r1;
always@(posedge clk)begin
  r_o_r1 <= (~exp_o[es+Bs+1] || |(exp_oN[es-1:0])) ? exp_oN[es+Bs:es] + 1 : exp_oN[es+Bs:es];
end
//Pipeline Stage 2
  reg [Bs:0] r_o_r2;
always@(posedge clk)begin
  r_o_r2 <= r_o_r1;
end
//Pipeline Stage 3
  reg [Bs:0] r_o_r3;
always@(posedge clk)begin
  r_o_r3 <= r_o_r2;
end
//Pipeline Stage 4
  reg [Bs:0] r_o_r4;
always@(posedge clk)begin
  r_o_r4 <= r_o_r3;
end
assign r_o = r_o_r4;
endmodule

/////////////////////////
module conv_2c_mult_mult (clk,a,c);
parameter N=10;
input clk;
input [N:0] a;
output [N:0] c;
//Pipeline Stage 1//
reg[N:0] c_r1;
  always@(posedge clk)begin
    c_r1<= a + 1'b1;
  end
//Pipeline Stage 2//
  reg[N:0] c_r2;
  always@(posedge clk)begin
    c_r2<= c_r1;
  end 
//Pipeline Stage 3//
  reg[N:0] c_r3;
  always@(posedge clk)begin
    c_r3<= c_r2;
  end 
//Pipeline Stage 4//
  reg[N:0] c_r4;
  always@(posedge clk)begin
    c_r4<= c_r3;
  end 
assign c = c_r4;
endmodule

/////////////////////////
module add_N_Cin_mult (clk,a,b,cin,c);
parameter N=10;
input clk;
input [N:0] a,b;
input cin;
output [N:0] c;
//Pipeline Stage 1//
reg [N:0] c_r1;
always @(posedge clk)begin
  c_r1 <= a + b + cin ;
end
//Pipeline Stage 2//
reg [N:0] c_r2;
always @(posedge clk)begin
  c_r2 <= c_r1 ;
end
//Pipeline Stage 3//
  reg [N:0] c_r3;
always @(posedge clk)begin
  c_r3 <= c_r2 ;
end
//Pipeline Stage 4//
  reg [N:0] c_r4;
always @(posedge clk)begin
  c_r4 <= c_r3 ;
end

assign c = c_r4;
endmodule
/////////////////////////
//wire [2*(N-es)+1:0] mult_m_r2 = m1_r2*m2_r2;//DSP block not available
module data_extract_N32_ES4_mult(clk, in, rc, regime, exp, mant);
/*function [31:0] log2;
input reg [31:0] value;
	begin
	value = value-1;
	for (log2=0; value>0; log2=log2+1)
        	value = value>>1;
      	end
endfunction*/

parameter N=16;
parameter Bs=$clog2(N);
parameter es = 2;

input clk;
input [N-1:0] in;
output rc;
output [Bs-1:0] regime;
output [es-1:0] exp;
output [N-es-1:0] mant;

//Data Extraction

wire [N-1:0] xin = in;
assign rc = xin[N-2];

wire [N-1:0] xin_r = rc ? ~xin : xin;

wire [Bs-1:0] k;
//LOD_32 uut_lod32_5 (.in({xin_r[N-2:0],rc^1'b0}), .out(k));
LOD_N_mult #(.N(N)) xinst_k(.clk(clk), .in({xin_r[N-2:0],rc^1'b0}), .out(k));

assign regime = rc ? k-1 : k;

wire [N-1:0] xin_tmp;
DSR_left_N_S_mult #(.N(N), .S(Bs)) ls (.clk(clk), .a({xin[N-3:0],2'b0}),.b(k),.c(xin_tmp));

assign exp= xin_tmp[N-1:N-es];
assign mant= xin_tmp[N-es-1:0];

endmodule


/////////////////////////
/*module DSR_left_N_S_mult(a,b,c);
        parameter N=16;
        parameter S=4;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a << 7'd1  : a; 
genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
		assign tmp[i] = b[i] ? tmp[i-1] << 2**i : tmp[i-1];
	end
endgenerate
assign c = tmp[S-1];

endmodule*/

/////////////////////////
module DSR_left_N_S_mult(clk,a,b,c);
        parameter N=16;
        parameter S=4;
        input clk;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a << 7'd1  : a; 
/*genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
		assign tmp[i] = b[i] ? tmp[i-1] << 2**i : tmp[i-1];
	end
endgenerate*/
//pipeline reg 1//
  reg [N-1:0] tmp_r1;
  reg [S-1:0] b_r1;
  always@(posedge clk)begin
    tmp_r1 <= tmp[0];
    b_r1 <= b;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r2;
  reg [S-1:0] b_r2;
  always@(posedge clk)begin
    tmp_r2 <= tmp_r1;
    b_r2 <= b_r1;
  end
  assign tmp[1]  = b_r2[1] ? tmp_r2 << 7'd2  : tmp_r2;
//pipeline reg 1//
  reg [N-1:0] tmp_r11;
  reg [S-1:0] b_r11;
  always@(posedge clk)begin
    tmp_r11 <= tmp[1];
    b_r11 <= b_r2;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r22;
  reg [S-1:0] b_r22;
  always@(posedge clk)begin
    tmp_r22 <= tmp_r11;
    b_r22 <= b_r11;
  end
  assign tmp[2]  = b_r22[2] ? tmp_r22 << 7'd4  : tmp_r22;
  //pipeline reg 1//
  reg [N-1:0] tmp_r33;
  reg [S-1:0] b_r33;
  always@(posedge clk)begin
    tmp_r33 <= tmp[2];
    b_r33 <= b_r22;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r44;
  reg [S-1:0] b_r44;
  always@(posedge clk)begin
    tmp_r44 <= tmp_r33;
    b_r44 <= b_r33;
  end

//assign tmp[3]  = b[3] ? tmp[2] >> 7'd8  : tmp[2];
//assign tmp[4]  = b[4] ? tmp[3] >> 7'd16  : tmp[3];
  assign tmp[3]  = b_r44[3] ? tmp_r44 << 7'd8  : tmp_r44;
  //pipeline reg 1//
  reg [N-1:0] tmp_r55;
  reg [S-1:0] b_r55;
  always@(posedge clk)begin
    tmp_r55 <= tmp[3];
    b_r55 <= b_r44;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r66;
  reg [S-1:0] b_r66;
  always@(posedge clk)begin
    tmp_r66 <= tmp_r55;
    b_r66 <= b_r55;
  end
  assign tmp[4]  = b_r66[4] ? tmp_r66 << 7'd16  : tmp_r66;
assign c = tmp[S-1];

endmodule


/////////////////////////
/*module DSR_right_N_S_mult(clk,a,b,c);
        parameter N=16;
        parameter S=4;
        input clk;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a >> 7'd1  : a;

//Pipeline Stage 1//
reg[N-1:0] tmp_r1[S-1:0] ;
reg [N-1:0] b_r1;
always @(posedge clk)begin
  tmp_r1[0] <= tmp[0];
  b_r1 <= b;
end
//Pipeline Stage 2//
  reg[N-1:0] tmp_r2[S-1:0] ;
  reg [N-1:0] b_r2;
always @(posedge clk)begin
  tmp_r2[0] <= tmp_r1[0];
  b_r2 <= b_r1;
end
//Pipeline Stage 3//
  reg[N-1:0] tmp_r3[S-1:0] ;
  reg [N-1:0] b_r3;
always @(posedge clk)begin
  tmp_r3[0] <= tmp_r2[0];
  b_r3 <= b_r2;
end
//Pipeline Stage 4//
  reg[N-1:0] tmp_r4[S-1:0] ;
  reg [N-1:0] b_r4;
always @(posedge clk)begin
  tmp_r4[0] <= tmp_r3[0];
  b_r4 <= b_r3;
end
//Final assign
wire[N-1:0] tmp_pipe[S-1:0];
assign tmp_pipe[0] = tmp_r4[0];
genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
      assign tmp_pipe[i] = b_r4[i] ? tmp_pipe[i-1] >> 2**i : tmp_pipe[i-1];
	end
endgenerate
assign c = tmp_pipe[S-1];

endmodule*/

/////////////////////////

/////////////////////////
module DSR_right_N_S_mult(clk,a,b,c);
        parameter N=16;
        parameter S=4;
        input clk;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a >> 7'd1  : a; 
//pipeline reg 1//
  reg [N-1:0] tmp_r1;
  reg [S-1:0] b_r1;
  always@(posedge clk)begin
    tmp_r1 <= tmp[0];
    b_r1 <= b;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r2;
  reg [S-1:0] b_r2;
  always@(posedge clk)begin
    tmp_r2 <= tmp_r1;
    b_r2 <= b_r1;
  end
assign tmp[1]  = b_r2[1] ? tmp_r2 >> 7'd2  : tmp_r2;
//pipeline reg 1//
  reg [N-1:0] tmp_r11;
  reg [S-1:0] b_r11;
  always@(posedge clk)begin
    tmp_r11 <= tmp[1];
    b_r11 <= b_r2;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r22;
  reg [S-1:0] b_r22;
  always@(posedge clk)begin
    tmp_r22 <= tmp_r11;
    b_r22 <= b_r11;
  end
  assign tmp[2]  = b_r22[2] ? tmp_r22 >> 7'd4  : tmp_r22;
  //pipeline reg 1//
  reg [N-1:0] tmp_r33;
  reg [S-1:0] b_r33;
  always@(posedge clk)begin
    tmp_r33 <= tmp[2];
    b_r33 <= b_r22;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r44;
  reg [S-1:0] b_r44;
  always@(posedge clk)begin
    tmp_r44 <= tmp_r33;
    b_r44 <= b_r33;
  end

//assign tmp[3]  = b[3] ? tmp[2] >> 7'd8  : tmp[2];
//assign tmp[4]  = b[4] ? tmp[3] >> 7'd16  : tmp[3];
  assign tmp[3]  = b_r44[3] ? tmp_r44 >> 7'd8  : tmp_r44;
  //pipeline reg 1//
  reg [N-1:0] tmp_r55;
  reg [S-1:0] b_r55;
  always@(posedge clk)begin
    tmp_r55 <= tmp[3];
    b_r55 <= b_r44;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r66;
  reg [S-1:0] b_r66;
  always@(posedge clk)begin
    tmp_r66 <= tmp_r55;
    b_r66 <= b_r55;
  end
  assign tmp[4]  = b_r66[4] ? tmp_r66 >> 7'd16  : tmp_r66;
 //pipeline reg 1//
  reg [N-1:0] tmp_r77;
  reg [S-1:0] b_r77;
  always@(posedge clk)begin
    tmp_r77 <= tmp[4];
    b_r77 <= b_r66;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r88;
  reg [S-1:0] b_r88;
  always@(posedge clk)begin
    tmp_r88 <= tmp_r77;
    b_r88 <= b_r77;
  end
  assign tmp[5]  = b_r88[5] ? tmp_r88 >> 7'd32  : tmp_r88;


/*genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
		assign tmp[i] = b[i] ? tmp[i-1] >> 2**i : tmp[i-1];
	end
endgenerate*/
assign c = tmp[S-1];

endmodule



///////////////////////
/*module LOD_N_mult (in, out);

  function [31:0] log2;
    input reg [31:0] value;
    begin
      value = value-1;
      for (log2=0; value>0; log2=log2+1)
	value = value>>1;
    end
  endfunction

parameter N = 64;
parameter S = $clog2(N); 
input [N-1:0] in;
output [S-1:0] out;

wire vld;
LOD #(.N(N)) l1 (in, out, vld);
endmodule


module LOD (in, out, vld);

  function [31:0] log2;
    input reg [31:0] value;
    begin
      value = value-1;
      for (log2=0; value>0; log2=log2+1)
	value = value>>1;
    end
  endfunction


parameter N = 64;
parameter S = $clog2(N);

   input [N-1:0] in;
   output [S-1:0] out;
   output vld;

  generate
    if (N == 2)
      begin
	assign vld = |in;
	assign out = ~in[1] & in[0];
      end
    else if (N & (N-1))
      //LOD #(1<<S) LOD ({1<<S {1'b0}} | in,out,vld);
      LOD #(1<<S) LOD ({in,{((1<<S) - N) {1'b0}}},out,vld);
    else
      begin
	wire [S-2:0] out_l, out_h;
	wire out_vl, out_vh;
	LOD #(N>>1) l(in[(N>>1)-1:0],out_l,out_vl);
	LOD #(N>>1) h(in[N-1:N>>1],out_h,out_vh);
	assign vld = out_vl | out_vh;
	assign out = out_vh ? {1'b0,out_h} : {out_vl,out_l};
      end
  endgenerate
endmodule*/

///////////////////////
module LOD_N_mult(clk,in, out);
parameter N = 32;
input clk;
input [31:0] in;
output [4:0] out;
wire [3:0] out_l, out_h;
wire out_vl, out_vh;

wire [4:0] out_pipe;
  
  LOD16_4_mult pl(.clk(clk),.in(in[15:0]), .out(out_l), .out_v(out_vl));
  LOD16_4_mult ph(.clk(clk),.in(in[31:16]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};

//Pipe Stage 5//
  reg [4:0] out_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
  end
//Pipe Stage 4//
  reg [4:0] out_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
  end
assign out = out_r2;
endmodule

////////////////////
module LOD16_4_mult(clk, in, out, out_v);
input clk;
input [15:0] in;
output [3:0] out;
output out_v;
wire [2:0] out_l, out_h;
wire out_vl, out_vh;

wire [3:0] out_pipe;
wire out_v_pipe;

LOD8_3_mult pl(.clk(clk),.in(in[7:0]), .out(out_l), .out_v(out_vl));
LOD8_3_mult ph(.clk(clk),.in(in[15:8]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;

//Pipe Stage 4//
  reg [3:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 4//
  reg [3:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule

////////////////////
module LOD8_3_mult(clk,in, out, out_v);
input clk;
input [7:0] in;
output [2:0] out;
output out_v;

wire [1:0] out_l, out_h;
wire out_vl, out_vh;
  
wire [2:0] out_pipe;
wire out_v_pipe;

LOD4_2_mult pl(.clk(clk),.in(in[3:0]), .out(out_l), .out_v(out_vl));
LOD4_2_mult ph(.clk(clk),.in(in[7:4]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;
//Pipe Stage 3//
  reg [2:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 3//
  reg [2:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule


////////////////////
module LOD4_2_mult(clk,in, out, out_v);
input clk;
input [3:0] in;
output [1:0] out;
output out_v;

wire out_l, out_h;
wire out_vl, out_vh;
  
wire [1:0] out_pipe;
wire out_v_pipe;

LOD2_1_mult pl(.clk(clk),.in(in[1:0]), .out(out_l), .out_v(out_vl));
LOD2_1_mult ph(.clk(clk),.in(in[3:2]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;
//Pipe Stage 2//
  reg [1:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 2//
  reg [1:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;

endmodule


module LOD2_1_mult(clk,in, out, out_v);
input clk;
input [1:0] in;
output out;
output out_v;
wire out_pipe;
wire out_v_pipe;
assign out_pipe = ~in[1] & in[0];
assign out_v_pipe = |in;
//Pipe stage 1//
reg out_r1;
reg out_v_r1;
always@(posedge clk) begin
  out_r1 <= out_pipe;
  out_v_r1 <= out_v_pipe;
end
//Pipe stage 1//
reg out_r2;
reg out_v_r2;
always@(posedge clk) begin
  out_r2 <= out_r1;
  out_v_r2 <= out_v_r1;
end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule


///////////////////////////////////////////////////////////////////////////////////////
//////////////////////Below does Posit<32,4> addition//////////////////////////////////
//////////////////////Pipelined to stages////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
module posit_add (clk, in1, in2, start, out, inf, zero, done);



parameter N = 32;
parameter Bs = $clog2(N); 
parameter es = 6;


input clk;
input [N-1:0] in1, in2;
input start; 
output reg [N-1:0] out;
output reg inf, zero;
output reg done;

wire start0= start;
wire s1 = in1[N-1];
wire s2 = in2[N-1];
wire zero_tmp1 = |in1[N-2:0];
wire zero_tmp2 = |in2[N-2:0];
wire inf1 = in1[N-1] & (~zero_tmp1),
	inf2 = in2[N-1] & (~zero_tmp2);
wire zero1 = ~(in1[N-1] | zero_tmp1),
	zero2 = ~(in2[N-1] | zero_tmp2);
wire inf_t = inf1 | inf2,
	zero_t = zero1 & zero2;


//Data Extraction
wire rc1, rc2;
wire [Bs-1:0] regime1, regime2;
wire [es-1:0] e1, e2;
wire [N-es-1:0] mant1, mant2;
wire [N-1:0] xin1 = s1 ? -in1 : in1;
wire [N-1:0] xin2 = s2 ? -in2 : in2;
wire in1_gt_in2 = (xin1[N-2:0] >= xin2[N-2:0]) ? 1'b1 : 1'b0;
  data_extract_N32_ES4_add #(.N(N),.es(es)) uut_de1(.clk(clk),.in(xin1), .rc(rc1), .regime(regime1), .exp(e1), .mant(mant1));
  data_extract_N32_ES4_add #(.N(N),.es(es)) uut_de2(.clk(clk),.in(xin2), .rc(rc2), .regime(regime2), .exp(e2), .mant(mant2));

wire [N-es:0] m1 = {zero_tmp1,mant1}, 
	m2 = {zero_tmp2,mant2};

reg start_r0; 
reg in1_gt_in2_r0, s1_r0, s2_r0, inf_r0, zero_r0, rc1_r0, rc2_r0;
reg [Bs-1:0] regime1_r0, regime2_r0;
reg [es-1:0] e1_r0, e2_r0;
reg [N-es:0] m1_r0, m2_r0;

always @(posedge clk) begin
start_r0 <= start0; in1_gt_in2_r0 <= in1_gt_in2; s1_r0 <= s1; s2_r0 <= s2; 
inf_r0 <= inf_t; zero_r0 <= zero_t; rc1_r0 <= rc1; rc2_r0 <= rc2;
regime1_r0 <= regime1; regime2_r0 <= regime2; 
e1_r0 <= e1; e2_r0 <= e2;
m1_r0 <= m1; m2_r0 <= m2;
end

//Large Checking and Assignment
wire ls = in1_gt_in2_r0 ? s1_r0 : s2_r0;
wire op = s1_r0 ~^ s2_r0;

wire lrc = in1_gt_in2_r0 ? rc1_r0 : rc2_r0;
wire src = in1_gt_in2_r0 ? rc2_r0 : rc1_r0;

wire [Bs-1:0] lr = in1_gt_in2_r0 ? regime1_r0 : regime2_r0;
wire [Bs-1:0] sr = in1_gt_in2_r0 ? regime2_r0 : regime1_r0;

wire [es-1:0] le = in1_gt_in2_r0 ? e1_r0 : e2_r0;
wire [es-1:0] se = in1_gt_in2_r0 ? e2_r0 : e1_r0;

wire [N-es:0] lm = in1_gt_in2_r0 ? m1_r0 : m2_r0;
wire [N-es:0] sm = in1_gt_in2_r0 ? m2_r0 : m1_r0;

//Exponent Difference: Lower Mantissa Right Shift Amount
wire [es+Bs+1:0] diff;
assign diff = {lrc ? {2'b0,lr} : -lr,le} - {src ? {2'b0,sr} : -sr, se};
//wire [es+Bs+1:0] diff;
//wire [Bs:0] lr_N;
//wire [Bs:0] sr_N;
//abs_regime #(.N(Bs)) uut_abs_regime1 (lrc, lr, lr_N);
//abs_regime #(.N(Bs)) uut_abs_regime2 (src, sr, sr_N);
//sub_N #(.N(es+Bs+1)) uut_ediff ({lr_N,le}, {sr_N, se}, diff);
wire [Bs-1:0] exp_diff = (|diff[es+Bs:Bs]) ? {Bs{1'b1}} : diff[Bs-1:0];

//DSR Right Shifting
  wire [N-1:0] DSR_right_in = {sm,3'b0};
//DSR Right Shifting
/*wire [N-1:0] DSR_right_in;
generate
	if (es >= 2) 
	assign DSR_right_in = {sm,{es-1{1'b0}}};
	else 
	assign DSR_right_in = sm;
endgenerate*/

wire [N-1:0] DSR_right_out;
wire [Bs-1:0] DSR_e_diff  = exp_diff;
  DSR_right_N_S_add #(.N(N), .S(Bs))  dsr1(.clk(clk),.a(DSR_right_in), .b(DSR_e_diff), .c(DSR_right_out));

reg start_r1;
reg ls_r1, op_r1, lrc_r1, inf_r1, zero_r1;
reg [Bs-1:0] lr_r1;
reg [es-1:0] le_r1;
reg [N-es:0] lm_r1;
reg [N-1:0] DSR_right_out_r1;
always @(posedge clk) begin
start_r1 <= start_r0; ls_r1 <= ls; op_r1 <= op; inf_r1 <= inf_r0; zero_r1 <= zero_r0;
lrc_r1 <= lrc;
le_r1 <= le;
lr_r1 <= lr;
lm_r1 <= lm;
DSR_right_out_r1 <= DSR_right_out;
end

//Mantissa Addition
  wire [N-1:0] add_m_in1 = {lm_r1,3'b0};
//Mantissa Addition
/*wire [N-1:0] add_m_in1;
generate
	if (es >= 2) 
	assign add_m_in1 = {lm,{es-1{1'b0}}};
	else 
	assign add_m_in1 = lm;
endgenerate*/

wire [N:0] add_m;
  add_sub_N_add #(.N(N)) uut_add_sub_N (clk,op_r1, add_m_in1, DSR_right_out_r1, add_m);
wire [1:0] mant_ovf = add_m[N:N-1];

//LOD
wire [N-1:0] LOD_in = {(add_m[N] | add_m[N-1]), add_m[N-2:0]};
wire [Bs-1:0] left_shift;
  LOD_N_add #(.N(N)) l2(.clk(clk), .in(LOD_in), .out(left_shift));


reg start_r2;
reg ls_r2, lrc_r2, inf_r2, zero_r2;
reg [Bs-1:0] lr_r2, left_shift_r2;
reg [es-1:0] le_r2;
reg [N:0] add_m_r2;
reg [1:0] mant_ovf_r2;
always @(posedge clk) begin
start_r2 <= start_r1; ls_r2 <= ls_r1; inf_r2 <= inf_r1; zero_r2 <= zero_r1;
lrc_r2 <= lrc_r1; lr_r2 <= lr_r1; le_r2 <= le_r1;
left_shift_r2 <= left_shift;
add_m_r2 <= add_m;
mant_ovf_r2 <= mant_ovf;
end

//DSR Left Shifting
wire [N-1:0] DSR_left_out_t;
  DSR_left_N_S_add #(.N(N), .S(Bs)) dsl1(.clk(clk), .a(add_m_r2[N:1]), .b(left_shift_r2), .c(DSR_left_out_t));
wire [N-1:0] DSR_left_out = DSR_left_out_t[N-1] ? DSR_left_out_t[N-1:0] : {DSR_left_out_t[N-2:0],1'b0}; 


//Exponent and Regime Computation
wire [Bs:0] lr_N = lrc_r2 ? {1'b0,lr_r2} : -{1'b0,lr_r2};///?????????????
wire [es+Bs+1:0] le_o_tmp, le_o;
sub_N_add #(.N(es+Bs+1)) sub3 (clk, {lr_N,le_r2}, {{es+1{1'b0}},left_shift_r2}, le_o_tmp);
add_mantovf_add #(es+Bs+1) uut_add_mantovf (clk,le_o_tmp, mant_ovf_r2[1], le_o);

//wire [es+Bs:0] le_oN = le_o[es+Bs] ? -le_o : le_o;
//wire [es-1:0] e_o = le_o[es-1:0];
//wire [Bs-1:0] r_o = (~le_o[es+Bs] || (|le_o[es-1:0])) + le_oN[es+Bs-1:es];
wire [es-1:0] e_o;
wire [Bs-1:0] r_o;
  reg_exp_op_add #(.es(es), .Bs(Bs)) uut_reg_ro (clk,le_o[es+Bs:0], e_o, r_o);


//Exponent and Mantissa Packing
wire [2*N-1+3:0] tmp_o;
/*generate
	if(es > 2)
		assign tmp_o = { {N{~le_o[es+Bs]}}, le_o[es+Bs], e_o, DSR_left_out[N-2:es-2], |DSR_left_out[es-3:0]};
	else 
		assign tmp_o = { {N{~le_o[es+Bs]}}, le_o[es+Bs], e_o, DSR_left_out[N-2:0], {3-es{1'b0}} };

endgenerate*/
assign tmp_o = { {N{~le_o[es+Bs]}}, le_o[es+Bs], e_o, DSR_left_out[N-2:2], |DSR_left_out[1:0]};

reg start_r3, ls_r3, inf_r3, zero_r3;
reg [2*N-1+3:0] tmp_o_r3;
reg [Bs-1:0] r_o_r3;
reg [N-1:0] DSR_left_out_r3;
always @(posedge clk) begin
start_r3 <= start_r2; ls_r3 <= ls_r2; inf_r3 <= inf_r2; zero_r3 <= zero_r2;
r_o_r3 <= r_o;
tmp_o_r3 <= tmp_o;
DSR_left_out_r3 <= DSR_left_out;
end

//Including/Pushing Regime bits in Exponent-Mantissa Packing
wire [3*N-1+3:0] tmp1_o;
DSR_right_N_S_add #(.N(3*N+3), .S(Bs)) dsr2 (.clk(clk), .a({tmp_o_r3,{N{1'b0}}}), .b(r_o_r3), .c(tmp1_o));


//Rounding RNE : ulp_add = G.(R + S) + L.G.(~(R+S))
wire L = tmp1_o[N+4], G = tmp1_o[N+3], R = tmp1_o[N+2], St = |tmp1_o[N+1:0], ulp1 = ((G & (R | St))) , ulp2 = (L & G & ~(R | St));
wire ulp = ulp1 | ulp2;
//Pipe stage 1
reg ulp_r1;
always@(posedge clk)begin
  ulp_r1 <= ulp;
end
//Pipe stage 2
reg ulp_r2;
always@(posedge clk)begin
  ulp_r2 <= ulp_r1;
end
//Pipe stage 3
reg ulp_r3;
always@(posedge clk)begin
  ulp_r3 <= ulp_r2;
end
//Pipe stage 4
reg ulp_r4;
always@(posedge clk)begin
  ulp_r4 <= ulp_r3;
end
wire [N-1:0] rnd_ulp = {{N-1{1'b0}},ulp_r4};
wire [N:0] tmp1_o_rnd_ulp;
add_N_add #(.N(N)) uut_add_ulp (clk,tmp1_o[2*N-1+3:N+3], rnd_ulp, tmp1_o_rnd_ulp);
//wire [N-1:0] tmp1_o_rnd = (r_o_r3 < N-es-2) ? tmp1_o[2*N-1+3:N+3] + rnd_ulp : tmp1_o[2*N-1+3:N+3];

wire [N-1:0] tmp1_o_rnd = (r_o_r3 < N-es-2) ? tmp1_o_rnd_ulp : tmp1_o[2*N-1+3:N+3];
//Final Output
wire [N-1:0] tmp1_oN = ls_r3 ? -tmp1_o_rnd : tmp1_o_rnd;
wire [N-1:0] out_tmp = inf_r3|zero_r3|(~DSR_left_out_r3[N-1]) ? {inf_r3,{N-1{1'b0}}} : {ls_r3, tmp1_oN[N-1:1]};  

always @(posedge clk) begin
out <= out_tmp;
done <= start_r3;
inf <= inf_r3;
zero <= zero_r3;
end
endmodule

/////////////////////////

/////////////////////////
module abs_regime_add (rc, regime, regime_N);
parameter N = 10;
input rc;
input [N-1:0] regime;
output [N:0] regime_N;

assign regime_N = rc ? {1'b0,regime} : -{1'b0,regime};
endmodule

/////////////////////////
module conv_2c_add (clk,a,c);
parameter N=10;
input clk;
input [N:0] a;
output [N:0] c;
//assign c = a + 1'b1;
  //Pipe 1//
  reg [N:0] c_r1;
  always@(posedge clk) begin
    c_r1<=a+1'b1;
  end
   //Pipe 2//
  reg [N:0] c_r2;
  always@(posedge clk) begin
    c_r2<=c_r1;
  end
  assign c = c_r2;
endmodule

module reg_exp_op_add (clk,exp_o, e_o, r_o);
parameter es=3;
parameter Bs=5;
input clk;
input [es+Bs:0] exp_o;
output [es-1:0] e_o;
output [Bs-1:0] r_o;
wire [es-1:0] e_o_pipe;
assign e_o_pipe = exp_o[es-1:0];
//Pipe 1//
reg [es-1:0] e_o_r1;
  always@(posedge clk)begin
    e_o_r1<=e_o_pipe;
  end
//Pipe 2//
  reg [es-1:0] e_o_r2;
  always@(posedge clk)begin
    e_o_r2<=e_o_r1;
  end
assign e_o = e_o_r2;

wire [es+Bs:0] exp_oN_tmp;
conv_2c_add #(.N(es+Bs)) uut_conv_2c1 (clk,~exp_o[es+Bs:0],exp_oN_tmp);
wire [es+Bs:0] exp_oN = exp_o[es+Bs] ? exp_oN_tmp[es+Bs:0] : exp_o[es+Bs:0];
assign r_o = (~exp_o[es+Bs] || |(exp_oN[es-1:0])) ? exp_oN[es+Bs-1:es] + 1 : exp_oN[es+Bs-1:es];
endmodule

/////////////////////////
////////////////////////////
////////////////////////////
module data_extract_N32_ES4_add(clk,in, rc, regime, exp, mant);



parameter N=16;
parameter Bs=$clog2(N);
parameter es = 2;

input clk;
input [N-1:0] in;
output rc;
output [Bs-1:0] regime;
output [es-1:0] exp;
output [N-es-1:0] mant;

//Data Extraction

wire [N-1:0] xin = in;
assign rc = xin[N-2];

wire [N-1:0] xin_r = rc ? ~xin : xin;

wire [Bs-1:0] k;
  LOD_N_add #(.N(N)) xinst_k (.clk(clk),.in({xin_r[N-2:0],rc^1'b0}), .out(k));

assign regime = rc ? k-1 : k;

wire [N-1:0] xin_tmp;
DSR_left_N_S_add #(.N(N), .S(Bs)) ls (.clk(clk),.a({xin[N-3:0],2'b0}),.b(k),.c(xin_tmp));

assign exp= xin_tmp[N-1:N-es];
assign mant= xin_tmp[N-es-1:0];

endmodule
////////////////////
module add_N_add (clk,a,b,c);
parameter N=10;
input clk;
input [N-1:0] a,b;
output [N:0] c;
wire [N:0] ain = {1'b0,a};
wire [N:0] bin = {1'b0,b};
//Pipeline stage 1//
reg [N:0] ain_r0;
reg [N:0] bin_r0;
always@(posedge clk) begin
  ain_r0 <= ain;
  bin_r0 <= bin;
end
//Pipeline stage 2//
reg [N:0] ain_r1;
reg [N:0] bin_r1;
always@(posedge clk) begin
  ain_r1 <= ain_r0;
  bin_r1 <= bin_r0;
end
  add_N_in_add #(.N(N)) a1 (clk,ain_r1,bin_r1,c);
endmodule
/////////////////////////
module add_N_in_add (clk, a,b,c);
parameter N=10;
input clk;
input [N:0] a,b;
output [N:0] c;
//assign c = c_r22;
//pipeline reg 1//
  reg [N:0] c_r11;
always@(posedge clk) begin
c_r11<=a+b;
end
//pipeline reg 2//
  reg [N:0] c_r22;
always@(posedge clk) begin
c_r22<=c_r11;
end
assign c = c_r22;
endmodule
////////////////////////
/////////////////
module sub_N_add (clk,a,b,c);
parameter N=10;
input clk;
input [N-1:0] a,b;
output [N:0] c;
wire [N:0] ain = {1'b0,a};
wire [N:0] bin = {1'b0,b};
//Pipeline stage 1//
reg [N:0] ain_r0;
reg [N:0] bin_r0;
always@(posedge clk) begin
  ain_r0 <= ain;
  bin_r0 <= bin;
end
//Pipeline stage 2//
reg [N:0] ain_r1;
reg [N:0] bin_r1;
always@(posedge clk) begin
  ain_r1 <= ain_r0;
  bin_r1 <= bin_r0;
end
sub_N_in_add #(.N(N)) s1 (clk,ain_r1,bin_r1,c);
endmodule
////////////////////////////
/////////////////////////
module sub_N_in_add (clk,a,b,c);
input clk;
parameter N=10;
input [N:0] a,b;
output [N:0] c;
//wire [N:0] c_pipe;
//assign c_pipe = a - b;
//Pipe reg1//
  reg[N:0] c_reg1;
  always@(posedge clk)begin
    c_reg1<=a-b;
  end
 //Pipe reg2//
  reg[N:0] c_reg2;
  always@(posedge clk)begin
    c_reg2<=c_reg1;
  end
assign c = c_reg2;
endmodule
//////////////////////////

module add_sub_N_add (clk,op,a,b,c);
parameter N=10;
input clk;
input op;
input [N-1:0] a,b;
output [N:0] c;
wire [N:0] c_add, c_sub;

add_N_add #(.N(N)) a11 (clk,a,b,c_add);
sub_N_add #(.N(N)) s11 (clk,a,b,c_sub);
assign c = op ? c_add : c_sub;
endmodule

/////////////////////////
module add_mantovf_add (clk,a,mant_ovf,c);
parameter N=10;
input clk;
input [N:0] a;
input mant_ovf;
output [N:0] c;
//assign c = a + mant_ovf; 
//Pipe reg 2//
  reg[N:0] c_reg1;
  always@(posedge clk)begin
    c_reg1 <= a + mant_ovf;
  end
//Pipe reg 2//
  reg[N:0] c_reg2;
  always@(posedge clk)begin
    c_reg2 <= c_reg1;
  end
assign c = c_reg2;
endmodule

/////////////////////////
module DSR_left_N_S_add(clk,a,b,c);
        parameter N=16;
        parameter S=4;
        input clk;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a << 7'd1  : a; 
/*genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
		assign tmp[i] = b[i] ? tmp[i-1] << 2**i : tmp[i-1];
	end
endgenerate*/
//pipeline reg 1//
  reg [N-1:0] tmp_r1;
  reg [S-1:0] b_r1;
  always@(posedge clk)begin
    tmp_r1 <= tmp[0];
    b_r1 <= b;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r2;
  reg [S-1:0] b_r2;
  always@(posedge clk)begin
    tmp_r2 <= tmp_r1;
    b_r2 <= b_r1;
  end
  assign tmp[1]  = b_r2[1] ? tmp_r2 << 7'd2  : tmp_r2;
//pipeline reg 1//
  reg [N-1:0] tmp_r11;
  reg [S-1:0] b_r11;
  always@(posedge clk)begin
    tmp_r11 <= tmp[1];
    b_r11 <= b_r2;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r22;
  reg [S-1:0] b_r22;
  always@(posedge clk)begin
    tmp_r22 <= tmp_r11;
    b_r22 <= b_r11;
  end
  assign tmp[2]  = b_r22[2] ? tmp_r22 << 7'd4  : tmp_r22;
  //pipeline reg 1//
  reg [N-1:0] tmp_r33;
  reg [S-1:0] b_r33;
  always@(posedge clk)begin
    tmp_r33 <= tmp[2];
    b_r33 <= b_r22;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r44;
  reg [S-1:0] b_r44;
  always@(posedge clk)begin
    tmp_r44 <= tmp_r33;
    b_r44 <= b_r33;
  end

//assign tmp[3]  = b[3] ? tmp[2] >> 7'd8  : tmp[2];
//assign tmp[4]  = b[4] ? tmp[3] >> 7'd16  : tmp[3];
  assign tmp[3]  = b_r44[3] ? tmp_r44 << 7'd8  : tmp_r44;
  //pipeline reg 1//
  reg [N-1:0] tmp_r55;
  reg [S-1:0] b_r55;
  always@(posedge clk)begin
    tmp_r55 <= tmp[3];
    b_r55 <= b_r44;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r66;
  reg [S-1:0] b_r66;
  always@(posedge clk)begin
    tmp_r66 <= tmp_r55;
    b_r66 <= b_r55;
  end
  assign tmp[4]  = b_r66[4] ? tmp_r66 << 7'd16  : tmp_r66;
assign c = tmp[S-1];

endmodule




/////////////////////////
module DSR_right_N_S_add(clk,a,b,c);
        parameter N=16;
        parameter S=4;
        input clk;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a >> 7'd1  : a; 
//pipeline reg 1//
  reg [N-1:0] tmp_r1;
  reg [S-1:0] b_r1;
  always@(posedge clk)begin
    tmp_r1 <= tmp[0];
    b_r1 <= b;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r2;
  reg [S-1:0] b_r2;
  always@(posedge clk)begin
    tmp_r2 <= tmp_r1;
    b_r2 <= b_r1;
  end
assign tmp[1]  = b_r2[1] ? tmp_r2 >> 7'd2  : tmp_r2;
//pipeline reg 1//
  reg [N-1:0] tmp_r11;
  reg [S-1:0] b_r11;
  always@(posedge clk)begin
    tmp_r11 <= tmp[1];
    b_r11 <= b_r2;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r22;
  reg [S-1:0] b_r22;
  always@(posedge clk)begin
    tmp_r22 <= tmp_r11;
    b_r22 <= b_r11;
  end
  assign tmp[2]  = b_r22[2] ? tmp_r22 >> 7'd4  : tmp_r22;
  //pipeline reg 1//
  reg [N-1:0] tmp_r33;
  reg [S-1:0] b_r33;
  always@(posedge clk)begin
    tmp_r33 <= tmp[2];
    b_r33 <= b_r22;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r44;
  reg [S-1:0] b_r44;
  always@(posedge clk)begin
    tmp_r44 <= tmp_r33;
    b_r44 <= b_r33;
  end

//assign tmp[3]  = b[3] ? tmp[2] >> 7'd8  : tmp[2];
//assign tmp[4]  = b[4] ? tmp[3] >> 7'd16  : tmp[3];
  assign tmp[3]  = b_r44[3] ? tmp_r44 >> 7'd8  : tmp_r44;
  //pipeline reg 1//
  reg [N-1:0] tmp_r55;
  reg [S-1:0] b_r55;
  always@(posedge clk)begin
    tmp_r55 <= tmp[3];
    b_r55 <= b_r44;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r66;
  reg [S-1:0] b_r66;
  always@(posedge clk)begin
    tmp_r66 <= tmp_r55;
    b_r66 <= b_r55;
  end
  assign tmp[4]  = b_r66[4] ? tmp_r66 >> 7'd16  : tmp_r66;

/*genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
		assign tmp[i] = b[i] ? tmp[i-1] >> 2**i : tmp[i-1];
	end
endgenerate*/
assign c = tmp[S-1];

endmodule

/////////////////////////

/*module LOD_N_add (in, out);


parameter N = 64;
parameter S = $clog2(N); 
input [N-1:0] in;
output [S-1:0] out;

wire vld;
LOD_add #(.N(N)) l1 (in, out, vld);
endmodule*/


///////////////////////
module LOD_N_add(clk,in, out);
parameter N = 32;
input clk;
input [31:0] in;
output [4:0] out;
wire [3:0] out_l, out_h;
wire out_vl, out_vh;

wire [4:0] out_pipe;
  
  LOD16_4_add pl(.clk(clk),.in(in[15:0]), .out(out_l), .out_v(out_vl));
  LOD16_4_add ph(.clk(clk),.in(in[31:16]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};

//Pipe Stage 5//
  reg [4:0] out_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
  end
//Pipe Stage 4//
  reg [4:0] out_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
  end
assign out = out_r2;
endmodule

////////////////////
module LOD16_4_add(clk, in, out, out_v);
input clk;
input [15:0] in;
output [3:0] out;
output out_v;
wire [2:0] out_l, out_h;
wire out_vl, out_vh;

wire [3:0] out_pipe;
wire out_v_pipe;

LOD8_3_add pl(.clk(clk),.in(in[7:0]), .out(out_l), .out_v(out_vl));
LOD8_3_add ph(.clk(clk),.in(in[15:8]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;

//Pipe Stage 4//
  reg [3:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 4//
  reg [3:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule

////////////////////
module LOD8_3_add(clk,in, out, out_v);
input clk;
input [7:0] in;
output [2:0] out;
output out_v;

wire [1:0] out_l, out_h;
wire out_vl, out_vh;
  
wire [2:0] out_pipe;
wire out_v_pipe;

LOD4_2_add pl(.clk(clk),.in(in[3:0]), .out(out_l), .out_v(out_vl));
LOD4_2_add ph(.clk(clk),.in(in[7:4]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;
//Pipe Stage 3//
  reg [2:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 3//
  reg [2:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule


////////////////////
module LOD4_2_add(clk,in, out, out_v);
input clk;
input [3:0] in;
output [1:0] out;
output out_v;

wire out_l, out_h;
wire out_vl, out_vh;
  
wire [1:0] out_pipe;
wire out_v_pipe;

LOD2_1_add pl(.clk(clk),.in(in[1:0]), .out(out_l), .out_v(out_vl));
LOD2_1_add ph(.clk(clk),.in(in[3:2]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;
//Pipe Stage 2//
  reg [1:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 2//
  reg [1:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;

endmodule


module LOD2_1_add(clk,in, out, out_v);
input clk;
input [1:0] in;
output out;
output out_v;
wire out_pipe;
wire out_v_pipe;
assign out_pipe = ~in[1] & in[0];
assign out_v_pipe = |in;
//Pipe stage 1//
reg out_r1;
reg out_v_r1;
always@(posedge clk) begin
  out_r1 <= out_pipe;
  out_v_r1 <= out_v_pipe;
end
//Pipe stage 1//
reg out_r2;
reg out_v_r2;
always@(posedge clk) begin
  out_r2 <= out_r1;
  out_v_r2 <= out_v_r1;
end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule



///////////////////////////////////////////////////////////////////////////////////////
//////////////////////Below does Posit<32,4> Division//////////////////////////////////
//////////////////////Pipelined to 32 stages///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
// Code your design here
//(* use_dsp = "no" *)
module posit_div(clk,in1, in2, start, out_out, inf_out, zero_out, done_out);
/*function [31:0] log2;
input reg [31:0] value;
	begin
	value = value-1;
	for (log2=0; value>0; log2=log2+1)
        	value = value>>1;
      	end
endfunction*/

parameter N = 16;
parameter Bs = $clog2(N); 
parameter es = 3;
parameter NR_Iter = 1;							// 2 for 32 bits, 1 for 16 bits, 0 for 8bits
parameter NRB = 2**NR_Iter;
parameter M = N-es;
parameter IW_MAX = 8;							//Max intial approximation storage bit-width
parameter IW = (NRB == 1 ) ? M : (M/NRB + ((M%NRB > 0) ? 1 : 0));	//(must be <= IW_MAX) 1/4th width of Mantissa: inverse width to be used in NR iterations multiplication 
parameter AW_MAX = 8;							//Max Address width of the intial approximation storage
parameter AW = (NRB == 1) ? M : (M/NRB + ((M%NRB > 0) ? 1 : 0));	//Actual address width used for initial approximation (AW must be <= AW_MAX)

input clk;
input [N-1:0] in1, in2;
input start; 
output [N-1:0] out_out;
output inf_out, zero_out;
output done_out;

wire [N-1:0] out_out;
wire inf_out,zero_out;
wire done_out;

wire [N-1:0] out;
wire inf,zero,done;

wire start0= start;
wire s1 = in1[N-1];
wire s2 = in2[N-1];
wire zero_tmp1 = |in1[N-2:0];
wire zero_tmp2 = |in2[N-2:0];
wire inf1 = in1[N-1] & (~zero_tmp1),
	inf2 = in2[N-1] & (~zero_tmp2);
wire zero1 = ~(in1[N-1] | zero_tmp1),
	zero2 = ~(in2[N-1] | zero_tmp2);
assign inf = inf1 | zero2,
	zero = zero1 | inf2;

//Data Extraction
wire rc1, rc2;
wire [Bs-1:0] regime1, regime2;
wire [es-1:0] e1, e2;
wire [M-1:0] mant1, mant2;
wire [N-1:0] xin1 = s1 ? -in1 : in1;
wire [N-1:0] xin2 = s2 ? -in2 : in2;
//Pipeline Stage 1//
reg [N-1:0] xin1_r1;
reg [N-1:0] xin2_r1;
reg zero_tmp1_r1;
reg zero_tmp2_r1;
reg s1_r1;
reg s2_r1;
reg inf_r1, zero_r1, start0_r1;
  always@(posedge clk)begin
    xin1_r1 <= xin1;
    xin2_r1 <= xin2;
    zero_tmp1_r1 <= zero_tmp1;
    zero_tmp2_r1 <= zero_tmp2;
    s1_r1 <= s1;
    s2_r1 <= s2;
    inf_r1 <= inf;
    zero_r1 <= zero;
    start0_r1 <= start0;
  end
//Pipeline Stage 2//
reg [N-1:0] xin1_r2;
reg [N-1:0] xin2_r2;
reg zero_tmp1_r2;
reg zero_tmp2_r2;
reg s1_r2;
reg s2_r2;
reg inf_r2, zero_r2, start0_r2;
  always@(posedge clk)begin
    xin1_r2 <= xin1_r1;
    xin2_r2 <= xin2_r1;
    zero_tmp1_r2 <= zero_tmp1_r1;
    zero_tmp2_r2 <= zero_tmp2_r1;
    s1_r2 <= s1_r1;
    s2_r2 <= s2_r1;
    inf_r2 <= inf_r1;
    zero_r2 <= zero_r1;
    start0_r2 <= start0_r1;
  end
//Pipeline Stage 3//
reg [N-1:0] xin1_r3;
reg [N-1:0] xin2_r3;
reg zero_tmp1_r3;
reg zero_tmp2_r3;
reg s1_r3;
reg s2_r3;
reg inf_r3, zero_r3, start0_r3;
  always@(posedge clk)begin
    xin1_r3 <= xin1_r2;
    xin2_r3 <= xin2_r2;
    zero_tmp1_r3 <= zero_tmp1_r2;
    zero_tmp2_r3 <= zero_tmp2_r2;
    s1_r3 <= s1_r2;
    s2_r3 <= s2_r2;
    inf_r3 <= inf_r2;
    zero_r3 <= zero_r2;
    start0_r3 <= start0_r2;
  end
//Pipeline Stage 4//
reg [N-1:0] xin1_r4;
reg [N-1:0] xin2_r4;
reg zero_tmp1_r4;
reg zero_tmp2_r4;
reg s1_r4;
reg s2_r4;
reg inf_r4, zero_r4, start0_r4;
  always@(posedge clk)begin
    xin1_r4 <= xin1_r3;
    xin2_r4 <= xin2_r3;
    zero_tmp1_r4<= zero_tmp1_r3;
    zero_tmp2_r4<= zero_tmp2_r3;
    s1_r4<=s1_r3;
    s2_r4<= s2_r3;
    inf_r4 <= inf_r3;
    zero_r4 <= zero_r3;
    start0_r4 <= start0_r3;
  end
//Pipeline Stage 5//
reg [N-1:0] xin1_r5;
reg [N-1:0] xin2_r5;
reg zero_tmp1_r5;
reg zero_tmp2_r5;
reg s1_r5;
reg s2_r5;
reg inf_r5, zero_r5, start0_r5;
  always@(posedge clk)begin
    xin1_r5 <= xin1_r4;
    xin2_r5 <= xin2_r4;
    zero_tmp1_r5<= zero_tmp1_r4;
    zero_tmp2_r5<= zero_tmp2_r4;
    s1_r5<=s1_r4;
    s2_r5<= s2_r4;
    inf_r5 <= inf_r4;
    zero_r5 <= zero_r4;
    start0_r5 <= start0_r4;
  end
//Pipeline Stage 6//
reg [N-1:0] xin1_r6;
reg [N-1:0] xin2_r6;
reg zero_tmp1_r6;
reg zero_tmp2_r6;
reg s1_r6;
reg s2_r6;
reg inf_r6, zero_r6, start0_r6;
  always@(posedge clk)begin
    xin1_r6 <= xin1_r5;
    xin2_r6 <= xin2_r5;
    zero_tmp1_r6<= zero_tmp1_r5;
    zero_tmp2_r6<= zero_tmp2_r5;
    s1_r6<=s1_r5;
    s2_r6<= s2_r5;
    inf_r6 <= inf_r5;
    zero_r6 <= zero_r5;
    start0_r6 <= start0_r5;
  end
//Pipeline Stage 7//
reg [N-1:0] xin1_r7;
reg [N-1:0] xin2_r7;
reg zero_tmp1_r7;
reg zero_tmp2_r7;
reg s1_r7;
reg s2_r7;
reg inf_r7, zero_r7, start0_r7;
  always@(posedge clk)begin
    xin1_r7 <= xin1_r6;
    xin2_r7 <= xin2_r6;
    zero_tmp1_r7<= zero_tmp1_r6;
    zero_tmp2_r7<= zero_tmp2_r6;
    s1_r7<=s1_r6;
    s2_r7<= s2_r6;
    inf_r7 <= inf_r6;
    zero_r7 <= zero_r6;
    start0_r7 <= start0_r6;
  end
//Pipeline Stage 8//
reg [N-1:0] xin1_r8;
reg [N-1:0] xin2_r8;
reg zero_tmp1_r8;
reg zero_tmp2_r8;
reg s1_r8;
reg s2_r8;
reg inf_r8, zero_r8, start0_r8;
  always@(posedge clk)begin
    xin1_r8 <= xin1_r7;
    xin2_r8 <= xin2_r7;
    zero_tmp1_r8<= zero_tmp1_r7;
    zero_tmp2_r8<= zero_tmp2_r7;
    s1_r8<=s1_r7;
    s2_r8<= s2_r7;
    inf_r8 <= inf_r7;
    zero_r8 <= zero_r7;
    start0_r8 <= start0_r7;
  end
wire [N-1:0] xin1_pipe;//Final wire
wire [N-1:0] xin2_pipe;//Final wire
assign xin1_pipe = xin1_r8;
assign xin2_pipe = xin2_r8;
  
  data_extract_v1 #(.N(N),.es(es)) uut_de1(.clk(clk), .in(xin1_pipe), .rc(rc1), .regime(regime1), .exp(e1), .mant(mant1));
  data_extract_v1 #(.N(N),.es(es)) uut_de2(.clk(clk), .in(xin2_pipe), .rc(rc2), .regime(regime2), .exp(e2), .mant(mant2));

//Pipeline Stage 1//
reg rc1_r1;
reg rc2_r1;
reg [Bs-1:0] regime1_r1,regime2_r1;
reg [es-1:0] e1_r1,e2_r1;
reg [M-1:0] mant1_r1;
reg [M-1:0] mant2_r1;
//reg zero_tmp1_r9;
//reg zero_tmp2_r9;
//reg s1_r9;
//reg s2_r9;
reg inf_r9, zero_r9, start0_r9;
always@(posedge clk)begin
  rc1_r1 <= rc1;
  rc2_r1 <= rc2;
  regime1_r1 <= regime1;
  regime2_r1 <= regime2;
  e1_r1 <= e1;
  e2_r1 <= e2;
  mant1_r1 <= mant1;
  mant2_r1 <= mant2;
  //zero_tmp1_r9 <= zero_tmp1_r8;
  //zero_tmp2_r9 <= zero_tmp2_r8;
  //s1_r9 <= s1_r8;
  //s2_r9 <= s2_r8;
  inf_r9 <= inf_r8;
  zero_r9 <= zero_r8;
  start0_r9 <= start0_r8;
end
///////////////////////////
//Pipeline Stage 2//
reg rc1_r2;
reg rc2_r2;
  reg [Bs-1:0] regime1_r2,regime2_r2;
  reg [es-1:0] e1_r2,e2_r2;
  reg [M-1:0] mant1_r2;
  reg [M-1:0] mant2_r2;
//reg zero_tmp1_r10;
//reg zero_tmp2_r10;
//reg s1_r10;
//reg s2_r10;
reg inf_r10, zero_r10, start0_r10;
always@(posedge clk)begin
  rc1_r2 <= rc1_r1;
  rc2_r2 <= rc2_r1;
  regime1_r2 <= regime1_r1;
  regime2_r2 <= regime2_r1;
  e1_r2 <= e1_r1;
  e2_r2 <= e2_r1;
  mant1_r2 <= mant1_r1;
  mant2_r2 <= mant2_r1;
  //zero_tmp1_r10 <= zero_tmp1_r9;
  //zero_tmp2_r10 <= zero_tmp2_r9;
  //s1_r10 <= s1_r9;
  //s2_r10 <= s2_r9;
  inf_r10 <= inf_r9;
  zero_r10 <= zero_r9;
  start0_r10 <= start0_r9;
end
///////////////////////////
//Pipeline Stage 3//
reg rc1_r3;
reg rc2_r3;
  reg [Bs-1:0] regime1_r3,regime2_r3;
  reg [es-1:0] e1_r3,e2_r3;
  reg [M-1:0] mant1_r3;
  reg [M-1:0] mant2_r3;
//reg zero_tmp1_r11;
//reg zero_tmp2_r11;
//reg s1_r11;
//reg s2_r11;
reg inf_r11, zero_r11, start0_r11;
always@(posedge clk)begin
  rc1_r3 <= rc1_r2;
  rc2_r3 <= rc2_r2;
  regime1_r3 <= regime1_r2;
  regime2_r3 <= regime2_r2;
  e1_r3 <= e1_r2;
  e2_r3 <= e2_r2;
  mant1_r3 <= mant1_r2;
  mant2_r3 <= mant2_r2;
  //zero_tmp1_r11 <= zero_tmp1_r2;
  //zero_tmp2_r11 <= zero_tmp2_r2;
  //s1_r11 <= s1_r10;
  //s2_r11 <= s2_r10;
  inf_r11 <= inf_r10;
  zero_r11 <= zero_r10;
  start0_r11 <= start0_r10;
end
///////////////////////////
///////////////////////////
//Pipeline Stage 4/
reg rc1_r4;
reg rc2_r4;
  reg [Bs-1:0] regime1_r4,regime2_r4;
  reg [es-1:0] e1_r4, e2_r4;
  reg [M-1:0] mant1_r4;
  reg [M-1:0] mant2_r4;
//reg zero_tmp1_r12;
//reg zero_tmp2_r12;
//reg s1_r12;
//reg s2_r12;
reg inf_r12, zero_r12, start0_r12;
always@(posedge clk)begin
  rc1_r4<= rc1_r3;
  rc2_r4<= rc2_r3;
  regime1_r4<= regime1_r3;
  regime2_r4<= regime2_r3;
  e1_r4<= e1_r3;
  e2_r4<= e2_r3;
  mant1_r4<= mant1_r3;
  mant2_r4<= mant2_r3;
  //zero_tmp1_r12<= zero_tmp1_r11;
  //zero_tmp2_r12<= zero_tmp2_r11;
  //s1_r12<=s1_r11;
  //s2_r12<= s2_r11;
  inf_r12 <= inf_r11;
  zero_r12 <= zero_r11;
  start0_r12 <= start0_r11;
end
///////////////////////////
///////////////////////////
//Pipeline Stage 5/
reg rc1_r5;
reg rc2_r5;
  reg [Bs-1:0] regime1_r5,regime2_r5;
  reg [es-1:0] e1_r5, e2_r5;
  reg [M-1:0] mant1_r5;
  reg [M-1:0] mant2_r5;
//reg zero_tmp1_r13;
//reg zero_tmp2_r13;
//reg s1_r13;
//reg s2_r13;
reg inf_r13, zero_r13, start0_r13;
always@(posedge clk)begin
  rc1_r5<= rc1_r4;
  rc2_r5<= rc2_r4;
  regime1_r5<= regime1_r4;
  regime2_r5<= regime2_r4;
  e1_r5<= e1_r4;
  e2_r5<= e2_r4;
  mant1_r5<= mant1_r4;
  mant2_r5<= mant2_r4;
  //zero_tmp1_r13<= zero_tmp1_r12;
  //zero_tmp2_r13<= zero_tmp2_r12;
  //s1_r5<=s1_r4;
  //s2_r5<= s2_r4;
  inf_r13 <= inf_r12;
  zero_r13 <= zero_r12;
  start0_r13 <= start0_r12;
end
///////////////////////////
///////////////////////////
//Pipeline Stage 6/
reg rc1_r6;
reg rc2_r6;
  reg [Bs-1:0] regime1_r6,regime2_r6;
  reg [es-1:0] e1_r6, e2_r6;
  reg [M-1:0] mant1_r6;
  reg [M-1:0] mant2_r6;
//reg zero_tmp1_r14;
//reg zero_tmp2_r14;
//reg s1_r14;
//reg s2_r14;
reg inf_r14, zero_r14, start0_r14;
always@(posedge clk)begin
  rc1_r6<= rc1_r5;
  rc2_r6<= rc2_r5;
  regime1_r6<= regime1_r5;
  regime2_r6<= regime2_r5;
  e1_r6<= e1_r5;
  e2_r6<= e2_r5;
  mant1_r6<= mant1_r5;
  mant2_r6<= mant2_r5;
  //zero_tmp1_r14<= zero_tmp1_r13;
  //zero_tmp2_r14<= zero_tmp2_r13;
  //s1_r14<=s1_r13;
  //s2_r14<= s2_r13;
  inf_r14 <= inf_r13;
  zero_r14 <= zero_r13;
  start0_r14 <= start0_r13;
end
///////////////////////////
///////////////////////////
//Pipeline Stage 7/
reg rc1_r7;
reg rc2_r7;
  reg [Bs-1:0] regime1_r7,regime2_r7;
  reg [es-1:0] e1_r7, e2_r7;
  reg [M-1:0] mant1_r7;
  reg [M-1:0] mant2_r7;
//reg zero_tmp1_r15;
//reg zero_tmp2_r15;
//reg s1_r15;
//reg s2_r15;
reg inf_r15, zero_r15, start0_r15;
always@(posedge clk)begin
  rc1_r7<= rc1_r6;
  rc2_r7<= rc2_r6;
  regime1_r7<= regime1_r6;
  regime2_r7<= regime2_r6;
  e1_r7<= e1_r6;
  e2_r7<= e2_r6;
  mant1_r7<= mant1_r6;
  mant2_r7<= mant2_r6;
  //zero_tmp1_r15<= zero_tmp1_r14;
  //zero_tmp2_r15<= zero_tmp2_r14;
  //s1_r15<=s1_r14;
  //s2_r15<= s2_r14;
  inf_r15 <= inf_r14;
  zero_r15 <= zero_r14;
  start0_r15 <= start0_r14;
end
///////////////////////////
///////////////////////////
//Pipeline Stage 8/
reg rc1_r8;
reg rc2_r8;
  reg [Bs-1:0] regime1_r8,regime2_r8;
  reg [es-1:0] e1_r8, e2_r8;
  reg [M-1:0] mant1_r8;
  reg [M-1:0] mant2_r8;
//reg zero_tmp1_r16;
//reg zero_tmp2_r16;
//reg s1_r16;
//reg s2_r16;
reg inf_r16, zero_r16, start0_r16;
always@(posedge clk)begin
  rc1_r8<= rc1_r7;
  rc2_r8<= rc2_r7;
  regime1_r8<= regime1_r7;
  regime2_r8<= regime2_r7;
  e1_r8<= e1_r7;
  e2_r8<= e2_r7;
  mant1_r8<= mant1_r7;
  mant2_r8<= mant2_r7;
  //zero_tmp1_r16<= zero_tmp1_r15;
  //zero_tmp2_r16<= zero_tmp2_r15;
  //s1_r16<=s1_r15;
  //s2_r16<= s2_r15;
  inf_r16 <= inf_r15;
  zero_r16 <= zero_r15;
  start0_r16 <= start0_r15;
end
///////////////////////////

  wire [M:0] m1 = {zero_tmp1_r8,mant1_r8},
  m2 = {zero_tmp2_r8,mant2_r8};
  
 
  
//Sign, Exponent and Mantissa Computation
wire div_s = s1_r8 ^ s2_r8;

  wire [Bs+1:0] r1 = rc1_r8 ? {2'b0,regime1_r8} : -regime1_r8;
  wire [Bs+1:0] r2 = rc2_r8 ? {2'b0,regime2_r8} : -regime2_r8;

wire [IW_MAX:0] m2_inv0_tmp;
generate
	if (M >= AW_MAX) //for 2 NR iteration
		if (AW == AW_MAX) begin : LUT_inst
			a1_inv_8bit9_lat0 i_uut (.clk(),.addr(m2[M-1:M-AW_MAX]),.dout(m2_inv0_tmp));
		end
		else begin : LUT_inst
			a1_inv_8bit9_lat0 i_uut (.clk(),.addr({m2[M-1:M-AW],{AW_MAX-AW{1'b0}}}),.dout(m2_inv0_tmp));
		end
		else begin : LUT_inst
		a1_inv_8bit9_lat0 i_uut (.clk(),.addr({m2[M-1:0],{AW_MAX-M{1'b0}}}),.dout(m2_inv0_tmp));//M =< AW_MAX, to use only a look-up table with 0-NR iteration.
	end
endgenerate

wire [IW:0] m2_inv0;
  
//Pipeline stage 1///
reg [IW:0] m2_inv0_r1;
reg [M:0] m1_r1;
  
always @(posedge clk)begin
  m2_inv0_r1 <= m2_inv0_tmp[IW_MAX:IW_MAX-IW];
  m1_r1<=m1                                  ;
end
//Pipeline stage 2///
reg [IW:0] m2_inv0_r2;
  reg [M:0] m1_r2;
always @(posedge clk)begin
  m2_inv0_r2 <= m2_inv0_r1;
  m1_r2<=m1_r1               ;
end
//Pipeline stage 3///
  reg [IW:0] m2_inv0_r3;
  reg [M:0] m1_r3;
always @(posedge clk)begin
  m2_inv0_r3 <= m2_inv0_r2;
  m1_r3 <= m1_r2          ;
end
//Pipeline stage 4///
  reg [IW:0] m2_inv0_r4;
  reg [M:0] m1_r4;
always @(posedge clk)begin
  m2_inv0_r4 <= m2_inv0_r3;
  m1_r4 <= m1_r3         ;
end
//Pipeline stage 5///
  reg [IW:0] m2_inv0_r5;
  reg [M:0] m1_r5;
always @(posedge clk)begin
  m2_inv0_r5 <= m2_inv0_r4;
  m1_r5<= m1_r4          ;
end
//Pipeline stage 6///
  reg [IW:0] m2_inv0_r6;
  reg [M:0] m1_r6;
always @(posedge clk)begin
  m2_inv0_r6 <= m2_inv0_r5;
  m1_r6 <= m1_r5          ;
end
//Pipeline stage 7///
  reg [IW:0] m2_inv0_r7;
  reg [M:0] m1_r7;
always @(posedge clk)begin
  m2_inv0_r7 <= m2_inv0_r6;
  m1_r7 <= m1_r6          ;
end
//Pipeline stage 8///
  reg [IW:0] m2_inv0_r8;
  reg [M:0] m1_r8;
always @(posedge clk)begin
  m2_inv0_r8 <= m2_inv0_r7;
  m1_r8 <= m1_r7         ;
end

//Pipeline stage 9///
  reg [M:0] m1_r9;
  reg [M-1:0] mant2_r9;
  always@(posedge clk)begin
    m1_r9<=m1_r8;
    mant2_r9 <= mant2_r8;
  end
  //Pipeline stage 10///
  reg [M:0] m1_r10;
  reg [M-1:0] mant2_r10;
  always@(posedge clk)begin
    m1_r10<=m1_r9;
    mant2_r10 <= mant2_r9;
  end
  //Pipeline stage 11///
  reg [M:0] m1_r11;
  reg [M-1:0] mant2_r11;
  always@(posedge clk)begin
    m1_r11<=m1_r10;
    mant2_r11 <= mant2_r10;
  end
  //Pipeline stage 12///
  reg [M:0] m1_r12;
  reg [M-1:0] mant2_r12;
  always@(posedge clk)begin
    m1_r12<=m1_r11;
    mant2_r12 <= mant2_r11;
  end
  //Pipeline stage 13///
  reg [M:0] m1_r13;
  reg [M-1:0] mant2_r13;
  always@(posedge clk)begin
    m1_r13<=m1_r12;
    mant2_r13 <= mant2_r12;
  end
  //Pipeline stage 14///
  reg [M:0] m1_r14;
  reg [M-1:0] mant2_r14;
  always@(posedge clk)begin
    m1_r14<=m1_r13;
    mant2_r14 <= mant2_r13;
  end
  //Pipeline stage 15///
  reg [M:0] m1_r15;
  reg [M-1:0] mant2_r15;
  always@(posedge clk)begin
    m1_r15<=m1_r14;
     mant2_r15 <= mant2_r14;
  end
  //Pipeline stage 16///
  reg [M:0] m1_r16;
  reg [M-1:0] mant2_r16;
  always@(posedge clk)begin
    m1_r16<=m1_r15;
     mant2_r16 <= mant2_r15;
  end
  //Pipeline stage 17///
  reg [M:0] m1_r17;
  reg [M-1:0] mant2_r17;
  always@(posedge clk)begin
    m1_r17<=m1_r16;
     mant2_r17 <= mant2_r16;
  end
  //Pipeline stage 18///
  reg [M:0] m1_r18;
  reg [M-1:0] mant2_r18;
  always@(posedge clk)begin
    m1_r18<=m1_r17;
     mant2_r18 <= mant2_r17;
  end
  //Pipeline stage 19///
  reg [M:0] m1_r19;
  reg [M-1:0] mant2_r19;
  always@(posedge clk)begin
    m1_r19<=m1_r18;
     mant2_r19 <= mant2_r18;
  end
  //Pipeline stage 20///
  reg [M:0] m1_r20;
  reg [M-1:0] mant2_r20;
  always@(posedge clk)begin
    m1_r20<=m1_r19;
     mant2_r20 <= mant2_r19;
  end
  //Pipeline stage 21///
  reg [M:0] m1_r21;
  reg [M-1:0] mant2_r21;
  always@(posedge clk)begin
    m1_r21<=m1_r20;
     mant2_r21 <= mant2_r20;
  end
  //Pipeline stage 22///
  reg [M:0] m1_r22;
  reg [M-1:0] mant2_r22;
  always@(posedge clk)begin
    m1_r22<=m1_r21;
     mant2_r22 <= mant2_r21;
  end
  //Pipeline stage 23///
  reg [M:0] m1_r23;
  reg [M-1:0] mant2_r23;
  always@(posedge clk)begin
    m1_r23<=m1_r22;
     mant2_r23 <= mant2_r22;
  end
  //Pipeline stage 2///
  reg [M:0] m1_r24;
  reg [M-1:0] mant2_r24;
  always@(posedge clk)begin
    m1_r24<=m1_r23;
     mant2_r24 <= mant2_r23;
  end

assign m2_inv0 = m2_inv0_r8;

wire [2*M+1:0] div_m;//Final wire
reg [2*M+1:0] div_m_r1_int;//Pipeline stage 1 reg
reg [2*M+1:0] div_m_r2_int;//Pipeline stage 2 reg
reg [2*M+1:0] div_m_r3_int;//Pipeline stage 3 reg
reg [2*M+1:0] div_m_r4_int;//Pipeline stage 4 reg
reg [2*M+1:0] div_m_r5_int;//Pipeline stage 5 reg
reg [2*M+1:0] div_m_r6_int;//Pipeline stage 6 reg
reg [2*M+1:0] div_m_r7_int;//Pipeline stage 7 reg
reg [2*M+1:0] div_m_r8_int;//Pipeline stage 8 reg
wire [2*M+1:0] div_m_pipe_start;//Beginning wire

genvar i;
generate
    
    wire [2*M+1:0] m2_inv [NR_Iter:0];//Final wire
    reg [2*M+1:0] m2_inv_r1 [NR_Iter:0];//Pipeline stage 1 reg
    reg [2*M+1:0] m2_inv_r2 [NR_Iter:0];//Pipeline stage 2 reg
    reg [2*M+1:0] m2_inv_r3 [NR_Iter:0];//Pipeline stage 3 reg
    reg [2*M+1:0] m2_inv_r4 [NR_Iter:0];//Pipeline stage 4 reg
    reg [2*M+1:0] m2_inv_r5 [NR_Iter:0];//Pipeline stage 5 reg
    reg [2*M+1:0] m2_inv_r6 [NR_Iter:0];//Pipeline stage 6 reg
    reg [2*M+1:0] m2_inv_r7 [NR_Iter:0];//Pipeline stage 7 reg
    reg [2*M+1:0] m2_inv_r8 [NR_Iter:0];//Pipeline stage 8 reg
    reg [2*M+1:0] m2_inv_r9 [NR_Iter:0];//Pipeline stage 9 reg
    reg [2*M+1:0] m2_inv_r10 [NR_Iter:0];//Pipeline stage 10 reg
    reg [2*M+1:0] m2_inv_r11 [NR_Iter:0];//Pipeline stage 11 reg
    reg [2*M+1:0] m2_inv_r12 [NR_Iter:0];//Pipeline stage 12 reg
    reg [2*M+1:0] m2_inv_r13 [NR_Iter:0];//Pipeline stage 13 reg
    reg [2*M+1:0] m2_inv_r14 [NR_Iter:0];//Pipeline stage 14 reg
    reg [2*M+1:0] m2_inv_r15 [NR_Iter:0];//Pipeline stage 15 reg
    reg [2*M+1:0] m2_inv_r16 [NR_Iter:0];//Pipeline stage 16 reg
    wire [2*M+1:0] m2_inv_pipe_start [NR_Iter:0];//Beginning wire
	
    if (NR_Iter > 0) begin : Mult
		//assign m2_inv[0] = {1'b0,m2_inv0,{M-IW{1'b0}},{M{1'b0}}};
        assign m2_inv_pipe_start[0] = {1'b0,m2_inv0,{M-IW{1'b0}},{M{1'b0}}};
        //Pipeline Stage 1//
      reg [M:0] m2_r1[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r1[0] <= m2_inv_pipe_start[0];
          m2_r1[0]<=m2                           ;
          m2_r1[1]<=m2                           ;
        end
        //Pipeline Stage 2//
      reg [M:0] m2_r2[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r2[0] <= m2_inv_r1[0];
          m2_r2[0]<=m2_r1[0]                ;
          m2_r2[1]<=m2_r1[1]                ;
        end
        //Pipeline Stage 3//
      reg [M:0] m2_r3[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r3[0] <= m2_inv_r2[0];
          m2_r3[0]<=m2_r2[0]                ;
          m2_r3[1]<=m2_r2[1]                ;
        end
        //Pipeline Stage 4//
      reg [M:0] m2_r4[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r4[0] <= m2_inv_r3[0];
          m2_r4[0]<=m2_r3[0]                ;
          m2_r4[1]<=m2_r3[1]                ;
        end
        //Pipeline Stage 5//
      reg [M:0] m2_r5[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r5[0] <= m2_inv_r4[0];
          m2_r5[0]<=m2_r4[0]                ;
          m2_r5[1]<=m2_r4[1]                ;
        end
        //Pipeline Stage 6//
      reg [M:0] m2_r6[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r6[0] <= m2_inv_r5[0];
          m2_r6[0]<=m2_r5[0]                ;
          m2_r6[1]<=m2_r5[1]                ;
        end
        //Pipeline Stage 7//
      reg [M:0] m2_r7[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r7[0] <= m2_inv_r6[0];
          m2_r7[0]<=m2_r6[0]                ;
          m2_r7[1]<=m2_r6[1]                ;
        end
        //Pipeline Stage 8//
      //reg [M:0] m2_r16[NR_Iter:0];
      reg [M:0] m2_r8[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r8[0] <= m2_inv_r7[0];
          m2_r8[0]<=m2_r8[0]                ;
          m2_r8[1]<=m2_r7[1]                ;
        end
        
       // assign m2_inv[0] = m2_inv_r8[0];
      //Pipeline stage 9//
      reg [M:0] m2_r9[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r9[0] <= m2_inv_r8[0];
          m2_r9[0]<=m2_r9[0]                ;
          m2_r9[1]<=m2_r8[1]                ;
        end
      //Pipeline stage 10//
      reg [M:0] m2_r10[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r10[0] <= m2_inv_r9[0];
          m2_r10[0]<=m2_r10[0]               ;
          m2_r10[1]<=m2_r9[1]                ;
        end
      //Pipeline stage 11//
      reg [M:0] m2_r11[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r11[0] <= m2_inv_r10[0];
          m2_r11[0]<=m2_r11[0]                ;
          m2_r11[1]<=m2_r10[1]                ;
        end
      //Pipeline stage 12//
      reg [M:0] m2_r12[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r12[0] <= m2_inv_r11[0];
          m2_r12[0]<=m2_r12[1]                ;       
          m2_r12[1]<=m2_r11[1]                ;
        end
       //Pipeline stage 13//
      reg [M:0] m2_r13[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r13[0] <= m2_inv_r12[0];
          m2_r13[0]<=m2_r3[0]                 ;
          m2_r13[1]<=m2_r12[1]                ;
        end
      //Pipeline stage 14//
      reg [M:0] m2_r14[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r14[0] <= m2_inv_r13[0];
          m2_r14[0]<=m2_r14[0]                ;
          m2_r14[1]<=m2_r13[1]                ;
        end
      //Pipeline stage 15//
      reg [M:0] m2_r15[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r15[0] <= m2_inv_r14[0];
          m2_r14[0]<=m2_r14[0]                ;
          m2_r15[1]<=m2_r14[1]                ;
        end
      //Pipeline stage 16//
        reg [M:0] m2_r16[NR_Iter:0];
        always@(posedge clk)begin
          m2_inv_r16[0] <= m2_inv_r15[0];
          m2_r16[0]<=m2_r16[1]                ;
          m2_r16[1]<=m2_r15[1]                ;
        end
      assign m2_inv[0] = m2_inv_r16[0];
		
        wire [2*M+1:0] m2_inv_X_m2 [NR_Iter-1:0];
        reg [2*M+1:0]  m2_inv_X_m2_r1 [NR_Iter-1:0];//Pipeline stage 1 reg
        reg [2*M+1:0]  m2_inv_X_m2_r2 [NR_Iter-1:0];//Pipeline stage 2 reg
        reg [2*M+1:0]  m2_inv_X_m2_r3 [NR_Iter-1:0];//Pipeline stage 3 reg
        reg [2*M+1:0]  m2_inv_X_m2_r4 [NR_Iter-1:0];//Pipeline stage 4 reg
        reg [2*M+1:0]  m2_inv_X_m2_r5 [NR_Iter-1:0];//Pipeline stage 5 reg
        reg [2*M+1:0]  m2_inv_X_m2_r6 [NR_Iter-1:0];//Pipeline stage 6 reg
        reg [2*M+1:0]  m2_inv_X_m2_r7 [NR_Iter-1:0];//Pipeline stage 7 reg
        reg [2*M+1:0]  m2_inv_X_m2_r8 [NR_Iter-1:0];//Pipeline stage 8 reg
        wire [2*M+1:0] m2_inv_X_m2_pipe [NR_Iter-1:0];//Final wire
		
        wire [M+1:0] two_m2_inv_X_m2 [NR_Iter-1:0];
        reg  [M+1:0] two_m2_inv_X_m2_r1 [NR_Iter-1:0];//Pipeline stage 1 reg
        reg  [M+1:0] two_m2_inv_X_m2_r2 [NR_Iter-1:0];//Pipeline stage 2 reg
        reg  [M+1:0] two_m2_inv_X_m2_r3 [NR_Iter-1:0];//Pipeline stage 3 reg
        reg  [M+1:0] two_m2_inv_X_m2_r4 [NR_Iter-1:0];//Pipeline stage 4 reg
        reg  [M+1:0] two_m2_inv_X_m2_r5 [NR_Iter-1:0];//Pipeline stage 5 reg
        reg  [M+1:0] two_m2_inv_X_m2_r6 [NR_Iter-1:0];//Pipeline stage 6 reg
        reg  [M+1:0] two_m2_inv_X_m2_r7 [NR_Iter-1:0];//Pipeline stage 7 reg
        reg  [M+1:0] two_m2_inv_X_m2_r8 [NR_Iter-1:0];//Pipeline stage 8 reg
        wire [M+1:0] two_m2_inv_X_m2_pipe [NR_Iter-1:0];//Final wire
		
        for (i = 0; i < NR_Iter; i=i+1)begin : NR_Iteration
          //assign m2_inv_X_m2[i] = {m2_inv[i][2*M:2*M-IW*(i+1)],{2*M-IW*(i+1)-M{1'b0}}} * m2_r16[i];
          product  p2 (clk, m2_inv_X_m2[i], {m2_inv[i][2*M:2*M-IW*(i+1)],{2*M-IW*(i+1)-M{1'b0}}}, m2_r16[i] );
          
            //Pipeline Stage 1//
            always@(posedge clk) begin
              m2_inv_X_m2_r1[i] <= m2_inv_X_m2[i]; 
            end
            //Pipeline Stage 2//
            always@(posedge clk) begin
              m2_inv_X_m2_r2[i] <= m2_inv_X_m2_r1[i]; 
            end
            //Pipeline Stage 3//
            always@(posedge clk) begin
              m2_inv_X_m2_r3[i] <= m2_inv_X_m2_r2[i]; 
            end
            //Pipeline Stage 4//
            always@(posedge clk) begin
              m2_inv_X_m2_r4[i] <= m2_inv_X_m2_r3[i]; 
            end
            //Pipeline Stage 5//
            always@(posedge clk) begin
              m2_inv_X_m2_r5[i] <= m2_inv_X_m2_r4[i]; 
            end
            //Pipeline Stage 6//
            always@(posedge clk) begin
              m2_inv_X_m2_r6[i] <= m2_inv_X_m2_r5[i]; 
            end
            //Pipeline Stage 7//
            always@(posedge clk) begin
              m2_inv_X_m2_r7[i] <= m2_inv_X_m2_r6[i]; 
            end
            //Pipeline Stage 8//
            always@(posedge clk) begin
              m2_inv_X_m2_r8[i] <= m2_inv_X_m2_r7[i]; 
            end
            
          assign m2_inv_X_m2_pipe[i] = m2_inv_X_m2_r8[i];
            
          sub_N #(.N(M+1)) uut_sub_m2 (clk,{1'b1,{M{1'b0}}}, {1'b0,m2_inv_X_m2_pipe[i][2*M+1:M+3],|m2_inv_X_m2_pipe[i][M+2:0]}, two_m2_inv_X_m2[i]);
            //Pipeline Stage 1//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r1[i] <= two_m2_inv_X_m2[i];
            end
            //Pipeline Stage 2//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r2[i] <= two_m2_inv_X_m2_r1[i];
            end
            //Pipeline Stage 3//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r3[i] <= two_m2_inv_X_m2_r2[i];
            end
            //Pipeline Stage 4//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r4[i] <= two_m2_inv_X_m2_r3[i];
            end
            //Pipeline Stage 5//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r5[i] <= two_m2_inv_X_m2_r4[i];
            end
            //Pipeline Stage 6//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r6[i] <= two_m2_inv_X_m2_r5[i];
            end
            //Pipeline Stage 7//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r7[i] <= two_m2_inv_X_m2_r6[i];
            end
            //Pipeline Stage 8//
            always@(posedge clk) begin
              two_m2_inv_X_m2_r8[i] <= two_m2_inv_X_m2_r7[i];
            end
            
            assign two_m2_inv_X_m2_pipe[i] = two_m2_inv_X_m2_r8[i];
          
          wire [2*M+1:0] m2_inv_pipe_start_int [NR_Iter:0]; //Beginning wire  
          //assign m2_inv[i+1] = {m2_inv[i][2*M:2*M-IW*(i+1)],{M-IW*(i+1){1'b0}}} * {two_m2_inv_X_m2_pipe[i][M-1:0],1'b0};
          product  p3 (clk, m2_inv_pipe_start_int [i+1], {m2_inv[i][2*M:2*M-IW*(i+1)],{M-IW*(i+1){1'b0}}}, {two_m2_inv_X_m2_pipe[i][M-1:0],1'b0} );
         // assign m2_inv_pipe_start_int [i+1] = {m2_inv[i][2*M:2*M-IW*(i+1)],{M-IW*(i+1){1'b0}}} * {two_m2_inv_X_m2_pipe[i][M-1:0],1'b0};
          //Pipeline Stage 1//
          reg [2*M+1:0] m2_inv_r1_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r1_int [i+1] <= m2_inv_pipe_start_int [i+1] ;
          end
          //Pipeline Stage 2//
          reg [2*M+1:0] m2_inv_r2_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r2_int [i+1] <= m2_inv_r1_int [i+1] ;
          end
          //Pipeline Stage 3//
          reg [2*M+1:0] m2_inv_r3_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r3_int [i+1] <= m2_inv_r2_int [i+1] ;
          end
          //Pipeline Stage 4//
          reg [2*M+1:0] m2_inv_r4_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r4_int [i+1] <= m2_inv_r3_int [i+1] ;
          end
          //Pipeline Stage 5//
          reg [2*M+1:0] m2_inv_r5_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r5_int [i+1] <= m2_inv_r4_int [i+1] ;
          end
          //Pipeline Stage 6//
          reg [2*M+1:0] m2_inv_r6_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r6_int [i+1] <= m2_inv_r5_int [i+1] ;
          end
          //Pipeline Stage 7//
          reg [2*M+1:0] m2_inv_r7_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r7_int [i+1] <= m2_inv_r6_int [i+1] ;
          end
          //Pipeline Stage 8//
          reg [2*M+1:0] m2_inv_r8_int[NR_Iter:0];
          always @(posedge clk) begin
            m2_inv_r8_int [i+1] <= m2_inv_r7_int [i+1] ;
          end
          assign m2_inv[i+1] = m2_inv_r8_int[i+1];
		end
	end
	else begin
        assign m2_inv_pipe_start[0] = {1'b0,m2_inv0,{M{1'b0}}};
        //Pipeline Stage 1//
        always@(posedge clk)begin
          m2_inv_r1[0] <= m2_inv_pipe_start[0];
        end
        //Pipeline Stage 2//
        always@(posedge clk)begin
          m2_inv_r2[0] <= m2_inv_r1[0];
        end
        //Pipeline Stage 3//
        always@(posedge clk)begin
          m2_inv_r3[0] <= m2_inv_r2[0];
        end
        //Pipeline Stage 4//
        always@(posedge clk)begin
          m2_inv_r4[0] <= m2_inv_r3[0];
        end
        //Pipeline Stage 5//
        always@(posedge clk)begin
          m2_inv_r5[0] <= m2_inv_r4[0];
        end
        //Pipeline Stage 6//
        always@(posedge clk)begin
          m2_inv_r6[0] <= m2_inv_r5[0];
        end
        //Pipeline Stage 7//
        always@(posedge clk)begin
          m2_inv_r7[0] <= m2_inv_r6[0];
        end
        //Pipeline Stage 8//
        always@(posedge clk)begin
          m2_inv_r8[0] <= m2_inv_r7[0];
        end
        
         assign m2_inv[0] = m2_inv_r8[0];
		//assign m2_inv[0] = {1'b0,m2_inv0,{M{1'b0}}};
        
	end
  wire [2*M+1:0] multi_result;
  product  p1 (clk, multi_result, m1_r24, m2_inv[NR_Iter][2*M:M]);
  //assign div_m_pipe_start = ~|mant2_r24 ? {1'b0,m1_r24,{M{1'b0}}} : m1_r24 * m2_inv[NR_Iter][2*M:M];
  assign div_m_pipe_start = ~|mant2_r24 ? {1'b0,m1_r24,{M{1'b0}}} : multi_result;
    //Pipeline Stage 1//
        always@(posedge clk)begin
          div_m_r1_int <= div_m_pipe_start;
        end
    //Pipeline Stage 2//
        always@(posedge clk)begin
          div_m_r2_int <= div_m_r1_int;
        end
    //Pipeline Stage 3//
        always@(posedge clk)begin
          div_m_r3_int <= div_m_r2_int;
        end
    //Pipeline Stage 4//
        always@(posedge clk)begin
          div_m_r4_int <= div_m_r3_int;
        end
    //Pipeline Stage 5//
        always@(posedge clk)begin
          div_m_r5_int <= div_m_r4_int;
        end
    //Pipeline Stage 6//
        always@(posedge clk)begin
          div_m_r6_int <= div_m_r5_int;
        end
    //Pipeline Stage 7//
        always@(posedge clk)begin
          div_m_r7_int <= div_m_r6_int;
        end
    //Pipeline Stage 8//
        always@(posedge clk)begin
          div_m_r8_int <= div_m_r7_int;
        end
    
      assign div_m = div_m_r8_int;
	//assign div_m = ~|mant2 ? {1'b0,m1,{M{1'b0}}} : m1 * m2_inv[NR_Iter][2*M:M];

endgenerate

//Pipeline Stage 1//
reg [2*M+1:0] div_m_r1;
reg div_m_udf_r1;
always@(posedge clk) begin
  div_m_r1 <= div_m;
  div_m_udf_r1 <= div_m[2*M+1];
end
//Pipeline Stage 2//
reg [2*M+1:0] div_m_r2;
reg div_m_udf_r2;
always@(posedge clk) begin
  div_m_r2 <= div_m_r1;
  div_m_udf_r2 <= div_m_udf_r1;
end
//Pipeline Stage 3//
  reg [2*M+1:0] div_m_r3;
reg div_m_udf_r3;
always@(posedge clk) begin
  div_m_r3 <= div_m_r2;
  div_m_udf_r3 <= div_m_udf_r2;
end
//Pipeline Stage 4//
  reg [2*M+1:0] div_m_r4;
reg div_m_udf_r4;
always@(posedge clk) begin
  div_m_r4 <= div_m_r3;
  div_m_udf_r4 <= div_m_udf_r3;
end
//Pipeline Stage 5//
  reg [2*M+1:0] div_m_r5;
reg div_m_udf_r5;
always@(posedge clk) begin
  div_m_r5 <= div_m_r4;
  div_m_udf_r5 <= div_m_udf_r4;
end
//Pipeline Stage 6//
  reg [2*M+1:0] div_m_r6;
reg div_m_udf_r6;
always@(posedge clk) begin
  div_m_r6 <= div_m_r5;
  div_m_udf_r6 <= div_m_udf_r5;
end
//Pipeline Stage 7//
  reg [2*M+1:0] div_m_r7;
reg div_m_udf_r7;
always@(posedge clk) begin
  div_m_r7 <= div_m_r6;
  div_m_udf_r7 <= div_m_udf_r6;
end
//Pipeline Stage 8//
  reg [2*M+1:0] div_m_r8;
reg div_m_udf_r8;
always@(posedge clk) begin
  div_m_r8 <= div_m_r7;
  div_m_udf_r8 <= div_m_udf_r7;
end

/////////////////////////////
wire div_m_udf = div_m_udf_r8;
wire [2*M+1:0] div_mN = ~div_m_udf ? div_m_r8 << 1'b1 : div_m_r8;

//Exponent and Regime Computation
wire bin = (~|mant2_r16 | div_m_udf) ? 0 : 1;
wire [Bs+es+1:0] div_e;// = {r1, e1} - {r2, e2} - bin;// 1 + ~|mant2 + div_m_udf;
sub_N_Bin #(.N(Bs+es+1)) uut_div_e (clk,{r1,e1_r8}, {r2,e2_r8}, bin, div_e);
//Pipeline Stage 1//
reg [Bs+es+1:0] div_e_r1;
always@(posedge clk) begin
  div_e_r1 <= div_e;
end
//Pipeline Stage 2//
reg [Bs+es+1:0] div_e_r2;
always@(posedge clk) begin
  div_e_r2 <= div_e_r1;
end
//Pipeline Stage 3//
reg [Bs+es+1:0] div_e_r3;
always@(posedge clk) begin
  div_e_r3 <= div_e_r2;
end
//Pipeline Stage 4//
reg [Bs+es+1:0] div_e_r4;
always@(posedge clk) begin
  div_e_r4 <= div_e_r3;
end
//Pipeline Stage 5//
reg [Bs+es+1:0] div_e_r5;
always@(posedge clk) begin
  div_e_r5 <= div_e_r4;
end
//Pipeline Stage 6//
reg [Bs+es+1:0] div_e_r6;
always@(posedge clk) begin
  div_e_r6 <= div_e_r5;
end
//Pipeline Stage 7//
reg [Bs+es+1:0] div_e_r7;
always@(posedge clk) begin
  div_e_r7 <= div_e_r6;
end
//Pipeline Stage 8//
reg [Bs+es+1:0] div_e_r8;
always@(posedge clk) begin
  div_e_r8 <= div_e_r7;
end
wire [Bs+es+1:0] div_e_pipe; //Final wire
assign div_e_pipe = div_e_r8;


wire [es-1:0] e_o;
wire [Bs:0] r_o;
  reg_exp_op #(.es(es), .Bs(Bs)) uut_reg_ro (clk, div_e_pipe[es+Bs+1:0], e_o, r_o);

//Exponent and Mantissa Packing
wire [2*N-1+3:0]tmp_o = {{N{~div_e_pipe[es+Bs+1]}},div_e_pipe[es+Bs+1],e_o,div_mN[2*M:2*M-(N-es-1)+1], div_mN[2*M-(N-es-1):2*M-(N-es-1)-1],|div_mN[2*M-(N-es-1)-2:0] };

//Pipeline Stage 1//
reg [Bs:0] r_o_r1;
reg [2*N-1+3:0] tmp_o_r1;
always@(posedge clk)begin
  r_o_r1<=r_o;
  tmp_o_r1<=tmp_o;
end
//Pipeline Stage 2//
reg [Bs:0] r_o_r2;
reg [2*N-1+3:0] tmp_o_r2;
always@(posedge clk)begin
  r_o_r2<=r_o_r1;
  tmp_o_r2<=tmp_o_r1;
end
//Pipeline Stage 3//
reg [Bs:0] r_o_r3;
reg [2*N-1+3:0] tmp_o_r3;
always@(posedge clk)begin
  r_o_r3<=r_o_r2;
  tmp_o_r3<=tmp_o_r2;
end
//Pipeline Stage 4//
reg [Bs:0] r_o_r4;
reg [2*N-1+3:0] tmp_o_r4;
always@(posedge clk)begin
  r_o_r4<=r_o_r3;
  tmp_o_r4<=tmp_o_r3;
end
//Pipeline Stage 5//
reg [Bs:0] r_o_r5;
reg [2*N-1+3:0] tmp_o_r5;
always@(posedge clk)begin
  r_o_r5<=r_o_r4;
  tmp_o_r5<=tmp_o_r4;
end
//Pipeline Stage 6//
reg [Bs:0] r_o_r6;
reg [2*N-1+3:0] tmp_o_r6;
always@(posedge clk)begin
  r_o_r6<=r_o_r5;
  tmp_o_r6<=tmp_o_r5;
end
//Pipeline Stage 7//
reg [Bs:0] r_o_r7;
reg [2*N-1+3:0] tmp_o_r7;
always@(posedge clk)begin
  r_o_r7<=r_o_r6;
  tmp_o_r7<=tmp_o_r6;
end
//Pipeline Stage 8//
reg [Bs:0] r_o_r8;
reg [2*N-1+3:0] tmp_o_r8;
always@(posedge clk)begin
  r_o_r8<=r_o_r7;
  tmp_o_r8<=tmp_o_r7;
end
wire [Bs:0] r_o_pipe;//Final wire
wire [2*N-1+3:0] tmp_o_pipe;//Final wire
assign r_o_pipe = r_o_r8;
assign tmp_o_pipe = tmp_o_r8;

//Including Regime bits in Exponent-Mantissa Packing
wire [3*N-1+3:0] tmp1_o;
  DSR_right_N_S #(.N(3*N+3), .S(Bs+1)) dsr2 (.clk(clk),.a({tmp_o_pipe,{N{1'b0}}}), .b(r_o_pipe[Bs] ? {Bs{1'b1}} : r_o_pipe), .c(tmp1_o));


//Rounding RNE : ulp_add = G.(R + S) + L.G.(~(R+S))
wire L = tmp1_o[N+4], G = tmp1_o[N+3], R = tmp1_o[N+2], St = |tmp1_o[N+1:0],
     ulp = ((G & (R | St)) | (L & G & ~(R | St)));
wire [N-1:0] rnd_ulp = {{N-1{1'b0}},ulp};

//Pipeline Stage 1//
reg [3*N-1+3:0] tmp1_o_r1;
reg [N-1:0] rnd_ulp_r1;
reg [Bs:0] r_o_r9;
always@(posedge clk)begin
  tmp1_o_r1 <= tmp1_o;
  rnd_ulp_r1<= rnd_ulp;
  r_o_r9<=r_o_pipe;
end
//Pipeline Stage 2//
reg [3*N-1+3:0] tmp1_o_r2;
reg [N-1:0] rnd_ulp_r2;
reg [Bs:0] r_o_r10;
always@(posedge clk)begin
  tmp1_o_r2 <= tmp1_o_r1;
  rnd_ulp_r2<= rnd_ulp_r1;
  r_o_r10<=r_o_r9;
end
//Pipeline Stage 3//
reg [3*N-1+3:0] tmp1_o_r3;
reg [N-1:0] rnd_ulp_r3;
reg [Bs:0] r_o_r11;
always@(posedge clk)begin
  tmp1_o_r3 <= tmp1_o_r2;
  rnd_ulp_r3<= rnd_ulp_r2;
  r_o_r11<=r_o_r10;
end
//Pipeline Stage 4//
reg [3*N-1+3:0] tmp1_o_r4;
reg [N-1:0] rnd_ulp_r4;
reg [Bs:0] r_o_r12;
always@(posedge clk)begin
  tmp1_o_r4 <= tmp1_o_r3;
  rnd_ulp_r4<= rnd_ulp_r3;
  r_o_r12<=r_o_r11;
end
//Pipeline Stage 5//
reg [3*N-1+3:0] tmp1_o_r5;
reg [N-1:0] rnd_ulp_r5;
reg [Bs:0] r_o_r13;
always@(posedge clk)begin
  tmp1_o_r5 <= tmp1_o_r4;
  rnd_ulp_r5<= rnd_ulp_r4;
  r_o_r13<=r_o_r12;
end
//Pipeline Stage 6//
reg [3*N-1+3:0] tmp1_o_r6;
reg [N-1:0] rnd_ulp_r6;
reg [Bs:0] r_o_r14;
always@(posedge clk)begin
  tmp1_o_r6 <= tmp1_o_r5;
  rnd_ulp_r6<= rnd_ulp_r5;
  r_o_r14<=r_o_r13;
end
//Pipeline Stage 7//
reg [3*N-1+3:0] tmp1_o_r7;
reg [N-1:0] rnd_ulp_r7;
reg [Bs:0] r_o_r15;
always@(posedge clk)begin
  tmp1_o_r7 <= tmp1_o_r6;
  rnd_ulp_r7<= rnd_ulp_r6;
  r_o_r15<=r_o_r14;
end
//Pipeline Stage 8//
reg [3*N-1+3:0] tmp1_o_r8;
reg [N-1:0] rnd_ulp_r8;
reg [Bs:0] r_o_r16;
always@(posedge clk)begin
  tmp1_o_r8 <= tmp1_o_r7;
  rnd_ulp_r8<= rnd_ulp_r7;
  r_o_r16<=r_o_r15;
end
wire [3*N-1+3:0] tmp1_o_pipe;//Final wire
wire [N-1:0] rnd_ulp_pipe;//Final wire
wire [Bs:0] r_o_pipe_next;//Final wire
assign tmp1_o_pipe = tmp1_o_r8;
assign rnd_ulp_pipe = rnd_ulp_r8;
assign r_o_pipe_next = r_o_r16;

wire [N:0] tmp1_o_rnd_ulp;
  add_N #(.N(N)) uut_add_ulp (clk, tmp1_o_pipe[2*N-1+3:N+3], rnd_ulp_pipe, tmp1_o_rnd_ulp);
wire [N-1:0] tmp1_o_rnd = (r_o_pipe_next < M-2) ? tmp1_o_rnd_ulp[N-1:0] : tmp1_o_pipe[2*N-1+3:N+3];


//Final Output
wire [N-1:0] tmp1_oN = div_s ? -tmp1_o_rnd : tmp1_o_rnd;
  assign out = inf_r16|zero_r16|(~div_mN[2*M+1]) ? {inf_r16,{N-1{1'b0}}} : {div_s, tmp1_oN[N-1:1]},
	done = start0_r16;
  
  
  /////Pipeline Stage 1 //////////
  reg [N-1:0] out_r1;
  reg inf_r17;
  reg zero_r17;
  reg done_r17;
  always@(posedge clk)begin
    out_r1 <= out;
    inf_r17 <= inf_r16;
    zero_r17<= zero_r16;
    done_r17<=done;
    
  end
  /////Pipeline Stage 2 //////////
  reg [N-1:0] out_r2;
  reg inf_r18;
  reg zero_r18;
  reg done_r18;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    inf_r18 <= inf_r17;
    zero_r18<= zero_r17;
    done_r18<=done_r17;
    
  end
  /////Pipeline Stage 3 //////////
  reg [N-1:0] out_r3;
  reg inf_r19;
  reg zero_r19;
  reg done_r19;
  always@(posedge clk)begin
    out_r3 <= out_r2;
    inf_r19 <= inf_r18;
    zero_r19<= zero_r18;
    done_r19<=done_r18;
    
  end
  /////Pipeline Stage 4 //////////
  reg [N-1:0] out_r4;
  reg inf_r20;
  reg zero_r20;
  reg done_r20;
  always@(posedge clk)begin
    out_r4 <= out_r3;
    inf_r20 <= inf_r19;
    zero_r20<= zero_r19;
    done_r20<=done_r19;
    
  end
  /////Pipeline Stage 5 //////////
  reg [N-1:0] out_r5;
  reg inf_r21;
  reg zero_r21;
  reg done_r21;
  always@(posedge clk)begin
    out_r5 <= out_r4;
    inf_r21 <= inf_r20;
    zero_r21<= zero_r20;
    done_r21<=done_r20;
    
  end
  /////Pipeline Stage 6 //////////
  reg [N-1:0] out_r6;
  reg inf_r22;
  reg zero_r22;
  reg done_r22;
  always@(posedge clk)begin
    out_r6 <= out_r5;
    inf_r22 <= inf_r21;
    zero_r22<= zero_r21;
    done_r22<=done_r21;
    
  end
  /////Pipeline Stage 7 //////////
  reg [N-1:0] out_r7;
  reg inf_r23;
  reg zero_r23;
  reg done_r23;
  always@(posedge clk)begin
    out_r7 <= out_r6;
    inf_r23 <= inf_r22;
    zero_r23<= zero_r22;
    done_r23<=done_r22;
    
  end
  /////Pipeline Stage 8 //////////
  reg [N-1:0] out_r8;
  reg inf_r24;
  reg zero_r24;
  reg done_r24;
  always@(posedge clk)begin
    out_r8 <= out_r7;
    inf_r24 <= inf_r23;
    zero_r24<= zero_r23;
    done_r24<=done_r23;
    
  end
  assign out_out = out_r8;
  assign inf_out = inf_r24;
  assign zero_out = zero_r24;
  assign done_out = done_r24;

endmodule

/////////////////////////
module data_extract_v1(clk,in, rc, regime, exp, mant);


parameter N=16;
parameter Bs=$clog2(N);
parameter es = 2;

input clk;
input [N-1:0] in;
output rc;
output [Bs-1:0] regime;
output [es-1:0] exp;
output [N-es-1:0] mant;

wire [N-1:0] xin = in;
assign rc = xin[N-2];

wire [N-1:0] xin_r = rc ? ~xin : xin;

wire [Bs-1:0] k;
LOD_N #(.N(N)) xinst_k(.clk(clk), .in({xin_r[N-2:0],rc^1'b0}), .out(k));

assign regime = rc ? k-1 : k;

wire [N-1:0] xin_tmp;
DSR_left_N_S #(.N(N), .S(Bs)) ls (.clk(clk), .a({xin[N-3:0],2'b0}),.b(k),.c(xin_tmp));

assign exp= xin_tmp[N-1:N-es];
assign mant= xin_tmp[N-es-1:0];

endmodule



/////////////////
module sub_N (clk,a,b,c);
parameter N=10;
input clk;
input [N-1:0] a,b;
output [N:0] c;
//Pipeline Stage 1//
reg [N:0] c_r1;
always@(posedge clk)begin
   c_r1 <= {1'b0,a} - {1'b0,b};
end
//Pipeline Stage 2//
reg [N:0] c_r2;
always@(posedge clk)begin
   c_r2 <= c_r1;
end
//Pipeline Stage 3//
reg [N:0] c_r3;
always@(posedge clk)begin
   c_r3 <= c_r2;
end
//Pipeline Stage 4//
  reg [N:0] c_r4;
always@(posedge clk)begin
   c_r4 <= c_r3;
end

assign c = c_r4;
endmodule

/////////////////////////
module sub_N_Bin (clk,a,b,bin,c);
parameter N=10;
input clk;
input [N:0] a,b;
input bin;
output [N:0] c;
//Pipeline Stage 1//
reg[N:0] c_r1;
always@(posedge clk)begin
    c_r1<= a - b - bin;
end
//Pipeline Stage 2//
reg[N:0] c_r2;
always@(posedge clk)begin
    c_r2<= c_r1;
end
//Pipeline Stage 3//
reg[N:0] c_r3;
always@(posedge clk)begin
    c_r3<= c_r2;
end
//Pipeline Stage 4//
  reg[N:0] c_r4;
always@(posedge clk)begin
    c_r4<= c_r3;
end



assign c = c_r4;
endmodule


/////////////////////////
module add_N (clk,a,b,c);
parameter N=10;
input clk;
input [N-1:0] a,b;
output [N:0] c;
//assign c = {1'b0,a} + {1'b0,b};
reg [N:0] c_r1;
always@(posedge clk)begin
  c_r1<={1'b0,a} + {1'b0,b};
end
reg [N:0] c_r2;
always@(posedge clk)begin
  c_r2<=c_r1;
end
  reg [N:0] c_r3;
always@(posedge clk)begin
  c_r3<=c_r2;
end
  reg [N:0] c_r4;
always@(posedge clk)begin
  c_r4<=c_r3;
end
assign c = c_r4;
endmodule

/////////////////////////
module add_1 (clk,a,mant_ovf,c);
parameter N=10;
input clk;
input [N:0] a;
input mant_ovf;
output [N:0] c;
  reg [N:0] c_r1;
  always@(posedge clk)begin
    c_r1<=a + mant_ovf;
  end
  reg [N:0] c_r2;
  always@(posedge clk)begin
    c_r2<=c_r1;
  end
  reg [N:0] c_r3;
  always@(posedge clk)begin
    c_r3<=c_r2;
  end
  reg [N:0] c_r4;
  always@(posedge clk)begin
    c_r4<=c_r3;
  end
assign c = c_r4;
endmodule

/*/////////////////////////
module conv_2c (a,c);
parameter N=10;
input [N:0] a;
output [N:0] c;
assign c = a + 1'b1;
endmodule

/////////////////////////
module reg_exp_op (exp_o, e_o, r_o);
parameter es=3;
parameter Bs=5;
input [es+Bs+1:0] exp_o;
output [es-1:0] e_o;
output [Bs:0] r_o;

assign e_o = exp_o[es-1:0];

wire [es+Bs:0] exp_oN_tmp;
conv_2c #(.N(es+Bs)) uut_conv_2c1 (~exp_o[es+Bs:0],exp_oN_tmp);
wire [es+Bs:0] exp_oN = exp_o[es+Bs+1] ? exp_oN_tmp[es+Bs:0] : exp_o[es+Bs:0];

assign r_o = (~exp_o[es+Bs+1] || |(exp_oN[es-1:0])) ? exp_oN[es+Bs:es] + 1 : exp_oN[es+Bs:es];
endmodule*/

module reg_exp_op (clk,exp_o, e_o, r_o);
parameter es=3;
parameter Bs=5;
input clk;
input [es+Bs+1:0] exp_o;
output [es-1:0] e_o;
output [Bs:0] r_o;

//Pipeline Stage 1//
reg[es-1:0] e_o_r1;
  always@(posedge clk)begin
    e_o_r1<= exp_o[es-1:0];
  end
//Pipeline Stage 2//
  reg[es-1:0] e_o_r2;
  always@(posedge clk)begin
    e_o_r2<= e_o_r1;
  end
//Pipeline Stage 3//
  reg[es-1:0] e_o_r3;
  always@(posedge clk)begin
    e_o_r3<= e_o_r2;
  end
//Pipeline Stage 4//
  reg[es-1:0] e_o_r4;
  always@(posedge clk)begin
    e_o_r4<= e_o_r3;
  end
  
  assign e_o = e_o_r4;


wire [es+Bs:0] exp_oN_tmp;
  conv_2c_mult_div #(.N(es+Bs)) uut_conv_2c1 (clk,~exp_o[es+Bs:0],exp_oN_tmp);
wire [es+Bs:0] exp_oN = exp_o[es+Bs+1] ? exp_oN_tmp[es+Bs:0] : exp_o[es+Bs:0];

//assign r_o = (~exp_o[es+Bs+1] || |(exp_oN[es-1:0])) ? exp_oN[es+Bs:es] + 1 : exp_oN[es+Bs:es];
//Pipeline Stage 1
reg [Bs:0] r_o_r1;
always@(posedge clk)begin
  r_o_r1 <= (~exp_o[es+Bs+1] || |(exp_oN[es-1:0])) ? exp_oN[es+Bs:es] + 1 : exp_oN[es+Bs:es];
end
//Pipeline Stage 2
  reg [Bs:0] r_o_r2;
always@(posedge clk)begin
  r_o_r2 <= r_o_r1;
end
//Pipeline Stage 3
  reg [Bs:0] r_o_r3;
always@(posedge clk)begin
  r_o_r3 <= r_o_r2;
end
//Pipeline Stage 4
  reg [Bs:0] r_o_r4;
always@(posedge clk)begin
  r_o_r4 <= r_o_r3;
end
assign r_o = r_o_r4;
endmodule

/////////////////////////
module conv_2c_mult_div (clk,a,c);
parameter N=10;
input clk;
input [N:0] a;
output [N:0] c;
//Pipeline Stage 1//
reg[N:0] c_r1;
  always@(posedge clk)begin
    c_r1<= a + 1'b1;
  end
//Pipeline Stage 2//
  reg[N:0] c_r2;
  always@(posedge clk)begin
    c_r2<= c_r1;
  end 
//Pipeline Stage 3//
  reg[N:0] c_r3;
  always@(posedge clk)begin
    c_r3<= c_r2;
  end 
//Pipeline Stage 4//
  reg[N:0] c_r4;
  always@(posedge clk)begin
    c_r4<= c_r3;
  end 
assign c = c_r4;
endmodule

module DSR_left_N_S(clk,a,b,c);
        parameter N=16;
        parameter S=4;
        input clk;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a << 7'd1  : a; 
/*genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
		assign tmp[i] = b[i] ? tmp[i-1] << 2**i : tmp[i-1];
	end
endgenerate*/
//pipeline reg 1//
  reg [N-1:0] tmp_r1;
  reg [S-1:0] b_r1;
  always@(posedge clk)begin
    tmp_r1 <= tmp[0];
    b_r1 <= b;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r2;
  reg [S-1:0] b_r2;
  always@(posedge clk)begin
    tmp_r2 <= tmp_r1;
    b_r2 <= b_r1;
  end
  assign tmp[1]  = b_r2[1] ? tmp_r2 << 7'd2  : tmp_r2;
//pipeline reg 1//
  reg [N-1:0] tmp_r11;
  reg [S-1:0] b_r11;
  always@(posedge clk)begin
    tmp_r11 <= tmp[1];
    b_r11 <= b_r2;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r22;
  reg [S-1:0] b_r22;
  always@(posedge clk)begin
    tmp_r22 <= tmp_r11;
    b_r22 <= b_r11;
  end
  assign tmp[2]  = b_r22[2] ? tmp_r22 << 7'd4  : tmp_r22;
  //pipeline reg 1//
  reg [N-1:0] tmp_r33;
  reg [S-1:0] b_r33;
  always@(posedge clk)begin
    tmp_r33 <= tmp[2];
    b_r33 <= b_r22;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r44;
  reg [S-1:0] b_r44;
  always@(posedge clk)begin
    tmp_r44 <= tmp_r33;
    b_r44 <= b_r33;
  end

//assign tmp[3]  = b[3] ? tmp[2] >> 7'd8  : tmp[2];
//assign tmp[4]  = b[4] ? tmp[3] >> 7'd16  : tmp[3];
  assign tmp[3]  = b_r44[3] ? tmp_r44 << 7'd8  : tmp_r44;
  //pipeline reg 1//
  reg [N-1:0] tmp_r55;
  reg [S-1:0] b_r55;
  always@(posedge clk)begin
    tmp_r55 <= tmp[3];
    b_r55 <= b_r44;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r66;
  reg [S-1:0] b_r66;
  always@(posedge clk)begin
    tmp_r66 <= tmp_r55;
    b_r66 <= b_r55;
  end
  assign tmp[4]  = b_r66[4] ? tmp_r66 << 7'd16  : tmp_r66;
assign c = tmp[S-1];

endmodule

module DSR_right_N_S(clk,a,b,c);
        parameter N=16;
        parameter S=4;
        input clk;
        input [N-1:0] a;
        input [S-1:0] b;
        output [N-1:0] c;

wire [N-1:0] tmp [S-1:0];
assign tmp[0]  = b[0] ? a >> 7'd1  : a; 
//pipeline reg 1//
  reg [N-1:0] tmp_r1;
  reg [S-1:0] b_r1;
  always@(posedge clk)begin
    tmp_r1 <= tmp[0];
    b_r1 <= b;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r2;
  reg [S-1:0] b_r2;
  always@(posedge clk)begin
    tmp_r2 <= tmp_r1;
    b_r2 <= b_r1;
  end
assign tmp[1]  = b_r2[1] ? tmp_r2 >> 7'd2  : tmp_r2;
//pipeline reg 1//
  reg [N-1:0] tmp_r11;
  reg [S-1:0] b_r11;
  always@(posedge clk)begin
    tmp_r11 <= tmp[1];
    b_r11 <= b_r2;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r22;
  reg [S-1:0] b_r22;
  always@(posedge clk)begin
    tmp_r22 <= tmp_r11;
    b_r22 <= b_r11;
  end
  assign tmp[2]  = b_r22[2] ? tmp_r22 >> 7'd4  : tmp_r22;
  //pipeline reg 1//
  reg [N-1:0] tmp_r33;
  reg [S-1:0] b_r33;
  always@(posedge clk)begin
    tmp_r33 <= tmp[2];
    b_r33 <= b_r22;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r44;
  reg [S-1:0] b_r44;
  always@(posedge clk)begin
    tmp_r44 <= tmp_r33;
    b_r44 <= b_r33;
  end

//assign tmp[3]  = b[3] ? tmp[2] >> 7'd8  : tmp[2];
//assign tmp[4]  = b[4] ? tmp[3] >> 7'd16  : tmp[3];
  assign tmp[3]  = b_r44[3] ? tmp_r44 >> 7'd8  : tmp_r44;
  //pipeline reg 1//
  reg [N-1:0] tmp_r55;
  reg [S-1:0] b_r55;
  always@(posedge clk)begin
    tmp_r55 <= tmp[3];
    b_r55 <= b_r44;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r66;
  reg [S-1:0] b_r66;
  always@(posedge clk)begin
    tmp_r66 <= tmp_r55;
    b_r66 <= b_r55;
  end
  assign tmp[4]  = b_r66[4] ? tmp_r66 >> 7'd16  : tmp_r66;
 //pipeline reg 1//
  reg [N-1:0] tmp_r77;
  reg [S-1:0] b_r77;
  always@(posedge clk)begin
    tmp_r77 <= tmp[4];
    b_r77 <= b_r66;
  end
//pipeline reg 2//
  reg [N-1:0] tmp_r88;
  reg [S-1:0] b_r88;
  always@(posedge clk)begin
    tmp_r88 <= tmp_r77;
    b_r88 <= b_r77;
  end
  assign tmp[5]  = b_r88[5] ? tmp_r88 >> 7'd32  : tmp_r88;


/*genvar i;
generate
	for (i=1; i<S; i=i+1)begin:loop_blk
		assign tmp[i] = b[i] ? tmp[i-1] >> 2**i : tmp[i-1];
	end
endgenerate*/
assign c = tmp[S-1];

endmodule


///////////////////////
module LOD_N(clk,in, out);
parameter N = 32;
input clk;
input [31:0] in;
output [4:0] out;
wire [3:0] out_l, out_h;
wire out_vl, out_vh;

wire [4:0] out_pipe;
  
  LOD16_4 pl(.clk(clk),.in(in[15:0]), .out(out_l), .out_v(out_vl));
  LOD16_4 ph(.clk(clk),.in(in[31:16]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};

//Pipe Stage 5//
  reg [4:0] out_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
  end
//Pipe Stage 4//
  reg [4:0] out_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
  end
assign out = out_r2;
endmodule

////////////////////
module LOD16_4(clk, in, out, out_v);
input clk;
input [15:0] in;
output [3:0] out;
output out_v;
wire [2:0] out_l, out_h;
wire out_vl, out_vh;

wire [3:0] out_pipe;
wire out_v_pipe;

LOD8_3 pl(.clk(clk),.in(in[7:0]), .out(out_l), .out_v(out_vl));
LOD8_3 ph(.clk(clk),.in(in[15:8]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;

//Pipe Stage 4//
  reg [3:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 4//
  reg [3:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule

////////////////////
module LOD8_3(clk,in, out, out_v);
input clk;
input [7:0] in;
output [2:0] out;
output out_v;

wire [1:0] out_l, out_h;
wire out_vl, out_vh;
  
wire [2:0] out_pipe;
wire out_v_pipe;

LOD4_2 pl(.clk(clk),.in(in[3:0]), .out(out_l), .out_v(out_vl));
LOD4_2 ph(.clk(clk),.in(in[7:4]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;
//Pipe Stage 3//
  reg [2:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 3//
  reg [2:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule


////////////////////
module LOD4_2(clk,in, out, out_v);
input clk;
input [3:0] in;
output [1:0] out;
output out_v;

wire out_l, out_h;
wire out_vl, out_vh;
  
wire [1:0] out_pipe;
wire out_v_pipe;

LOD2_1 pl(.clk(clk),.in(in[1:0]), .out(out_l), .out_v(out_vl));
LOD2_1 ph(.clk(clk),.in(in[3:2]), .out(out_h), .out_v(out_vh));
assign out_pipe = out_vh ? {1'b0,out_h} : {out_vl,out_l};
assign out_v_pipe = out_vl | out_vh;
//Pipe Stage 2//
  reg [1:0] out_r1;
  reg out_v_r1;
  always@(posedge clk)begin
    out_r1 <= out_pipe;
    out_v_r1 <= out_v_pipe;
  end
//Pipe Stage 2//
  reg [1:0] out_r2;
  reg out_v_r2;
  always@(posedge clk)begin
    out_r2 <= out_r1;
    out_v_r2 <= out_v_r1;
  end
assign out = out_r2;
assign out_v = out_v_r2;

endmodule


module LOD2_1(clk,in, out, out_v);
input clk;
input [1:0] in;
output out;
output out_v;
wire out_pipe;
wire out_v_pipe;
assign out_pipe = ~in[1] & in[0];
assign out_v_pipe = |in;
//Pipe stage 1//
reg out_r1;
reg out_v_r1;
always@(posedge clk) begin
  out_r1 <= out_pipe;
  out_v_r1 <= out_v_pipe;
end
//Pipe stage 1//
reg out_r2;
reg out_v_r2;
always@(posedge clk) begin
  out_r2 <= out_r1;
  out_v_r2 <= out_v_r1;
end
assign out = out_r2;
assign out_v = out_v_r2;
endmodule


/////////////////////////
module a1_inv_8bit9_lat0 (clk, addr, dout);
  input clk;
  output reg [8 : 0] dout;
  input  [7 : 0] addr;

   reg [8:0] a1_inv_rom [(2**8-1):0];

always @(*) begin 
	case (addr) 
		8'd000	:       dout <= 9'h1ff;
		8'd001  :       dout <= 9'h1fe;
		8'd002  :       dout <= 9'h1fc;
                8'd003  :       dout <= 9'h1fa;
	        8'd004  :       dout <= 9'h1f8;
                8'd005  :       dout <= 9'h1f6;
                8'd006  :       dout <= 9'h1f4;
                8'd007  :       dout <= 9'h1f2;
                8'd008	:       dout <= 9'h1f0;
                8'd009  :       dout <= 9'h1ee;
                8'd010  :       dout <= 9'h1ec;
                8'd011  :       dout <= 9'h1ea;
                8'd012  :       dout <= 9'h1e9;
                8'd013  :       dout <= 9'h1e7;
                8'd014  :       dout <= 9'h1e5;
                8'd015  :       dout <= 9'h1e3;
                8'd016  :       dout <= 9'h1e1;
                8'd017  :       dout <= 9'h1e0;
                8'd018	:       dout <= 9'h1de;
                8'd019  :       dout <= 9'h1dc;
                8'd020  :       dout <= 9'h1da;
                8'd021  :       dout <= 9'h1d9;
                8'd022  :       dout <= 9'h1d7;
                8'd023  :       dout <= 9'h1d5;
                8'd024  :       dout <= 9'h1d4;
                8'd025  :       dout <= 9'h1d2;
                8'd026  :       dout <= 9'h1d0;
                8'd027  :       dout <= 9'h1cf;
                8'd028	:       dout <= 9'h1cd;
                8'd029  :       dout <= 9'h1cb;
                8'd030  :       dout <= 9'h1ca;
                8'd031  :       dout <= 9'h1c8;
                8'd032  :       dout <= 9'h1c7;
                8'd033  :       dout <= 9'h1c5;
                8'd034  :       dout <= 9'h1c3;
                8'd035  :       dout <= 9'h1c2;
                8'd036  :       dout <= 9'h1c0;
                8'd037  :       dout <= 9'h1bf;
                8'd038	:       dout <= 9'h1bd;
                8'd039  :       dout <= 9'h1bc;
                8'd040  :       dout <= 9'h1ba;
                8'd041  :       dout <= 9'h1b9;
                8'd042  :       dout <= 9'h1b7;
                8'd043  :       dout <= 9'h1b6;
                8'd044  :       dout <= 9'h1b4;
                8'd045  :       dout <= 9'h1b3;
                8'd046  :       dout <= 9'h1b2;
                8'd047  :       dout <= 9'h1b0;
                8'd048	:       dout <= 9'h1af;
                8'd049  :       dout <= 9'h1ad;
                8'd050  :       dout <= 9'h1ac;
                8'd051  :       dout <= 9'h1aa;
                8'd052  :       dout <= 9'h1a9;
                8'd053  :       dout <= 9'h1a8;
                8'd054  :       dout <= 9'h1a6;
                8'd055  :       dout <= 9'h1a5;
                8'd056  :       dout <= 9'h1a4;
                8'd057  :       dout <= 9'h1a2;
                8'd058	:       dout <= 9'h1a1;
                8'd059  :       dout <= 9'h1a0;
                8'd060  :       dout <= 9'h19e;
                8'd061  :       dout <= 9'h19d;
                8'd062  :       dout <= 9'h19c;
                8'd063  :       dout <= 9'h19a;
                8'd064  :       dout <= 9'h199;
                8'd065  :       dout <= 9'h198;
                8'd066  :       dout <= 9'h197;
                8'd067  :       dout <= 9'h195;
                8'd068	:       dout <= 9'h194;
                8'd069  :       dout <= 9'h193;
                8'd070  :       dout <= 9'h192;
                8'd071  :       dout <= 9'h190;
                8'd072  :       dout <= 9'h18f;
                8'd073  :       dout <= 9'h18e;
                8'd074  :       dout <= 9'h18d;
                8'd075  :       dout <= 9'h18b;
                8'd076  :       dout <= 9'h18a;
                8'd077  :       dout <= 9'h189;
                8'd078	:       dout <= 9'h188;
                8'd079  :       dout <= 9'h187;
                8'd080  :       dout <= 9'h186;
                8'd081  :       dout <= 9'h184;
                8'd082  :       dout <= 9'h183;
                8'd083  :       dout <= 9'h182;
                8'd084  :       dout <= 9'h181;
                8'd085  :       dout <= 9'h180;
                8'd086  :       dout <= 9'h17f;
                8'd087  :       dout <= 9'h17e;
                8'd088	:       dout <= 9'h17d;
                8'd089  :       dout <= 9'h17b;
                8'd090  :       dout <= 9'h17a;
                8'd091  :       dout <= 9'h179;
                8'd092  :       dout <= 9'h178;
                8'd093  :       dout <= 9'h177;
                8'd094  :       dout <= 9'h176;
                8'd095  :       dout <= 9'h175;
                8'd096  :       dout <= 9'h174;
                8'd097  :       dout <= 9'h173;
                8'd098	:       dout <= 9'h172;
                8'd099  :       dout <= 9'h171;
                8'd100  :       dout <= 9'h170;
                8'd101  :       dout <= 9'h16f;
                8'd102  :       dout <= 9'h16e;
                8'd103  :       dout <= 9'h16d;
                8'd104  :       dout <= 9'h16c;
                8'd105  :       dout <= 9'h16b;
                8'd106  :       dout <= 9'h16a;
                8'd107  :       dout <= 9'h169;
                8'd108	:       dout <= 9'h168;
                8'd109  :       dout <= 9'h167;
                8'd110  :       dout <= 9'h166;
                8'd111  :       dout <= 9'h165;
                8'd112  :       dout <= 9'h164;
                8'd113  :       dout <= 9'h163;
                8'd114  :       dout <= 9'h162;
                8'd115  :       dout <= 9'h161;
                8'd116  :       dout <= 9'h160;
                8'd117  :       dout <= 9'h15f;
                8'd118	:       dout <= 9'h15e;
                8'd119  :       dout <= 9'h15d;
                8'd120  :       dout <= 9'h15c;
                8'd121  :       dout <= 9'h15b;
                8'd122  :       dout <= 9'h15a;
                8'd123  :       dout <= 9'h159;
                8'd124  :       dout <= 9'h158;
                8'd125  :       dout <= 9'h158;
                8'd126  :       dout <= 9'h157;
                8'd127  :       dout <= 9'h156;
                8'd128	:       dout <= 9'h155;
                8'd129  :       dout <= 9'h154;
                8'd130  :       dout <= 9'h153;
                8'd131  :       dout <= 9'h152;
                8'd132  :       dout <= 9'h151;
                8'd133  :       dout <= 9'h150;
                8'd134  :       dout <= 9'h150;
                8'd135  :       dout <= 9'h14f;
                8'd136  :       dout <= 9'h14e;
                8'd137  :       dout <= 9'h14d;
                8'd138	:       dout <= 9'h14c;
                8'd139  :       dout <= 9'h14b;
                8'd140  :       dout <= 9'h14a;
                8'd141  :       dout <= 9'h14a;
                8'd142  :       dout <= 9'h149;
                8'd143  :       dout <= 9'h148;
                8'd144  :       dout <= 9'h147;
                8'd145  :       dout <= 9'h146;
                8'd146  :       dout <= 9'h146;
                8'd147  :       dout <= 9'h145;
                8'd148	:       dout <= 9'h144;
                8'd149  :       dout <= 9'h143;
                8'd150  :       dout <= 9'h142;
                8'd151  :       dout <= 9'h142;
                8'd152  :       dout <= 9'h141;
                8'd153  :       dout <= 9'h140;
                8'd154  :       dout <= 9'h13f;
                8'd155  :       dout <= 9'h13e;
                8'd156  :       dout <= 9'h13e;
                8'd157  :       dout <= 9'h13d;
                8'd158	:       dout <= 9'h13c;
                8'd159  :       dout <= 9'h13b;
                8'd160  :       dout <= 9'h13b;
                8'd161  :       dout <= 9'h13a;
                8'd162  :       dout <= 9'h139;
                8'd163  :       dout <= 9'h138;
                8'd164  :       dout <= 9'h138;
                8'd165  :       dout <= 9'h137;
                8'd166  :       dout <= 9'h136;
                8'd167  :       dout <= 9'h135;
                8'd168	:       dout <= 9'h135;
                8'd169  :       dout <= 9'h134;
                8'd170  :       dout <= 9'h133;
                8'd171  :       dout <= 9'h132;
                8'd172  :       dout <= 9'h132;
                8'd173  :       dout <= 9'h131;
                8'd174  :       dout <= 9'h130;
                8'd175  :       dout <= 9'h130;
                8'd176  :       dout <= 9'h12f;
                8'd177  :       dout <= 9'h12e;
                8'd178	:       dout <= 9'h12e;
                8'd179  :       dout <= 9'h12d;
                8'd180  :       dout <= 9'h12c;
                8'd181  :       dout <= 9'h12b;
                8'd182  :       dout <= 9'h12b;
                8'd183  :       dout <= 9'h12a;
                8'd184  :       dout <= 9'h129;
                8'd185  :       dout <= 9'h129;
                8'd186  :       dout <= 9'h128;
                8'd187  :       dout <= 9'h127;
                8'd188	:       dout <= 9'h127;
                8'd189  :       dout <= 9'h126;
                8'd190  :       dout <= 9'h125;
                8'd191  :       dout <= 9'h125;
                8'd192  :       dout <= 9'h124;
                8'd193  :       dout <= 9'h123;
                8'd194  :       dout <= 9'h123;
                8'd195  :       dout <= 9'h122;
                8'd196  :       dout <= 9'h121;
                8'd197  :       dout <= 9'h121;
                8'd198	:       dout <= 9'h120;
                8'd199  :       dout <= 9'h120;
                8'd200  :       dout <= 9'h11f;
                8'd201  :       dout <= 9'h11e;
                8'd202  :       dout <= 9'h11e;
                8'd203  :       dout <= 9'h11d;
                8'd204  :       dout <= 9'h11c;
                8'd205  :       dout <= 9'h11c;
                8'd206  :       dout <= 9'h11b;
                8'd207  :       dout <= 9'h11b;
                8'd208	:       dout <= 9'h11a;
                8'd209  :       dout <= 9'h119;
                8'd210  :       dout <= 9'h119;
                8'd211  :       dout <= 9'h118;
                8'd212  :       dout <= 9'h118;
                8'd213  :       dout <= 9'h117;
                8'd214  :       dout <= 9'h116;
                8'd215  :       dout <= 9'h116;
                8'd216  :       dout <= 9'h115;
                8'd217  :       dout <= 9'h115;
                8'd218	:       dout <= 9'h114;
                8'd219  :       dout <= 9'h113;
                8'd220  :       dout <= 9'h113;
                8'd221  :       dout <= 9'h112;
                8'd222  :       dout <= 9'h112;
                8'd223  :       dout <= 9'h111;
                8'd224  :       dout <= 9'h111;
                8'd225  :       dout <= 9'h110;
                8'd226  :       dout <= 9'h10f;
                8'd227  :       dout <= 9'h10f;
                8'd228	:       dout <= 9'h10e;
                8'd229  :       dout <= 9'h10e;
                8'd230  :       dout <= 9'h10d;
                8'd231  :       dout <= 9'h10d;
                8'd232  :       dout <= 9'h10c;
                8'd233  :       dout <= 9'h10c;
                8'd234  :       dout <= 9'h10b;
                8'd235  :       dout <= 9'h10a;
                8'd236  :       dout <= 9'h10a;
                8'd237  :       dout <= 9'h109;
                8'd238	:       dout <= 9'h109;
                8'd239  :       dout <= 9'h108;
                8'd240  :       dout <= 9'h108;
                8'd241  :       dout <= 9'h107;
                8'd242  :       dout <= 9'h107;
                8'd243  :       dout <= 9'h106;
                8'd244  :       dout <= 9'h106;
                8'd245  :       dout <= 9'h105;
                8'd246  :       dout <= 9'h105;
                8'd247  :       dout <= 9'h104;
                8'd248	:       dout <= 9'h104;
                8'd249  :       dout <= 9'h103;
                8'd250  :       dout <= 9'h103;
                8'd251  :       dout <= 9'h102;
                8'd252  :       dout <= 9'h102;
                8'd253  :       dout <= 9'h101;
                8'd254  :       dout <= 9'h101;
                8'd255  :       dout <= 9'h100;
		default : 	dout <= 9'h0;
	endcase
end
endmodule


////////////////////////////////////////////////////////////////////////////////////
///////////////////////Clock Divider Module/////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Clock generator module///////////////////////////////////////
module clk_gen
  #(
  parameter THRESHOLD_FOR_CLOCK = 24
)
  (clk_0_1ps,clk_out);
input clk_0_1ps;
output clk_out; 
  wire clk_out;
  clk_div #(.THRESHOLD(THRESHOLD_FOR_CLOCK)) cd (.i_clk(clk_0_1ps), .ck_stb(clk_out));
  
endmodule
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
////////////////////////////Module Presynapse//////////////////////////////////////////
////////////////////////contains K,ActSpike, Neuro, SYNC1,SYNC2, Prel,Inh//////////////
module PreSynapse
#(
  parameter N=32,
  parameter Bs=$clog2(N),
  parameter es=4
)
(
clkm,
clks,
reset7,
enable7,
clkx7,
start7,
tp2,
clk5,
reset5,
enable5,
clkx5,
start5,
clkp,
reset6,
enable6,
clkxp,
clkxy,
start6,
clkb,
reset1,
enable1,
start1,
clkx1,
clka,
clk8,
reset2,
reset8,
enable8,
start8,
clkx8,
tp1,
RM1,
reset4,
enable4,
clkx4,
start4,
td4,
clkc,
reset3,
enable3,
clkx3,
start3,
clkd,
enable2,
clkx2,
start2,
KKx,
Sk,
ak,
counter1,
gk,
kk,
qk,
xk,
Ax,
Dx,
RMtrx,
Prelx,
Inhx,
ax,
bx,
cx,
dx,
ex,
fx,
gx,
anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq,Pxy,
WWx,
SS,
Isyn7,
aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,
Yn,
Xn,
axx,
bxx,
cxx,
Sy
);
  //Input port declarations
  input  clkm                      ;
  input  clks                      ;
  input  reset7                    ;
  input  enable7                   ;
  input  clkx7                     ;
  input  start7                    ;
  input  tp2                       ;
  input  clk5                      ;
  input  reset5                    ;
  input  enable5                   ;
  input  clkx5                     ;
  input  start5                    ;
  input  clkp                      ;
  input  reset6                    ;
  input  enable6                   ;
  input  clkxp                     ;
  input  clkxy                     ;
  input  start6                    ;
  input  clkb                      ;
  input  reset1                    ;
  input  enable1                   ;
  input  start1                    ;
  input  clkx1                     ;
  input  clka                      ;
  input  clk8                      ;
  input  reset2                    ;
  input  reset8                    ;
  input  enable8                   ;
  input  start8                    ;
  input  clkx8                     ;
  input  tp1                       ;
  input  [N-1:0] RM1               ;
  input  reset4                    ;
  input  enable4                   ;
  input  clkx4                     ;
  input  start4                    ;
  input  td4                       ;
  input  clkc                      ;
  input  reset3                    ;
  input  enable3                   ;
  input  clkx3                     ;
  input  start3                    ;
  input  clkd                      ;
  input  enable2                   ;
  input  clkx2                     ;
  input  start2                    ;
  //Output port declarations
  output [N-1:0] KKx               ;
  output [N-1:0] Sk                ;
  output [N-1:0] ak                ;
  output [N-1:0] counter1          ;
  output [N-1:0] gk                ;
  output [N-1:0] kk                ;
  output [N-1:0] qk                ;
  output [N-1:0] xk                ;
  output [N-1:0] Ax                ;
  output [N-1:0] Dx                ;
  output [N-1:0] RMtrx             ;
  output [N-1:0] Prelx             ;
  output [N-1:0] Inhx              ;
  output[N-1:0]ax,bx,cx,dx,ex,fx,gx;
  output[N-1:0]anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq;
  output[N-1:0] Pxy                ;
  output[N-1:0] WWx                ;
  output[N-1:0] SS                 ;
  output[N-1:0] Isyn7              ;
  output[N-1:0]aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;
  output[N-1:0]Yn                  ;
  output[N-1:0]Xn                  ;
  output[N-1:0]axx                 ;
  output[N-1:0]bxx                 ;
  output[N-1:0]cxx                 ;
  output[N-1:0]Sy                  ;
  //reg variables
  reg [N-1:0] C01                  ;
  reg [N-1:0] del1                 ;
  reg [N-1:0] in1                  ;
  reg [N-1:0] in2                  ;
  reg [N-1:0] in3                  ;
  reg [N-1:0] C08                  ;
  reg [N-1:0] C04                  ;
  reg [N-1:0] C14                  ;
  reg [N-1:0] C03                  ;
  reg [N-1:0] C02                  ;
  reg [N-1:0] C12                  ;
  reg [N-1:0] del5                 ;
  //wire variables
  wire [N-1:0] KtoSYNC2            ;
  wire [N-1:0] ACTtoINHtoSYNC1     ;
  wire [N-1:0] out1                ;
  wire [N-1:0] NEUROtoSYNC1        ;
  wire [N-1:0] RMTtoINH            ;
  wire [N-1:0] INHtoPREL           ;
  wire [N-1:0] SYNC1toPREL         ;
  wire [N-1:0] StoS2               ;
  
  //Continuos assignments
  assign Ax  = ACTtoINHtoSYNC1      ;
  assign KKx = KtoSYNC2             ;
  assign Dx  = NEUROtoSYNC1         ;
  assign RMtrx=RMTtoINH             ;
  assign Inhx=INHtoPREL             ;
  assign Prelx=SYNC1toPREL          ;
  assign WWx=StoS2                  ;
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////  
  ////////////////K_instance/////////////////////
  ///////////////ActSpike Instance///////////////
  ActSpike #(.N(N),.es(es)) AC1 (clkm,clkb,reset1,enable1,clkx1,start1,C01,del1,in1,in2,in3,tp1,out1,ACTtoINHtoSYNC1);
  //////////////////Neuro Instance///////////////
  Neuro #(.N(N),.es(es)) N1 (clkm,clka,reset4,enable4,clkx4,start4,td4,C04,C14,NEUROtoSYNC1);
  //////////////////RMtrace Instance/////////////
  RMtrace_ar #(.N(N),.es(es)) RMtr (clkm,clkc,reset3,enable3,clkx3,start3,C03,RM1,RMTtoINH);
  ////////////////Inh Instance///////////////////
  Inh #(.N(N),.es(es)) inh1 (clkm,clkd,reset2,enable2,clkx2,start2,C02,C12,RMTtoINH,ACTtoINHtoSYNC1,INHtoPREL,ax,bx,cx,dx,ex,fx,gx);
  ////////////////Prel Instance///////////////////
  Prel #(.N(N),.es(es)) p (clkm,clkp,reset6,enable6,clkxp,clkxy,start6,INHtoPREL,SYNC1toPREL,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq,Pxy);
  ////////////////SYNC1 Instance///////////////////
  SYNC1 #(.N(N),.es(es)) S (clkm,clk5,reset5,enable5,clkx5,start5,del5,SYNC1toPREL,ACTtoINHtoSYNC1,NEUROtoSYNC1,StoS2);
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  ////////////////SYNC2 Instance///////////////////
  SYNC2 #(.N(N),.es(es)) S2 (clkm,clks,reset7,enable7,clkx7,start7,StoS2,Xn,tp2,Isyn7,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q);
  X #(.N(N),.es(es)) Xn1 (clkm,clkb,reset8,enable8,clkx8,start8,tp1,Yn,Xn,axx,bxx,cxx);
  Y #(.N(N),.es(es)) Yn1 (clkm,clkb,reset8,enable8,clkx8,start8,tp1,Yn,Sy);
  //input signals
  always @(posedge clka) begin
    if (reset2) begin
      C01 <= 'h3FF5C28F ;//0.989999994635582
      del1 <='h328F5C29 ;//0.010000000009313226
      in1 <= 'h40000000 ;//1.0
      in2 <= 'h05400000 ;//1.734723475976807e-18
      in3 <= 'hC0000000 ;//-1
      C08 <= 'h39333333 ;//0.1
      C04 <= 'h3FCCCCCD ;//0.9500000029802322
      C14 <= 'h37333333 ;//0.049999999813735485
      C03 <= 'h3FFD70A4 ;//0.9975000023841858
      C02 <= 'h3FF5C28F ;//0.989999994635582
      C12 <= 'h2C0C49BA ;//0.0009999999892897904
      del5<= 'h2C0C49BA ;//0.0009999999892897904
    end
    else begin
    end
  end//always
  
endmodule
///////////////////////////////////////////////////////////////////////////////////////
////////////////////////////Top Level Design Module-MODEL//////////////////////////////
////////////////////////////contains PreSynapse////////////////////////////////////////
module MODEL
#(
  parameter N=32,
  parameter Bs=$clog2(N),
  parameter es=4
)
(
clkm,
clks,
clkp,
clkxp,
clkxy,
clka,
clkb,
clk,
reset,
enable,
clkx,
start,
tp1,
td4,
KKx,
Sk,
ak,
counter1,
gk,
kk,
qk,
xk,
RMx,
Ax,
Dx,
RMtrx,
Prelx,
Inhx,
ax,
bx,
cx,
dx,
ex,
fx,
gx,
anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq,
Pxy,
WWx,
SS,
Isyn1,
aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,
Yn,
Xn,
axx,
bxx,
cxx,
Sy
);
  //Input port declarations
  input  clkm             ;
  input  clks             ;
  input  clkp             ;
  input  clkxp            ;
  input  clkxy            ;
  input  clka             ;
  input  clkb             ;
  input  clk              ;
  input  reset            ;
  input  enable           ;
  input  clkx             ;
  input  start            ;
  input  tp1              ;
  input  td4              ;
  //Output port declarations
  output [N-1:0] KKx               ;
  output [N-1:0] Sk                ;
  output [N-1:0] ak                ;
  output [N-1:0] counter1          ;
  output [N-1:0] gk                ;
  output [N-1:0] kk                ;
  output [N-1:0] qk                ;
  output [N-1:0] xk                ;
  output [N-1:0] RMx               ;
  output [N-1:0] Ax                ;
  output [N-1:0] Dx                ;
  output [N-1:0] RMtrx             ;
  output [N-1:0] Prelx             ;
  output [N-1:0] Inhx              ;
  output[N-1:0]ax,bx,cx,dx,ex,fx,gx;
  output[N-1:0]anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq;
  output[N-1:0]Pxy                 ;
  output[N-1:0]WWx                 ;
  output[N-1:0]SS                  ;
  output[N-1:0]Isyn1               ;
  output[N-1:0]aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;
  output[N-1:0]Yn                  ;
  output[N-1:0]Xn                  ;
  output[N-1:0]axx                 ;
  output[N-1:0]bxx                 ;
  output[N-1:0]cxx                 ;
  output[N-1:0]Sy                  ;
  
  
  //reg variables
  reg [N-1:0] RM                   ;
  
  //Continuos assignments
  assign RMx     =     RM          ;
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////  
  ////////////////PreSynapse_instance////////////
 
  PreSynapse #(.N(N),.es(es)) PS1 (clkm,clks,reset,enable,clkx,start,tp1,clk,reset,enable,clkx,start,clkp,reset,enable,clkxp,clkxy,start,clkb,reset,enable,start,clkx,clka,clk,reset,reset,enable,start,clkx,tp1,RMx,reset,enable,clkx,start,td4,clkb,reset,enable,clkx,start,clkb,enable,clkx,start,KKx,Sk,ak,counter1,gk,kk,qk,xk,Ax,Dx,RMtrx,Prelx,Inhx,ax,bx,cx,dx,ex,fx,gx,anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq,Pxy,WWx,SS,Isyn1,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,Yn,Xn,axx,bxx,cxx,Sy);
  
 
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  //input signals
  always@(posedge clk)begin
    if(reset)begin
    RM<='h3EC39581;//0.691
   end
  else 
   begin
    end
  end
endmodule
//////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////Top////////////////////////////////////////////////////
//////////////////Top level design module with all instances//////////////////////////
module top
#(
  parameter N=32,
  parameter Bs=$clog2(N),
  parameter es=4
)
(clk_0_1ps,
 reset,
 enable,
 start,
 tp1,
 td4,
 KKx,
 Sk,
 ak,
 counter1,
 gk,
 kk,
 qk,
 xk,
 RMx,
 Ax,
 Dx,
 RMtrx,
 Prelx,
 Inhx,
 ax,
 bx,
 cx,
 dx,
 ex,
 fx,
 gx,
 anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq,
 Pxy,
 WWx,
 SS,
 Isyn1,
 aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q,
 Yn,
 Xn,
 axx,
 bxx,
 cxx,
 Sy
);
  //Input port declarations
  input  clk_0_1ps          ;
  input  reset            ;
  input  enable           ;
  input  start            ;
  input  tp1              ;
  input  td4              ;
  //Output port declarations
  output [N-1:0] KKx               ;
  output [N-1:0] Sk                ;
  output [N-1:0] ak                ;
  output [N-1:0] counter1          ;
  output [N-1:0] gk                ;
  output [N-1:0] kk                ;
  output [N-1:0] qk                ;
  output [N-1:0] xk                ;
  output [N-1:0] RMx               ;
  output [N-1:0] Ax                ;
  output [N-1:0] Dx                ;
  output [N-1:0] RMtrx             ;
  output [N-1:0] Inhx              ;
  output[N-1:0]Prelx               ;
  output[N-1:0]ax,bx,cx,dx,ex,fx,gx;
  output[N-1:0]anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq;
  output[N-1:0]Pxy                 ;
  output[N-1:0]WWx                 ;
  output[N-1:0]SS                  ;
  output[N-1:0]Isyn1               ;
  output[N-1:0]aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;
  output[N-1:0]Yn                  ;
  output[N-1:0]Xn                  ;
  output[N-1:0]axx                 ;
  output[N-1:0]bxx                 ;
  output[N-1:0]cxx                 ;
  output[N-1:0]Sy                  ;
  
  //reg variables
  reg clk,clkxp,clks;
  
  //wire variables
  wire [N-1:0] KKx,Sk,ak,counter1           ;
  wire [N-1:0] gk,kk,qk,xk,RMx,Ax,Dx,RMtrx  ;
  wire [N-1:0] Prelx                        ;
  wire [N-1:0] Inhx,ax,bx,cx,dx,ex,fx,gx    ;
  wire [N-1:0]anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq;
  wire [N-1:0] Pxy                          ;
  wire [N-1:0] WWx                          ;
  wire [N-1:0] SS                           ;
  wire [N-1:0] Isyn1                        ;
  wire [N-1:0] aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;
  wire[N-1:0]Yn                    ;
  wire[N-1:0]Xn                    ;
  wire[N-1:0]axx                   ;
  wire[N-1:0]bxx                   ;
  wire[N-1:0]cxx                   ;
  wire[N-1:0]Sy                    ;
  
  parameter THRESHOLD_FOR_5NS_CLOCK = 50000;//Always should be even//(0.1ps=0.0001ns)*50000=5ns
  parameter THRESHOLD_FOR_2_5NS_CLOCK = 25000;//Always should be even//(0.1ps=0.0001ns)*25000=2.5ns
  parameter THRESHOLD_FOR_0_1NS_CLOCK = 1000;//Always should be even//(0.1ps=0.0001ns)*1000=0.1ns

  /////////INSTANCE//////////////
  MODEL #(.N(N),.es(es)) SynNeur1(.clkm(clk_0_1ps),.clks(clks),.clkp(clks),.clkxp(clkxp),      .clkxy(clkxp),.clka(clks),.clkb(clks),.clk(clk),.reset(reset),.enable(enable),.clkx(clkxp),.start(start),.tp1(tp1),.td4(td4),.KKx(KKx),.Sk(Sk),.ak(ak),.counter1(counter1),.gk(gk),.kk(kk),.qk(qk),.xk(xk),.RMx(RMx),.Ax(Ax),.Dx(Dx),.RMtrx(RMtrx),.Prelx(Prelx),.Inhx(Inhx),.ax(ax),.bx(bx),.cx(cx),.dx(dx),.ex(ex),.fx(fx),.gx(gx),.anq(anq),.bnq(bnq),.cnq(cnq),.dnq(dnq),.enq(enq),.inq(inq),.jnq(jnq),.knq(knq),.mnq(mnq),.nnq(nnq),.n1nq(n1nq),.pnq(pnq),.qnq(qnq),.unq(unq),.u1nq(u1nq),.vnq(vnq),.Pxy(Pxy),.WWx(WWx),.SS(SS),.Isyn1(Isyn1),.aq(aq),.bq(bq),.cq(cq),.dq(dq),.eq(eq),.fq(fq),.gq(gq),.hq(hq),.iq(iq),.Sq(Sq),.S1q(S1q),.S11q(S11q),.k0q(k0q),.Yn(Yn),.Xn(Xn),.axx(axx),.bxx(bxx),.cxx(cxx),.Sy(Sy));
    ///////////////////////Clocks coming from top level clkgen module./////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
  clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_5NS_CLOCK))
  gen_instance5 (.clk_0_1ps(clk_0_1ps),.clk_out(clk));
  
 // clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
 // gen_instance2_5a (.clk_1ps(clk_1ps),.clk_out(clka));
  
 // clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
 // gen_instance2_5b (.clk_1ps(clk_1ps),.clk_out(clkb));
  
 // clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
 // gen_instance2_5p (.clk_1ps(clk_1ps),.clk_out(clkp));
  
  
  clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_2_5NS_CLOCK))
  gen_instance2_5s (.clk_0_1ps(clk_0_1ps),.clk_out(clks));
  
  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_0_1NS_CLOCK))
  //gen_instance0_1xy (.clk_1ps(clk_1ps),.clk_out(clkxy));
  
  //clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_0_1NS_CLOCK))
  //gen_instance0_1x (.clk_1ps(clk_1ps),.clk_out(clkx));
  
  clk_gen #(.THRESHOLD_FOR_CLOCK(THRESHOLD_FOR_0_1NS_CLOCK))
  gen_instance0_1xp (.clk_0_1ps(clk_0_1ps),.clk_out(clkxp));
endmodule
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////Comparator//////////////////////////////////////////////////
//////////////////////////////Module for comparison of 2 posit nos/////////////////////////
module comparator
#(
parameter N=32,
parameter Bs=$clog2(N),
parameter es=4
)
(
a,
clk,
start,
reset,
comp
);
  //Input port declarations
  input[N-1:0] a                    ;
  input clk                         ;
  input start                       ;
  input reset                       ;
  //Output port declarations
  output comp                       ;
  //reg variables
  reg[N-1:0] neg_b,pos_b            ;
  reg        out_temp               ;
  //Internal wire variables
  wire[N-1:0] out                   ;
  wire inf_add, zero_add, done_add  ;
  
  //Continuos assignments
  assign comp = out_temp;
  //input signals
  always@(posedge clk)begin
  if(reset)begin
    neg_b <= 'h348F5C29              ;//0.02
    pos_b <= 'hCB70A3D7              ;//-0.02
  end
  else begin
  end
  end//always
  always@(negedge clk)begin
   if(a==pos_b)begin
      out_temp <= 1'b1               ;//1 a>=b
   end
   else if (out[31] == 1'b1)begin
      out_temp <= 1'b0               ;//1 a<b
   end
   else if (out[31] == 1'b0)begin
      out_temp <= 1'b1               ;//1 a >=b
   end
  end//always
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  posit_add #(.N(N), .es(es)) add (clk,a, neg_b, start, out, inf_add, zero_add, done_add);
endmodule
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////Prel///////////////////////////////////////////////////////
///////////////////////////Module for Prel[n]//////////////////////////////////////////////
module Prel
#(
parameter N=32,
parameter Bs=$clog2(N),
parameter es=4
)
(
clkm,
clk,
reset, 
enable,
clkx,
clkxy,
start,
Inh1,
Prel,
aq,
bq,
cq,
dq,
eq,
iq,
jq,
kq,
mq,
nq,
n1q,
pq,
qq,
uq,
u1q,
vq,
Pxy
);
  //Internal Parameters
  parameter NR_Iter = 2;							// 2 for 32 bits, 1 for 16 bits, 0 for 8bits
  //Input port declarations
  input  clkm,clk,reset,enable,clkx,clkxy                            ;
  input  start                                                       ;
  input  [N-1:0] Inh1                                                ;
  //Output port declarations
  output [N-1:0] Prel                                                ;
  output [N-1:0] aq,bq,cq,dq,eq,iq,jq,kq,mq,nq                       ;
  output [N-1:0] n1q,pq,qq,uq,u1q,vq,Pxy                             ;
  //reg variables
  reg [N-1:0] Prel                                                 ;
  reg [N-1:0] xn                                                     ;
  reg [N-1:0] y                                                      ;
  reg [N-1:0] C0                                                     ;
  reg [N-1:0] const1                                                 ;
  reg [N-1:0] constm1                                                ;
  reg [N-1:0] const025                                               ;
  reg [N-1:0] const1001                                              ;
  reg [N-1:0] constm011                                              ;
  reg [N-1:0] constm001                                              ;
  reg [N-1:0] conste8                                                ;
  reg [N-1:0] conste16                                               ;
  reg [N-1:0] constm_00001                                           ;
  reg [N-1:0] constm_00007                                           ;
  reg [N-1:0] const1_1                                               ;
  reg [N-1:0] const1000                                              ;
  reg [N-1:0] ax,bx,cx,dx,ex,px,kx,m1,n1,ox,zx,nx,kkx                ;
  reg [N-1:0] Prel_temp                                              ;
  reg[N-1:0] const10                                                 ;
  //Internal wire variables
 // wire[N-1:0] Prel                                                    ;
  wire[N-1:0] aq,bq,cq,dq,eq,iq,jq,kq,mq,nq,n1q,pq,qq,uq,u1q,vq,Pxy   ;
  wire[N-1:0] u1                                                      ;
  wire[N-1:0] a,b,c,d,e,i,j,k,m,n,p,q,r,u,v,w,o,z,con1,con2,o1,Inh,k1 ;
  wire inf_DUT, zero_DUT, done_DUT                                    ;
  wire inf_AddInh, zero_AddInh, done_AddInh                           ;
  wire inf_MM17xx, zero_MM17xx, done_MM17xx                           ;
  wire inf_MM18xx, zero_MM18xx, done_MM18xx                           ;
  //wire inf_MM20xx, zero_MM20xx, done_MM20xx                           ;
  //wire inf_MM77xx, zero_MM77xx, done_MM77xx                           ;
  wire inf_MM21xx, zero_MM21xx, done_MM21xx                           ;
  //wire inf_MM22xx, zero_MM22xx, done_MM22xx                           ;
  //wire inf_MM21xsssx, zero_MM21xsssx, done_MM21xsssx                  ;
  //wire inf_MM22xsssx, zero_MM22xsssx, done_MM22xsssx                  ;
  //wire inf_AA5xx, zero_AA5xx, done_AA5xx                              ;
  //wire inf_AA6xx, zero_AA6xx, done_AA6xx                              ;
  //wire inf_AA7xx, zero_AA7xx, done_AA7xx                              ;
  //wire inf_SS3xx, zero_SS3xx, done_SS3xx                              ;
  wire inf_AA444xx, zero_AA444xx, done_AA444xx                        ;
  //wire inf_AA445xx, zero_AA445xx, done_AA445xx                        ;
  wire inf_SS99xx, zero_SS99xx, done_SS99xx                           ;
  wire inf_D1xx, zero_D1xx, done_D1xx                                 ;
  wire compare                                                        ;
  wire res1,res2                                                      ;
  
  //Continuos assignments
  assign aq=ax                                 ;
  assign bq=bx                                 ;
  assign cq=cx                                 ;
  assign dq=dx                                 ;
  assign eq=ex                                 ;
  assign iq=i                                  ;
  assign jq=j                                  ;
  assign kq=kx                                 ;
  assign mq=m                                  ;
  assign nq=n                                  ;
  assign n1q=n1                                ;
  assign pq=px                                 ;
  assign qq=q                                  ;
  assign uq=u                                  ;
  assign u1q=u1                                ;
  assign vq=v                                  ;
  assign Pxy=n                                 ;
  assign u1=~u+1'b1                            ;//Negative number in Posit = 2's complement
  assign o1=~ox+1'b1                           ;//Negative number in Posit = 2's complement
  assign compare=res1&&px[31]                  ;
  //assign const10=con                           ;
  //assign Prel=Prel_temp                        ;
  //input signals
  always@(posedge clkx)begin
  if(n[31]==1'b0)begin
	  n1<=~n+1'b1                              ;//Negative number in Posit = 2's complement
  end
  else if(n[31]==1'b1)begin
	  n1<='h5400000                            ;//1.734723475976807e-18
  end
  end//always

  always@(posedge clk)begin
  if (reset) begin
	Prel<='h5400000                            ;//1.734723475976807e-18
	xn  <='h5400000                            ;//1.734723475976807e-18
	y   <='h5400000                            ;//1.734723475976807e-18
	ax  <='h5400000                            ;//1.734723475976807e-18
    bx  <='h5400000                            ;//1.734723475976807e-18
    cx  <='h5400000                            ;//1.734723475976807e-18
	dx  <='h5400000                            ;//1.734723475976807e-18
    ex  <='h5400000                            ;//1.734723475976807e-18
    px  <='h5400000                            ;//1.734723475976807e-18
	ox  <='h5400000                            ;//1.734723475976807e-18
    zx  <='h5400000                            ;//1.734723475976807e-18
    nx  <='h5400000                            ;//1.734723475976807e-18
    kkx  <='h5400000                           ;//1.734723475976807e-18
	C0  <='h40000000                           ;//1
    const1<='h40000000                         ;//1
    constm1<='hC0000000                        ;//-1
	const025<='h3C000000                       ;//0.25
    const1001<='h40008312                      ;//1.0009999871253967
    constm011<='hCD2F1AA0                      ;//-0.010999999940395355
    constm001<='hD3F3B646                      ;//-0.0009999999892897904
    conste8<='h155798EE                        ;//9.99999993922529e-9
    conste16<='h6B34ACA                        ;//9.999999506879345e-17
    constm_00001<='hE0B074A7                     ;//-0.000010000000202126103
    constm_00007<='hDBB4CC25                     ;//-0.00007000000005064066
    const1_1 <= 'h40333333                     ;//1.0999999940395355
    const1000<= 'h53E80000                     ;//1000
  end
  else if (enable) begin
    ax <= a                                    ;
	kkx <= k                                   ;
	cx <= c                                    ;
    dx <= d                                    ;
	ex <= e                                    ;
    kx <= k                                    ;
    px <= p                                    ;
	ox <= o                                    ;
    zx <= z                                    ;
    if(res1&&px[31])begin
    Prel<='h2546DC5C                           ;//0.00009999999747378752
    end
    else if(px[31]==1'b1)begin
    Prel<='h3C000000                           ;//0.25
    end
    else begin
    Prel<=px                                   ;
    end
  end//elseif
  end//always
  /////////////Example of casez////////////////
  //Casez treats ‘z’ as don’t care
  //example 1
  //casez(a)
  //2'b1z : b=a;
  //2'b0? : c=a;
  //in above example 1z or 1?is considered either as 10 or 11
  ////////////////////////////////////////////
  //always@(posedge clkm)begin///This always block is used to solely remove the 3rd don't care value that is happening in Prel
  //  if(enable)begin
  //  casez(Prel_temp)
  //    32'hxxxxxxxx:begin
  //                    Prel_temp<=32'h3C000000  ;//0.25-to maintain functionality-Souradeep told
  //                 end
  //    default     :begin
  //                    Prel_temp<=px            ; 
  //                 end
  //  endcase
  //  end//if
  //end//always
  
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  //fpadd AddInh(Inh1,constm_00001,clkm,Inh);//Inh
  //Division DUT(clkm,const1,ax,Exception,k1);
  posit_div  #(.N(N), .es(es), .NR_Iter(NR_Iter)) DUT (clkm,const1, ax, start, k1, inf_DUT, zero_DUT, done_DUT);
  posit_add #(.N(N), .es(es)) AddInh (clkm,Inh1, constm_00001, start, Inh, inf_AddInh, zero_AddInh, done_AddInh);//Inh
  posit_mult #(.N(N), .es(es)) MM17xx (clkm,const1000, Inh, start, a, inf_MM17xx, zero_MM17xx, done_MM17xx);
  posit_mult #(.N(N), .es(es)) MM18xx (clkm,k1, const1000, start, k, inf_MM18xx, zero_MM18xx, done_MM18xx);
  //posit_mult #(.N(N), .es(es)) MM20xx (clkx,bx, i, start, c, inf_MM20xx, zero_MM20xx, done_MM20xx);
  //posit_mult #(.N(N), .es(es)) MM77xx (clkx,const10, v, start, k, inf_MM77xx, zero_MM77xx, done_MM77xx);
  posit_mult #(.N(N), .es(es)) MM21xx (clkm,kkx, constm_00007, start, d, inf_MM21xx, zero_MM21xx, done_MM21xx);
  //posit_mult #(.N(N), .es(es)) MM22xx (clkx,kx, dx, start, e, inf_MM22xx, zero_MM22xx, done_MM22xx);
  //posit_mult #(.N(N), .es(es)) MM21xsssx (clkx,dx, conste8, start, o, inf_MM21xsssx, zero_MM21xsssx, done_MM21xsssx);
  //posit_mult #(.N(N), .es(es)) MM22xsssx (clkx,ex, conste16, start, z, inf_MM22xsssx, zero_MM22xsssx, done_MM22xsssx);
  //posit_add #(.N(N), .es(es)) AA5xx (clkx,constm1, ax, start, i, inf_AA5xx, zero_AA5xx, done_AA5xx);
  //posit_add #(.N(N), .es(es)) AA6xx (clkx,const1, bx, start, j, inf_AA6xx, zero_AA6xx, done_AA6xx);
  //posit_add #(.N(N), .es(es)) AA7xx (clkx,i, cx, start, u, inf_AA7xx, zero_AA7xx, done_AA7xx);
  //posit_add #(.N(N), .es(es)) SS3xx (clkx,j, u1, start, v, inf_SS3xx, zero_SS3xx, done_SS3xx);
  posit_add #(.N(N), .es(es)) AA444xx (clkm,dx, const1_1, start, n, inf_AA444xx, zero_AA444xx, done_AA444xx);
  //posit_add #(.N(N), .es(es)) AA445xx (clkx,o1, m, start, n, inf_AA445xx, zero_AA445xx, done_AA445xx);
  posit_add #(.N(N), .es(es)) SS99xx (clkm,const1, n1, start, q, inf_SS99xx, zero_SS99xx, done_SS99xx);
  posit_mult #(.N(N), .es(es)) D1xx (clkm,q, const025, start, p, inf_D1xx, zero_D1xx, done_D1xx);
  comparator #(.N(N), .es(es)) VFFF (px,clkm,start,reset,res1);
endmodule
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////Inh////////////////////////////////////////////////////////
////////////////////////////////// Module for Inh[n]///////////////////////////////////////
module Inh
#(
parameter N=32,
parameter Bs=$clog2(N),
parameter es=4
)
(
clkm,
clk, 
reset, 
enable,
clkx,
start,
C0,
C1,
RMtr,
A,
Inh,
aq,
bq,
cq,
dq,
eq,
fq,
gq
);
  //Input port declarations
  input clkm                          ;
  input clk                           ;
  input reset                         ;
  input enable                        ;
  input clkx                          ;
  input start                         ;
  input [N-1:0] C0                    ;
  input [N-1:0] C1                    ;
  input [N-1:0] RMtr                  ;
  input [N-1:0] A                     ;
  //Output port declarations
  output [N-1:0] Inh                  ;
  output [N-1:0] aq,bq,cq,dq,eq,fq,gq ;
  //reg variables
  reg [N-1:0] Inh                     ;
  reg [N-1:0] RMtr_in1_in,A_in1_in    ;
  reg [N-1:0] C1_in1_in               ;
  reg [N-1:0] C0_in1_in               ;
  reg [N-1:0] ax,bx,cx                ;
  //Internal wire variables
  wire[N-1:0] aq,bq,cq,dq,eq,fq,gq    ;
  wire[N-1:0] a,b,c,d                 ;
  wire inf_MM14, zero_MM14, done_MM14 ;
  wire inf_MM15, zero_MM15, done_MM15 ;
  wire inf_MM16, zero_MM16, done_MM16 ;
  wire inf_AA4, zero_AA4, done_AA4    ;
  
  //Continuos assignments
  assign aq=ax                        ;
  assign bq=bx                        ;
  assign cq=cx                        ;
  assign dq=d                         ;
  assign eq=a                         ;
  assign fq=b                         ;
  assign gq=c                         ;
  //input signals
  always@(posedge clk)begin
    RMtr_in1_in <= RMtr               ;//clock synchronous input
    A_in1_in    <= A                  ;//clock synchronous input
    C1_in1_in   <= C1                 ;//clock synchronous input
    C0_in1_in   <= C0                 ;//clock synchronous input
  if (reset) begin
	Inh <= 'h1F4F8B59                 ;//0.000010000000202126103
	ax  <= 'h5400000                  ;//1.734723475976807e-18
    bx  <= 'h5400000                  ;//1.734723475976807e-18
    cx  <= 'h5400000                  ;//1.734723475976807e-18
  end 
  else if (enable) begin
    ax <= a                           ;
    bx <= b                           ;
    cx <= c                           ;
    Inh <= d                          ;
  end
  end//always
 
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  posit_mult #(.N(N), .es(es)) MM14 (clkm,RMtr_in1_in, A_in1_in, start, a, inf_MM14, zero_MM14, done_MM14);
  posit_mult #(.N(N), .es(es)) MM15 (clkm,ax, C1_in1_in, start, b, inf_MM15, zero_MM15, done_MM15);
  posit_mult #(.N(N), .es(es)) MM16 (clkm,C0_in1_in, Inh, start, c, inf_MM16, zero_MM16, done_MM16);
  posit_add #(.N(N), .es(es)) AA4 (clkm,bx, cx, start, d, inf_AA4, zero_AA4, done_AA4);
endmodule
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////RMtrace_ar///////////////////////////////////////////////////
////////////////////////////////Module for RMtr[n]/////////////////////////////////////////
module RMtrace_ar
#(
parameter N=32,
parameter Bs=$clog2(N),
parameter es=4
)
(
clkm,
clkb,
reset, 
enable,
clkx,
start,
C0,
RM1,
RMtr
);
  //Input port declarations
  input clkm                  ;
  input clkb                  ;
  input reset                 ;
  input enable                ;
  input clkx                  ;
  input start                 ;
  input [N-1:0] C0            ;
  input [N-1:0] RM1           ;
  //Output port declarations
  output[N-1:0] RMtr          ;
  //reg variables
  reg   [N-1:0] RMtr          ;
  reg   [N-1:0] ax,cx         ;
  reg   [N-1:0] C1            ;
  reg   [N-1:0] C0_in1_in     ;
  reg   [N-1:0] RM1_in1_in    ;
  //Internal wire variables
  wire  [N-1:0] a,b,c                            ;
  wire   inf_MM1, zero_MM1, done_MM1             ;
  wire   inf_MMMM1, zero_MMMM1, done_MMMM1       ;
  wire   inf_AA1, zero_AA1, done_AA1             ;
  
  //input signals
  always@(posedge clkb)begin
    C0_in1_in<=C0             ;//clock synchronous input
    RM1_in1_in<=RM1           ;//clock synchronous input
  if (reset) begin
	RMtr<='h5400000           ;//1.734723475976807e-18
	ax<='h5400000             ;//1.734723475976807e-18
	cx<='h5400000             ;//1.734723475976807e-18 
	C1<='h2C0C49BA            ;//0.0009999999892897904 
  end 
  else if (enable) begin
    ax<=a                     ;
    cx<=c                     ;
    RMtr<=b                   ;//RMtr=(C0*RMtr)+(C1*RM)
  end
  end//always
  
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  posit_mult #(.N(N), .es(es)) MM1 (clkm,C0_in1_in, RMtr, start, a, inf_MM1, zero_MM1, done_MM1);
  posit_mult #(.N(N), .es(es)) MMMM1 (clkm,C1, RM1_in1_in, start, c, inf_MMMM1, zero_MMMM1, done_MMMM1);
  posit_add #(.N(N), .es(es)) AA1 (clkm,ax, cx, start, b, inf_AA1, zero_AA1, done_AA1);
endmodule
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////SYNC1///////////////////////////////////////////////////
//////////////////////////////Module for w[n]/////////////////////////////////////////
module SYNC1
#(
parameter N=32,
parameter Bs=$clog2(N),
parameter es=4
)
(
clkm,
clk, 
reset, 
enable,
clkx,
start,
del,
Prel,
A,
D,
W
);
  //Input port declarations
  input clkm                 ;
  input clk                  ;
  input reset                ;
  input enable               ;
  input clkx                 ;
  input start                ;
  input [N-1:0] del          ;
  input [N-1:0] Prel         ;
  input [N-1:0] A            ;
  input [N-1:0] D            ;
  //Output port declarations
  output[N-1:0] W            ;
  //reg variables
  reg [N-1:0]   W            ;
  reg [N-1:0]   ax,bx,cx     ;
  reg [N-1:0]   D_in1_in     ;
  reg [N-1:0]   A_in1_in     ;
  reg [N-1:0]   Prel_in1_in  ;
  reg [N-1:0]   del_in1_in   ;
  //Internal wire variables
  wire[N-1:0]   a,b,c,d                 ;
  wire   inf_MM2, zero_MM2, done_MM2    ;
  wire   inf_MM3, zero_MM3, done_MM3    ;
  wire   inf_MM4, zero_MM4, done_MM4    ;
  wire   inf_AA99, zero_AA99, done_AA99 ;
  //Internal variable
  integer counter                       ;
  
  //input signals
  always@(posedge clk)begin
    D_in1_in <= D            ;//clock synchronous input
    A_in1_in <= A            ;//clock synchronous input
    Prel_in1_in<=Prel        ;//clock synchronous input
    del_in1_in <= del        ;//clock synchronous input
    if (reset) begin
	W<= 'h5400000            ;//1.734723475976807e-18
    ax<='h5400000            ;//1.734723475976807e-18
    bx<='h5400000            ;//1.734723475976807e-18
    cx<='h5400000            ;//1.734723475976807e-18
    counter<=0               ;
    end 
    else if (enable) begin
	ax <= a                  ;
    bx <= b                  ;
    cx <= c                  ;
    if(counter<990)begin 
	  counter<=counter+1     ;
	  W<='h6B34ACA           ;//9.999999506879345e-17
	  end
	else begin
	  W <= d                 ;
	  end
    end
  end//always
  
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  posit_mult #(.N(N), .es(es)) MM2 (clkm,D_in1_in, A_in1_in, start, a, inf_MM2, zero_MM2, done_MM2);
  posit_mult #(.N(N), .es(es)) MM3 (clkm,ax, Prel_in1_in, start, b, inf_MM3, zero_MM3, done_MM3);
  posit_mult #(.N(N), .es(es)) MM4 (clkm,bx, del_in1_in, start, c, inf_MM4, zero_MM4, done_MM4);
  posit_add #(.N(N), .es(es)) AA99 (clkm,W, cx, start, d, inf_AA99, zero_AA99, done_AA99);
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
endmodule
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////SYNC2//////////////////////////////////////////////
////////////////////////////Module for Isyn[n]////////////////////////////////////////
module SYNC2
#(
parameter N=32,
parameter Bs=$clog2(N),
parameter es=4
)
(
clkm,
clk, 
reset,
enable,
clkx,
start,
W,
Xn,
tp,
Isyn,
aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q
);
  //Input port declarations
  input clkm                                               ;
  input clk                                                ;
  input reset                                              ;
  input enable                                             ;
  input clkx                                               ;
  input start                                              ;
  input [N-1:0] W                                          ;
  input [N-1:0] Xn                                         ;
  input tp                                                 ;
  //Output port declarations
  output [N-1:0] Isyn                                      ;
  output [N-1:0] aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;
  //reg variables
  reg [N-1:0] Isyn                                         ;
  reg [N-1:0] dx_actual,fx_actual                          ;
  reg [N-1:0] const1                                       ;
  reg [N-1:0] k0,S,S1,S11,ax,fx,gx,dx,jx                   ;
  reg [N-1:0] CONST                                        ;
  reg [N-1:0] W_in1_in                                     ;
  reg [N-1:0] Xn_in1_in                                    ;
  //Internal wire variables
  wire[N-1:0] K,aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q ;
  wire[N-1:0] a,b,c,d,e,f,g,h,i,j,z                        ;
  wire inf_AA99, zero_AA99, done_AA99                      ;
  wire inf_MM99, zero_MM99, done_MM99                      ;
  wire inf_AA98, zero_AA98, done_AA98                      ;
  wire inf_MM98, zero_MM98, done_MM98                      ;
  wire inf_MM97, zero_MM97, done_MM97                      ;
  wire inf_ADD2, zero_ADD2, done_ADD2                      ;
  wire inf_ADD8, zero_ADD8, done_ADD8                      ;
  wire inf_ADD811, zero_ADD811, done_ADD811                ;
  
  //Continuos assignments
  assign aq=ax                                             ;
  assign bq=b                                              ;
  assign cq=c                                              ;
  assign dq=dx                                             ;
  assign eq=e                                              ;
  assign fq=fx                                             ;
  assign gq=gx                                             ;
  assign hq=h                                              ;
  assign iq=i                                              ;
  assign Sq=S                                              ;
  assign S1q=S1                                            ;
  assign S11q=S11                                          ;
  assign k0q=k0                                            ;
  //input signals
  always@(posedge clk)begin
    W_in1_in <= W                                          ;//clock synchronous input
    Xn_in1_in <= Xn                                        ;//clock synchronous input
  if (reset) begin
	Isyn <= 'h5400000                                      ;//1.734723475976807e-18
	S    <= 'h5400000                                      ;//1.734723475976807e-18 
	k0   <= 'h5400000                                      ;//1.734723475976807e-18
	ax   <= 'h5400000                                      ;//1.734723475976807e-18
    dx   <= 'h5400000                                      ;//1.734723475976807e-18
	fx   <= 'h5400000                                      ;//1.734723475976807e-18
	gx   <= 'h5400000                                      ;//1.734723475976807e-18
    jx   <= 'h5400000                                      ;//1.734723475976807e-18
    dx_actual<='h5400000                                   ;//1.734723475976807e-18
    fx_actual<='h5400000                                   ;//1.734723475976807e-18
	const1<='h40000000                                     ;//1.0
	CONST<='h2C0C49BA                                      ;//0.0009999999892897904
  end 
  else if(enable) begin	
    ax <= a                                                ;
	dx <= d                                                ;
	fx <= f                                                ;
    gx <= g                                                ;
	jx <= j                                                ;
    if(tp)begin
	S<= 'h5400000                                          ;//1.734723475976807e-18
	k0<=Isyn                                               ;
	begin
	Isyn<=gx                                               ;
	end
	end
	else begin
	Isyn<=gx                                               ;
	k0<=k0                                                 ;
	S<=h                                                   ;
	end
  end//elseif
  end//always
  
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  posit_add #(.N(N), .es(es)) AA99 (clkm,W_in1_in, k0, start, c, inf_AA99, zero_AA99, done_AA99);
  posit_mult #(.N(N), .es(es)) MM99 (clkm,Xn_in1_in, c, start, d, inf_MM99, zero_MM99, done_MM99);
  posit_add #(.N(N), .es(es)) AA98 (clkm,S, S11, start, e, inf_AA98, zero_AA98, done_AA98);
  posit_mult #(.N(N), .es(es)) MM98 (clkm,S, CONST, start, f, inf_MM98, zero_MM98, done_MM98);
  posit_mult #(.N(N), .es(es)) MM97 (clkm,fx, dx, start, g, inf_MM97, zero_MM97, done_MM97);
  posit_add #(.N(N), .es(es)) ADD2 (clkm,S, const1, start, h, inf_ADD2, zero_ADD2, done_ADD2);
  posit_add #(.N(N), .es(es)) ADD8 (clkm,S1, const1, start, i, inf_ADD8, zero_ADD8, done_ADD8);
  //posit_add #(.N(N), .es(es)) ADD811 (clkx,SS, gx, start, z, inf_ADD811, zero_ADD811, done_ADD811);
  
endmodule
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////Neuro///////////////////////////////////////////////////
//////////////////////////////Module for D[n]/////////////////////////////////////////
module Neuro
#(
parameter N=32,
parameter Bs=$clog2(N),
parameter es=4
)
(
clkm,
clk1, 
reset,
enable,
clkx,
start,
td,
C0,
C1,
D
);
  //Input port declarations
  input clkm              ;
  input clk1              ;
  input reset             ;
  input enable            ;
  input clkx              ;
  input start             ;
  input td                ;
  input [N-1:0] C0        ;
  input [N-1:0] C1        ;
  //Output port declarations
  output[N-1:0] D         ;
  //reg variables
  reg [N-1:0] D           ;
  reg [N-1:0] S           ;
  reg [N-1:0] ax          ;
  reg [N-1:0] bx          ;
  reg [N-1:0] D1          ;
  reg [N-1:0] D11         ;
  reg [N-1:0] const1      ;
  reg [N-1:0] const0_1    ;
  reg [N-1:0] C0_in1_in   ;
  reg [N-1:0] C1_in1_in   ;
  //Internal wire variables
  wire[N-1:0] a           ;
  wire[N-1:0] b           ;
  wire[N-1:0] c           ;
  wire[N-1:0] d           ;
  wire inf_MM6, zero_MM6, done_MM6;
  wire inf_MM7, zero_MM7, done_MM7;
  wire inf_AA2, zero_AA2, done_AA2;
  wire inf_ADD1,zero_ADD1,done_ADD1;
  
  //input signals
  always@(posedge clk1)begin
    C0_in1_in<=C0          ;//clock synchronous input
    C1_in1_in<=C1          ;//clock synchronous input
    if(reset)begin
      D <= 'h5400000       ;//1.734723475976807e-18
      D1 <='h5400000       ;//1.734723475976807e-18
      D11<='h5400000       ;//1.734723475976807e-18
      S<='h5400000         ;//1.734723475976807e-18
      ax<='h5400000        ;//1.734723475976807e-18
      bx<='h5400000        ;//1.734723475976807e-18
      const1<='h40000000   ;//1.0
      const0_1<='h39333333 ;//0.09999999962747097
    end
    else if(enable)begin
      ax <= a              ;
      bx <= b              ;
      D  <= c              ;
      if(td)begin
      S<=d                 ;
      end
      else begin
      S<='h5400000         ;//1.734723475976807e-18
      end
    end//elseif
  end//always
  
  ////////////INSTANTIATION//////////////////////
  ///////////////////////////////////////////////
  ///////////////////////////////////////////////
  posit_mult #(.N(N), .es(es)) MM6 (clkm,C0_in1_in, D, start, a, inf_MM6, zero_MM6, done_MM6);
  posit_mult #(.N(N), .es(es)) MM7 (clkm,S, C1_in1_in, start, b, inf_MM7, zero_MM7, done_MM7);
  posit_add #(.N(N), .es(es)) AA2 (clkm,ax, bx, start, c, inf_AA2, zero_AA2, done_AA2);
  posit_add #(.N(N), .es(es)) ADD1 (clkm,S, const0_1, start, d, inf_ADD1, zero_ADD1, done_ADD1);

endmodule

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////ActSpike///////////////////////////////////////////////
module ActSpike
  #(
  parameter N=32,
 // parameter E=8,
  parameter Bs=$clog2(N),
  parameter es=4
)
(
  clkm,
  clkb,
  reset,
  enable,
  clkx,//.1ns clock
  start,
  C0,
  del,
  in1,
  in2,
  in3,
  tp,
  out,
  A1
);
   
  //Input port declarations
  input  clkm             ;
  input  clkb             ; 
  input  reset            ;
  input  enable           ;
  input  clkx             ;
  input  start            ;
  input  tp               ;
  input  [N-1:0] C0       ;
  input  [N-1:0] del      ;
  input  [N-1:0] in1      ;
  input  [N-1:0] in2      ;
  input  [N-1:0] in3      ;
  //Output port declarations
  output [N-1:0] out      ;
  output [N-1:0] A1       ;
  //reg variables 
  reg    [N-1:0] A1       ;
  reg    [N-1:0] out      ;
  reg    [N-1:0] S        ;
  reg    [N-1:0] f        ;
  reg    [N-1:0] g        ;
  reg    [N-1:0] ax       ;
  reg    [N-1:0] AA       ;
  reg    [N-1:0] const1   ;
  reg    [N-1:0]  const0_1;
  reg    [N-1:0] consta   ;
  reg    [1:0]   sel      ;
  reg    h                ;
  reg    [N-1:0] C0_in1_in;
  //Internal wire variables
  wire   [N-1:0] a,b,c,d,e;
  wire   h1               ;
  wire   inf_MM11, zero_MM11, done_MM11;
  wire   inf_MM12, zero_MM12, done_MM12;
  wire   inf_MM13, zero_MM13, done_MM13;
  wire   inf_AA3, zero_AA3, done_AA3;
  wire   inf_ADD4, zero_ADD4, done_ADD4;
    wire inf_ADD3, zero_ADD3, done_ADD3                                                  ;
 
  //input signals
  always@(posedge clkb)begin
    C0_in1_in<=C0         ;//clock synchronous input
  begin
		if(tp&h)
		sel<=2'b00;
		else if(tp^h)
		sel<=2'b10;
		else
		sel<=2'b01;
  end

  case(sel)
		2'b00: out<=in1;//1
		2'b01: out<=in2;//0
		2'b10: out<=in3;//-1
		2'b11: out<=in2;//0
  endcase
 if (reset) begin
	
	AA <= 'h05400000    ;//1.734723475976807e-18;
    A1 <= 'h05400000    ;//1.734723475976807e-18;
    S  <= 'h05400000    ;//1.734723475976807e-18;
    f  <= 'h05400000    ;//1.734723475976807e-18;
    g  <= 'h05400000    ;//1.734723475976807e-18;
    ax <= 'h05400000    ;//1.734723475976807e-18;
	const1<='h40000000  ;//1.0
	consta<='h1DFBBEE2  ;//0.0000037829997836524853
    const0_1<='h39333333;//0.09999999962747097
	h     <=1'b1        ;
	
 end 
 else if (enable) begin
   f<=b                 ;
   g<=c                 ;
   ax<=a                ;
   AA<=d                ;
 if(tp)begin
	S<=e                ;
 end
 else begin
	S<='h05400000       ;//1.734723475976807e-18;
 end
 if(AA[31]==1)begin
   A1<= ~AA+1'b1        ;//A1 = -A ==> A1 = 2's comp(A)
 end
 else begin
   A1<=AA               ;
 end
 end//elseif
end//always
////////////INSTANTIATION//////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////
  posit_mult #(.N(N), .es(es)) MM11 (clkm,C0_in1_in, AA, start, a, inf_MM11, zero_MM11, done_MM11);
  posit_mult #(.N(N), .es(es)) MM12 (clkm,out, S, start, b, inf_MM12, zero_MM12, done_MM12);
  posit_mult #(.N(N), .es(es)) MM13 (clkm,f, del, start, c, inf_MM13, zero_MM13, done_MM13);
  posit_add #(.N(N), .es(es)) AA3 (clkm,ax, g, start, d, inf_AA3, zero_AA3, done_AA3);
  posit_add #(.N(N), .es(es)) ADD4 (clkm,S, const0_1, start, e, inf_ADD4, zero_ADD4, done_ADD4);
  
 
endmodule        
///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////// Module for X[n]//////////////////////////////
module X
#(
  parameter N=32,
  parameter Bs=$clog2(N),
  parameter es=4
)
(
clkm,
clk, 
reset, 
enable,
clkx,
start,
tp,
Yn,
Xn,
axx,
bxx,
cxx
);
  //Input port declarations
  input clkm               ;
  input clk                ; 
  input reset              ; 
  input enable             ;
  input clkx               ;
  input start              ;
  input tp                 ;
  input[N-1:0] Yn          ;
  //Output port declarations
  output[N-1:0] Xn         ;
  output[N-1:0] axx        ;
  output[N-1:0] bxx        ;
  output[N-1:0] cxx        ;
  //reg variables
  reg [N-1:0] Xn           ;
  reg[N-1:0]const0_9       ;
  reg[N-1:0]const0_1       ;
  reg[N-1:0] ax            ;
  reg[N-1:0] bx            ;
  //Internal wire variables
  wire[N-1:0] a,b,c        ;
  wire inf_XX14, zero_XX14, done_XX14;
  wire inf_XX15, zero_XX15, done_XX15;
  wire inf_XRREEX4, zero_XRREEX4, done_XRREEX4;
  
  //Continuos assignments
  assign axx=ax            ;
  assign bxx=bx            ;
  assign cxx=c             ;
  //input signals
  always@(posedge clk)begin
  //Yn_in1_in <= Yn          ;//clock synchronous input
  if (reset) begin
	Xn <= 'hC0CBCCC        ;//9.999999960041972e-13
	const0_9<='h3F99999A   ;//0.9000000059604645
	const0_1<='h39333330   ;//0.09999999403953552
	ax<='hC0CBCCC          ;//9.999999960041972e-13
	bx<='hC0CBCCC          ;//9.999999960041972e-13
  end 
  else if (enable) begin
    ax<=a                  ;
    bx<=b                  ;
    Xn<=c                  ;
  end//elseif
end//always
    
////////////INSTANTIATION//////////////////////
///////////////////////////////////////////////
  posit_mult #(.N(N), .es(es)) XX14 (clkm,const0_9, Xn, start, a, inf_XX14, zero_XX14, done_XX14);
  posit_mult #(.N(N), .es(es)) XX15 (clkm,const0_1, Yn, start, b, inf_XX15, zero_XX15, done_XX15);
  posit_add #(.N(N), .es(es)) XRREEX4(clkm,bx,ax,start,c,inf_XRREEX4, zero_XRREEX4, done_XRREEX4);
///////////////////////////////////////////////
///////////////////////////////////////////////
endmodule
///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////// Module for Y[n]//////////////////////////////
module Y
#(
  parameter N=32,
  parameter Bs=$clog2(N),
  parameter es=4
)
(
clkm,
clk, 
reset, 
enable,
clkx,
start,
tp,
Yn,
Sy
);
  //Input port declarations
  input clkm              ;
  input clk               ; 
  input reset             ; 
  input enable            ;
  input clkx              ;
  input start             ;
  input tp                ;
  //Output port declarations
  output[N-1:0]Yn,Sy      ;
  //reg variables
  reg [N-1:0] Yn          ;
  reg[N-1:0] const0_9     ;
  reg[N-1:0]const1,consty ;
  reg[N-1:0]const0_1      ;
  reg[N-1:0]ax,bx,S       ;
  //Internal wire variables
  wire [N-1:0] a,b,c,d    ;
  wire inf_YY14, zero_YY14, done_YY14;
  wire inf_YYYY1, zero_YYYY1, done_YYYY1;
  wire inf_YY15, zero_YY15, done_YY15;
  wire inf_YYYY3, zero_YYYY3, done_YYYY3;
  
  //Continuos assignments
  assign Sy=S             ;
  //input signals
  always@(posedge clk)begin
  if (reset) begin
	Yn <= 'h40000000      ;//1
	const0_9<='h3F99999A  ;//0.9000000059604645
	const1<='h40000000    ;//1
    const0_1<='h39333333  ;//0.09999999962747097
	S<= 'hC0CBCCC         ;//9.999999960041972e-13
	ax<='hC0CBCCC         ;//9.999999960041972e-13
    bx<='hC0CBCCC         ;//9.999999960041972e-13
    consty<='h40000000    ;//1
   end 
  else if (enable) begin
   if(tp)begin
	 S<=const0_1          ;
    end
    else begin
	 S<='hC0CBCCC         ;//9.999999960041972e-13
	end
   ax<=a                  ;
   bx<=b                  ;
   Yn<=c                  ;
   end//elseif 
   end//always
   
   ////////////INSTANTIATION//////////////////////
   ///////////////////////////////////////////////
  posit_mult #(.N(N), .es(es)) YY14 (clkm,const0_9, Yn, start, a, inf_YY14, zero_YY14, done_YY14);
  //posit_add #(.N(N), .es(es)) YYYY1(clkx,S,const1,start,d,inf_YYYY1, zero_YYYY1, done_YYYY1);
  posit_mult #(.N(N), .es(es)) YY15 (clkm,S, consty, start, b, inf_YY15, zero_YY15, done_YY15);
  posit_add #(.N(N), .es(es)) YYYY3(clkm,bx,ax,start,c,inf_YYYY3, zero_YYYY3, done_YYYY3);
endmodule
   
