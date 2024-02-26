/* Read an xlsx file with XLSX engine */

options validvarname=v7;
libname orionx xlsx "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Data\sales.xlsx";

proc contents data=orionx._all_;
run;

proc print data=orionx.Australia;
run;

libname orionx clear;
