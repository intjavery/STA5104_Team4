proc sort data=orion.sales
	       out=work.sales;
   by Country;
run;
proc print data=work.sales;
   by Country;
   sum Salary;
   format Salary dollar20.;
run;
