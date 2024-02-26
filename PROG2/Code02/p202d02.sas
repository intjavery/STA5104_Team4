libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_Used";

proc print data=orion.employee_addresses;
   var Employee_Name City Country; 
run;
