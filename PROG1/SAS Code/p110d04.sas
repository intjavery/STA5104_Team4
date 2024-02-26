********** Create Data **********;
data empsau;
   input First $ Gender $ EmpID;
   datalines;
Togar   M   121150
Kylie   F   121151
Birin   M   121152
;

data phoneh;
   input EmpID Phone $15.;
   datalines;
121150 +61(2)5555-1793
121151 +61(2)5555-1849
121152 +61(2)5555-1665
;

********** One-to-One Merge **********;
data empsauh;
   merge empsau phoneh;
   by EmpID;
run;

proc print data=empsauh;
run;
