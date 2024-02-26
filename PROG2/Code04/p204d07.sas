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

data EuropeQ1;
   infile "&path\sales.dat"; 
   input @6 Location $3. @;
   if Location = 'EUR';
   input  @1 SaleID $4.
         @10 SaleDate date9. 
         @20 Amount commax7.;
run;

proc print data=EuropeQ1 noobs;
   var SaleID Location SaleDate Amount;
run;
