proc sort data=orion.sales
	       out=work.sales;
	where Salary<25500;
   by Country descending Salary;
run;
proc print data=work.sales noobs;
	by Country;
	sum Salary;
	var First_name Last_Name Gender Salary;
run;
