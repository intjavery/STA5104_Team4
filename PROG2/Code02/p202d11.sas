libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_Used";

/* use OBS= and FIRSTOBS= options on a PROC step */

proc print data=orion.employee_addresses 
           (firstobs=10 obs=15);
   var Employee_Name City State Country;
run;



