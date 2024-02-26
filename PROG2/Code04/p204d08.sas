/*********************************************************************/
 /* This program uses an INFILE statement to read a raw data file.    */
 /* The INFILE statement includes a full path for Microsoft Windows.  */
 /*                                                                   */
 /* For UNIX or SAS onDemand:                                         */
 /*      Replace  the INFILE statement with the following statement:  */
 /*               infile "&path/sales.csv" dlm=',';                 */
 /*                                                                   */
 /* For  z/OS:                                                        */
 /*      Replace  the INFILE statement with the following statement:  */
 /*               infile "&path..rawdata(sales)" dlm=',';           */
 /*********************************************************************/

%let PATH = C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\Data;

data work.sales;
   length First_Name $ 12 Last_Name $ 18 
          Gender $ 1 Job_Title $ 25 
          Country $ 2;
   infile "&path\sales.csv" dlm=',';
   input Employee_ID First_Name $ Last_Name $ 
         Gender $ Salary Job_Title $ Country $;
run;

proc print data=work.sales;
   var Employee_ID First_Name Last_Name  
       Gender Salary Job_Title Country;
run;
