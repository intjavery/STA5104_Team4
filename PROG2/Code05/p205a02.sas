libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data hrdata;
   set orion.convert;            
   GrossPay=input(GrossPay,comma6.);
run;

proc contents data=hrdata;
run;
