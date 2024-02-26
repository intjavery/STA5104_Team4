libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";
data hrdata(drop=CharGross);
   set orion.convert(rename=(GrossPay=
                             CharGross));            
   GrossPay=input(CharGross,comma6.);
run;

proc contents data=hrdata;
run;

proc print data=hrdata noobs;
run;



