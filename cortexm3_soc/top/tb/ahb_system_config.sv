/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_system_config.svh
//  EDITED_BY :- Pradip Prajapati
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ahb_system_config extends uvm_object;

  //configurations which can be modified
  ahb_env_config env_cfg; 

  //factory registration
  `uvm_object_utils(ahb_system_config)

  extern function new(string name="ahb_system_config");
  
endclass : ahb_system_config

//*****************************************************************************
//methods
//*****************************************************************************

//new function
function ahb_system_config::new(string name="ahb_system_config");

  super.new(name);

  env_cfg = ahb_env_config::type_id::create($sformatf("env_cfg"));   
  
  env_cfg.has_scoreboard = 0;
  env_cfg.has_coverage = 0;
  env_cfg.no_of_uvc = 1;
  env_cfg.create_sub_cfgs(1);
  //env_cfg.uvc_cfg[0].no_of_masters = 1;
  //env_cfg.uvc_cfg[0].no_of_slaves  = 0;
  env_cfg.uvc_cfg[0].no_of_masters = 5;
  env_cfg.uvc_cfg[0].no_of_slaves  = 5;
  
  env_cfg.uvc_cfg[0].create_sub_cfgs(5,5);
  
  env_cfg.uvc_cfg[0].master_cfg[0].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].master_cfg[1].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].master_cfg[2].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].master_cfg[3].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].master_cfg[4].is_active = UVM_PASSIVE;
  
  env_cfg.uvc_cfg[0].master_cfg[0].is_enable = DISABLE;
  env_cfg.uvc_cfg[0].master_cfg[1].is_enable = DISABLE;
  env_cfg.uvc_cfg[0].master_cfg[2].is_enable = DISABLE;
  env_cfg.uvc_cfg[0].master_cfg[3].is_enable = DISABLE;
  env_cfg.uvc_cfg[0].master_cfg[4].is_enable = DISABLE;
  
  env_cfg.uvc_cfg[0].slave_cfg[0].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].slave_cfg[1].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].slave_cfg[2].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].slave_cfg[3].is_active = UVM_PASSIVE;
  env_cfg.uvc_cfg[0].slave_cfg[4].is_active = UVM_PASSIVE;

  env_cfg.print();

endfunction : new

