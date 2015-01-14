/*-----------------------------------------------------------------
File name     : demo_tb.sv
Developers    : Kathleen Meade
Created       : May 16, 2010
Description   : Simple Testbench to understand the APB UVC
Notes         :
-------------------------------------------------------------------
Copyright 2010 (c) Cadence Design Systems
-----------------------------------------------------------------*/

`ifndef DEMO_TB_SV
`define DEMO_TB_SV


`include "demo_scoreboard.sv"
`include "demo_config.sv"

//------------------------------------------------------------------------------
// CLASS: demo_tb
//------------------------------------------------------------------------------

class demo_tb extends uvm_env;

  // Provide UVM automation and utility methods
  `uvm_component_utils(demo_tb)

  // AD environment
  ad_pkg::ad_env ad_m0;
  ad_pkg::ad_env ad_m1;
  axi4lite_pkg::axi4lite_env axi4lite_m0;

	// Virtual sequencer
	demo_virtual_sequencer virtual_sequencer;

  // configuration object
  demo_m_config cfg;

  // Scoreboard 
  demo_scoreboard scoreboard0;

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : demo_tb

  // UVM build() phase
  function void demo_tb::build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Create the configuration object
    cfg = demo_m_config::type_id::create("cfg");     
    if (!cfg.randomize()) `uvm_error("RNDFAIL", "Demo Config Randomization")
    cfg.print();

    uvm_config_object::set(this, "ad_m0*", "cfg", cfg.ad_cfg);
    ad_m0 = ad_env::type_id::create("ad_m0", this);
    uvm_config_object::set(this, "ad_m1*", "cfg", cfg.ad_cfg);
    ad_m1 = ad_env::type_id::create("ad_m1", this);

    cfg = demo_m_config::type_id::create("cfg");
    uvm_config_object::set(this, "axi4lite_m0*", "cfg", cfg.axi4lite_cfg);
    uvm_config_object::set(this, "axi4lite_m0.slave[0]*", "cfg", cfg.axi4lite_cfg.slave_configs[0]);
	axi4lite_m0 = axi4lite_env::type_id::create("axi4lite_m0", this);

	uvm_config_object::set(this, "virtual_sequencer", "cfg", cfg);
	virtual_sequencer = demo_virtual_sequencer::type_id::create("virtual_sequencer",this);

	scoreboard0 = demo_scoreboard::type_id::create("scoreboard0",this);
  endfunction : build_phase

  // UVM connect() phase
  function void demo_tb::connect_phase(uvm_phase phase);
  	//ad_m0.Tx.monitor.item_collected_port.connect(scoreboard0.item_collected_imp_tx);
  	virtual_sequencer.axi4lite_seqr = axi4lite_m0.master.sequencer;
	virtual_sequencer.ad_tx_seqr0	= ad_m0.Tx.sequencer;
	virtual_sequencer.ad_tx_seqr1	= ad_m1.Tx.sequencer;
  endfunction : connect_phase

`endif // DEMO_TB_SV
