
class load_arg_and_read_register extends demo_base_vseq;


  function new(string name="load_arg_and_read_register");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(load_arg_and_read_register)

	wait_load_arg_vseq 	wait_load_arg;
	read_word_seq		read_reg_seq;

  virtual task body();
  	bit [31:0] addr;
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

	$fsdbDumpoff;
    `uvm_do(wait_load_arg);
	$fsdbDumpon;
    `uvm_do(wait_load_arg);
	// read arg reg
	addr = 32'h100;
	for(int i=0; i<75*2; i++) begin
    	`uvm_do_on_with(read_reg_seq, p_sequencer.axi4lite_seqr, {
				start_addr == addr;
			});
		addr = addr + 4;
	end

  endtask : body

endclass : load_arg_and_read_register

class test_load_arg_and_read_register extends demo_base_test;

  `uvm_component_utils(test_load_arg_and_read_register)

  function new(string name = "test_load_arg_and_read_register", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slaves
    uvm_config_db#(uvm_object_wrapper)::set(this, "demo_tb0.virtual_sequencer.run_phase","default_sequence", 
		load_arg_and_read_register::type_id::get());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : test_load_arg_and_read_register

