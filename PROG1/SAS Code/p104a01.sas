proc print data=orion.sales;
	where Country='AU';
   where Salary<30000;
run;


