libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_Used";

/* use OBS= with a WHERE statment*/

proc print data=orion.employee_addresses 
           (obs=10);
   where Country='AU';
   var Employee_Name City Country;
run;
