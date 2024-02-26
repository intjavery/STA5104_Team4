/*********************************************************
*  1. Complete the program to match-merge the sorted     *
*     SAS data sets referenced in the PROC SORT steps.   *                                  *
*  2. Submit the program. Correct and resubmit,          *
*     if necessary.                                      * 
*  4. What are the modified, completed statement?        *
*********************************************************/
libname orion "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\SASData";
proc sort data=orion.employee_payroll
          out=work.payroll; 
   by Employee_ID;
run;

proc sort data=orion.employee_addresses
          out=work.addresses;
   by Employee_ID;
run;

data work.payadd;
   merge         ;
   by            ;
run;

proc print data=work.payadd;
   var Employee_ID Employee_Name Birth_Date Salary;
   format Birth_Date weekdate.;
run;
