libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

/* Solution 1: Test for multplie values of country */
data work.bonus;
   set orion.nonsales;
   if Country in ('US','us')
		then Bonus=500;
   else Bonus=300;
run;

proc print data=work.bonus;
   var First Last Country Bonus;
run;

  /* Solution 2: Call the upcase function in the expression */
data work.bonus;
   set orion.nonsales;
   if upcase(Country)='US' then Bonus=500;
   else Bonus=300;
run;

proc print data=work.bonus;
   var First Last Country Bonus;
run;


