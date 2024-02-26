********** Create Data **********;
data empsact;
   input First $ Gender $ EmpID;
   datalines;
Togar   M   121150
Kylie   F   121151
Birin   M   121152
Jack M 121154
Liza F 121155
Sasha F 121157
;

data phoneact;
   input EmpID Phone $15.;
   datalines;
121150 +61(2)5555-1795
121152 +61(2)5555-1667
121153 +61(2)5555-1348
121155 +61(2)5555-1679
121156 +61(2)5555-1352
;

data empsphone;
   merge empsact(in=inEmps) 
         phoneact(in=inCell);
   by EmpID;
   if inEmps=1 and inCell=0;
run;

proc print data=empsphone;
run;

data empsphone;
   merge empsact(in=inEmps) 
         phoneact(in=inCell);
   by EmpID;
   if inEmps and not inCell;
run;

proc print data=empsphone;
run;
