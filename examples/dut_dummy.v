//This is dummy DUT. 

`timescale 1 ns / 100 ps

module dut_dummy( input clock, input reset, 
	axi4lite_if m_if,
	ad_if axis_m_if0,
	ad_if axis_m_if1
	);

wire resetn = reset;

assign  m_if.axi_arready  = 1'b1;
assign  m_if.axi_awready  = 1'b1;
assign  m_if.axi_bresp    = 2'b0;
assign  m_if.axi_bvalid   = 1'b1;
assign  m_if.axi_rdata    = 32'h12341234;
assign  m_if.axi_rresp    = 2'b0;
assign  m_if.axi_rvalid   = 1'b1;
assign  m_if.axi_wready   = 1'b1;

assign axis_m_if0.tready	= 1'b1;
assign axis_m_if1.tready	= 1'b1;

endmodule

