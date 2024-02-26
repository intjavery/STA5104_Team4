libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data mnthtot2;
   set orion.aprsales2;
   Mth2Dte+SaleAmt;
run;

proc print data=mnthtot2 noobs;
   format SaleDate date9.;
run;
