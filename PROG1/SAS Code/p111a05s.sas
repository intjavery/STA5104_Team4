options nodate nonumber;
title; footnote;

ods listing file="&path\myreport.txt";

proc print data=orion.sales;
run;

ods listing close;
