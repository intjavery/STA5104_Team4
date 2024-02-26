libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

data work.subset1;
	set orion.sales;
	where Country='AU' and
         Job_Title contains 'Rep';
	Bonus=Salary*.10;
	drop Employee_ID Gender Country Birth_Date;
run;

proc print data=work.subset1;
run;


