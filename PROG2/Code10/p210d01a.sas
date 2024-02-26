/*********************/
/*  p307d01a         */
/*********************/
libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

/* Step 1         */
/* Make country   */

data country;
   keep Start Label FmtName;
   FmtName='$country';
   set orion.country;
   Start=Country;
   Label=Country_Name;
run;


proc print data=country noobs;
   title 'Country';
run;

/* Step 2        */
/* Make $country */

proc format library=orion.MyFmts cntlin=country fmtlib;
   select $country;
run;


/*******************************************************/
/* If there are missing country values, they can be    */
/* handled by creating the format $Extra.  This format */
/* specifically sets missing values to the label       */
/* Unknown and uses the label of the $Country format   */
/* for all other values. Notice that a length of 30 is */
/* provided for the $country format. The default       */
/* would be 40.                                        */
/*******************************************************/ 

proc format library=orion.MyFmts cntlin=country fmtlib;
   value $extra ' '='Unknown'
                other=[$country30.];
   select $country $extra;
   title '$country format with missing';
run;

proc catalog cat=orion.MyFmts;
   contents;
quit;

proc format library=orion.MyFmts fmtlib;
   select $country;
run;

title;

