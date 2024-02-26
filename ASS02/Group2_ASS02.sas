/*---------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 2: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 02                                                              |
| Due: 1/30/24                                                               |
*----------------------------------------------------------------------------*/

%let PATH = ~/ASS02/;
LIBNAME ASS02 "/home/u63737872/ASS02";

/*
=========
 PART I    
=========

/* PB1: Use data step to read the SAS data set “customer_dim” and to create a SAS data set called “work.youngadult”.
Use “keep statement” to keep just five variables: Customer_Name, Customer_Age, Customer_BirthDate, Customer_Gender,
and Customer_Group. Use “where” statement to select only female customer in “Gold” group between 18 and 36 years old. */


DATA work.youngadult;
	SET ASS02.customer_dim;
	KEEP Customer_Name Customer_Age Customer_BirthDate Customer_Gender Customer_Group;
	WHERE Customer_Gender = 'F' AND Customer_Group CONTAINS 'Gold'
		AND Customer_Age BETWEEN 18 AND 36;
RUN;
	
/* PB2: Use data step to read the SAS data set “product_dim” and to create a SAS data set called “work.sports”.  
Use “drop” statement to drop variables: Product_ID, Product_Line, Product_Group, Supplier_Name, and Supplier_ID.  
Only select “sports” products from country 'GB', 'ES', or 'NL'. */

DATA work.sports;
	SET ASS02.product_dim;
	DROP Product_ID Product_Line Product_Group Supplier_Name Supplier_ID;
	WHERE Product_Category CONTAINS 'Sports'
		AND Supplier_Country in ('GB' 'ES' 'NL');
RUN;
		

/* PB3: Use data step to read the SAS data set “customer_dim” and to create a SAS data set called “work.tony”.  
Only select customer name sounds like “Tony” and to keep two variables Customer_FirstName and Customer_LastName. */


DATA work.tony;
	SET ASS02.customer_dim;
	WHERE Customer_FirstName LIKE 'To%';
	KEEP Customer_FirstName Customer_LastName;
RUN;


/* PB4: Repeat PB1 by adding a permanent label and format for all variables. */

DATA work.youngadult;
    SET ASS02.customer_dim;
    KEEP Customer_Name Customer_Age Customer_BirthDate Customer_Gender Customer_Group;
    WHERE Customer_Gender = 'F' AND Customer_Group CONTAINS 'Gold'
        AND Customer_Age BETWEEN 18 AND 36;
	LABEL Customer_Name = 'Customer Name'
	Customer_Age = 'Customer Age'
    Customer_BirthDate = 'Customer Birth Date'
    Customer_Gender = 'Customer Gender'
    Customer_Group = 'Customer Group';

    FORMAT Customer_Name $32.
    Customer_Age $3.
	Customer_BirthDate mmddyy10.
	Customer_Gender $1.
	Customer_Group $32.;
RUN;
	

/* PB5: Repeat PB2 by adding a permanent label and format for all variables. */

DATA work.sports;
	SET ASS02.product_dim;
	DROP Product_ID Product_Line Product_Group Supplier_Name Supplier_ID;
	WHERE Product_Category CONTAINS 'Sports'
		AND Supplier_Country in ('GB' 'ES' 'NL');
		
	LABEL Product_Category = 'Product Category'
	Product_Name = 'Product Name'
	Product_Country = 'Product Country';
	
	FORMAT Product_Category $32.
	Product_Name $32.
	Supplier_Country $2.;
RUN;
		
/* PB6: Repeat PB3 by adding a permanent label and format for all variables to look like the given output. */


DATA work.tony;
    SET ASS02.customer_dim;
    KEEP Customer_FirstName Customer_LastName;
    WHERE Customer_FirstName LIKE 'To%';
    
    LABEL Customer_FirstName = 'Customer First Name'
    Customer_LastName = 'Customer Last Name';
    
    FORMAT Customer_FirstName $32.
    Customer_LastName $32.;

PROC PRINT data=work.tony SPLIT = '*';
RUN;

/*
==========
 PART II    
==========

/* PB1: Read the SAS data set “customer” and create a data set called “work.birthday”.  
The four variables kept in “work.birthday” are Customer_Name, Birth_Date, BdayDOW2012, and Age2012 where 
BdayDOW2012 is the day of week for the birthday in 2012 and Age2012 is the age for this individual at her/his 
birthday in 2012.  You need to add label and format statements. */

DATA work.birthday;
	SET ASS02.customer;
	KEEP Customer_Name Birth_Date BdayDOW2012 Age2012;
	
	/* Calculate the day of the week for the birthday in 2012 */
	Bday2012 = MDY(MONTH(Birth_Date), DAY(Birth_Date), 2012);
	BdayDOW2012 = WEEKDAY(Bday2012);
	
    /* Calculate the age at birthday in 2012 */
	Age2012 = 2012 - YEAR(Birth_Date);
	
	LABEL Customer_Name = 'Customer Name'
	Birth_Date = 'Birth Date'
	BdayDOW2012 = 'Day of Week of Birthday in 2012'
	Age2012 = 'Age in 2012';
	
	FORMAT Customer_Name $32.
	Birth_Date mmddyy10.
	BdayDOW2012 DOWNAME.
	Age2012 8.;
	
RUN;

/* PB2: Read the SAS data set “sales” and create a data set called “work.employees” that has three variables: 
Full_Name (by combining First and Last Name), Hire_Date, and Yrs2012 (number of years employeed at January 1, 2012).  
Label and format statement should be used if it is necessary.
*/

DATA work.employees;
	SET ASS02.SALES;
	Full_Name = CATX(' ', First_Name, Last_Name);	
	
	FORMAT Hire_Date DATE9.;
	Yrs2012 = INTCK('year', Hire_Date, '01JAN2012'D) - (MONTH(Hire_Date) > 1 OR (MONTH(Hire_Date) = 1 AND DAY(Hire_Date) > 1));

    LABEL Full_Name = 'Full Name'
          Hire_Date = 'Date of Hire'
          Yrs2012 = 'Years Employed as of 2012';

    FORMAT Hire_Date DATE9.
           Yrs2012 8.;
RUN;


/* PB3: Read the SAS data set “employee_donations” and create a data set called “work.bigdonations” that has all 
employees who made donation each quarter and donated more than 50 in four quarters combined. */

DATA work.bigdonations;
	SET ASS02.employee_donations;
	Total_Donations = SUM (Qtr1, Qtr2, Qtr3, Qtr4);
	
	/* Check if donations are made each quarter and the total is more than 50 */
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


/*PB4: Read the SAS data set “orders” and create a data set called “work.ordertype” that has two additional variables “Type” and “SaleAd” created using the variable “Order_Type”.  The rules for creating these variables are as follows:
•	Type = 'Catalog Sale' and SaleAd = 'Mail' if Order_Type = 1
•	Type = 'Internet Sale' and SaleAds='Email'if Order_Type = 2
•	Type = 'Retail Sale' if Order_Type = 3.  
*/

DATA work.ordertype;
	SET ASS02.orders;

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
RUN;









