//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains environment level sequences that will
//    be reused from block to top level simulations.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class lc3_env_sequence_base #( 
      type CONFIG_T
      ) extends uvmf_virtual_sequence_base #(.CONFIG_T(CONFIG_T));


  `uvm_object_param_utils( lc3_env_sequence_base #(
                           CONFIG_T
                           ) );

  
// This lc3_env_sequence_base contains a handle to a lc3_env_configuration object 
// named configuration.  This configuration variable contains a handle to each 
// sequencer within each agent within this environment and any sub-environments.
// The configuration object handle is automatically assigned in the pre_body in the
// base class of this sequence.  The configuration handle is retrieved from the
// virtual sequencer that this sequence is started on.
// Available sequencer handles within the environment configuration:

  // Initiator agent sequencers in lc3_environment:

  // Responder agent sequencers in lc3_environment:

  // Virtual sequencers in sub-environments located in sub-environment configuration
    // configuration.fetch_subenvironment_config.vsqr
    // configuration.decode_subenvironment_config.vsqr
    // configuration.execute_subenvironment_config.vsqr
    // configuration.writeback_subenvironment_config.vsqr
    // configuration.memaccess_subenvironment_config.vsqr
    // configuration.control_subenvironment_config.vsqr


typedef fetch_env_sequence_base #(
        .CONFIG_T(fetch_env_configuration)
        ) 
        fetch_subenvironment_sequence_base_t;
rand fetch_subenvironment_sequence_base_t fetch_subenvironment_seq;

typedef decode_env_sequence_base #(
        .CONFIG_T(decode_env_configuration)
        ) 
        decode_subenvironment_sequence_base_t;
rand decode_subenvironment_sequence_base_t decode_subenvironment_seq;

typedef execute_env_sequence_base #(
        .CONFIG_T(execute_env_configuration)
        ) 
        execute_subenvironment_sequence_base_t;
rand execute_subenvironment_sequence_base_t execute_subenvironment_seq;

typedef writeback_env_sequence_base #(
        .CONFIG_T(writeback_env_configuration)
        ) 
        writeback_subenvironment_sequence_base_t;
rand writeback_subenvironment_sequence_base_t writeback_subenvironment_seq;

typedef memaccess_env_sequence_base #(
        .CONFIG_T(memaccess_env_configuration)
        ) 
        memaccess_subenvironment_sequence_base_t;
rand memaccess_subenvironment_sequence_base_t memaccess_subenvironment_seq;

typedef control_env_sequence_base #(
        .CONFIG_T(control_env_configuration)
        ) 
        control_subenvironment_sequence_base_t;
rand control_subenvironment_sequence_base_t control_subenvironment_seq;



  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  function new(string name = "" );
    super.new(name);

    fetch_subenvironment_seq = fetch_subenvironment_sequence_base_t::type_id::create("fetch_subenvironment_seq");
    decode_subenvironment_seq = decode_subenvironment_sequence_base_t::type_id::create("decode_subenvironment_seq");
    execute_subenvironment_seq = execute_subenvironment_sequence_base_t::type_id::create("execute_subenvironment_seq");
    writeback_subenvironment_seq = writeback_subenvironment_sequence_base_t::type_id::create("writeback_subenvironment_seq");
    memaccess_subenvironment_seq = memaccess_subenvironment_sequence_base_t::type_id::create("memaccess_subenvironment_seq");
    control_subenvironment_seq = control_subenvironment_sequence_base_t::type_id::create("control_subenvironment_seq");

  endfunction

  virtual task body();


    fetch_subenvironment_seq.start(configuration.fetch_subenvironment_config.vsqr);
    decode_subenvironment_seq.start(configuration.decode_subenvironment_config.vsqr);
    execute_subenvironment_seq.start(configuration.execute_subenvironment_config.vsqr);
    writeback_subenvironment_seq.start(configuration.writeback_subenvironment_config.vsqr);
    memaccess_subenvironment_seq.start(configuration.memaccess_subenvironment_config.vsqr);
    control_subenvironment_seq.start(configuration.control_subenvironment_config.vsqr);

  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

