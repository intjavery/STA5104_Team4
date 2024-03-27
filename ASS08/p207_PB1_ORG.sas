data future_expenses;
   drop start stop;
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
   start=year(today())+1;
   stop=start+9;
   do Year=start to stop;
      wages = wages * 1.06;
      retire=retire*1.014;
      medical=medical *1.095;
      Total_Cost=sum(wages,retire,medical);
      output;
   end;
run;
