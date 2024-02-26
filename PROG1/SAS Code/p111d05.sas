libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc freq data=orion.sales;
	tables Hire_Date / nocum;
	format Hire_Date date9.;
run;

proc freq data=orion.sales;
	tables Hire_Date / nocum;
	format Hire_Date year4.;
run;

