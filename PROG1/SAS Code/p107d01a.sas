/* Read an xlsx file with EXCEL or PCFILES engine */

options validvarname=v7;
libname orionx excel "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Data\sales.xlsx";
*libname orionx pcfiles path="&path\sales.xlsx";

proc contents data=orionx._all_;
run;

proc print data=orionx.'Australia$'n;
run;

libname orionx clear;
