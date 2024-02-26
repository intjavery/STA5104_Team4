libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc print data=orion.nonsales2;
   where Gender not in ('F','M') or
         Country not in ('AU','US') or
			Job_Title is null or 
			Employee_ID is missing or
			Employee_ID=120108;
run;
