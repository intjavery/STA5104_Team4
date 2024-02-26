data work.us;
	set orion.sales;
	where Country='US'; 
	Bonus=Salary*.10;
	label Job_Title='Sales Title';
	drop Employee_ID Gender Country Birth_Date;
run;

proc print data=work.us label;
	label Job_Title='Title';
run;
