libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData";

data usa australia;
   set orion.employee_addresses;
   select (Country);
	  when ('US') output usa;
	  when ('AU') output australia;
	  otherwise;
   end;
run;
