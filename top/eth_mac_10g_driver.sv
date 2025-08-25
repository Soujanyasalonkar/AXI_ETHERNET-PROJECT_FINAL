class eth_mac_10g_driver extends uvm_driver #(eth_mac_10g_seq_item);
   `uvm_component_utils(eth_mac_10g_driver)
   
   virtual taxi_axis_if axis_if;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction
  
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if (!uvm_config_db#(virtual  taxi_axis_if)::get(this, "*", "axis_if", axis_if)) 
         `uvm_fatal("NO_VIF", "Virtual interface not set")
  
     `uvm_info("DRV", $sformatf("Interface handle: %p", axis_if), UVM_LOW)
   endfunction 
       
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(req);
         drive_packet(req);
         seq_item_port.item_done();
      end
   endtask
   
   virtual task drive_packet(eth_mac_10g_seq_item item);
     @(posedge axis_if.rx_clk);
       axis_if.tvalid <= 1'b1;
     while (!axis_if.tready) @(posedge axis_if.rx_clk);
     foreach(item.tx_axis_tdata[i]) begin
       @(posedge axis_if.rx_clk)
       axis_if.tdata <= item.tx_axis_tdata[i];
       
       if(i==item.tx_axis_tdata.size()-1)
          item.tx_axis_tlast=1; 
     end
     axis_if.tkeep <= item.tx_axis_tlast;
     axis_if.tlast <= item.tx_axis_tlast;
     axis_if.tuser <= item.tx_axis_tuser;
   endtask
     endclass
       
  
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

