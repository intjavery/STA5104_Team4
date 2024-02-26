********** Create Data **********;
data empscn;
   input First $ Gender $ Country $;
   datalines;
Chang   M   China
Li      M   China
Ming    F   China
;

data empsjp;
   input First $ Gender $ Region $;
   datalines;
Cho     F   Japan
Tomi    M   Japan
;

********** Unlike-Structured Data Sets **********;
data empsall2;
   set empscn empsjp;
run;

proc print data=empsall2;
run;
