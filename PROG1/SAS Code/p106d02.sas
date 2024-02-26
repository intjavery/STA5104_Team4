data work.subset1;
	set orion.sales;
	where Country='AU' and
         Job_Title contains 'Rep' and
         Hire_Date<'01jan2000'd;
run;

proc print data=work.subset1 noobs;
	var First_Name Last_Name Salary Job_Title Hire_Date;
	format Hire_Date date9.;
run;

