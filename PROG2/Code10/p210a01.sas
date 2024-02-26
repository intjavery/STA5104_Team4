/*********************/
/*  p210a01          */
/*********************/
options fmterr fmtsearch=(orion orion.MyFmts);

data customers;
   set orion.customer;
   Country_Name=put(Country,$country.);
run;

proc freq data=orion.employee_addresses;
   tables Country;
   format Country $extra.;
run;



/* Set back to defaults */
options fmterr fmtsearch=(work);
