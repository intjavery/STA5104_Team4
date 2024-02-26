********** Create Data **********;
data empsdk;
   input First $ Gender $ Country $;
   datalines;
Lars    M   Denmark
Kari    F   Denmark
Jonas   M   Denmark
;

data empsfr;
   input First $ Gender $ Country $;
   datalines;
Pierre  M   France
Sophie  F   France
;

********** Like-Structured Data Sets **********;
data empsall1;
   set empsdk empsfr;
run;

proc print data=empsall1;
run;
