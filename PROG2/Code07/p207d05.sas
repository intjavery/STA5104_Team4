libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data forecast;
   set orion.growth;
   do Year=1 to 6;
  	  Total_Employees=Total_Employees*(1+Increase);
  	  output;
   end;
run;
proc print data=forecast noobs;
run;
