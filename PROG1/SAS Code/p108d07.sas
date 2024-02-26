 /****************************************************************/
 /* The INFILE statement uses a Microsoft Windows path.          */
 /*                                                              */
 /* For UNIX, Linux, SAS University Edition, and SAS on Demand:  */
 /*      Change the INFILE statement to:                         */
 /*           infile "&path/sales.csv" dlm=',';                  */
 /*                                                              */
 /* For  z/OS:                                                   */
 /*      Change the INFILE statement to:                         */
 /*            infile "&path..rawdata(sales)" dlm=',';           */
 /****************************************************************/

%let PATH = C:\Users\Morgan31955\Desktop\2017\UCFDocuments\STA5104\SAS_PG01\Data;

data work.sales;
   infile "&path\sales.csv" dlm=',';   
   input Employee_ID First_Name :$12. Last_Name :$18. 
         Gender :$1. Salary Job_Title :$25. 
         Country :$2. Birth_Date :date. Hire_Date :mmddyy.;
   if Country='AU';
   keep First_Name Last_Name Salary 
        Job_Title Hire_Date;
   label Job_Title='Sales Title'
         Hire_Date='Date Hired';
   format Salary dollar12. Hire_Date monyy7.;
run;

proc print data=work.sales label;
run;
