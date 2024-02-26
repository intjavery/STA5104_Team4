proc sort data=orion.sales
	       out=work.sales;
/*	where Salary<25500; */
   by Country descending Salary;
run;
proc print data=work.sales noobs;
   by Country;
	sum Salary;
/*	where Salary<25500; */
	var First_Name Last_Name Gender Salary;
run;
