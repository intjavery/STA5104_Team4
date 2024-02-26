********** Create Data **********;
data empsau;
   input First $ Gender $ EmpID;
   datalines;
Togar   M   121150
Kylie   F   121151
Birin   M   121152
;

data phonec;
   input EmpID Phone $15.;
   datalines;
121150 +61(2)5555-1795
121152 +61(2)5555-1667
121153 +61(2)5555-1348
;

********** IN= Option **********;
data empsauc;
   merge empsau(in=Emps) 
         phonec(in=Cell);
   by EmpID;
run;

proc print data=empsauc;
run;


********** Matches Only **********;
data empsauc;
   merge empsau(in=Emps) 
         phonec(in=Cell);
   by EmpID;
   if Emps=1 and Cell=1;
run;

proc print data=empsauc;
run;

********** Non-Matches from empsau Only **********;
data empsauc;
   merge empsau(in=Emps) 
         phonec(in=Cell);
   by EmpID;
   if Emps=1 and Cell=0;
run;

proc print data=empsauc;
run;

********** Non-Matches from PhoneC Only **********;
data empsauc;
   merge empsau(in=Emps) 
         phonec(in=Cell);
   by EmpID;
   if Emps=0 and Cell=1;
run;

proc print data=empsauc;
run;

********** All Non-Matches **********;
data empsauc;
   merge empsau(in=Emps) 
         phonec(in=Cell);
   by EmpID;
   if Emps=0 or Cell=0;
run;

proc print data=empsauc;
run;
