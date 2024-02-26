/*********************************************************************/
/* This program uses an INFILE statement to read a raw data file.    */
/* The INFILE statement includes a full path for Microsoft Windows.  */
/*                                                                   */
/* For UNIX                                                          */
/*      Replace  the INFILE statement with the following statement:  */
/*               infile "&path/emps.dat" firstobs=11 obs=15;         */
/*                                                                   */
/* For  z/OS:                                                        */
/*      Replace  the INFILE statement with the following statement:  */
/*               infile "&path..rawdata(emps)" firstobs=11 obs=15;   */
/*********************************************************************/
libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData";
%let PATH = C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\Data;  
/* Use FIRSTOBS= and OBS= in an INFILE statement */
proc contents data=orion.employees;
run;
data employees;
  infile "&path\emps.csv" firstobs=10 obs=15 dsd ;
  length Name $40. Street_Name $30. City $30.;
  input Employee_ID	
		Name	$
		Street_Number	
		Street_Name	$
		City	$
		State	$
		Postal_Code	$
		Country	$
		Job_Title	$
		Department	$
		Manager_ID	
		Gender	$
		Salary	
		Birth_Date	
		Hire_date	
		Term_date	
		Marital_Status	$
		Dependents;
run;
proc print data=employees;
run;
