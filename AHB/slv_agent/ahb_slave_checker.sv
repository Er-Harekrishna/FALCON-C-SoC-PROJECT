/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_slave_checker.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_CHECKER
`define AHB_SLAVE_CHECKER
 
class ahb_slv_checker extends uvm_component;

  /** factory registration */
  `uvm_component_utils(ahb_slv_checker)
 
  /** chk_trans_q and res for transaction checking */
  ahb_slv_trans chk_trans_q[$],res[$];

  /** beat_count - indicates the number of transfers required in burst */
  int beat_count;

  /** trans_count - indicates the number of transfer is going in burst */
  int trans_count;

  /** no_of_bytes - indicates the number of bytes in burst */
  int no_of_bytes;

  /** addr_boundary - indicates the address boundary of the burst */
  int addr_boundary;

  /** lower_boundary - indicates the lower address boundary for wrapping bursts */
  int lower_boundary;

  /** higher_boundary - indicates the higher address boundary for wrapping burst */
  int higher_boundary; 

  /** error_detect - bit indicat the error is detected in trasaction */
  bit error_detect;
  
  /** virtual interface handle */
  virtual ahb_mas_inf vif;

  /** mas_ai_ch - analysis import for the receiving data from the monitor for checker */
  uvm_analysis_imp #(ahb_slv_trans,ahb_slv_checker) slv_ai_ch;
  
  /** class constructor */
  extern function new(string name="ahb_slv_checker",uvm_component parent=null);

  /** build phase */
  extern function void build_phase(uvm_phase phase);

  /** run phase */
  extern task run_phase(uvm_phase phase);

  /** write method for getting trasaction from analysis port */
  extern function void write(ahb_slv_trans slv_trans_h);

  /** Checkers */
  
  /** Checks That First Transfer Type Of The Burst Must Be NONSEQ Type */
  extern function void first_trans_not_nonseq_check(ahb_slv_trans slv_trans_h);
  
  /** Checks During Fixed Burst After First Trnasfer NONSEQ Transfer Type Is Invalid */
  extern function void during_burst_invalid_nonseq_check(ahb_slv_trans slv_trans_h);
  
  /** Checks During Fixed Burst After First Transfer IDLE Transfer Type IS Invalid */
  extern function void during_burst_invalid_idle_check(ahb_slv_trans slv_trans_h);
  
  /** Checks The Address Increment As Per The Transfer Size*/
  extern function void addr_incr_check(ahb_slv_trans slv_trans_h);
  
  /** Checks That HBURST Must Be Stable During Burst */
  extern function void hburst_stable_during_burst_check(ahb_slv_trans slv_trans_h);
  
  /** Checks That Burst Must Not Cross The Boundary Limit */
  extern function void one_k_boundry_cross_check(ahb_slv_trans slv_trans_h);
  
  /** Checks In SINGLE Burst SEQ and BUSY Transfer Type Is Invalid  */
  extern function void seq_busy_in_single_burst_check(ahb_slv_trans slv_trans_h);
  
  /** Checks That Transfer Size Must Be Greater Than Data Width */
  extern function void size_greater_than_data_width_check(ahb_slv_trans slv_trans_h);
  
  /** Checks That HSIZE Must Be Stable During Burst */
  extern function void hsize_stable_during_burst_check(ahb_slv_trans slv_trans_h);
  
  /** Checks Error Response Must Be Two Cycles With Second Cycle Hready As Low */
  extern function void two_cycle_error_check(ahb_slv_trans slv_trans_h);
  
  /** ignored_transaction - For Transaction Ordering, Terminated and Completed Burst Are Handled Vie This Method */
  extern function void ignored_transection(ahb_slv_trans slv_trans_h);
    
endclass : ahb_slv_checker

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_slv_checker::new(string name="ahb_slv_checker",uvm_component parent=null);
  super.new(name,parent);
  /** master checker analysis import */
  mas_ai_ch = new("mas_ai_ch",this);
endfunction : new

/** build_phase */
function void ahb_slv_checker::build_phase(uvm_phase phase);
  if(!uvm_config_db #(virtual ahb_mas_inf)::get(this,"","mas_vif",vif))
    `uvm_fatal(get_full_name(),"Not Able To Get The Interface!!!")
endfunction : build_phase

/** run phase */
task ahb_slv_checker::run_phase(uvm_phase phase);
  forever begin
    @(negedge vif.hresetn)
    chk_trans_q.delete();
    res.delete();
    trans_count = 0;
    error_detect = 0;
  end
endtask : run_phase

/** write method */
function void ahb_slv_checker::write(ahb_slv_trans slv_trans_h);

  `uvm_info("MASTER CHECKER","THIS IS CHECKER RECEIVED TRANSECTION",UVM_MEDIUM)
  slv_trans_h.print();

  chk_trans_q.push_back(slv_trans_h);
  if(slv_trans_h.HREADY)
    res.push_back(slv_trans_h);

  case (slv_trans_h.hburst_type)

    hburst_enum'(SINGLE)  : beat_count = 1;
    hburst_enum'(WRAP4)   : beat_count = 4;
    hburst_enum'(INCR4)   : beat_count = 4;
    hburst_enum'(WRAP8)   : beat_count = 8;
    hburst_enum'(INCR8)   : beat_count = 8;
    hburst_enum'(WRAP16)  : beat_count = 16;
    hburst_enum'(INCR16)  : beat_count = 16;

  endcase
  
  `uvm_info(get_type_name(),$sformatf("size of check trans q = %0d | res = %0d",chk_trans_q.size(),res.size()),UVM_MEDIUM)

  if((slv_trans_h.htrans_type[0]==NONSEQ || slv_trans_h.htrans_type[0]==SEQ) && slv_trans_h.HREADY)
    trans_count++; 
 
  two_cycle_error_check(slv_trans_h);
  ignored_transection(slv_trans_h);
  addr_incr_check(slv_trans_h);
  during_burst_invalid_nonseq_check(slv_trans_h);
  during_burst_invalid_idle_check(slv_trans_h);
  first_trans_not_nonseq_check(slv_trans_h);
  one_k_boundry_cross_check(slv_trans_h);
  seq_busy_in_single_burst_check(slv_trans_h);
  size_greater_than_data_width_check(slv_trans_h);
  hburst_stable_during_burst_check(slv_trans_h);
  hsize_stable_during_burst_check(slv_trans_h);
   
endfunction : write
  
/** Checkes That First trans type of the burst must be NONSEQ*/
function void ahb_slv_checker::first_trans_not_nonseq_check(ahb_slv_trans slv_trans_h);
 
  if(res.size()!=0) begin
    if(res[0].htrans_type[0]!=NONSEQ && res[0].hresp_type!=ERROR) begin	
      `uvm_error("Checker Failed!!!","First Transection Of The Burst Should Be NONSEQ")
    end
  end
  
endfunction : first_trans_not_nonseq_check
  
/** Checkes That During Single or Fixed Length Burst Transfer Inbetween NONSEQ Trans type is not allowed  */
function void ahb_slv_checker::during_burst_invalid_nonseq_check(ahb_slv_trans slv_trans_h);

  if(slv_trans_h.htrans_type[0]==NONSEQ && trans_count!=beat_count && slv_trans_h.hburst_type!=INCR && res.size()>1 && slv_trans_h.hresp_type!=ERROR) begin
    chk_trans_q.delete();
    res.delete();
    trans_count = 0;
    error_detect = 0;
    `uvm_error("Checker Failed!!!","In The Single and Fixed burst NONSEQ Transfer In Between Burst Is Not Possible")
  end

endfunction : during_burst_invalid_nonseq_check	
  
/** In Fixed Burst Transfer IDLE Transfer Is Not Allowed In Between*/
function void ahb_slv_checker::during_burst_invalid_idle_check(ahb_slv_trans slv_trans_h);

  if(slv_trans_h.htrans_type[0]==IDLE && trans_count!=beat_count && slv_trans_h.hburst_type!=INCR && res.size()>1 && slv_trans_h.hresp_type!=ERROR) begin
    chk_trans_q.delete();
    res.delete();
    trans_count = 0;
    error_detect = 0;
    `uvm_error("Checker Failed!!!","In The Single And Fixed Burst IDLE Transfer In Between Burst Is Not Possible")
  end

endfunction : during_burst_invalid_idle_check

/** It Checks That Burst Address Are Increments As Per The Transfer Size - In incrementing 
 *  and warping burst address increments with size but in warping  burst addr wraps at 
 *  address boundary
 */
function void ahb_slv_checker::addr_incr_check(ahb_slv_trans slv_trans_h);
  
  if(res.size()!=0) begin
    addr_boundary = beat_count*(2**res[0].hsize_type);
    no_of_bytes     = beat_count*(2**res[0].hsize_type);
    lower_boundary  = (int'(res[0].HADDR/no_of_bytes))*no_of_bytes;
    higher_boundary = lower_boundary + addr_boundary;
    
    foreach(res[i]) begin	   
      if(i>0) begin
        if(res[0].hburst_type==WRAP4 || res[0].hburst_type==WRAP8 || res[0].hburst_type==WRAP16) begin	    
  	  if(res[i].HADDR<higher_boundary) begin
	    if(res[i].HADDR-res[i-1].HADDR!=(2**res[0].hsize_type) && res[i-1].htrans_type[0]!=BUSY)begin
	      if(res[i].HADDR != lower_boundary) 
                `uvm_error("Checker Failed!!!","Address Incrementing In Wraping Burst Is Not Correct") 
	    end
          end
  	  else if(res[i].HADDR>=higher_boundary && res[i-1].htrans_type[0]!=BUSY)
            `uvm_error("Checker Failed!!!","Address Incrementing In Wraping Burst Is Not Correct")         
        end  
        if(res[0].hburst_type==INCR || res[0].hburst_type==INCR4 || res[0].hburst_type==INCR8 || res[0].hburst_type==INCR16) begin
          if((res[i].HADDR - res[i-1].HADDR)!=(2**res[0].hsize_type) && res[i-1].htrans_type[0]!=BUSY)
            `uvm_error("Checker Failed!!!","Address Incrementing In Wraping Burst Is Not Correct")           
        end	      	
      end	    
    end
  end  

endfunction : addr_incr_check	

/** It Checks The Address Must Not Cross The Boundary Limit */
function void ahb_slv_checker::one_k_boundry_cross_check(ahb_slv_trans slv_trans_h);
  if(slv_trans_h.HADDR>32'hffff_fc00 && slv_trans_h.htrans_type[0]!=IDLE)
    `uvm_error("Checker Failed!!!","Address Crossed The Boundary Limit")
endfunction :one_k_boundry_cross_check

/** It Checks That The Single Burst Should Not Contain BUSY and SEQ Transfer Types */
function void ahb_slv_checker::seq_busy_in_single_burst_check(ahb_slv_trans slv_trans_h);
	
  if(slv_trans_h.hburst_type==SINGLE) begin
    if(slv_trans_h.htrans_type[0]==BUSY || slv_trans_h.htrans_type[0]==SEQ)
      `uvm_error("Checker Failed!!!","In Single Trnasfer BUSY And SEQ Transfer Is Invalid ")
  end	    

endfunction : seq_busy_in_single_burst_check

/** Checks That The Size Of The Transfer Must Not Be The Greater Than The Data Width */
function void ahb_slv_checker::size_greater_than_data_width_check(ahb_slv_trans slv_trans_h);
		        
  if(slv_trans_h.hsize_type>(`DATA_WIDTH))	
    `uvm_error("Checker Failed!!!","Size Of The Transfer Must Not Be Greater Than The Data Width")	

endfunction : size_greater_than_data_width_check
			      
/** Checks That HBURST should be constant Over The Whole Burst */
function void ahb_slv_checker::hburst_stable_during_burst_check(ahb_slv_trans slv_trans_h);

  if(chk_trans_q.size()>=2) begin
    if((slv_trans_h.hburst_type != chk_trans_q[0].hburst_type)) begin
      `uvm_error("Checker Failed!!!"," HBURST Should Be Constant Throughtout The Burst") 
    end	 
    else begin
      for(int i=2;i<chk_trans_q.size();i++) begin
        if((slv_trans_h.hburst_type != chk_trans_q[chk_trans_q.size()-i].hburst_type))
          error_detect=1;      
      end	  
      if(error_detect) begin
	error_detect=0;
        `uvm_error("Checker Failed!!!","HBURST Should Be Constant Throughout The Burst") 
      end
    end
  end

endfunction :hburst_stable_during_burst_check

/** In between burst HSIZE should be constant*/
function void ahb_slv_checker::hsize_stable_during_burst_check(ahb_slv_trans slv_trans_h);

  if(chk_trans_q.size()>=2) begin
    if((slv_trans_h.hsize_type != chk_trans_q[0].hsize_type)) begin
      `uvm_error("SIZE NOT CONSTANT!!","In between of whole burst HSIZE should be constant") 
    end	 
    else begin
      for(int i=2;i<chk_trans_q.size();i++) begin
        if((slv_trans_h.hsize_type != chk_trans_q[chk_trans_q.size()-i].hsize_type))
          error_detect=1;      
      end	  
      if(error_detect) begin
	error_detect=0;
        `uvm_error("SIZE NOT CONSTANT!!","In between of whole burst HSIZE should be constant") 
      end
    end
  end

endfunction :hsize_stable_during_burst_check
  
/** Checks That The Error Response Must Be Of Two cycles */
function void ahb_slv_checker::two_cycle_error_check(ahb_slv_trans slv_trans_h);

  if(slv_trans_h.hresp_type==ERROR && !slv_trans_h.HREADY) begin
    chk_trans_q.delete();
    chk_trans_q.push_back(slv_trans_h);
    error_detect = 1;
  end

  else if(chk_trans_q.size()==2 && error_detect) begin
    if(!(chk_trans_q[chk_trans_q.size()-2].HREADY==0 && chk_trans_q[chk_trans_q.size()-2].hresp_type==ERROR && chk_trans_q[chk_trans_q.size()-1].HREADY==1 && chk_trans_q[chk_trans_q.size()-1].hresp_type==ERROR)) 
      `uvm_error("Checker Failed!!!","Error Response Must Be Of Two Cycle With Second Cycle Hready Is low")
    chk_trans_q.delete();
    res.delete();
    trans_count = 0;
    error_detect = 0;
  end
 
endfunction :two_cycle_error_check

/** Ignored Transaction Transaction Handling Is Done */
function void ahb_slv_checker::ignored_transection(ahb_slv_trans slv_trans_h);

  /** In the incr burst when idle and nonseq is seen terminate the burst */
  if((slv_trans_h.htrans_type[0]==NONSEQ || slv_trans_h.htrans_type[0]==IDLE) && chk_trans_q.size()>=2 && slv_trans_h.hresp_type!=ERROR) begin
    if(chk_trans_q[chk_trans_q.size()-2].hburst_type==INCR) begin
      chk_trans_q.delete();
      res.delete();
      trans_count = 0;
      if(slv_trans_h.htrans_type[0]==NONSEQ) begin
        chk_trans_q.push_back(slv_trans_h);
        if(slv_trans_h.HREADY) begin
	  res.push_back(slv_trans_h);
	  trans_count++;
        end
      end
    end
  end

  /** Idle transfer should be ignored*/
  if(chk_trans_q.size()==1 && slv_trans_h.htrans_type[0]==IDLE && slv_trans_h.hresp_type!=ERROR) begin
    chk_trans_q.delete();
    res.delete();
    trans_count = 0;
  end

  /** After Burst Finishes The Queue Must be Deleted To Enter The New Burst Information 
   *  and Flags Are Cleared 
   */
  if(trans_count == beat_count && slv_trans_h.hburst_type!=INCR && slv_trans_h.hresp_type!=ERROR) begin
    chk_trans_q.delete();
    res.delete();
    trans_count = 0;
    error_detect = 0;
  end
	
endfunction : ignored_transection

`endif //AHB_SLAVE_CHECKER
