
module demo_top;

  // Import the UVM Package

  reg clock;
  reg reset;


  dut_dummy dut(clock, reset, ad_m_if_0, ad_m_if_1);

  initial begin
    reset <= 1'b0;
    clock <= 1'b1;
    #251 reset = 1'b1;
  end

  //Generate Clock
  always #5 clock = ~clock;

endmodule
