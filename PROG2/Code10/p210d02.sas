/* Step 1 */
proc format library=orion.myfmts cntlout=countryfmt;
   select $country;
run;

proc print data=countryfmt;
run;

proc print data=orion.NewCodes;
run;

/* Step 2 */

data countryfmt;
   set countryfmt orion.NewCodes;
run;

/* Step 3 */

proc format library=orion.myfmts cntlin=countryfmt fmtlib;
   select $country;
run;
