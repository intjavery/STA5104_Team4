libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

/*Sort data set to prepare to summarize*/
proc sort data=orion.specialsals out=salsort;
   by Dept;
run;

  /*Summarize Salaries by Division*/
data deptsals(keep=Dept DeptSal);
   set SalSort;
   by Dept;
   if First.Dept then DeptSal=0;
   DeptSal+Salary;
   if Last.Dept;
run;

proc print data=deptsals noobs;
   title 'Employee Salaries by Department';
run;

