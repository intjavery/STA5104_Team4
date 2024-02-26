libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc means data =orion.sales;
	var Salary;
	class Country;
run;

********* maxdec=0 ************;
proc means data =orion.sales maxdec=0;
	var Salary;
	class Country;
run;

********* maxdec=1 ************;
proc means data =orion.sales maxdec=1;
	var Salary;
	class Country;
run;

********* nonobs ************;
proc means data =orion.sales nonobs;
	var Salary;
	class Country;
run;
