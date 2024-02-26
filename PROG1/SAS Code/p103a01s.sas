/*********************************************************
*  1. After the DATA step, add a PROC CONTENTS step to   *
*     view the descriptor portion of work.donations.     *                 
*  2. Submit the program and review the results.         *
*  3. How many observations are in the data set?         *
*********************************************************/
 /****************************************************************/
 /* The INFILE statement uses a Microsoft Windows path.          */
 /*                                                              */
 /* For UNIX, Linux, SAS University Edition, and SAS on Demand:  */
 /*      Change the INFILE statement to:                         */
 /*           infile "&path/donation.dat" dlm=',';               */
 /*                                                              */
 /* For  z/OS:                                                   */
 /*      Change the INFILE statement to:                         */
 /*            infile "&path..rawdata(donation)" dlm=',';        */
 /****************************************************************/

%let path = C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Data;
data work.donations;
   infile "&path\donation.dat"; 
   input Employee_ID Qtr1 Qtr2 Qtr3 Qtr4;
   Total=sum(Qtr1,Qtr2,Qtr3,Qtr4);
run;

proc contents data=work.donations;
run;
