//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: THis is the configuration for the lc3 environment.
//  it contains configuration classes for each agent.  It also contains
//  environment level configuration variables.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class lc3_env_configuration 
extends uvmf_environment_configuration_base;

  `uvm_object_utils( lc3_env_configuration )


//Constraints for the configuration variables:


  covergroup lc3_configuration_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    // pragma uvmf custom covergroup end
  endgroup

typedef fetch_env_configuration fetch_subenvironment_config_t;
rand fetch_subenvironment_config_t fetch_subenvironment_config;

typedef decode_env_configuration decode_subenvironment_config_t;
rand decode_subenvironment_config_t decode_subenvironment_config;

typedef execute_env_configuration execute_subenvironment_config_t;
rand execute_subenvironment_config_t execute_subenvironment_config;

typedef writeback_env_configuration writeback_subenvironment_config_t;
rand writeback_subenvironment_config_t writeback_subenvironment_config;

typedef memaccess_env_configuration memaccess_subenvironment_config_t;
rand memaccess_subenvironment_config_t memaccess_subenvironment_config;

typedef control_env_configuration control_subenvironment_config_t;
rand control_subenvironment_config_t control_subenvironment_config;



    string                fetch_subenvironment_interface_names[];
    uvmf_active_passive_t fetch_subenvironment_interface_activity[];
    string                decode_subenvironment_interface_names[];
    uvmf_active_passive_t decode_subenvironment_interface_activity[];
    string                execute_subenvironment_interface_names[];
    uvmf_active_passive_t execute_subenvironment_interface_activity[];
    string                writeback_subenvironment_interface_names[];
    uvmf_active_passive_t writeback_subenvironment_interface_activity[];
    string                memaccess_subenvironment_interface_names[];
    uvmf_active_passive_t memaccess_subenvironment_interface_activity[];
    string                control_subenvironment_interface_names[];
    uvmf_active_passive_t control_subenvironment_interface_activity[];


  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(lc3_env_configuration)) lc3_vsqr_t;
  lc3_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
// This function constructs the configuration object for each agent in the environment.
//
  function new( string name = "" );
    super.new( name );

   fetch_subenvironment_config = fetch_subenvironment_config_t::type_id::create("fetch_subenvironment_config");
   decode_subenvironment_config = decode_subenvironment_config_t::type_id::create("decode_subenvironment_config");
   execute_subenvironment_config = execute_subenvironment_config_t::type_id::create("execute_subenvironment_config");
   writeback_subenvironment_config = writeback_subenvironment_config_t::type_id::create("writeback_subenvironment_config");
   memaccess_subenvironment_config = memaccess_subenvironment_config_t::type_id::create("memaccess_subenvironment_config");
   control_subenvironment_config = control_subenvironment_config_t::type_id::create("control_subenvironment_config");



    lc3_configuration_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that configuration variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")

  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
// FUNCTION : set_vsqr()
// This function is used to assign the vsqr handle.
  virtual function void set_vsqr( lc3_vsqr_t vsqr);
     this.vsqr = vsqr;
  endfunction : set_vsqr

// ****************************************************************************
// FUNCTION: post_randomize()
// This function is automatically called after the randomize() function 
// is executed.
//
  function void post_randomize();
    super.post_randomize();
    // pragma uvmf custom post_randomize begin
    // pragma uvmf custom post_randomize end
  endfunction
  
// ****************************************************************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for
// logfile reporting. This function concatenates the convert2string result for
// each agent configuration in this configuration class.
//
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    return {
     

     "\n", fetch_subenvironment_config.convert2string,
     "\n", decode_subenvironment_config.convert2string,
     "\n", execute_subenvironment_config.convert2string,
     "\n", writeback_subenvironment_config.convert2string,
     "\n", memaccess_subenvironment_config.convert2string,
     "\n", control_subenvironment_config.convert2string

       };
    // pragma uvmf custom convert2string end
  endfunction
// ****************************************************************************
// FUNCTION: initialize();
// This function configures each interface agents configuration class.  The 
// sim level determines the active/passive state of the agent.  The environment_path
// identifies the hierarchy down to and including the instantiation name of the
// environment for this configuration class.  Each instance of the environment 
// has its own configuration class.  The string interface names are used by 
// the agent configurations to identify the virtual interface handle to pull from
// the uvm_config_db.  
//
  function void initialize(uvmf_sim_level_t sim_level, 
                                      string environment_path,
                                      string interface_names[],
                                      uvm_reg_block register_model = null,
                                      uvmf_active_passive_t interface_activity[] = {}
                                     );

    super.initialize(sim_level, environment_path, interface_names, register_model, interface_activity);

  // Interface initialization for sub-environments
    fetch_subenvironment_interface_names    = new[2];
    fetch_subenvironment_interface_activity = new[2];

    fetch_subenvironment_interface_names     = interface_names[0:1];
    fetch_subenvironment_interface_activity  = interface_activity[0:1];
    decode_subenvironment_interface_names    = new[2];
    decode_subenvironment_interface_activity = new[2];

    decode_subenvironment_interface_names     = interface_names[2:3];
    decode_subenvironment_interface_activity  = interface_activity[2:3];
    execute_subenvironment_interface_names    = new[2];
    execute_subenvironment_interface_activity = new[2];

    execute_subenvironment_interface_names     = interface_names[4:5];
    execute_subenvironment_interface_activity  = interface_activity[4:5];
    writeback_subenvironment_interface_names    = new[2];
    writeback_subenvironment_interface_activity = new[2];

    writeback_subenvironment_interface_names     = interface_names[6:7];
    writeback_subenvironment_interface_activity  = interface_activity[6:7];
    memaccess_subenvironment_interface_names    = new[2];
    memaccess_subenvironment_interface_activity = new[2];

    memaccess_subenvironment_interface_names     = interface_names[8:9];
    memaccess_subenvironment_interface_activity  = interface_activity[8:9];
    control_subenvironment_interface_names    = new[2];
    control_subenvironment_interface_activity = new[2];

    control_subenvironment_interface_names     = interface_names[10:11];
    control_subenvironment_interface_activity  = interface_activity[10:11];




     fetch_subenvironment_config.initialize( sim_level, {environment_path,".fetch_subenvironment"}, fetch_subenvironment_interface_names, null,   fetch_subenvironment_interface_activity);
     decode_subenvironment_config.initialize( sim_level, {environment_path,".decode_subenvironment"}, decode_subenvironment_interface_names, null,   decode_subenvironment_interface_activity);
     execute_subenvironment_config.initialize( sim_level, {environment_path,".execute_subenvironment"}, execute_subenvironment_interface_names, null,   execute_subenvironment_interface_activity);
     writeback_subenvironment_config.initialize( sim_level, {environment_path,".writeback_subenvironment"}, writeback_subenvironment_interface_names, null,   writeback_subenvironment_interface_activity);
     memaccess_subenvironment_config.initialize( sim_level, {environment_path,".memaccess_subenvironment"}, memaccess_subenvironment_interface_names, null,   memaccess_subenvironment_interface_activity);
     control_subenvironment_config.initialize( sim_level, {environment_path,".control_subenvironment"}, control_subenvironment_interface_names, null,   control_subenvironment_interface_activity);



  // pragma uvmf custom initialize begin
  // pragma uvmf custom initialize end

  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

