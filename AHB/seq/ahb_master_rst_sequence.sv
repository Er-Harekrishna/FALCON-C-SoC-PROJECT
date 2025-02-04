/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_rst_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a all burst random AHB WRITE followed 
 * by a random AHB READ along with reset. sequence is generated using `uvm_do_with 
 * macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */

`ifndef AHB_MASTER_RESET_SEQUENCE
`define AHB_MASTER_RESET_SEQUENCE

class ahb_master_rst_sequence extends ahb_base_master_sequence;

  /** factroy registration */
  `uvm_object_utils(ahb_master_rst_sequence)
  
  /** class constructor */
  extern function new(string name="ahb_master_rst_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_rst_sequence

//*****************************************************************************
//methods
//*****************************************************************************

function ahb_master_rst_sequence::new(string name="ahb_master_rst_sequence");
  super.new(name);
endfunction : new

task ahb_master_rst_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);
  
  for(int k=0;k<8;k++) begin

    for(int i=0;i<=$clog2(`DATA_WIDTH/8);i++) begin

      repeat (sequence_length) begin

        `uvm_do_with(req,
         {  HADDR       == 2**(i);
	    HWRITE      == 1;
	    hburst_type == hburst_enum'(k);
	    hsize_type  == hsize_enum'(i);
	    incr_size   == 1;
	    foreach(busy_trans_cycles[i])
	      busy_trans_cycles[i]==0;
	 })

        `uvm_do_with(req,
         {  HADDR       == 2**(i);
	    HWRITE      == 0;
	    hburst_type == hburst_enum'(k);
	    hsize_type  == hsize_enum'(i);
	    incr_size   == 1;
	    foreach(busy_trans_cycles[i])
	      busy_trans_cycles[i]==0;
	 })

        p_sequencer.vif.reset(11,2);
        
	`uvm_do_with(req,
         {  HADDR       == 2**(i);
	    HWRITE      == 1;
	    hburst_type == hburst_enum'(k);
	    hsize_type  == hsize_enum'(i);
	    incr_size   == 1;
	    foreach(busy_trans_cycles[i])
	      busy_trans_cycles[i]==0;
	 })

      end
    end

  end

  `uvm_info("body", "Exiting ...", UVM_MEDIUM)

endtask : body

`endif //AHB_MASTER_RESET_SEQUENCE




