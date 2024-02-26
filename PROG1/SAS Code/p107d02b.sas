/* Display a subset of an xlsx file with XLSX engine */

options validvarname=v7;  
libname orionx xlsx "&path\sales.xlsx";

proc print data=orionx.Australia noobs;
   where Job_Title ? 'IV';
   var Employee_ID Last_Name Job_Title Salary;
run;

libname orionx clear;
