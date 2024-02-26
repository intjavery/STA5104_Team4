libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data hrdata;
   keep Phone Code Mobile;
   set orion.convert;
   Phone='(' || put(Code,3.) || ') ' || Mobile;
run;

proc print data=hrdata noobs;
run;
