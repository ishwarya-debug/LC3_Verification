module hvl_top();

    import uvm_pkg::*;

    `include "uvm_macros.svh"

    import fetch_in_pkg::*;
    import fetch_out_pkg::*;
    import decode_in_pkg::*;
    import decode_out_pkg::*;
    import execute_in_pkg::*;
    import execute_out_pkg::*;
    import memaccess_in_pkg::*;
    import memaccess_out_pkg::*;
    import writeback_in_pkg::*;
    import writeback_out_pkg::*;
    import control_in_pkg::*;
    import control_out_pkg::*;
    import lc3_test_pkg::*;

    // class test_top extends uvm_test;

    //     `uvm_component_utils( test_top ); 

    //     decode_in_cfg       decode_in_agent_cfg;
    //     decode_in_agent     agent_in_agent_obj;
    //     decode_in_sequence  decode_in_sequence_obj;

    //     function new(string name, uvm_component parent = null);
    //         super.new(name, parent);
    //     endfunction: new

    //     function build_phase(uvm_phase phase);
    //         decode_in_agent_cfg     =   new("decode_in_agent_cfg", this);
    //         agent_in_agent_obj      =   new("agent_in_agent_obj", this);
    //         decode_in_sequence_obj  =   new("decode_in_sequence_obj", this);   
    //     endfunction
 
    // endclass: test_top

    initial begin
        // $display("hvl_top:: Calling run_test() now");
        // `uvm_info("hvl_top", "Calling run_test", UVM_MEDIUM)
        run_test();
    end

endmodule