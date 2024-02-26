libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data rotate (keep=Employee_Id Period Amount);
   set orion.employee_donations
	         (drop=recipients paid_by);
   array contrib{4} qtr1-qtr4;
   do i=1 to 4;
      if contrib{i} ne . then do;
         Period=cats("Qtr",i);
         Amount=contrib{i};
         output;
      end;
   end;
run;

proc print data=rotate;
run;

proc freq data=rotate;
   tables Period /nocum nopct;
run;

proc gchart data=rotate;
   pie3d Period / sumvar=Amount 
                type=Sum
				slice=outside
                value=inside
                 noheading;
   format amount dollar8.;
title  "Sum of Employee Contributions"; 
run;
quit;
