class slv_drv_user_callback extends slv_drv_callback;

  `uvm_object_utils(slv_drv_user_callback)

  function new(string name="slv_drv_user_callback");
    super.new(name);
  endfunction

  task hresp_cycle_count(ahb_slv_trans trans_h);
    trans_h.hresp_type=hresp_enum'(OKAY);
  endtask

endclass 

