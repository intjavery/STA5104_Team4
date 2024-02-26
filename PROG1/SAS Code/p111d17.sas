options nodate nonumber;
title; footnote;
%let PATH = C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Report;

ods csvall file="&path\myexcela.xls";
ods msoffice2k file="&path\myexcelb.xls";
ods tagsets.excelxp file="&path\myexcelc.xls";

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

