libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_Used";

/* Q- What is wrong with this code? */

data usa australia(drop=State) other;
  set orion.employee_addresses
     (drop=Country Street_ID Employee_ID);
  if Country='US' then output usa;
  else if Country='AU' then output australia;
  else output other;
run;
