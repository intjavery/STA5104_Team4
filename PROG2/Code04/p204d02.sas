/*********************************************************************/
 /* This program uses an INFILE statement to read a raw data file.    */
 /* The INFILE statement includes a full path for Microsoft Windows.  */
 /*                                                                   */
 /* For UNIX or SAS onDemand:                                         */
 /*      Replace  the INFILE statement with the following statement:  */
 /*               infile "&path/address.dat";                 */
 /*                                                                   */
 /* For  z/OS:                                                        */
 /*      Replace  the INFILE statement with the following statement:  */
 /*               infile "&path..rawdata(address)";           */
 /*********************************************************************/

data contacts;
   input FullName $30.;
   input;
   input Address2 $25.;
   input Phone $8. ; 
datalines;
Ms. Sue Farr
      
Macon, GA  31298     
869-7008
Dr. Kay B. Cox  
  
Kern, CA  93280      
483-3321
Mr. Ron Mason  
   
Miami, FL  33054     
589-9030
Ms. G. H. Ruth    

Munger, MI  48747    
754-3582
run;

proc print data=contacts noobs;
run;
