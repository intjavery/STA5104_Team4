 /****************************************************************/
 /* The INFILE statement uses a Microsoft Windows path.          */
 /*                                                              */
 /* For UNIX, Linux, SAS University Edition, and SAS on Demand:  */
 /*      Change the INFILE statement to:                         */
 /*           infile "&path/newemps.csv" dlm=',';                */
 /*                                                              */
 /* For  z/OS:                                                   */
 /*      Change the INFILE statement to:                         */
 /*            infile "&path..rawdata(newemps)" dlm=',';         */
 /****************************************************************/

data work.newsalesemps;
   length First_Name $ 12 Last_Name $ 18
          Job_Title $ 25;
   infile "&path\newemps.csv" dlm=',';   
   input First_Name $ Last_Name $  
         Job_Title $ Salary /*numeric*/;
run;

proc print data=work.newsalesemps;
run;
/*
proc means data=work.newsalesemps;
   var Salary;
run;
*/
