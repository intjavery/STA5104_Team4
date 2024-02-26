********** Create Data **********;
data empsau;
   input First $ Gender $ EmpID;
   datalines;
Togar   M   121150
Kylie   F   121151
Birin   M   121152
;

data phones;
   input EmpID Type $ Phone $15.;
   datalines;
121150 Home +61(2)5555-1793
121150 Work +61(2)5555-1794
121151 Home +61(2)5555-1849
121152 Work +61(2)5555-1850
121152 Home +61(2)5555-1665
121152 Cell +61(2)5555-1666
;

********** Many-to-One Merge **********;
data empphones;
   merge phones empsau;
   by EmpID;
run;

proc print data=empphones;
run;
