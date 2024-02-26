proc print data=orion.sales;
	where Country='AU'  and Salary<30000;
   where also Gender='F';
	var First_Name Last_Name Gender Salary Country;
run;


