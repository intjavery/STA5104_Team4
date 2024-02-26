data work.au_reps;
	drop Employee_ID Gender Country Birth_Date;
	set orion.sales;
	where Country='AU' and
         Job_Title contains 'Rep';
	Bonus=Salary*.10;
run;

proc print data=work.au_reps;
run;


