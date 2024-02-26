libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc freq data=orion.nonsales2;
   tables Job_Title / nocum nopercent;
run; 
