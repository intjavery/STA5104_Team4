options nodate nonumber;
title; footnote;
%let PATH = C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Report;

ods csvall file="&path\example.csv";
ods msoffice2k file="&path\example.html";
ods tagsets.excelxp file="&path\example.xml";

proc freq data=orion.sales;
   tables Country;
run;

proc means data=orion.sales;
   var Salary;
run;

ods csvall close;
ods msoffice2k close;
ods tagsets.excelxp close;

*ods _all_ close;
*ods html;
