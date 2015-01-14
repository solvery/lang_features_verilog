/*-----------------------------------------------------------------
File name     : demo_top.sv
Developers    : Kathleen Meade
Created       : Tue May  4 15:13:46 2010
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2010 (c) Cadence Design Systems
-----------------------------------------------------------------*/
`timescale 1 ns / 100 ps

`include "ad_if.sv"
`include "axi4lite_if.sv"
`include "ad_pkg.sv"
`include "axi4lite_pkg.sv"
`include "axi4stream_pkg.sv"

module demo_top;

  // Import the UVM Package
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Import the AD UVC Package
  import ad_pkg::*;
  import axi4lite_pkg::*;

	`include "demo_config.sv"
	`include "demo_virtual_sequencer.sv"
  // Import the test library
	`include "demo_tb.sv"
	`include "demo_vseq_lib.sv"
  `include "test_lib.sv"

  reg clock;
  reg reset;

  ad_if ad_m_if_0(clock, reset);
  ad_if ad_m_if_1(clock, reset);
  axi4lite_if axi4lite_m_if_0(clock, reset);

  dut_dummy dut(clock, reset, 
		  axi4lite_m_if_0, 
		  ad_m_if_0, ad_m_if_1);

  initial begin
    uvm_config_db#(virtual ad_if)::set(null, "uvm_test_top.demo_tb0.ad_m0*", "vif", ad_m_if_0);
    uvm_config_db#(virtual ad_if)::set(null, "uvm_test_top.demo_tb0.ad_m1*", "vif", ad_m_if_1);
	uvm_config_db#(virtual axi4lite_if)::set(null, "*.demo_tb0.axi4lite_m0*", "vif", axi4lite_m_if_0);
	uvm_config_db#(virtual axi4lite_if)::set(null, "*.demo_tb0.axi4lite_m0.master*", "vif", axi4lite_m_if_0);
	uvm_config_db#(virtual axi4lite_if)::set(null, "*.demo_tb0.axi4lite_m0.bus_collector", "vif", axi4lite_m_if_0);
    run_test();
  end

  initial begin
    reset <= 1'b0;
    clock <= 1'b1;
    #51 reset = 1'b1;
  end

  //Generate Clock
  always #5 clock = ~clock;

endmodule
