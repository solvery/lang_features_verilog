/*******************************************************************************
  Copyright (c) 2006 Cadence Design Systems, Inc.
  All rights reserved worldwide.
********************************************************************************
  FILE : demo_config.sv
*******************************************************************************/
`ifndef DEMO_CONFIG_SV
`define DEMO_CONFIG_SV
class demo_config extends uvm_object;

	ad_config ad_cfg;
	axi4lite_config axi4lite_cfg;

  `uvm_object_utils_begin(demo_config)
      `uvm_field_object(ad_cfg, UVM_DEFAULT)
      `uvm_field_object(axi4lite_cfg, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "demo_config");
    super.new(name);
	ad_cfg = ad_config::type_id::create("ad_cfg");
	axi4lite_cfg = axi4lite_config::type_id::create("axi4lite_cfg");
  endfunction

endclass

class demo_m_config extends demo_config;

  `uvm_object_utils(demo_m_config)

  function new(string name = "demo_m_config");
    super.new(name);
	ad_cfg = ad_config::type_id::create("ad_cfg");
	ad_cfg.is_tx_active = UVM_ACTIVE;

	axi4lite_cfg = axi4lite_config::type_id::create("axi4lite_cfg");
	axi4lite_cfg.add_slave("slave0", 32'h0000_0000, 32'h7FFF_FFFF, 0, UVM_PASSIVE);
	axi4lite_cfg.add_master("master", UVM_ACTIVE);
  endfunction

endclass

`endif
