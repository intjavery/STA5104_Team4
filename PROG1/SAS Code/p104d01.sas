libname orion "E:\Data\UCFDOC\STA5104\SAS_PG01\Instructor\SASData";
ods liting;
proc print data=orion.sales;
run;

proc print data=orion.sales;
	var Last_Name First_Name Salary;
run;

proc print data=orion.sales;
	var Last_Name First_Name Salary;
	sum salary;
run;
