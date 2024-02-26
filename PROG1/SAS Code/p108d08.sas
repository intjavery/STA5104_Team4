/* This DATA step uses the DATALINES statement 
    to provide instream directly in the DATA step.
    The INPUT statement to reads this instream data 
    instead of reading data from an external file.        */

data work.newemps;
   input First_Name :$12. Last_Name :$18.  
         Job_Title :$15. Salary :dollar.;
   datalines;
Steven Worton Auditor $40,450
Marta-Lyn Bamberger Manager $32,000
Merle Hieds Trainee $24,025
;

proc print data=work.newemps;
run;


