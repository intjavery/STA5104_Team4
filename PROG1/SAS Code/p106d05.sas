data work.auemps;
   set orion.sales;
   where Country='AU';
	Bonus=Salary*.10;
   if Bonus>=3000;
run;

proc print data=work.auemps;
	var First_Name Last_Name Salary Bonus;
run;
