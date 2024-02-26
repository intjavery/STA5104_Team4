proc sort data=orion.sales
	       out=work.sales;
   by Country descending Salary;
run;
proc print data=work.sales noobs;
	by Country;
	sum Salary;
	var First_Name Last_Name Gender Salary;
run;

