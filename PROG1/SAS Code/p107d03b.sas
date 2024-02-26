/* Read an xlsx file with XLSX engine */

options validvarname=v7;
libname xl xlsx "&path\sales.xlsx";

proc contents data=xl._all_;
run;

data work.subset2;
	set xl.Australia;
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
