data work.us;
   set orion.sales;
   where Country='US' ;
run;
