
class datapath_from_ad_to_aurora extends demo_base_vseq;


  function new(string name="datapath_from_ad_to_aurora");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(datapath_from_ad_to_aurora)

	ad_multiple_simple_trans ad_tx_seq;

  virtual task body();
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

	#6000; // wait for reset done.
	fork
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr0, {cnt == 10;})
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr1, {cnt == 10;})
	join
	#8000;

  endtask : body

endclass : datapath_from_ad_to_aurora

class test_datapath_from_ad_to_aurora extends demo_base_test;

  `uvm_component_utils(test_datapath_from_ad_to_aurora)

  function new(string name = "test_datapath_from_ad_to_aurora", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slaves
    uvm_config_db#(uvm_object_wrapper)::set(this, "demo_tb0.virtual_sequencer.run_phase","default_sequence", 
		datapath_from_ad_to_aurora::type_id::get());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : test_datapath_from_ad_to_aurora

