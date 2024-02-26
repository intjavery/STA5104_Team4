data work.auemps;
	set orion.sales;
	where Country='AU';
	Bonus=Salary*.10;
	drop Employee_ID Gender Country Birth_Date;
run;

proc print data=work.auemps;
run;


