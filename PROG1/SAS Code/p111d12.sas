libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";

options nodate nonumber;
title; footnote;

ods html file="C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Report\myreport.html";

proc freq data=orion.sales;
   tables Country;
run;

ods html close;
