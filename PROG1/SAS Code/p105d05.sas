data work.salaries;
	input Name $ Salary;
	Original_Salary=Salary;
	datalines;
Abi 50000
Mike 65000
Jose 50000.00
Joe 37000.50
Ursula 142000
Luis 49999.99
;

proc format;
   value tiers  20000-<50000='Tier 1'                  
               50000-<100000='Tier 2'
               100000-250000='Tier 3';
run;

proc print data=work.salaries;
   format Salary tiers.;
run;
