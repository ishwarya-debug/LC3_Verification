add wave -position insertpoint sim:/hdl_top/decode_ip_if/*
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/decode_env/decode_in_agent_obj/decode_in_agent_obj_monitor/txn_stream
add wave -position insertpoint sim:/hdl_top/decode_op_if/*
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/decode_env/decode_out_agent_obj/decode_out_agent_obj_monitor/txn_stream
run -a