proc sort data=orion.sales
	       out=work.sales;
   by Country descending Salary;
run;

proc print data=work.sales noobs;
run;

proc print data=work.sales noobs;
	by Country;
run;
