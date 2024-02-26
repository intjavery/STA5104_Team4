libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";
data find;
   Text='AUSTRALIA, DENMARK, US';
   Pos1=find(Text,'US');
   Pos2=find(Text,' US');
   Pos3=find(Text,'us');
   Pos4=find(Text,'us','I');
   Pos5=find(Text,'us','I',10);
run;

proc print data=find noobs;
run;
