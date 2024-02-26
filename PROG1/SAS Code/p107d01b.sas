/* Read an xlsx file with XLSX engine */

options validvarname=v7;
libname orionx xlsx "&path\sales.xlsx";

proc contents data=orionx._all_;
run;

proc print data=orionx.Australia;
run;

libname orionx clear;
