proc sort data=orion.sales
	       out=work.sales;
   by Salary;
run;

proc print data=work.sales noobs;
   var Employee_ID Last_Name Salary;
run;
