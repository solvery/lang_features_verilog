
class demo_virtual_sequencer extends uvm_sequencer;
  
    ad_pkg::ad_sequencer ad_tx_seqr0;
    ad_pkg::ad_sequencer ad_tx_seqr1;
    axi4lite_pkg::axi4lite_master_sequencer axi4lite_seqr;
    //axi4stream_pkg::uart_sequencer axi4stream_seqr;

    // UVM_REG: Pointer to the register model
   
    // Uart Controller configuration object
    demo_m_config cfg;

    function new (input string name="demo_virtual_sequencer", input uvm_component parent=null);
      super.new(name, parent);
    endfunction : new

    `uvm_component_utils_begin(demo_virtual_sequencer)
       `uvm_field_object(cfg, UVM_DEFAULT | UVM_NOPRINT)
    `uvm_component_utils_end

endclass : demo_virtual_sequencer

