/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_uvc.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_uvc constains master and slave agents and their configuration class
 * which used to set configurations for master and slave agents.
 *
 */

`ifndef AHB_UVC
`define AHB_UVC

class ahb_uvc extends uvm_component;

  /** factory registration */
  `uvm_component_utils(ahb_uvc)

  /** configurable class instantce */
  ahb_uvc_config uvc_cfg;

  /** configuration class handle */
  ahb_mas_agent  mas_agent_h[];
  ahb_slv_agent  slv_agent_h[];

  /** class constructor */
  extern function new(string name = "ahb_uvc", uvm_component parent = null);

  /** build phase */
  extern function void build_phase(uvm_phase phase);

endclass : ahb_uvc

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_uvc::new(string name = "ahb_uvc", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

/** build_phase */
function void ahb_uvc::build_phase(uvm_phase phase);

  if (!uvm_config_db#(ahb_uvc_config)::get(this, "", "uvc_cfg", uvc_cfg))
    `uvm_fatal(get_full_name(), "Not Able To Get The UVC Configurations!!!")

  mas_agent_h = new[uvc_cfg.no_of_masters];
  slv_agent_h = new[uvc_cfg.no_of_slaves];

  /** create master agent */
  foreach(mas_agent_h[i])
    mas_agent_h[i] = ahb_mas_agent::type_id::create($sformatf("mas_agent_h[%0d]",i), this);
 
  /** create slave agent */
  foreach(slv_agent_h[i])
    slv_agent_h[i] = ahb_slv_agent::type_id::create($sformatf("slv_agent_h[%0d]",i), this);
 
  foreach(uvc_cfg.master_cfg[i])
    uvm_config_db#(ahb_mas_agent_cfg)::set(this,$sformatf("*mas_agent_h[%0d]*",i),"mas_agent_cfg",
                                           uvc_cfg.master_cfg[i]);

  foreach(uvc_cfg.slave_cfg[i])
    uvm_config_db#(ahb_slv_agent_cfg)::set(this,$sformatf("*slv_agent_h[%0d]*",i),"slv_agent_cfg",
                                           uvc_cfg.slave_cfg[i]);

endfunction : build_phase

`endif  //AHB_UVC
