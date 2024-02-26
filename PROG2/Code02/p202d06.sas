libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_Used";

/* Use DROP= data set option to control variable output */

data usa (drop=Street_ID Country)
     australia (drop=Street_ID State Country)
     other;
   set orion.employee_addresses;
   if Country='US' then output usa;
   else if Country='AU' then output australia;
   else output other;
run;
