*----------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 4: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 04                                                              |
| Due: 02/13/24                                                                |
*----------------------------------------------------------------------------*;

%let PATH = ~/ASS04/;
LIBNAME ASS04 "/home/u63754503/Assignments/ASS04";

/* PB1: Read the SAS data set “customer” and create a data set called “work.birthday”.  
The four variables kept in “work.birthday” are Customer_Name, Birth_Date, BdayDOW2012, and Age2012 where 
BdayDOW2012 is the day of week for the birthday in 2012 and Age2012 is the age for this individual at her/his 
birthday in 2012.  You need to add label and format statements. */

DATA work.birthday;
    SET ASS04.customer;
    KEEP Customer_Name Birth_Date BdayDOW2012 Age2012;
    
    /* Calculate the day of the week for the birthday in 2012 */
    Bday2012 = MDY(MONTH(Birth_Date), DAY(Birth_Date), 2012);
    BdayDOW2012 = WEEKDAY(Bday2012);
    
    /* Calculate the age at birthday in 2012 */
    Age2012 = 2012 - YEAR(Birth_Date);
    
    LABEL Customer_Name = 'Customer Name'
    Birth_Date = 'Birth Date'
    BdayDOW2012 = 'Week Day in 2012'
    Age2012 = 'Age at the Birthday of 2012';
    
    FORMAT Customer_Name $32.
    Birth_Date date9.
    BdayDOW2012 DOWNAME.
    Age2012 3.;
    
RUN;

PROC PRINT DATA=work.birthday LABEL;
RUN;

/*PB2: Read the SAS data set “sales” and create a data set called “work.employees” that has three variables: 
Full_Name (by combining First and Last Name), Hire_Date, and Yrs2012 (number of years employeed at January 1, 2012).  
Label and format statement should be used if it is necessary.
*/

DATA work.employees;
	SET ASS04.SALES;
	KEEP FullName Hire_Date Yrs2012;
	Full_Name = CATX(' ', First_Name, Last_Name);	
	Yrs2012=INTCK('year',Hire_Date,'01JAN2012'd);
	
	FORMAT Hire_Date ddmmyy10.;
	LABEL Yrs2012='Years of Employment in 2012';
	LABEL Full_Name = "full Name";

RUN;

PROC PRINT DATA=work.employees LABEL;
   VAR FullName Hire_Date Yrs2012;
RUN;

/*PB3:Read the SAS data set “employee_donations” and create a data set called
“work.bigdonations” that has all employees who made donation each quarter and donated more
than 50 in four quarters combined.*/

DATA work.bigdonations;

SET ASS04.employee_donations;
	Total_Donations = SUM (Qtr1, Qtr2, Qtr3, Qtr4);
	
	IF Qtr1 > 0 AND Qtr2 > 0 AND Qtr3 > 0 AND Qtr4 > 0 AND Total_Donations > 50 THEN OUTPUT;


LABEL Employee_ID = 'Employee ID'
    Qtr1 = 'Quarter 1'
    Qtr2 = 'Quarter 2'
    Qtr3 = 'Quarter 3'
    Qtr4 = 'Quarter 4'
    Recipients = 'Recipients'
    Paid_By = 'Paid By'
    Total_Donations = 'Total Donations';
    
FORMAT Employee_ID 6.
    Qtr1 17.
    Qtr2 17.
    Qtr3 17.
    Qtr4 17.
    Recipients $200.
    Paid_By $32.
    Total_Donations 17.;
    
RUN;


PROC PRINT DATA=work.bigdonations LABEL;
   VAR Employee_ID Qtr1 Qtr2 Qtr3 Qtr4 Total_Donations;
RUN;

/*PB4: Read the SAS data set “staff” and create a data set called “work.increase”. The new data
set includes all employee hired after July 1, 2006 who has more than $3000 raise assume that the
rate of raise is 10%.*/

DATA work.increase;
	SET ASS04.staff;
	
	IF Emp_Hire_Date > '01JUL2006'd THEN DO;
	Raise = 0.10 * Salary;
	
	IF Raise > 3000 THEN DO;
            OUTPUT;
    END;
        ELSE delete;
	END;
	
	FORMAT Raise dollar9.1;
	
RUN;

PROC PRINT DATA=work.increase SPLIT='';
   VAR Employee_ID Start_Date Job_Title Salary Emp_Hire_Date Raise;
RUN;

/*PB5: Read the SAS data set “orders” and create a data set called “work.ordertype” that has two
additional variables “Type” and “SaleAd” created using the variable “Order_Type”. The rules
for creating these variables are as follows:
 Type = 'Catalog Sale' and SaleAd = 'Mail' if Order_Type = 1
 Type = 'Internet Sale' and SaleAds='Email'if Order_Type = 2
 Type = 'Retail Sale' if Order_Type = 3.
*/

DATA work.ordertype;
	SET ASS04.orders;
	LENGTH Type $13 SaleAd $5;

    IF Order_Type = 1 THEN DO;
        Type = 'Catalog Sale';
        SaleAd = 'Mail';
   END;
   ELSE IF Order_Type = 2 THEN DO;
        Type = 'Internet Sale';
        SaleAd = 'Email';
   END;
   ELSE IF Order_Type = 3 THEN DO;
        Type = 'Retail Sale';
        SaleAd = '';
   END;
   DROP Order_Type Employee_ID Customer_ID;
RUN;

PROC PRINT DATA=work.ordertype;
RUN;



