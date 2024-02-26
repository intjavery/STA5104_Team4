title1 'Orion Star Sales Staff';
title2 'Salary Report';
footnote1 'Confidential';

proc print data=orion.sales label;
   var Employee_ID Last_Name Salary;
   label Employee_ID='Sales ID' 
         Last_Name='Last Name' 
         Salary='Annual Salary';
run;

title;
footnote;


