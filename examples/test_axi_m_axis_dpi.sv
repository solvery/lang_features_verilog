
class axi_m_axis_dpi_seq extends demo_base_vseq;


  function new(string name="axi_m_axis_dpi_seq");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(axi_m_axis_dpi_seq)

	ad_multi_fixed_data_dis_trans ad_tx_seq;
	read_word_seq		read_reg_seq;
	write_word_seq		write_reg_seq;

	bit [31:0] addr;
	bit [31:0] data;

	task reg32_r(bit [31:0] addr);
    	`uvm_do_on_with(read_reg_seq, p_sequencer.axi4lite_seqr, { start_addr == addr; });
	endtask

	task reg32_w(bit [31:0] addr, bit [31:0] data);
    	`uvm_do_on_with(write_reg_seq, p_sequencer.axi4lite_seqr, { start_addr == addr; write_data == data; });
	endtask

  virtual task body();
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

	#6000; // wait for reset done.

	addr = 32'h00031000;
	reg32_r(addr);

	addr = 32'h00031000;
	data = 32'h11;
	reg32_w(addr, data);
	reg32_w(32'h00031000, 32'h12);

	fork
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr0, {cnt == 20; start_data == -30; })
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr1, {cnt == 20; start_data == 32'h50; })
	join


	#20;

  endtask : body

endclass : axi_m_axis_dpi_seq

class test_axi_m_axis_dpi extends demo_base_test;

  `uvm_component_utils(test_axi_m_axis_dpi)

  function new(string name = "test_axi_m_axis_dpi", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slaves
    uvm_config_db#(uvm_object_wrapper)::set(this, "demo_tb0.virtual_sequencer.run_phase","default_sequence", 
		axi_m_axis_dpi_seq::type_id::get());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : test_axi_m_axis_dpi

