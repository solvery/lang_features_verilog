#! /bin/sh

case_old=$1
case_new=$2
file_old=test_$case_old.sv
file_new=test_$case_new.sv

cp $file_old $file_new
ls $file_new | xargs sed -i "s/$case_old/$case_new/g"
echo "\`include \"$file_new\"" >> test_lib.sv

git add test_lib.sv $file_new

