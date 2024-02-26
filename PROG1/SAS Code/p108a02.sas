 /****************************************************************/
 /* The INFILE statement uses a Microsoft Windows path.          */
 /*                                                              */
 /* For UNIX, Linux, SAS University Edition, and SAS on Demand:  */
 /*      Change the INFILE statement to:                         */
 /*           infile "&path/salary.dat" dlm=',';                 */
 /*                                                              */
 /* For  z/OS:                                                   */
 /*      Change the INFILE statement to:                         */
 /*            infile "&path..rawdata(salary)" dlm=',';          */
 /****************************************************************/

   /* Part 1 - using colon format modifiers*/
data work.salaries;
	infile "&path\salary.dat";
	input Name $ HireDate :date. Age State $ Salary :comma.;
run;

proc print data=work.salaries;
run;

  /* Part 2 - omit the colon format modifier for Salary */
data work.salaries;
	infile "&path\salary.dat";
	input Name $ HireDate :date. Age State $ Salary comma.;
run;

proc print data=work.salaries;
run;
