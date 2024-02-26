libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

data work.subset1;
	set orion.sales;
	where Country='AU' and
         Job_Title contains 'Rep' and
         Hire_Date<'01jan2000'd;
	Bonus=Salary*.10;
run;

proc print data=work.subset1 noobs;
	var First_Name Last_Name Salary Job_Title Bonus Hire_Date;
	format Hire_Date date9.;
run;

