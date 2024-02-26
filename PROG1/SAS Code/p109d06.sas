libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

/* Clean the data before checking the value */
data work.bonus;
   set orion.nonsales;
   Country=upcase(Country);
   if Country='US' then Bonus=500;
   else Bonus=300;
run;

proc print data=work.bonus;
   var First Last Country Bonus;
run;
