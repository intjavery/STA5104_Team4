libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

proc transpose 
     data=orion.employee_donations 
     out=rotate2 (rename=(col1=Amount))
     name=Period;
   by employee_id;
run;

proc freq data=rotate2;
   where Amount ne .;
   tables Period/nocum nopct;
   label Period=" ";
run;
