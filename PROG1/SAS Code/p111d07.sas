libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc means data=orion.sales;
run; 

proc means data=orion.sales;
	var Salary;
run; 

proc means data=orion.sales n mean;
	var Salary;
run; 

