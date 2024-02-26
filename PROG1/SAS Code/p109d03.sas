libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

data work.comp;
	set orion.sales;
	if Job_Title='Sales Rep. IV' then Bonus=1000;
	else if Job_Title='Sales Manager' then Bonus=1500;
	else if Job_Title='Senior Sales Manager' then Bonus=2000;
	else if Job_Title='Chief Sales Officer' then Bonus=2500;
run;

proc print data=work.comp;
	var Last_Name Job_Title Bonus;
run;
