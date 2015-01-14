
#ln -s ../behavioral/*mem .
#ln -s ../behavioral/synopsys_sim.setup .
sed 's/\("\)\(\w\)/\1\.\.\/behavioral\/\2/g' ../behavioral/pa5000.do > .1
sed 's/vlog\ -novopt\ -incr\ -work\ ddr3_ctrl_v1_00_a/vlog\ -sv\ -novopt\ -incr\ -work\ ddr3_ctrl_v1_00_a/g' .1 > system.do
echo "quit" >> system.do
vsim -c -do system.do | tee -i log

grep "Warning: \[8\]" transcript | grep -v ipcore_dir > link.log

rm .1

