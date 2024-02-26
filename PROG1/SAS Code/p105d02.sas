proc print data=orion.sales label;
	var Employee_ID Job_Title Salary 
 		 Country Birth_Date Hire_Date;
   label Employee_ID='Sales ID'
         Job_Title='Job Title'
         Salary='Annual Salary'
         Birth_Date='Date of Birth'
         Hire_Date='Date of Hire';
   format Salary dollar10.0
          Birth_Date Hire_Date monyy7.;
run;

