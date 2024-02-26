libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc print data=orion.sales;
	var Last_Name First_Name Salary;
	where Salary<25500;
run;

proc print data=orion.sales noobs;
	var Last_Name First_Name Salary;
	where Salary<25500;
run;


