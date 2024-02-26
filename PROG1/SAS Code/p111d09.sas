libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc means data=orion.sales nmiss min max sum;
	var Salary;
	class Gender Country;
run;
