title 'Orion Star Employees';
proc print data =orion.staff noobs;
	where Gender='F';
	var Employee_ID Salary;
run;

title 'Orion Star Female Employees';
proc print data =orion.staff noobs;
	where Gender='F';
	var Employee_ID Salary;
run;

title 'Orion Star Employees';
proc print data =orion.staff noobs;
	where Gender='F';
	var Employee_ID Gender Salary;
run;

title 'Orion Star Female Employees';
proc print data =orion.staff noobs;
	where Gender='F';
	var Employee_ID Gender Salary;
run;
