//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class lc3_environment  extends uvmf_environment_base #(
    .CONFIG_T( lc3_env_configuration 
  ));
  `uvm_component_utils( lc3_environment )

  typedef fetch_environment fetch_subenvironment_t;
  fetch_subenvironment_t fetch_subenvironment;
   
  typedef decode_environment decode_subenvironment_t;
  decode_subenvironment_t decode_subenvironment;
   
  typedef execute_environment execute_subenvironment_t;
  execute_subenvironment_t execute_subenvironment;
   
  typedef writeback_environment writeback_subenvironment_t;
  writeback_subenvironment_t writeback_subenvironment;
   
  typedef memaccess_environment memaccess_subenvironment_t;
  memaccess_subenvironment_t memaccess_subenvironment;
   
  typedef control_environment control_subenvironment_t;
  control_subenvironment_t control_subenvironment;
   











  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(lc3_env_configuration)) lc3_vsqr_t;
  lc3_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    fetch_subenvironment = fetch_subenvironment_t::type_id::create("fetch_subenvironment",this);
    fetch_subenvironment.set_config(configuration.fetch_subenvironment_config);
    decode_subenvironment = decode_subenvironment_t::type_id::create("decode_subenvironment",this);
    decode_subenvironment.set_config(configuration.decode_subenvironment_config);
    execute_subenvironment = execute_subenvironment_t::type_id::create("execute_subenvironment",this);
    execute_subenvironment.set_config(configuration.execute_subenvironment_config);
    writeback_subenvironment = writeback_subenvironment_t::type_id::create("writeback_subenvironment",this);
    writeback_subenvironment.set_config(configuration.writeback_subenvironment_config);
    memaccess_subenvironment = memaccess_subenvironment_t::type_id::create("memaccess_subenvironment",this);
    memaccess_subenvironment.set_config(configuration.memaccess_subenvironment_config);
    control_subenvironment = control_subenvironment_t::type_id::create("control_subenvironment",this);
    control_subenvironment.set_config(configuration.control_subenvironment_config);

    vsqr = lc3_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.lc3_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

