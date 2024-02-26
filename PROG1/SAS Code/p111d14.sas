libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

options nodate nonumber;
title; footnote;

%let PATH = C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Report;


********** STYLE= with HTML **********;
ods html file="&path\myreport1.html" style=htmlblue;
proc freq data=orion.sales;
   tables Country;
run;
ods html close;
ods html file="&path\myreport2.html" style=default;
proc freq data=orion.sales;
   tables Country;
run;
ods html close;
ods html file="&path\myreport3.html" style=sasweb;
proc freq data=orion.sales;
   tables Country;
run;
ods html close;

********** STYLE= with PDF **********;
ods pdf file="&path\myreport1.pdf" style=pearl;
proc freq data=orion.sales;
   tables Country;
run;
ods pdf close;
ods pdf file="&path\myreport2.pdf" style=printer;
proc freq data=orion.sales;
   tables Country;
run;
ods pdf close;
ods pdf file="&path\myreport3.pdf" style=journal;
proc freq data=orion.sales;
   tables Country;
run;
ods pdf close;

********** STYLE= with RTF **********;
ods rtf file="&path\myreport1.rtf" style=rtf;
proc freq data=orion.sales;
   tables Country;
run;
ods rtf close;
ods rtf file="&path\myreport2.rtf" style=ocean;
proc freq data=orion.sales;
   tables Country;
run;
ods rtf close;
ods rtf file="&path\myreport3.rtf" style=minimal;
proc freq data=orion.sales;
   tables Country;
run;
ods rtf close;

********** Available Styles **********;
ods listing;
proc template;
   list styles;
run;
ods listing close;
