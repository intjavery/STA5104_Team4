/*********************/
/*  p210d01          */
/*********************/
options fmterr fmtsearch=(orion orion.MyFmts);


/* Step 1         */
/* Make country   */

data country;
   keep Start Label FmtName;
   retain FmtName '$country';
   set orion.country(rename=(Country=Start
                             Country_Name=Label));
run;

proc print data=country noobs;
   title 'Country';
run;

/* Step 2        */
/* Make $country */

proc format library=orion.MyFmts cntlin=country;
run;

proc catalog cat=orion.MyFmts;
   contents;
quit;

/*******************************************************/
/* If there are missing country values, they can be    */
/* handled by creating the format $extra.  This format */
/* specifically sets missing values to the label       */
/* Unknown and uses the label of the $country format   */
/* for all other values. Notice that a length of 30 is */
/* provided for the $country format. The default       */
/* would be 40.                                        */
/*******************************************************/ 

proc format library=orion.MyFmts;
   value $extra   ' '='Unknown'
                other=[$country30.];
run;

title;

proc format library=orion.MyFmts fmtlib;
   select $country $extra;
run;

