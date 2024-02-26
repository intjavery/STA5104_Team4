/* Read an xlsx file with EXCEL or PCFILES engine */

options validvarname=v7; 
libname xl excel "C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Data\sales.xlsx";

*libname xl pcfiles path="&path\sales.xlsx";

proc contents data=xl._all_;
run;

data work.subset2;
   set xl.'Australia$'n;
   where Job_Title contains 'Rep';
   Bonus=Salary*.10;
   keep First_Name Last_Name Salary Bonus
        Job_Title Hire_Date;
   label Job_Title='Sales Title'
         Hire_Date='Date Hired';
   format Salary comma10. Hire_Date mmddyy10.
          Bonus comma8.2;
run;

proc contents data=work.subset2;
run;

proc print data=work.subset2 label;
run;

libname xl clear;
