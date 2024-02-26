libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc print data=orion.sales noobs;
	var Last_Name First_Name Country Job_Title Salary Hire_Date;
run;

proc print data=orion.sales noobs;
	format Salary dollar8. Hire_Date mmddyy10.;
	var Last_Name First_Name Country Job_Title Salary Hire_Date;
run;

