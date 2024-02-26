libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_Used";

/* Example using OBS= data set option */

data australia;
	set orion.employee_addresses (obs=100);
	if Country='AU' then output;
run;

proc print data=australia;
run;

