
class front_ctrl_laod_arg_vseq extends demo_base_vseq;


  function new(string name="front_ctrl_laod_arg_vseq");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(front_ctrl_laod_arg_vseq)

	wait_load_arg_vseq wait_load_arg;

  virtual task body();
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

    `uvm_do(wait_load_arg);

  endtask : body

endclass : front_ctrl_laod_arg_vseq

class test_front_ctrl_laod_arg_vseq extends demo_base_test;

  `uvm_component_utils(test_front_ctrl_laod_arg_vseq)

  function new(string name = "test_front_ctrl_laod_arg_vseq", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slaves
    uvm_config_db#(uvm_object_wrapper)::set(this, "demo_tb0.virtual_sequencer.run_phase","default_sequence", 
		front_ctrl_laod_arg_vseq::type_id::get());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : test_front_ctrl_laod_arg_vseq

