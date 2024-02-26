proc format;
   value $ctryfmt 'AU'='Australia'
                  'US'='United States' 
                 other='Miscoded';

   value tiers low-<50000='Tier 1'                  
            50000-<100000='Tier 2'
              100000-high='Tier 3';
run;

proc print data=orion.sales;
   var Employee_ID Job_Title Salary 
       Country Birth_Date Hire_Date;
   format Birth_Date Hire_Date monyy7.
          Country $ctryfmt. 
          Salary tiers.;
run;
