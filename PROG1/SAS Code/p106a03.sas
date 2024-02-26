data work.usemps;
   set orion.sales;
   Bonus=Salary*.10;
   where Country='US' and Bonus>=3000;
run;
