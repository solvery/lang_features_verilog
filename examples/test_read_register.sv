
class read_register extends demo_base_vseq;


  function new(string name="read_register");
      super.new(name);
  endfunction : new

  // Register sequence with a sequencer 
 `uvm_object_utils(read_register)

	wait_load_arg_vseq 	wait_load_arg;
	read_word_seq		read_reg_seq;
	write_word_seq		write_reg_seq;

  virtual task body();
  	bit [31:0] addr;
  	bit [31:0] data;
    `uvm_info(get_type_name(), "Virtual Sequencer Executing", UVM_LOW)

	#700; // wait reset done
`ifdef 0
	// read arg reg
	addr = 32'h100<<2; // arg reg base address.
	for(int i=0; i<75*2; i++) begin
    	`uvm_do_on_with(read_reg_seq, p_sequencer.axi4lite_seqr, {
				start_addr == addr;
			});
		addr = addr + 4;
	end
`endif	
	addr = 32'h1<<2;
	data = 32'hff;
    `uvm_do_on_with(write_reg_seq,	p_sequencer.axi4lite_seqr, { start_addr == addr; write_data == data;});
#2000;
    `uvm_do_on_with(read_reg_seq,	p_sequencer.axi4lite_seqr, { start_addr == addr; });

  endtask : body

endclass : read_register

class test_read_register extends demo_base_test;

  `uvm_component_utils(test_read_register)

  function new(string name = "test_read_register", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slaves
    uvm_config_db#(uvm_object_wrapper)::set(this, "demo_tb0.virtual_sequencer.run_phase","default_sequence", 
		read_register::type_id::get());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : test_read_register

