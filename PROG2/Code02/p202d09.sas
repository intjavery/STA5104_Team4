libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_Used";

/* Example using OBS= and FISRTOBS= options */
data australia;
	set orion.employee_addresses 
            (firstobs=50 obs=100);
	if Country='AU' then output;
run;

proc print data=australia;
run;
