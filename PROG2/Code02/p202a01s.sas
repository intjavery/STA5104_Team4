libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData";

data forecast;
   set orion.growth;
   Year=1;
   Total_Employees=Total_Employees*(1+Increase);
   Year=2;
   Total_Employees=Total_Employees*(1+Increase);
   output;
run;
proc print data=forecast noobs;
   var Department Total_Employees Year;
run;


  /* Alternate solution */
data forecast;
   set orion.growth;
   Total_Employees=Total_Employees*(1+Increase);
   Total_Employees=Total_Employees*(1+Increase);
   Year=2;
run;
proc print data=forecast noobs;
   var Department Total_Employees Year;
run;
