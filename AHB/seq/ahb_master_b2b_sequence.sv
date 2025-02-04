////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_b2b_sequence.sv
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a all burst back to back AHB WRITE followed 
 * by a AHB READ sequence is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */

`ifndef AHB_MASTER_BACK_TO_BACK_SEQUENCE
`define AHB_MASTER_BACK_TO_BACK_SEQUENCE

class ahb_master_b2b_sequence extends ahb_base_master_sequence;
  
  /** factroy registration */
  `uvm_object_utils(ahb_master_b2b_sequence)
  
  /** class constructor */
  extern function new(string name="ahb_master_b2b_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_b2b_sequence 

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_b2b_sequence::new(string name="ahb_master_b2b_sequence");
  super.new(name);
endfunction : new

/** body method for generating stimulus */
task ahb_master_b2b_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);
  
   for(int i=0;i<8;i++) begin 
      for(int k=0;k<=$clog2(`DATA_WIDTH/8);k++) begin

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 1;
	   hburst_type == hburst_enum'(i);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 0;
	   hburst_type == hburst_enum'(k);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 0;
	   hburst_type == hburst_enum'(i);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 1;
	   hburst_type == hburst_enum'(k);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 1;
	   hburst_type == hburst_enum'(i);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 1;
	   hburst_type == hburst_enum'(k);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 0;
	   hburst_type == hburst_enum'(i);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})

       `uvm_do_with(req,
        {  HADDR       == 2**(k);
	   HWRITE      == 0;
	   hburst_type == hburst_enum'(k);
	   hsize_type  == hsize_enum'(k);
	   incr_size   == 1;
	   foreach(busy_trans_cycles[j])
	     busy_trans_cycles[j]==0;
	})
       
     end
   end

  `uvm_info("body", "Exiting ...", UVM_MEDIUM)
 
endtask : body

`endif //AHB_MASTER_BACK_TO_BACK_SEQUENCE.

