class driver_callback extends uvm_callback;

  `uvm_object_utils(driver_callback)

   function new(string name="driver_callback");
     super.new(name);
   endfunction 
  

virtual task hsize_greater_than_data(ahb_mas_trans trans_h);
endtask

virtual task unaligned_haddr_error(ahb_mas_trans trans_h);
endtask
endclass 
