libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc freq data=orion.sales;
   tables Gender Country;
run;

proc sort data=orion.sales out=sorted;
   by Country;
run;

proc freq data=sorted;
   tables Gender; 
   by Country;
run;

proc freq data=orion.sales;
   tables Gender*Country;
run;

proc freq data=orion.sales ;
   tables Gender*Country / list;
run;

proc freq data=orion.sales;
   tables Gender*Country / crosslist;
run;


