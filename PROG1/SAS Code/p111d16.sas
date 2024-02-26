options nodate nonumber;
title; footnote;
%let PATH = C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Report;

ods listing; /* OUTPUT window in SAS Windowing Environment */
ods html file="&path\myreport.html";
ods pdf file="&path\myreport.pdf";
ods rtf file="&path\myreport.rtf";

title 'Report 1';
proc freq data=orion.sales;
   tables Country;
run;

title 'Report 2';
proc means data=orion.sales;
   var Salary;
run;

title 'Report 3';
proc print data=orion.sales;
   var First_Name Last_Name 
       Job_Title Country Salary;
   where Salary > 75000;
run;

ods _all_ close;
ods html; /* SAS Windowing Environment */

