
class template_vseq extends demo_base_vseq;


  function new(string name="template_vseq");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(template_vseq)

	ad_multiple_simple_trans ad_tx_seq;

  virtual task body();
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

	fork
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr0, {cnt == 101;})
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr1, {cnt == 101;})
	join

  endtask : body

endclass : template_vseq

class test_template_vseq extends demo_base_test;

  `uvm_component_utils(test_template_vseq)

  function new(string name = "test_template_vseq", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slaves
    uvm_config_db#(uvm_object_wrapper)::set(this, "demo_tb0.virtual_sequencer.run_phase","default_sequence", 
		template_vseq::type_id::get());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : test_template_vseq

