libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";
proc print data=orion.banks;
   format rate 6.4;
run;

data invest(drop=Quarter Year);
   set orion.banks;
   Capital=0;
   do Year=1 to 5;
      Capital+5000;
      do Quarter=1 to 4;
         Capital+(Capital*(Rate/4));
      end;
   end;
run;

proc print data=invest noobs;
run;
