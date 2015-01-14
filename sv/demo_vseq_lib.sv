
class demo_base_vseq extends uvm_sequence;
  function new(string name="demo_base_vseq");
    super.new(name);
  endfunction

  `uvm_object_utils(demo_base_vseq)
  `uvm_declare_p_sequencer(demo_virtual_sequencer)

  // Use a base sequence to raise/drop objections if this is a default sequence
  virtual task pre_body();
     if (starting_phase != null)
        starting_phase.raise_objection(this, {"Running sequence '",
                                              get_full_name(), "'"});
  endtask

  virtual task post_body();
     if (starting_phase != null)
        starting_phase.drop_objection(this, {"Completed sequence '",
                                             get_full_name(), "'"});
  endtask
endclass : demo_base_vseq

class pcard_ad_tx_vseq extends demo_base_vseq;


  function new(string name="pcard_ad_tx_vseq");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(pcard_ad_tx_vseq)

	ad_multiple_simple_trans ad_tx_seq;

  virtual task body();
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

	fork
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr0, {cnt == 101;})
    `uvm_do_on_with(ad_tx_seq, p_sequencer.ad_tx_seqr1, {cnt == 101;})
	join

  endtask : body

endclass : pcard_ad_tx_vseq


class wait_load_arg_vseq extends demo_base_vseq;

  function new(string name="wait_load_arg_vseq");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(wait_load_arg_vseq)

  virtual task body();
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

	#(2650*75*2); // checkpoint: spi flash in 25M clock. 
	#(100);

  endtask : body

endclass : wait_load_arg_vseq


