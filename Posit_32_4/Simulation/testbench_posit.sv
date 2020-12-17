// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
`timescale 1ps / 1fs
module tb_k_with_posit;
parameter N=32          ;
//parameter E=8           ;
parameter Bs=log2(N)    ;
parameter es=4          ;
//parameter TCLK_LO_TP1 = 1000000;
//parameter TCLK_LO_TD4 = 1010000;
//parameter TCLK_HI_TP1 = 1000 ; 
//parameter TCLK_HI_TD4 = 10000  ;
//parameter MAIN_CLK_HALF_PERIOD = 1 ;
reg clk               ;
reg reset             ;
reg enable            ;
reg tp1               ;
reg td4               ;
reg start             ;
//reg  [N-1:0] C0       ;
wire [N-1:0] KKx      ;
//wire [N-1:0] K_FP32   ;
wire [N-1:0] Sk       ;
wire [N-1:0] ak       ;
wire [N-1:0] counter1 ;
wire [N-1:0] gk       ;
wire [N-1:0] kk       ;
wire [N-1:0] qk       ;
wire [N-1:0] xk       ;
wire [N-1:0] RMx      ;
wire [N-1:0] Ax       ;
wire [N-1:0] Dx       ;
wire [N-1:0] RMtrx    ;
wire [N-1:0] Prelx    ;
wire [N-1:0] Inhx     ;
wire [N-1:0]ax,bx,cx,dx,ex,fx,gx;
wire [N-1:0]anq,bnq,cnq,dnq,enq,inq,jnq,knq,mnq,nnq,n1nq,pnq,qnq,unq,u1nq,vnq;
wire [N-1:0]Pxy       ;
wire [N-1:0]WWx       ;
wire [N-1:0] SS       ;
wire [N-1:0] Isyn1    ;
wire [N-1:0] aq,bq,cq,dq,eq,fq,gq,hq,iq,Sq,S1q,S11q,k0q;
wire[N-1:0]Yn                    ;
wire[N-1:0]Xn                    ;
wire[N-1:0]axx                   ;
wire[N-1:0]bxx                   ;
wire[N-1:0]cxx                   ;
wire[N-1:0]Sy                    ;
integer f,i,j         ;

function [31:0] log2;
input reg [31:0] value;
	begin
	value = value-1;
	for (log2=0; value>0; log2=log2+1)
        	value = value>>1;
      	end
endfunction
/////////////Top Instance//////////////////
///////////////////////////////////////////
  top #(.N(N), .es(es)) top_inst (.clk_0_1ps(clk),.reset(reset),.enable(enable),.start(start),.tp1(tp1),.td4(td4),.KKx(KKx),.Sk(Sk),.ak(ak),.counter1(counter1),.gk(gk),.kk(kk),.qk(qk),.xk(xk),.RMx(RMx),.Ax(Ax),.Dx(Dx),.RMtrx(RMtrx),.Prelx(Prelx),.Inhx(Inhx),.ax(ax),.bx(bx),.cx(cx),.dx(dx),.ex(ex),.fx(fx),.gx(gx),.anq(anq),.bnq(bnq),.cnq(cnq),.dnq(dnq),.enq(enq),.inq(inq),.jnq(jnq),.knq(knq),.mnq(mnq),.nnq(nnq),.n1nq(n1nq),.pnq(pnq),.qnq(qnq),.unq(unq),.u1nq(u1nq),.vnq(vnq),.Pxy(Pxy),.WWx(WWx),.SS(SS),.Isyn1(Isyn1),.aq(aq),.bq(bq),.cq(cq),.dq(dq),.eq(eq),.fq(fq),.gq(gq),.hq(hq),.iq(iq),.Sq(Sq),.S1q(S1q),.S11q(S11q),.k0q(k0q),.Yn(Yn),.Xn(Xn),.axx(axx),.bxx(bxx),.cxx(cxx),.Sy(Sy));
///////////////////////////////////////////
/////////////Clocks////////////////////////
always #0.1ps clk=~clk;//Global Clock 1ps out of which all clocks are derived by clock generator

//////////////////////////////////////////
///////////////////////////////////////////
//always
//begin
//#TCLK_LO_TP1;
//tp1 = 1'b1;
//#TCLK_HI_TP1;
//tp1 = 1'b0;
//end
//always
//begin
//#TCLK_LO_TD4;
//td4 = 1'b1;
//#TCLK_HI_TD4;
//td4 = 1'b0;
//end
///////////////////////////////////////////
///////////////////////////////////////////

initial begin
clk = 1;
td4=0;tp1=0;reset=1;enable=0;start = 0;
#985ns ;
td4=~td4;tp1=~tp1;

#5ns;
td4=~td4;

#5ns;
tp1=~tp1;

#5ns;
reset=0;enable=1;



for(j=0;j<6;j=j+1)
begin

tp1=~tp1;
#10ns;

td4=~td4;//10
#90ns;

tp1=~tp1;//100
#10ns;

td4=~td4;//110

#9890ns;

end
 
end       

initial begin
#20ns start = 1;
end

initial begin
#50us;
$finish;
end
initial begin
//$dumpfile("dump.vcd"); $dumpvars;
end

always @(posedge top_inst.clk) begin
    if(enable)begin
     
      $strobe("time-%t,\ttp-%b,\ttd-%b,\tXn-%h,\tYn-%h,\tIsyn1-%h,\tWWx-%h,\tAx-%h,\tDx-%h,\tRMtrx-%h,\tPrelx-%h,\tInhx-%h",$time,tp1,td4,Xn,Yn,Isyn1,WWx,Ax,Dx,RMtrx,Prelx,Inhx);
    end
end


endmodule