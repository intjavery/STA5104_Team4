libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";
data charities;
  length ID $ 5;
	set orion.biz_list;
	if char(right(Acct_Code),6) = '2';
	ID = left(substr(right(Acct_Code),1,5));
run;

proc print data=charities noobs;
run;
