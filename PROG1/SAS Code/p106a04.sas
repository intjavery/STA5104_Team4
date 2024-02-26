 /* Run each of the following programs.                */ 
 /* compare the output and number of observations read */

 /* original program with WHERE and subsetting IF      */
data work.auemps;
	set orion.sales;
	where Country='AU';
	Bonus=Salary*.10;
   if Bonus>=3000;
run;

proc print data=work.auemps;
	var First_Name Last_Name Salary Bonus;
run;

 /* modified program with only a subsetting IF         */
data work.auemps;
	set orion.sales;
	Bonus=Salary*.10;
   if Country='AU' and Bonus>=3000;
run;

proc print data=work.auemps;
	var First_Name Last_Name Salary Bonus;
run;
