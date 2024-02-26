libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data labels;
   set orion.contacts;
   length FullName $ 30 FMName LName $ 15;
   FMName = scan(Name,2,',');            
   LName = scan(Name,1,',');
   FullName = catx(' ',Title,FMName,LName);
run;

proc print data=labels noobs;
   var ID FullName Address1 Address2;
run;


