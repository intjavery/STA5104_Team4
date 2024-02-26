*----------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 4: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 03                                                              |
| Due: 2/6/24                                                                |
*----------------------------------------------------------------------------*;

%let PATH = ~/ASS03/;
LIBNAME ASS03 "/home/u63737872/ASS03";

/*=========================================================
 Problem 1: Displaying Formatted Values in a Detail Report   
==========================================================*/

/* Write a PROC PRINT step to display the report below using sales as input. Subset the observations and 
variables to produce the report. Include titles, labels, and formats. The results contain 13 observations. */

PROC PRINT DATA = ASS03.sales LABEL NOOBS;
	WHERE Salary < 26000 AND Country = "US";
	VAR Employee_ID First_Name Last_Name Job_Title Salary Hire_Date;
	TITLE "US Sales Employees";
	TITLE2 "Earning Under $26,000";
	LABEL Employee_ID = "Employee ID"
		First_Name = "First Name"
		Last_Name = "Last Name"
		Job_Title = "Title"
		Salary = "Salary"
		Hire_Date = "Date Hired";
	FORMAT Salary dollar12.
		Hire_Date monyy7.;
		
RUN;

/*=========================================================
 Problem 2: Displaying Formatted Values in a Detail Report   
==========================================================*/

/*a. Execute the following SAS Code */

DATA Q1Birthdays;
	SET ASS03.employee_payroll;
	BirthMonth = MONTH(Birth_Date);
	IF BirthMonth LE 3;
	
RUN;

/*b. Add a PROC FORMAT step following the DATA step to create a character format named $GENDER */

/*c. In the same PROC FORMAT step, create a numeric format named MNAME that displays month numbers */

PROC FORMAT;
	VALUE $GENDER "F" = "Female"
				  "M" = "Male";
	VALUE MNAME 1 = "January"
				2 = "February"
				3 = "March"
				4 = "April"
				5 = "May"
				6 = "June"
				7 = "July"
				8 = "August"
				9 = "September"
				10 = "October"
				11 = "November"
				12 = "December";
				
RUN;

/*d. Add a PROC PRINT step following the PROC FORMAT step to display the Q1Birthdays data
set. Apply the two user-defined formats to the Employee_Gender and BirthMonth variables,
respectively. Include the title Employees with Birthdays in Q1, and clear the title at the end
of the program.

e. Submit the program to produce the following report. The results contain 113 observations. */

PROC PRINT DATA = Q1Birthdays;
	VAR Employee_ID Employee_Gender BirthMonth;
	TITLE "Employees with Birthdays in Q1";
	FORMAT Employee_Gender $GENDER.
		BirthMonth MNAME.;
		
RUN;

	TITLE;

/*=========================================================
 Problem 3: Defining Ranges in User-Defined Formats   
==========================================================*/

/*a. Write a PROC Print step to display the report using SAS Data set nonsales. */
PROC PRINT DATA=ASS03.nonsales;
    TITLE "Report for Non-Sales Employees";
RUN;


/* b. Create a character format named $GENDER that displays gender codes as follows:
c. Create a numeric format named SALRANGE that displays salary ranges as follows */

PROC FORMAT;
	VALUE $GENDER "F" = "Female"
				  "M" = "Male"
				  OTHER = "Invalid code";
	VALUE SALRANGE	20000 -< 100000 = "Below $100,000"
					100000 - 500000 = "$100,000 or more"
					. = "Missing salary"
					OTHER = "Invalid salary";	
					
RUN;	
				  
/*d. In the PROC PRINT step, apply these two user-defined formats to the Gender and Salary variables, respectively. */

PROC PRINT DATA = ASS03.nonsales;
	VAR Employee_ID Job_Title Salary Gender;
	TITLE "Salary and Gender Values for Non-Sales Employees";
	FORMAT Gender $GENDER.
		Salary SALRANGE.;

RUN;

/*=========================================================
 Problem 4: Creating a SAS Data Set  
==========================================================*/

/*a. Write a PROC Print step to display the report using SAS Data set customer_dim.*/

PROC PRINT DATA = ASS03.customer_dim;

RUN;

/*b. Add a DATA step before the PROC PRINT step to create a new data set named work.youngadult. 
Use the data set orion.customer_dim as input. Include a WHERE statement to select only female customers */

DATA work.youngadult;
	SET ASS03.customer_dim;
	WHERE Customer_Gender = "F";

RUN; 

/* Submit the program and confirm that work.youngadult was created with 30 observations and 11 variables. */

PROC PRINT DATA=work.youngadult;
  
RUN;

/*c. Modify the program to select female customers whose ages are between 18 and 36. Submit the
program and confirm that work.youngadult was created with 15 observations and 11 variables. */

DATA work.youngadult;
	SET ASS03.customer_dim;
	WHERE Customer_Gender = "F" 
	AND Customer_Age BETWEEN 18 AND 36;

RUN;

/*d. Modify the program to select 18- to 36-year-old female customers who have the word Gold in
their Customer_Group values. */


DATA work.youngadult;
	SET ASS03.customer_dim;
	WHERE Customer_Gender = "F" 
	AND Customer_Age BETWEEN 18 AND 36
	AND Customer_Group CONTAINS "Gold";
	
RUN;


/*e. Add an assignment statement to the DATA step to create a new variable, Discount, and assign it
a value of .25*/

DATA work.youngadult;
	SET ASS03.customer_dim;
	WHERE Customer_Gender = "F" 
	AND Customer_Age BETWEEN 18 AND 36
	AND Customer_Group CONTAINS "Gold";
	Discount = 0.25;

RUN;

/*f. Modify the PROC PRINT step to print the new data set as shown below. Use an ID statement to
display Customer_ID instead of the Obs column. Results should contain five observations.*/

PROC PRINT DATA = work.youngadult;
	ID Customer_ID;
	VAR Customer_ID Customer_Name Customer_Age Customer_Gender Customer_Group Discount;

RUN;

/*=========================================================
 Problem 5: Creating a SAS Data Set  
==========================================================*/

/*a. Write a DATA step to create a new data set named work.assistant.
Use the data set staff as input.*/
DATA work.assistant;
	SET ASS03.staff;
	
RUN;	

/*b. The work.assistant data set should contain only the observations where Job_Title contains
Assistant and Salary is less than $26,000 */
DATA work.assistant;
	SET ASS03.staff;	
	WHERE Job_Title CONTAINS "Assistant"
	AND Salary < 26000;

RUN;



/*b. The work.assistant data set should contain only the observations where Job_Title contains
Assistant and Salary is less than $26,000*/

DATA work.assistant;
	SET ASS03.staff;
	WHERE Job_Title CONTAINS 'Assistant' 
	AND Salary < 26000;
	
RUN;

/*c. Create two new variables, Increase and New_Salary.
- Increase is Salary multiplied by 0.10.
- New_Salary is Salary added to Increase. */

DATA work.assistant;
	SET ASS03.staff;
	WHERE Job_Title CONTAINS "Assistant" 
	AND Salary < 26000;
	Increase = Salary * .10;
	New_Salary = SUM (Salary, Increase);

RUN;


/*d. Generate a detail listing report as shown below. Display Employee_ID as the identifier in place
of the Obs column. */

PROC PRINT DATA = work.assistant;
	ID Employee_ID;
	VAR Employee_ID Job_Title Salary Increase New_Salary;
	FORMAT Salary DOLLAR12.2 
		Increase DOLLAR12.2
		New_Salary DOLLAR12.2;
		
RUN;