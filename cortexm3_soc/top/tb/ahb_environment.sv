/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_environment.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef AHB_ENVIRONMENT
`define AHB_ENVIRONMENT

/**
 * Abstract:
 * ahb_env is used to provide an environment where uvc and scoreboard
 * and coverage are contained also the configuration is obtained from test is
 * used to set the configuration for each UVC.
 *
 */

class ahb_env extends uvm_env;

  /** configurable class instance */
  ahb_env_config env_cfg;

  /** factory registration */
  `uvm_component_utils(ahb_env)

  /** lower component handles */
  ahb_uvc           ahb_uvc_h[];

  /** scoreboard handle */
  ahb_sb            ahb_sb_h;

  sram_monitor      sram_mon_h;

  /** class constructor */
  extern function new(string name="ahb_env",uvm_component parent=null);

  /** build phase */
  extern function void build_phase(uvm_phase phase);

  /** connect phase */
  extern function void connect_phase(uvm_phase phase);

endclass : ahb_env

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_env::new(string name="ahb_env",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

/** build_phase - create the uvc, scoreboard and coverage collector classes */
function void ahb_env::build_phase(uvm_phase phase);

  /** configurations from test */
  if(!uvm_config_db #(ahb_env_config)::get(this,"","env_cfg",env_cfg))
    `uvm_fatal(get_full_name(),"Not Able To Get Environment Configurations!!!")

  /** create the lower components (UVC) */
  ahb_uvc_h = new[env_cfg.no_of_uvc];

  foreach(ahb_uvc_h[i])
  ahb_uvc_h[i] = ahb_uvc::type_id::create($sformatf("ahb_uvc_h[%0d]",i),this);
 
  /** create scoreboard class */
  if(env_cfg.has_scoreboard) ahb_sb_h = ahb_sb::type_id::create("ahb_sb_h",this);

  sram_mon_h = sram_monitor::type_id::create("sram_mon_h",this);

  /** set the uvc configuration */
  foreach(env_cfg.uvc_cfg[i])
  uvm_config_db #(ahb_uvc_config)::set(this,$sformatf("*ahb_uvc_h[%0d]*",i),"uvc_cfg",
                                       env_cfg.uvc_cfg[i]);

endfunction : build_phase

/** connect phase - connection of the master monitor with the scoreboard
 *  and coverage collector class.
 */
function void ahb_env::connect_phase(uvm_phase phase);

  /** connection of agents with the scoreboard */
  if(env_cfg.has_scoreboard) begin
      
    //M0	  
    ahb_uvc_h[0].mas_agent_h[0].mas_mon_h.mas_ap_mon.connect(ahb_sb_h.mas_ai_sb_m0);
    
    ahb_uvc_h[0].slv_agent_h[0].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s0);
    ahb_uvc_h[0].slv_agent_h[1].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s1);
    ahb_uvc_h[0].slv_agent_h[3].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s4);
    ahb_uvc_h[0].slv_agent_h[4].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s5);
 
    //M1
    ahb_uvc_h[0].mas_agent_h[1].mas_mon_h.mas_ap_mon.connect(ahb_sb_h.mas_ai_sb_m1);
    
    ahb_uvc_h[0].slv_agent_h[0].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s0);
    ahb_uvc_h[0].slv_agent_h[1].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s1);
    ahb_uvc_h[0].slv_agent_h[3].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s4);
    ahb_uvc_h[0].slv_agent_h[4].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s5);
    
    //M3
    ahb_uvc_h[0].mas_agent_h[3].mas_mon_h.mas_ap_mon.connect(ahb_sb_h.mas_ai_sb_m3);
    
    ahb_uvc_h[0].slv_agent_h[2].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s3);
    ahb_uvc_h[0].slv_agent_h[4].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s5);

    //M2
    ahb_uvc_h[0].mas_agent_h[2].mas_mon_h.mas_ap_mon.connect(ahb_sb_h.mas_ai_sb_m2);
    
    ahb_uvc_h[0].slv_agent_h[2].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s3);
    ahb_uvc_h[0].slv_agent_h[3].slv_mon_h.slv_mon_sb.connect(ahb_sb_h.slv_ai_sb_s4);

    ahb_uvc_h[0].mas_agent_h[4].mas_mon_h.mas_ap_mon.connect(ahb_sb_h.ahb_sram_ai_sb);
    sram_mon_h.item_collected_port.connect(ahb_sb_h.sram_ai_sb);

  end

endfunction : connect_phase

`endif //AHB_ENVIRONMENT
