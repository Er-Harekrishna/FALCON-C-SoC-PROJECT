//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_sb.svh
//  EDITED_BY :- Karan Patadiya
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** ABSTRACT : - 
*                Scoreboard is used to compare data from master and slave
*                side.
*                When master provide data for one address and for read
*                operation on that address we are getting same address or not
*                is going to check in scoreboard class   */

`ifndef AHB_SCOREBOARD
`define AHB_SCOREBOARD

class ahb_sb extends uvm_scoreboard;

  /** factory registration */
  `uvm_component_utils(ahb_sb)

  /** Decl method for two write method  */
  `uvm_analysis_imp_decl (_mas_m0)
  `uvm_analysis_imp_decl (_mas_m1)
  `uvm_analysis_imp_decl (_mas_m2)
  `uvm_analysis_imp_decl (_mas_m3)
  `uvm_analysis_imp_decl (_slv_s0)
  `uvm_analysis_imp_decl (_slv_s1)
  `uvm_analysis_imp_decl (_slv_s3)
  `uvm_analysis_imp_decl (_slv_s4)
  `uvm_analysis_imp_decl (_slv_s5) 

  `uvm_analysis_imp_decl (_ahb_sram)  
  `uvm_analysis_imp_decl (_sram)

  //transaction queues
  ahb_mas_trans mas_m0_act_q[$];
  ahb_mas_trans mas_m1_act_q[$];
  ahb_mas_trans mas_m2_act_q[$];
  ahb_mas_trans mas_m3_act_q[$];

  ahb_slv_trans slv_s0_exp_q[$];
  ahb_slv_trans slv_s1_exp_q[$];
  ahb_slv_trans slv_s3_exp_q[$];
  ahb_slv_trans slv_s4_exp_q[$];
  ahb_slv_trans slv_s5_exp_q[$];

  /** inf handle for reset case. */
  virtual ahb_inf vif;

  int mem [int];

  longint m0_trans_count;
  longint m1_trans_count;
  longint m2_trans_count;
  longint m3_trans_count;
  longint s0_m0_trans_count;
  longint s0_m1_trans_count;
  longint s1_m0_trans_count;
  longint s1_m1_trans_count;
  longint s3_m2_trans_count;
  longint s3_m3_trans_count;
  longint s4_m0_trans_count;
  longint s4_m1_trans_count;
  longint s4_m2_trans_count;
  longint s5_m0_trans_count;
  longint s5_m1_trans_count;
  longint s5_m3_trans_count;
  
  /** analysis import for the receiving data from the monitor for checker */
  uvm_analysis_imp_mas_m0 #(ahb_mas_trans,ahb_sb) mas_ai_sb_m0;
  uvm_analysis_imp_mas_m1 #(ahb_mas_trans,ahb_sb) mas_ai_sb_m1;
  uvm_analysis_imp_mas_m2 #(ahb_mas_trans,ahb_sb) mas_ai_sb_m2;
  uvm_analysis_imp_mas_m3 #(ahb_mas_trans,ahb_sb) mas_ai_sb_m3;
  uvm_analysis_imp_slv_s0 #(ahb_slv_trans,ahb_sb) slv_ai_sb_s0;
  uvm_analysis_imp_slv_s1 #(ahb_slv_trans,ahb_sb) slv_ai_sb_s1;
  uvm_analysis_imp_slv_s3 #(ahb_slv_trans,ahb_sb) slv_ai_sb_s3;
  uvm_analysis_imp_slv_s4 #(ahb_slv_trans,ahb_sb) slv_ai_sb_s4;
  uvm_analysis_imp_slv_s5 #(ahb_slv_trans,ahb_sb) slv_ai_sb_s5;

  uvm_analysis_imp_sram #(sram_transaction,ahb_sb) sram_ai_sb;
  uvm_analysis_imp_ahb_sram #(ahb_mas_trans,ahb_sb) ahb_sram_ai_sb;

  /** extern methods */
  extern function new(string name="ahb_sb",uvm_component parent=null);
  extern function void write_mas_m0(ahb_mas_trans mas_trans_h);
  extern function void write_mas_m1(ahb_mas_trans mas_trans_h);
  extern function void write_mas_m2(ahb_mas_trans mas_trans_h);
  extern function void write_mas_m3(ahb_mas_trans mas_trans_h);
  extern function void write_slv_s0(ahb_slv_trans slv_trans_h);
  extern function void write_slv_s1(ahb_slv_trans slv_trans_h);
  extern function void write_slv_s3(ahb_slv_trans slv_trans_h);
  extern function void write_slv_s4(ahb_slv_trans slv_trans_h);
  extern function void write_slv_s5(ahb_slv_trans slv_trans_h);
  extern function void write_sram(sram_transaction sram_tr);
  extern function void write_ahb_sram(ahb_mas_trans ahb_sram_tr);

  extern function void build_phase(uvm_phase phase);
  //extern function void compare_trans(ahb_slv_trans slv_tr,ahb_mas_trans mas_tr);
  //extern task run_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);
  
endclass : ahb_sb

//*****************************************************************************
//                                   METHODS
//*****************************************************************************

/**  constructor(new)  function */
function ahb_sb::new(string name="ahb_sb",uvm_component parent=null);

  super.new(name,parent);
  mas_ai_sb_m0 = new("mas_ai_sb_m0",this);
  mas_ai_sb_m1 = new("mas_ai_sb_m1",this);
  mas_ai_sb_m2 = new("mas_ai_sb_m2",this);
  mas_ai_sb_m3 = new("mas_ai_sb_m3",this);
  slv_ai_sb_s0 = new("slv_ai_sb_s0",this);
  slv_ai_sb_s1 = new("slv_ai_sb_s1",this);
  slv_ai_sb_s3 = new("slv_ai_sb_s3",this);
  slv_ai_sb_s4 = new("slv_ai_sb_s4",this);
  slv_ai_sb_s5 = new("slv_ai_sb_s5",this);
  sram_ai_sb   = new("sram_ai_sb",this);
  ahb_sram_ai_sb = new("ahb_sram_si_sb",this);

endfunction : new

/**  build phase  */
function void ahb_sb::build_phase(uvm_phase phase);
  
  if(!(uvm_config_db#(virtual ahb_inf)::get(null,"","inf",vif))) begin
    `uvm_fatal(get_type_name(),"Failed to get inf handle!!!");
  end

endfunction 

/** write method for master */
function void ahb_sb::write_mas_m0(ahb_mas_trans mas_trans_h);

  if(mas_trans_h.htrans_type[0]!=IDLE) begin

    if(mas_trans_h.HADDR>=32'h0000_0000 && mas_trans_h.HADDR<=32'h0000_ffff)begin
	mas_m0_act_q.push_back(mas_trans_h);
	m0_trans_count++;
    end

    else
      `uvm_error("SCOREBOARD",$sformatf("Address out of range for M0 Port, Monitored address - %h",mas_trans_h.HADDR))

  end  

endfunction : write_mas_m0

/** write method for master */
function void ahb_sb::write_mas_m1(ahb_mas_trans mas_trans_h);

  if(mas_trans_h.htrans_type[0]!=IDLE) begin
    
    if(mas_trans_h.HADDR>=32'h0001_0000 && mas_trans_h.HADDR<=32'h0001_ffff) begin
      mas_m1_act_q.push_back(mas_trans_h);
      m1_trans_count++;
    end
    else
      `uvm_error("SCOREBOARD",$sformatf("Address out of range for M1 Port, Monitored address - %h",mas_trans_h.HADDR))
  
  end  

endfunction : write_mas_m1

/** write method for master */
function void ahb_sb::write_mas_m2(ahb_mas_trans mas_trans_h);

  if(mas_trans_h.htrans_type[0]!=IDLE) begin
  
	  if(mas_trans_h.HADDR>=32'h4000_0000 && mas_trans_h.HADDR<=32'h4000_ffff) begin
      mas_m2_act_q.push_back(mas_trans_h);
      m2_trans_count++;
      end
    else
      `uvm_error("SCOREBOARD",$sformatf("Address out of range for M2 Port, Monitored address - %h",mas_trans_h.HADDR))
    
    `uvm_info("COUNT",$sformatf("Count Of M2 Transaction - %0d",mas_m2_act_q.size()),UVM_MEDIUM)

  end  

endfunction : write_mas_m2

/** write method for master */
function void ahb_sb::write_mas_m3(ahb_mas_trans mas_trans_h);
  
  if(mas_trans_h.htrans_type[0]!=IDLE) begin
 
	  if(mas_trans_h.HADDR>=32'h2000_0000 && mas_trans_h.HADDR<=32'h2001_ffff) begin
      mas_m3_act_q.push_back(mas_trans_h);
      m3_trans_count++;
      end
    else
      `uvm_error("SCOREBOARD",$sformatf("Address out of range for M3 Port, Monitored address - %h",mas_trans_h.HADDR))

  end

endfunction : write_mas_m3

/**  write method for slave */
function void ahb_sb::write_slv_s0(ahb_slv_trans slv_trans_h);

  ahb_mas_trans mas_tr;	

  if(slv_trans_h.htrans_type!=IDLE) begin 
 
    case (slv_trans_h.HADDR) inside
      
      [32'h0000_0000 : 32'h0000_ffff] : begin 
                                          mas_tr = mas_m0_act_q.pop_front();
          			          if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          			              `uvm_error("SCOREBOARD",$sformatf("write data mismatch act - %0d | exp - %0d",mas_tr.HWDATA[0],slv_trans_h.HWDATA))
          			          end
          			          else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          			          end
					  s0_m0_trans_count++;
                                        end
      [32'h0001_0000 : 32'h0001_ffff] : begin 
                                          mas_tr = mas_m1_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch at S0")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s0_m1_trans_count++;
          		                end

      default : `uvm_error("SCOREBOARD","Address out of range access")

    endcase

  end

endfunction : write_slv_s0

/**  write method for slave */
function void ahb_sb::write_slv_s1(ahb_slv_trans slv_trans_h);

  ahb_mas_trans mas_tr;	
  
  if(slv_trans_h.htrans_type!=IDLE) begin 
 
    case (slv_trans_h.HADDR) inside
      
      [32'h0000_0000 : 32'h0000_ffff] : begin 
                                          mas_tr = mas_m0_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch S1")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s1_m0_trans_count++;
                                        end
      [32'h0001_0000 : 32'h0001_ffff] : begin 
                                          mas_tr = mas_m1_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s1_m1_trans_count++;
          		                end

      default : `uvm_error("SCOREBOARD","Address out of range access")

    endcase

  end

endfunction : write_slv_s1

/**  write method for slave */
function void ahb_sb::write_slv_s3(ahb_slv_trans slv_trans_h);
 
  ahb_mas_trans mas_tr;	
  
  if(slv_trans_h.htrans_type!=IDLE) begin 
 
    case (slv_trans_h.HADDR) inside
      
      [32'h2000_0000 : 32'h2001_ffff] : begin 
                                          mas_tr = mas_m3_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch S3")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s3_m3_trans_count++;
                                        end
      [32'h4000_0000 : 32'h4000_ffff] : begin 
                                          mas_tr = mas_m2_act_q.pop_front();
					  if(mas_tr==null)
					    `uvm_info("NULL","null access",UVM_MEDIUM)
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s3_m2_trans_count++;
          		                end

      default : `uvm_error("SCOREBOARD","Address out of range access")

    endcase

  end

endfunction : write_slv_s3

/**  write method for slave */
function void ahb_sb::write_slv_s4(ahb_slv_trans slv_trans_h);

  ahb_mas_trans mas_tr;	
  
  if(slv_trans_h.htrans_type!=IDLE) begin 
 
    case (slv_trans_h.HADDR) inside
      
      [32'h0000_0000 : 32'h0000_ffff] : begin 
                                          mas_tr = mas_m0_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch s4")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s4_m0_trans_count++;
                                        end
      [32'h0001_0000 : 32'h0001_ffff] : begin 
                                          mas_tr = mas_m1_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s4_m1_trans_count++;
          		                end

      [32'h4000_0000 : 32'h4000_ffff] : begin 
                                          mas_tr = mas_m2_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s4_m2_trans_count++;
          		                end

      default : `uvm_error("SCOREBOARD","Address out of range access")

    endcase

  end

endfunction : write_slv_s4

/**  write method for slave */
function void ahb_sb::write_slv_s5(ahb_slv_trans slv_trans_h);

  ahb_mas_trans mas_tr;	
  
  if(slv_trans_h.htrans_type!=IDLE) begin 
 
    case (slv_trans_h.HADDR) inside
      
      [32'h0000_0000 : 32'h0000_ffff] : begin 
                                          mas_tr = mas_m0_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch S5")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s5_m0_trans_count++;
                                        end
      [32'h0001_0000 : 32'h0001_ffff] : begin 
                                          mas_tr = mas_m1_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s5_m1_trans_count++;
          		                end

      [32'h2000_0000 : 32'h2001_ffff] : begin 
                                          mas_tr = mas_m3_act_q.pop_front();
          				  if(slv_trans_h.HWRITE) begin
          			            if(slv_trans_h.HWDATA!=mas_tr.HWDATA[0])
          				      `uvm_error("SCOREBOARD","write data mismatch")
          			          end
          				  else begin
                                            if(slv_trans_h.HRDATA!=mas_tr.HRDATA)
          			              `uvm_error("SCOREBOARD",$sformatf("read data mismatch act - %0d | exp - %0d",mas_tr.HRDATA,slv_trans_h.HRDATA))
          				  end
					  s5_m3_trans_count++;
                                        end

      default : `uvm_error("SCOREBOARD","Address out of range access")

    endcase

  end
  
endfunction : write_slv_s5

function void ahb_sb::write_ahb_sram(ahb_mas_trans ahb_sram_tr);

  if(ahb_sram_tr.HWRITE)	
    mem[ahb_sram_tr] = ahb_sram_tr.HWDATA[0]; 
  	
endfunction : write_ahb_sram

function void ahb_sb::write_sram(sram_transaction sram_tr);

  if(!sram_tr.SRAMWREN) begin
    if(sram_tr.SRAMRDATA != mem[sram_tr.SRAMADATA])
      `uvm_info("DATA INTEGRATY FAILED","Data mismatch",UVM_MEDIUM)
  end

endfunction : write_sram

/**  run phase to reset memory when active low reset comes  */
//task ahb_sb:: run_phase(uvm_phase phase);
  //forever begin

   /* @(posedge vif.HCLK);

    if(slv_ai_sb_s0.size()>0 && mas_m0_act_q.size()>0) begin
     
      slv_tr = slv_ai_sb_s0.pop_front();
      mas_tr = mas_m0_act_q.pop_front();

      if()

    end*/
     
  //end
//endtask

function void ahb_sb::report_phase(uvm_phase phase);

  $display("|-----------------------------------------------");
  $display("|     M0 - %5d | S0 - %5d                       ",m0_trans_count,s0_m0_trans_count);
  $display("|                | S1 - %5d                     ",s1_m0_trans_count);
  $display("|                | S4 - %5d                     ",s4_m0_trans_count);
  $display("|                | S5 - %5d                     ",s5_m0_trans_count);
  $display(" ----------------------------------------------- ");
  $display("|     M1 - %5d | S0 - %5d                       ",m1_trans_count,s0_m1_trans_count);
  $display("|                | S1 - %5d                       ",s1_m1_trans_count);
  $display("|                | S4 - %5d                       ",s4_m1_trans_count);
  $display("|                | S5 - %5d                       ",s5_m1_trans_count);
  $display(" ----------------------------------------------- ");
  $display("|     M2 - %5d | S3 - %5d                       ",m2_trans_count,s3_m2_trans_count);
  $display("|                | S4 - %5d                       ",s4_m2_trans_count);
  $display(" ----------------------------------------------- ");
  $display("|     M3 - %5d | S3 - %5d                       ",m3_trans_count,s3_m3_trans_count);
  $display("|                | S5 - %5d                       ",s5_m3_trans_count);
  $display("|-----------------------------------------------");

  if(m0_trans_count != s0_m0_trans_count+s1_m0_trans_count+s4_m0_trans_count+s5_m0_trans_count)
    `uvm_error("SB",$sformatf("Transaction Count Mis Match Exp Count - %0d | Act Count - %0d",m0_trans_count,s0_m0_trans_count+s1_m0_trans_count+s4_m0_trans_count+s5_m0_trans_count))
  
  if(m1_trans_count != s0_m1_trans_count+s1_m1_trans_count+s4_m1_trans_count+s5_m1_trans_count)
    `uvm_error("SB",$sformatf("Transaction Count Mis Match Exp Count - %0d | Act Count - %0d",m1_trans_count,s0_m1_trans_count+s1_m1_trans_count+s4_m1_trans_count+s5_m1_trans_count))
    
  if(m2_trans_count != s3_m2_trans_count+s4_m2_trans_count)
    `uvm_error("SB",$sformatf("Transaction Count Mis Match Exp Count - %0d | Act Count - %0d",m2_trans_count,s3_m2_trans_count+s4_m2_trans_count))

  if(m3_trans_count != s3_m3_trans_count+s5_m3_trans_count)
    `uvm_error("SB",$sformatf("Transaction Count Mis Match Exp Count - %0d | Act Count - %0d",m3_trans_count,s3_m3_trans_count+s5_m3_trans_count))

endfunction : report_phase

`endif 

