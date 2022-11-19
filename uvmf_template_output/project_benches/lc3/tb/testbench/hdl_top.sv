`timescale 1ns/1ns

module hdl_top();

    import uvm_pkg::*;
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
    import uvmf_base_pkg_hdl::*;

    `include "uvm_macros.svh"

    logic           clk = 1;
    logic           reset=1;

    tri             complete_instr;
    tri             complete_data;
    tri     [15:0]  Instr_dout;
    tri     [15:0]  Data_dout;

    tri     [15:0]  PC;
    tri     [15:0]  Data_addr;
    tri     [15:0]  Data_din;
    tri             Data_rd;
    tri             instrmem_rd;
    tri             I_macc;
    tri             D_macc;

    LC3 DUT (	clk, reset, PC, instrmem_rd, Instr_dout, Data_addr, complete_instr, complete_data,  
                Data_din, Data_dout, Data_rd			
            );

    // Connecting BFMs to the interface bundle
    fetch_in_if                 fetch_ip_if(clk, reset, DUT.enable_updatePC, DUT.enable_fetch, DUT.pcout, DUT.br_taken);
    fetch_in_monitor_bfm        fetch_monitor_bfm(fetch_ip_if.monitor_port);
    fetch_in_driver_bfm         fetch_driver_bfm(fetch_ip_if.initiator_port);
    
    fetch_out_if                fetch_op_if(clk, reset, DUT.npc_out_fetch, DUT.pc, instrmem_rd);
    fetch_out_monitor_bfm       fetch_monitor_out_bfm(fetch_op_if.monitor_port);
    fetch_out_driver_bfm        fetch_driver_out_bfm(fetch_op_if.initiator_port);

    decode_in_if                decode_ip_if(clk, reset, DUT.enable_decode, DUT.Instr_dout, DUT.npc_out_fetch);
    decode_in_monitor_bfm       decode_monitor_bfm(decode_ip_if.monitor_port);
    decode_in_driver_bfm        decode_driver_bfm(decode_ip_if.initiator_port);
    
    decode_out_if               decode_op_if(clk, reset, DUT.IR, DUT.npc_out_dec, DUT.E_Control, DUT.W_Control, DUT.Mem_Control);
    decode_out_monitor_bfm      decode_monitor_out_bfm(decode_op_if.monitor_port);
    decode_out_driver_bfm       decode_driver_out_bfm(decode_op_if.initiator_port);

    execute_in_if               execute_ip_if(clk, reset, DUT.enable_execute, DUT.E_Control, DUT.IR, DUT.npc_out_dec, DUT.Mem_Control, DUT.W_Control, DUT.VSR1, DUT.VSR2, DUT.bypass_alu_1, DUT.bypass_alu_2, DUT.bypass_mem_1, DUT.bypass_mem_2, DUT.memout);
    execute_in_monitor_bfm      execute_monitor_bfm(execute_ip_if.monitor_port);
    execute_in_driver_bfm       execute_driver_bfm(execute_ip_if.initiator_port);
    
    execute_out_if              execute_op_if(clk, reset, DUT.aluout, DUT.W_Control_out, DUT.Mem_Control_out, DUT.M_Data, DUT.dr, DUT.sr1, DUT.sr2, DUT.pcout, DUT.NZP, DUT.IR_Exec);
    execute_out_monitor_bfm     execute_monitor_out_bfm(execute_op_if.monitor_port);
    execute_out_driver_bfm      execute_driver_out_bfm(execute_op_if.initiator_port);
    
    memaccess_in_if             memaccess_ip_if(clk, reset, DUT.M_Data, DUT.pcout, DUT.Mem_Control_out, DUT.mem_state, Data_dout);
    memaccess_in_monitor_bfm    memaccess_monitor_bfm(memaccess_ip_if.monitor_port);
    memaccess_in_driver_bfm     memaccess_driver_bfm(memaccess_ip_if.initiator_port);
    
    memaccess_out_if            memaccess_op_if(clk, reset, DUT.Data_addr, DUT.Data_din, DUT.Data_rd, DUT.memout);
    memaccess_out_monitor_bfm   memaccess_monitor_out_bfm(memaccess_op_if.monitor_port);
    memaccess_out_driver_bfm    memaccess_driver_out_bfm(memaccess_op_if.initiator_port);

    writeback_in_if             writeback_ip_if(clk, reset, DUT.npc_out_dec, DUT.W_Control_out, DUT.aluout, DUT.pcout, DUT.memout, DUT.enable_writeback, DUT.sr1, DUT.sr2, DUT.dr);
    writeback_in_monitor_bfm    writeback_monitor_bfm(writeback_ip_if.monitor_port);
    writeback_in_driver_bfm     writeback_driver_bfm(writeback_ip_if.initiator_port);
    
    writeback_out_if            writebacks_op_if(clk, reset, DUT.VSR1, DUT.VSR2, DUT.psr);
    writeback_out_monitor_bfm   writebacks_monitor_out_bfm(writeback_op_if.monitor_port);
    writeback_out_driver_bfm    writebacks_driver_out_bfm(writeback_op_if.initiator_port);

    control_in_if               control_ip_if(clk, reset, complete_data, complete_instr, DUT.IR, DUT.psr, DUT.IR_Exec, Instr_dout, DUT.NZP);
    control_in_monitor_bfm      control_monitor_bfm(control_ip_if.monitor_port);
    control_in_driver_bfm       control_driver_bfm(control_ip_if.initiator_port);
    
    control_out_if              control_op_if(clk, reset, DUT.enable_updatePC, DUT.enable_fetch, DUT.enable_decode, DUT.enable_execute, DUT.enable_writeback, DUT.bypass_alu_1, DUT.bypass_alu_2, DUT.bypass_mem_1, DUT.bypass_mem_2, DUT.mem_state, DUT.br_taken);
    control_out_monitor_bfm     control_monitor_out_bfm(control_op_if.monitor_port);
    control_out_driver_bfm      control_driver_out_bfm(control_op_if.initiator_port);

    initial begin
        `uvm_info("hdl_top", "Adding BFMs to uvm_config_db", UVM_MEDIUM)
        // Adding interface and BFM handles to config_db to be retrived by the agent configuration later

        uvm_config_db#(virtual fetch_in_monitor_bfm)::set(null, "*", "fetch_in_agent", fetch_monitor_bfm);
        uvm_config_db#(virtual fetch_in_driver_bfm)::set(null, "*", "fetch_in_agent", fetch_driver_bfm);
        uvm_config_db#(virtual fetch_in_if)::set(null, "*", "fetch_ip_if", fetch_ip_if);
        uvm_config_db#(virtual fetch_out_monitor_bfm)::set(null, "*", "fetch_out_agent", fetch_monitor_out_bfm);
        uvm_config_db#(virtual fetch_out_driver_bfm)::set(null, "*", "fetch_out_agent", fetch_driver_out_bfm);
        uvm_config_db#(virtual fetch_out_if)::set(null, "*", "fetch_op_if", fetch_op_if);

        uvm_config_db#(virtual decode_in_monitor_bfm)::set(null, "*", "decode_in_agent", decode_monitor_bfm);
        uvm_config_db#(virtual decode_in_driver_bfm)::set(null, "*", "decode_in_agent", decode_driver_bfm);
        uvm_config_db#(virtual decode_in_if)::set(null, "*", "decode_ip_if", decode_ip_if);
        uvm_config_db#(virtual decode_out_monitor_bfm)::set(null, "*", "decode_out_agent", decode_monitor_out_bfm);
        uvm_config_db#(virtual decode_out_driver_bfm)::set(null, "*", "decode_out_agent", decode_driver_out_bfm);
        uvm_config_db#(virtual decode_out_if)::set(null, "*", "decode_op_if", decode_op_if);

        uvm_config_db#(virtual execute_in_monitor_bfm)::set(null, "*", "execute_in_agent", execute_monitor_bfm);
        uvm_config_db#(virtual execute_in_driver_bfm)::set(null, "*", "execute_in_agent", execute_driver_bfm);
        uvm_config_db#(virtual execute_in_if)::set(null, "*", "execute_ip_if", execute_ip_if);
        uvm_config_db#(virtual execute_out_monitor_bfm)::set(null, "*", "execute_out_agent", execute_monitor_out_bfm);
        uvm_config_db#(virtual execute_out_driver_bfm)::set(null, "*", "execute_out_agent", execute_driver_out_bfm);
        uvm_config_db#(virtual execute_out_if)::set(null, "*", "execute_op_if", execute_op_if);

        uvm_config_db#(virtual memaccess_in_monitor_bfm)::set(null, "*", "memaccess_in_agent", memaccess_monitor_bfm);
        uvm_config_db#(virtual memaccess_in_driver_bfm)::set(null, "*", "memaccess_in_agent", memaccess_driver_bfm);
        uvm_config_db#(virtual memaccess_in_if)::set(null, "*", "memaccess_ip_if", memaccess_ip_if);
        uvm_config_db#(virtual memaccess_out_monitor_bfm)::set(null, "*", "memaccess_out_agent", memaccess_monitor_out_bfm);
        uvm_config_db#(virtual memaccess_out_driver_bfm)::set(null, "*", "memaccess_out_agent", memaccess_driver_out_bfm);
        uvm_config_db#(virtual memaccess_out_if)::set(null, "*", "memaccess_op_if", memaccess_op_if);

        uvm_config_db#(virtual writeback_in_monitor_bfm)::set(null, "*", "writeback_in_agent", writeback_monitor_bfm);
        uvm_config_db#(virtual writeback_in_driver_bfm)::set(null, "*", "writeback_in_agent", writeback_driver_bfm);
        uvm_config_db#(virtual writeback_in_if)::set(null, "*", "writeback_ip_if", writeback_ip_if);
        uvm_config_db#(virtual writeback_out_monitor_bfm)::set(null, "*", "writeback_out_agent", writeback_monitor_out_bfm);
        uvm_config_db#(virtual writeback_out_driver_bfm)::set(null, "*", "writeback_out_agent", writeback_driver_out_bfm);
        uvm_config_db#(virtual writeback_out_if)::set(null, "*", "writeback_op_if", writeback_op_if);

        uvm_config_db#(virtual control_in_monitor_bfm)::set(null, "*", "control_in_agent", control_monitor_bfm);
        uvm_config_db#(virtual control_in_driver_bfm)::set(null, "*", "control_in_agent", control_driver_bfm);
        uvm_config_db#(virtual control_in_if)::set(null, "*", "control_ip_if", control_ip_if);
        uvm_config_db#(virtual control_out_monitor_bfm)::set(null, "*", "control_out_agent", control_monitor_out_bfm);
        uvm_config_db#(virtual control_out_driver_bfm)::set(null, "*", "control_out_agent", control_driver_out_bfm);
        uvm_config_db#(virtual control_out_if)::set(null, "*", "control_op_if", control_op_if);                
    end

    initial forever #5 clk = ~clk;

    initial begin
        // $display();
        #10 reset   =   1'b0;
    end

endmodule: hdl_top