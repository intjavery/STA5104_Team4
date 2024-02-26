libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data hrdata;
   keep GrossPay Bonus;
   set orion.convert;
   Bonus = GrossPay * .10;
run;

proc print data=hrdata noobs;
run;
