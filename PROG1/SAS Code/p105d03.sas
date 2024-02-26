proc format;
	value $ctryfmt 'AU'='Australia'
					   'US'='United States' 
			  	    other ='Miscoded';
run;

proc print data=orion.sales;
	var Employee_ID  Salary 
		 Country Birth_Date Hire_Date;
	format Salary dollar10. 
		    Birth_Date Hire_Date monyy7.
			 Country $ctryfmt.;
run;

