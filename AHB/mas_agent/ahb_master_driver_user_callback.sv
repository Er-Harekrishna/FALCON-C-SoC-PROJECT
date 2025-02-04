class driver_user_callback extends driver_callback;

  `uvm_object_utils(driver_user_callback)

  function new(string name="driver_user_callback");
    super.new(name);
  endfunction

  task hsize_greater_than_data(ahb_mas_trans trans_h);
     trans_h.hsize_type = hsize_enum'(DOUBLEWORD);
  endtask

  task unaligned_haddr_error(ahb_mas_trans trans_h);
    trans_h.HADDR = 'd2090 ;
  endtask
endclass 
