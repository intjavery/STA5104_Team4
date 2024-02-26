libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";
data hrdata;
   keep EmpID;
   set orion.convert;
   EmpID = ID + 11000;
run;

proc print data=hrdata noobs;
run;
 /* check the variable type for EmpID and ID */
proc contents data=orion.convert;
run;

proc contents data=hrdata;
run;
