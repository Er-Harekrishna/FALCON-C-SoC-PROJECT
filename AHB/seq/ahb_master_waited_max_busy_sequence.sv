/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_waited_max_busy_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a INCR busrt with maximum busy cycles 
 * and maximum wait cycles are inserted to AHB WRITE followed by a random AHB READ
 * sequence is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */
	 
`ifndef AHB_WAITED_MAX_BUSY_SEQUENCE
`define AHB_WAITED_MAX_BUSY_SEQUENCE

class ahb_master_waited_max_busy_sequence extends ahb_base_master_sequence;
  
  /** factroy registration */
  `uvm_object_utils(ahb_master_waited_max_busy_sequence)
 
  /** class constructor */
  extern function new(string name="ahb_master_waited_max_busy_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_waited_max_busy_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_waited_max_busy_sequence::new(string name="ahb_master_waited_max_busy_sequence");
  super.new(name);
endfunction : new
  
/** body method for generating stimulus */
task ahb_master_waited_max_busy_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);
  
  for(int k=0;k<8;k++) begin

    for(int i=0;i<=$clog2(`DATA_WIDTH/8);i++) begin

      `uvm_do_with(req,
       { HADDR       == 2**(i);
         HWRITE      == 1;
 	 hburst_type == hburst_enum'(k);
	 hsize_type  == hsize_enum'(i);
	 incr_size   == 3;
	 if(beat_cnt!=1) busy_trans_cycles[0]==16;
       })
    
      `uvm_do_with(req,
       { HADDR       == 2**(i);
         HWRITE      == 0;
 	 hburst_type == hburst_enum'(k);
	 hsize_type  == hsize_enum'(i);
	 incr_size   == 3;
	 if(beat_cnt!=1) busy_trans_cycles[0]==16;
       })

    end
  end

  `uvm_info("body", "Exiting ...", UVM_MEDIUM)

endtask : body

`endif //AHB_WAITED_MAX_BUSY_SEQUENCE


