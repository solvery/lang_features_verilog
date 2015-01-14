sed 's/.*"\(.*\.v\)".*/\1/g' system.do | grep -v system_tb.v > .1
grep -v "com\|quit\|map\|vlib\|#\|glbl" .1 > .2
cat 1.f .2 > verdi.f
echo "../system_top.v" >> verdi.f
dos2unix verdi.f


