// Description here
// ### Author : Nazmus Sakib (nazmus.sakib.punno@dsinnovators.com)

`include "clocking.svh"

module edge_detector_tb;

  `define ENABLE_DUMPFILE

  //`define ENABLE_DUMPFILE

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // bring in the testbench essentials functions and macros
  `include "tb_ess.svh"

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-LOCALPARAMS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-TYPEDEFS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // generates static task start_clk_i with tHigh:4ns tLow:6ns
  `CREATE_CLK(clk_i, 5ns, 5ns)
  logic in;
  logic out;

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-VARIABLES{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  logic err_n=0;
  logic err_p=0;
  

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-INTERFACES{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-CLASSES{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-ASSIGNMENTS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////


    
edge_detector u_edge_detector(
    .e_data_i(in),
    .clk_ref_i(clk_i),
    .edge_out_bar_o(out)
);


  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-METHODS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  task static rand_switch(realtime unit_time = 1ns, int unsigned min = 100,
                          int unsigned max = 1000);
    fork
      forever begin
        #(unit_time * $urandom_range(min, max));
         in <= $urandom;
      end
    join_none
  endtask 

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always @(negedge in or posedge clk_i) begin
    @(posedge clk_i) begin
      #1fs
      if(out != 0) begin
        err_n=1;
      end
    end
    @(posedge clk_i) begin
      #1fs
      if(out != 1) begin
        err_p=1;
      end
    end
  end
  final begin                                                                                      
      result_print(err_n,"Didnt go low at first posedge!!");
      result_print(err_p,"Didnt go high at second posedge!!");                                                
    end
   

  initial begin  // main initial{{{
    start_clk_i();
    rand_switch();

    #0.5ms;


    $finish;

  end  //}}}

  //}}}

endmodule