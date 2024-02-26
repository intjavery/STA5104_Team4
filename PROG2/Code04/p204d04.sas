/*********************************************************************/
 /* This program uses an INFILE statement to read a raw data file.    */
 /* The INFILE statement includes a full path for Microsoft Windows.  */
 /*                                                                   */
 /* For UNIX or SAS onDemand:                                         */
 /*      Replace  the INFILE statement with the following statement:  */
 /*               infile "&path/sales.dat";                 */
 /*                                                                   */
 /* For  z/OS:                                                        */
 /*      Replace  the INFILE statement with the following statement:  */
 /*               infile "&path..rawdata(sales)";           */
 /*********************************************************************/
%let PATH = C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\Data;

data salesQ1;
   infile "&path\sales.txt";  
   input SaleID $4. @6 Location $3.;
   if Location='USA' then
       input @10 SaleDate mmddyy10. 
             @20 Amount 7.;
   else if Location='EUR' then
       input @10 SaleDate date9. 
             @20 Amount commax7.;
run;

proc print data=salesQ1 noobs;
run;
