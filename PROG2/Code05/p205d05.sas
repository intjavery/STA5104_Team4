libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data Scan_Quiz;
  Text = "New Year's Day, January 1st, 2007"; 
  Year1 = scan(Text,-1);
  Year2 = scan(Text,6);
  Year3 = scan(Text,6,', ');
run;

proc print data=Scan_Quiz;
run;
