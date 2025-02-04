/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_environment_configuration.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_env_config is used to provide configurations for configuring
 * the environment basically it contains wether our environment contains
 * scoreboard and coverage and also it decides how much UVC we have in
 * environment.
 *
 */

`ifndef AHB_ENVIRONMENT_CONFIGURATION
`define AHB_ENVIRONMENT_CONFIGURATION

class ahb_env_config extends uvm_object;

  /** configurations which can be modified 
   *  has_scoreboard = 1 enables the scoreboard
   *  has_coverage   = 1 enables the coverage
   */
  bit has_scoreboard = 0;
  bit has_coverage   = 0;
  int no_of_uvc      = 2;
  ahb_uvc_config uvc_cfg[];

  /** factory registration */
  `uvm_object_utils_begin(ahb_env_config)

    `uvm_field_int(has_scoreboard,UVM_PRINT)
    `uvm_field_int(has_coverage,UVM_PRINT)
    `uvm_field_int(no_of_uvc,UVM_PRINT)
    `uvm_field_array_object(uvc_cfg,UVM_PRINT)

  `uvm_object_utils_end

  /** class constructor */
  extern function new(string name="ahb_env_config");

  /** create_sub_cfgs method */
  extern function void create_sub_cfgs(int no_of_uvc_cfg=2);

endclass : ahb_env_config

//*****************************************************************************
//methods
//*****************************************************************************

/** new function */
function ahb_env_config::new(string name="ahb_env_config");
  super.new(name);
endfunction : new

/** create_sub_cfgs - it provides config class for the each UVC created */
function void ahb_env_config::create_sub_cfgs(int no_of_uvc_cfg=2);

  uvc_cfg = new[no_of_uvc_cfg];

  foreach(uvc_cfg[i])
    uvc_cfg[i] = ahb_uvc_config::type_id::create($sformatf("uvc_cfg[%0d]",i));

endfunction : create_sub_cfgs

`endif //AHB_ENVIRONMENT_CONFIGURATION
