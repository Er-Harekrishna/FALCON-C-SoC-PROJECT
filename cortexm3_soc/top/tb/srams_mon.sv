/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- AHB_master_monitor.sv
//  EDITED_BY :- Pradip Prajapati
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef SRAMS_MONITOR
`define SRAMS_MONITOR

class sram_monitor extends uvm_monitor;
 
  /** factory registration */
  `uvm_component_utils(sram_monitor)
  
  /** virtual interface handle */
  virtual sram_inf vif;
  
  /** transaction handle */
  sram_transaction strans_h;
  
  /** analysis port */
  uvm_analysis_port#(sram_transaction) item_collected_port;
  
  /** class constructor */
  extern function new(string name = "sram_monitor",uvm_component parent);
  
  /** build phase */
  extern function void build_phase(uvm_phase phase);
  
  /** run phase */
  extern task run_phase(uvm_phase phase);
  
  /** sample method */
  extern function void sample();

endclass : sram_monitor

/** class constructor */
function sram_monitor::new(string name = "sram_monitor",uvm_component parent);
  super.new(name,parent);
  item_collected_port = new("item_collected_port",this);
endfunction
 
/** build phase */
function void sram_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  //strans_h = sram_transaction::type_id::create("stran_h");
      
  if(!uvm_config_db#(virtual sram_inf)::get(this,"","sram_if",vif))
    `uvm_error(get_type_name(),"Not able to get the sram interface");
endfunction
    
/** run phase */
task sram_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  @(posedge vif.HCLK)
  wait(vif.SRAMCS);
  strans_h = sram_transaction::type_id::create("strans_h");
  sample();
  item_collected_port.write(strans_h);
endtask
    
function void sram_monitor::sample();
  strans_h.SRAMADATA = vif.SRAMADDR;
  strans_h.SRAMWDATA = vif.SRAMWDATA;
  strans_h.SRAMRDATA = vif.SRAMRDATA;
  strans_h.SRAMWREN  = vif.SRAMWEN;
endfunction

`endif
