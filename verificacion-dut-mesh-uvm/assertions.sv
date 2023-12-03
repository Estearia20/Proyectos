// This file includes the assertions that we are using to check for a proper
// workflow from the DUT

`define ASSERT_DRV_PNDG_IN(vif) \
assert (vif.pndng_i_in[this.terminal] == 1'b1) else `uvm_fatal("ASSERT_FAIL", $sformatf("[FAIL] The DUT pending was not set"));

`define ASSERT_DRV_DATA_IN(vif) \
//assert (vif.data_out_i_in[this.terminal] == trans.dato_pkg) else `uvm_fatal("ASSERT_FAIL", $sformatf("[FAIL] The data was not passed to the DUT"));

`define ASSERT_DRV_PNDG_IN_ZERO(vif) \
assert (vif.pndng_i_in[this.terminal] == 0) else `uvm_fatal("ASSERT_FAIL", $sformatf("[FAIL] The terminal has nothing to send, and pending is still 1"));

`define ASSERT_MNT_POP_ONE(vif) \
assert (vif.pop[this.terminal] == 1) else `uvm_fatal("ASSERT_FAIL", $sformatf("[FAIL] There is a pending from DUT but the pop was not generated"));

`define ASSERT_MNT_POP_ZERO(vif) \
assert (vif.pop[this.terminal] == 0) else `uvm_fatal("ASSERT_FAIL",$sformatf("[FAIL] The pop was generated but not turned off"));
