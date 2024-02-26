libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data charities;
  length ID $ 5;
  set orion.biz_list;
  if substr(Acct_Code,length(Acct_Code),1)='2';
  ID=substr(Acct_Code,1,length(Acct_Code)-1);
run;

proc print data=charities noobs;
run;
