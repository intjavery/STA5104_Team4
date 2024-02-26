/*********************/
/*  p210a01s         */
/*********************/
libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

/************************/
/* Step 1 - 10.03      */
/* Add NOFMTERR option  */
/************************/

options nofmterr;

data customers;
   set orion.customer;
   Country_Name=put(Country,$country.);
run;

proc freq data=orion.employee_addresses;
   tables Country;
   format Country $extra.;
run;

 
title;

/************************/
/* Step 2 - 10.04       */ 
/* Change NOFMTERR to   */
/*    FMTERR            */
/* Add FMTSEARCH option */
/************************/

options fmterr fmtsearch=(orion orion.MyFmts);

data supplier_country;
   set orion.shoe_vendors;
   Country_Name=put(Supplier_Country, $country.);
run;

proc freq data=orion.employee_addresses;
   tables Country;
   format Country $extra.;
run;
 
title;

/* Set back to defaults */
options fmterr fmtsearch=(work);
