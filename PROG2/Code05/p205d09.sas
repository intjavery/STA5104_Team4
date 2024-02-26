libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

Data correct;
   set orion.clean_up;
   if find(Product,'Mittens','I') > 0 then do;
      substr(Product_ID,9,1) = '5';
   end;
run;

proc print data=correct noobs;
run;
