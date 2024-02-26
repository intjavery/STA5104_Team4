libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

proc freq data=orion.sales;
	tables Gender*Country;
run;

proc format;
	value $ctryfmt 'AU'='Australia'
                  'US'='United States';
	value $gender 'F'='Female'
	              'M'='Male';
run;

proc freq data=orion.sales;
	tables Gender*Country;
	format Country $ctryfmt.
          Gender $gender.;
run;

proc freq data=orion.sales;
   tables Gender*Country / format=13.;
   format Country $ctryfmt.
          Gender $gender.;
run;

