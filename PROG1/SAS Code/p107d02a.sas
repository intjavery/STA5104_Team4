/* Display a subset of an xlsx file with EXCEL or PCFILES engine */

options validvarname=v7;
*libname orionx excel "&path\sales.xlsx";
*libname orionx pcfiles path="&path\sales.xlsx";

proc print data=orionx.'Australia$'n noobs;
   where Job_Title contains 'IV';
   var Employee_ID Last_Name 
       Job_Title Salary;
run;

libname orionx clear;
