data work.subset1;
	set orion.sales;
	where Country='AU' and
         Job_Title contains 'Rep';
	Bonus=Salary*.10;
	label Job_Title='Sales Title'
		   Hire_Date='Date Hired';
	drop Employee_ID Gender Country Birth_Date;
run;

proc contents data=work.subset1;
run;

proc print data=work.subset1 label;
run;

proc print data=work.subset1 split=' ';
run;
