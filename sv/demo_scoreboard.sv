/*-----------------------------------------------------------------
File name     : demo_scoreboard.sv
Developers    : Kathleen Meade
Created       : Tue May 11, 2010
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2010 (c) Cadence Design Systems
-----------------------------------------------------------------*/

`ifndef DEMO_SCOREBOARD_SV
`define DEMO_SCOREBOARD_SV

//------------------------------------------------------------------------------
//
// CLASS: demo_scoreboard
//
//------------------------------------------------------------------------------

`uvm_analysis_imp_decl(_tx)

class demo_scoreboard extends uvm_scoreboard;

  // This TLM port is used to connect the scoreboard to the monitor
  uvm_analysis_imp_tx#(ad_trans, demo_scoreboard) item_collected_imp_tx;

  protected bit disable_scoreboard = 0;
  protected int num_writes = 0;
  protected int num_init_reads = 0;
  protected int num_uninit_reads = 0;

  bit [32-1:0]	data_to_check[$];

  // Provide UVM automation and utility methods
  `uvm_component_utils_begin(demo_scoreboard)
    `uvm_field_int(disable_scoreboard, UVM_ALL_ON)
    `uvm_field_int(num_writes, UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(num_init_reads, UVM_ALL_ON|UVM_DEC)
    `uvm_field_int(num_uninit_reads, UVM_ALL_ON|UVM_DEC)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
    // Construct the TLM interface
    item_collected_imp_tx = new("item_collected_imp_tx", this);
  endfunction : new

  // Additional class methods
  extern virtual function void write_tx(ad_trans trans);
  extern virtual function void report();
   
endclass : demo_scoreboard

  // TLM write() implementation
  function void demo_scoreboard::write_tx(ad_trans trans);
    if(!disable_scoreboard)
	begin
		bit [31:0] result;
		result = ~trans.data;
		data_to_check.push_back(result);
		`uvm_info("SCRBD", $psprintf("write_tx received = 'h%0h", trans.data), UVM_LOW)
	end
  endfunction : write_tx

  // report
  function void demo_scoreboard::report();
    if(!disable_scoreboard)
      `uvm_info(get_type_name(),
        $psprintf("Reporting scoreboard information...\n%s", this.sprint()), 
        UVM_LOW)
  endfunction : report

`endif // DEMO_SCOREBOARD_SV

