proc print data=orion.sales;
	where Country='AU' and 
         Salary<30000;
run;
