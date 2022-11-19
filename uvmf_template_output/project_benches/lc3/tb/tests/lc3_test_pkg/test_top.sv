import lc3_env_pkg::*;
import uvmf_base_pkg_hdl::*;

class test_top extends uvm_test;

    `uvm_component_utils( test_top ); 
    
    // lc3_in_configuration     configuration;
    // lc3_in_agent             lc3_in_agent_obj;
    lc3_in_random_sequence   lc3_in_sequence_obj;
    // lc3_out_configuration    configuration_out;
    // lc3_out_agent            lc3_out_agent_obj;

    lc3_environment          lc3_env;
    lc3_env_configuration    lc3_env_config;

    // print_component             print_comp;

    // uvmf_parameterized_agent_configuration_base_s conf_in;
    // uvmf_parameterized_agent_configuration_base_s conf_out;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        `uvm_info("test_top", "Building Configuration, Agent and Sequence", UVM_MEDIUM)
        // configuration     =   new("configuration");
        // configuration_out =   new("configuration_out");
        // uvm_config_db#(lc3_in_configuration)::set(null, "*", "AGENT_CONFIG", configuration);
        // uvm_config_db#(lc3_out_configuration)::set(null, "*", "AGENT_CONFIG", configuration_out);
        // lc3_in_agent_obj     =   new("lc3_in_agent_obj", this);
        // lc3_out_agent_obj    =   new("lc3_out_agent_obj", this);
        lc3_in_sequence_obj  =   new("lc3_in_sequence_obj"); 

        lc3_env_config       =   new("lc3_env_config");

        lc3_env              =   new("lc3_env", this);

        // print_comp = new("print_comp", this);

        // uvmf_parameterized_agent_configuration_base_s conf_in;
        // conf_in = '{ACTIVE, INITIATOR, 1'b1};

        // uvmf_parameterized_agent_configuration_base_s conf_out;
        // conf_out = '{PASSIVE, RESPONDER, 1'b1};

        // lc3_env_config.initialize(   ACTIVE,
        //                                 "test_top.lc3_in_agent_obj",
        //                                 "lc3_in_agent",
        //                                 INITIATOR,
        //                                 1'b1,
                                        
        //                                 PASSIVE,
        //                                 "test_top.lc3_out_agent_obj",
        //                                 "lc3_out_agent",
        //                                 RESPONDER,
        //                                 1'b1);


        lc3_env.set_config(lc3_env_config);

        lc3_env_config.initialize(NA, 
                                     "test_top.env",
                                     { "lc3_in_agent", "lc3_out_agent"},
                                     null,
                                     { ACTIVE, PASSIVE}
                                     );

        // configuration.initialize(ACTIVE, "test_top.lc3_in_agent_obj", "lc3_in_agent");
        // // configuration.active_passive = ACTIVE;
        // configuration.initiator_responder = INITIATOR;
        // configuration.has_coverage = 1'b1;

        // configuration_out.initialize(PASSIVE, "test_top.lc3_out_agent_obj", "lc3_out_agent");
        // // configuration_out.active_passive = PASSIVE;
        // configuration_out.initiator_responder = RESPONDER;
        // configuration_out.has_coverage = 1'b1;



        `uvm_info("test_top", "Done Building Everything in test_top", UVM_MEDIUM)
    endfunction
    
    // virtual function void connect_phase(uvm_phase phase);
    //     super.connect_phase(phase);
    //     lc3_in_agent_obj.monitor.monitored_ap.connect(print_comp.lc3_in_agent_imp);
    //     lc3_out_agent_obj.monitor.monitored_ap.connect(print_comp.lc3_out_agent_imp);
    // endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info("test_top", "Starting Run Phase", UVM_MEDIUM)
        phase.raise_objection(this);
        // lc3_in_sequence_obj.sequencer = lc3_in_agent_obj.sequencer;
        repeat(25) begin
            lc3_in_sequence_obj.start(lc3_env.lc3_in_agent_obj.sequencer);
        end
        lc3_env_config.lc3_in_agent_obj_config.wait_for_num_clocks(1);
        phase.drop_objection(this);
    endtask


endclass: test_top