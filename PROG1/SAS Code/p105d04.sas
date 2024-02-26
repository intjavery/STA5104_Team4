proc format;
   value tiers 0-49999='Tier 1'                  
           50000-99999='Tier 2'
         100000-250000='Tier 3';
run;

data work.salaries;
	input Name $ Salary;
	Original_Salary=Salary;
	datalines;
Abi 50000
Mike 65000
Jose 50000.00
Joe 37000.50
Ursula 142000
Lu 49999.99
;

proc print data=work.salaries;
   format Salary tiers.;
run;

proc print data=work.salaries;
   format Salary tiers8.;
run;

