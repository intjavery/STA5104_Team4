title1 'Orion Star Sales Staff';
title2 'Salary Report';
footnote1 'Confidential';

  /* Use an asterisk as the split= character */
proc print data=orion.sales split='*';
   var Employee_ID Last_Name Salary;
   label Employee_ID = 'Sales ID'
	      Last_Name = 'Last*Name'     /* no split character */ 
			Salary = 'Annual*Salary';
run;

title;
footnote;
