//This is dummy DUT. 

`timescale 1 ns / 100 ps

module dut_dummy( input clock, input reset, 
	axi4lite_if m_if,
	ad_if ad_m_if0,
	ad_if ad_m_if1
	);

wire resetn = reset;


// external io

// aurora link

reg clock_ref; // aurora ref clock.
initial begin
	clock_ref = 1'b0;
    forever #5 clock_ref = ~clock_ref;
end



// data pack
wire		axis_a_tready;
wire [31:0]	axis_a_tdata ;
wire		axis_a_tvalid;
wire		axis_b_tready;
wire [31:0]	axis_b_tdata ;
wire		axis_b_tvalid;
wire		axis_tvalid ;
wire [31:0]	axis_tdata 	;
wire		axis_tready ;

assign 		axis_a_tdata		= ad_m_if0.tdata;
assign 		axis_a_tvalid		= ad_m_if0.tvalid;
assign 		axis_b_tdata		= ad_m_if0.tdata;
assign		axis_b_tvalid		= ad_m_if0.tvalid;
assign  	ad_m_if0.tready 	= 1'b1;
assign		axis_tready			= 1'b1;

pcard_pack pcard_pack_0 (
	.axis_aclk 				(clock),
	.axis_a_aresetn_i 		(resetn),
	.axis_b_aresetn_i 		(resetn),
	.axis_aresetn_o 		(),
	.s_axis_a_tready 		(axis_a_tready),
	.s_axis_a_tdata 		(axis_a_tdata ),
	.s_axis_a_tvalid 		(axis_a_tvalid),
	.s_axis_b_tready 		(axis_b_tready),
	.s_axis_b_tdata 		(axis_b_tdata ),
	.s_axis_b_tvalid 		(axis_b_tvalid),
	.m_axis_tvalid 			(axis_tvalid),
	.m_axis_tdata 			(axis_tdata ),
	.m_axis_tready 			(axis_tready),
	.adc_start 				(1'b1),
	.debug_data1 			(),
	.debug_data2 			(),
	.debug_sig 				(),
	.debug_sig1 			(  )
    );

// dut
wire  [6:0]  card_insert_n = 7'b1111111;
pa5000 system_top(

	.sys_int_ctrl_0_card_insert_n_pin(card_insert_n),

	// axis4
    .s_axi_awaddr   (m_if.axi_awaddr    ),
    .s_axi_awvalid  (m_if.axi_awvalid   ),
    .s_axi_awready  (m_if.axi_awready   ),
    .s_axi_wdata    (m_if.axi_wdata         ),
    .s_axi_wstrb    (m_if.axi_wstrb         ),
    .s_axi_wvalid   (m_if.axi_wvalid    ),
    .s_axi_wready   (m_if.axi_wready    ),
    .s_axi_bresp    (m_if.axi_bresp         ),
    .s_axi_bvalid   (m_if.axi_bvalid    ),
    .s_axi_bready   (m_if.axi_bready    ),
    .s_axi_araddr   (m_if.axi_araddr    ),
    .s_axi_arvalid  (m_if.axi_arvalid   ),
    .s_axi_arready  (m_if.axi_arready   ),
    .s_axi_rdata    (m_if.axi_rdata         ),
    .s_axi_rresp    (m_if.axi_rresp         ),
    .s_axi_rvalid   (m_if.axi_rvalid    ),
    .s_axi_rready   (m_if.axi_rready    ),
	.s_axi_arlen	(8'b0),
	.s_axi_arsize	(3'b010),
	.s_axi_arburst	(2'b0),
	.s_axi_arcache	(4'b0),
	.s_axi_arprot	(3'b0),
	.s_axi_awlen	(8'b0),
	.s_axi_awsize	(3'b010),
	.s_axi_awburst	(2'b0),
	.s_axi_awcache	(4'b0),
	.s_axi_awprot	(3'b0),
	.s_axi_wlast	(1'b1),
	// axis to aurora
    .ch0_data	(axis_tdata	),
    .ch0_valid	(axis_tvalid	),
    .ch1_data	(axis_tdata	),
    .ch1_valid	(axis_tvalid	),
    .ch2_data	(axis_tdata	),
    .ch2_valid	(axis_tvalid	),
    .ch3_data	(axis_tdata	),
    .ch3_valid	(axis_tvalid	),
    .ch4_data	(axis_tdata	),
    .ch4_valid	(axis_tvalid	),
    .ch5_data	(axis_tdata	),
    .ch5_valid	(axis_tvalid	),
    .ch6_data	(axis_tdata	),
    .ch6_valid	(axis_tvalid	),
	.sim_user_clk(clock	),

	// ddr3
	.ddr3_ctrl_0_sys_clk_i_pin(clock),
	.ddr3_ctrl_0_clk_ref_i_pin(clock),

	// clock, reset
    .proc_sys_reset_0_Ext_Reset_In_pin(resetn),
    .util_ds_buf_0_IBUF_DS_P_pin(clock),
    .util_ds_buf_0_IBUF_DS_N_pin(~clock)
);

endmodule

