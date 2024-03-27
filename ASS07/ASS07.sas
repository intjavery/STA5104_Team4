*----------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 4: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 07                                                              |
| Due: 03/13/24                                                              |
*----------------------------------------------------------------------------*;

%let PATH = ~/ASS07/;
LIBNAME ASS07 "/home/u63737872/ASS07";

/*Problem 1. Extracting Characters Based on Position
The data set orion.newcompetitors has data on competing retail stores that recently opened near existing 
Orion Star locations.

a.   Orion Star would like a data set containing only the small retail stores from these observations. 
•	Create a new variable, Country, that contains the first two characters of ID.
•	Create a new variable, Store_Code, that contains the other characters from the value in ID. 
Left-justify the value so that there are no leading blanks.
•	The first character in the value of Store_Code indicates the size of the store, 
and 1 is the code for a small retail store.  
•	Write a program to output only the small retail store observations. 
Hint: You might need to use a SUBSTR functions as part of a subsetting IF statement
•	Make sure that the City values appear in proper case (as displayed below).*/

DATA work.smallstores;
	SET ASS07.newcompetitors;
	Country = SUBSTR(ID, 1, 2);
	Store_Code = SUBSTR(ID, 3);
	Store_Code = LEFT(Store_Code);
	City = PROPCASE(City);
	IF SUBSTR(Store_Code, 1, 1) = "1";
RUN;
	
/*b.   Print your results with an appropriate title. 
Show these columns only once: Store_Code, Country, City, and Postal_Code.*/

	TITLE "New Small-Store Competitors";	
PROC PRINT DATA=work.smallstores NOOBS;
    VAR Store_Code Country City Postal_Code;
RUN;


/*Problem 2. Converting U.S. Postal Codes to State Names
The data set orion.contacts contains a list of contacts for the U.S. charities that Orion Star donates to.

a.	Create a new data set named states that includes the variables ID and Name as well as a new variable named Location that shows the full name in proper case for the state that the contact is based in.
Hint:	Address2 is 24 characters long and the last item in Address2 is always the ZIP code.   ZIPNAMEL is a function that you like to use.*/

DATA states;
    SET ASS07.contacts;
     /* Extract ZIP code from Address2 */
    ZIP_Code = SUBSTR(Address2, LENGTH(Address2)-4);

    /* Call ZIPNAMEL function to get state name */
    Location = ZIPNAMEL(ZIP_Code);
    
    DROP ZIP_Code Title Address1 Address2;
RUN;

*b.	Print your results;
PROC PRINT DATA=states NOOBS;
    TITLE 'Contacts with Full State Names';
RUN;


/*Problem 3. Searching Character Values and Explicit Output
•	The data set orion.employee_donations contains information about charity contributions from Orion Star employees. 
•	Each employee is allowed to list either one or two charities, which are shown in the Recipients variable.

a.   Use explicit output to create a data set named work.split.
•	The data set has one observation for each combination of employee and charity to which he donated. 
•	Some employees made two contributions. Therefore, they have two observations in the output data set. 
These employees contain a % character in the value of Recipients.
Hint:	Store the position where the % character is found in a variable named PctLoc. 
This can make subsequent coding easier.
•	Create a variable named Charity with the name and percent contribution of the appropriate charity. 
•	Read only the first 10 observations from orion.employee_donations to test your program.*/

DATA work.split;
	SET ASS07.employee_donations (obs=10);
	LENGTH Charity $ 50.;
	
	IF INDEX(Recipients, '%') > 0 THEN DO;
		PctLoc = FIND(Recipients, '%');
		Charity = SUBSTR(Recipients, 1, PctLoc);
		OUTPUT;
		
		Charity = SUBSTR(Recipients, PctLoc, +2);
		OUTPUT;
	END;
	
	ELSE DO;
		Charity = Recipients;
		OUTPUT;
	END;
RUN;

PROC PRINT DATA=work.split NOOBS;
	VAR Employee_ID Charity;
RUN;


/*b.   Modify the program to read the entire orion.employee_donations data set. 
•	Print only the columns Employee_ID and Charity. 
•	Add an appropriate title.*/

DATA work.split;
    SET ASS07.employee_donations;
    LENGTH Charity $100.;
    
    IF INDEX(Recipients, '%') > 0 THEN DO;
        PctLoc = FIND(Recipients, '%');
        Charity = SUBSTR(Recipients, 1, PctLoc);
        OUTPUT;
        
        Charity = SUBSTR(Recipients, PctLoc + 2);
        OUTPUT;
    END;
    ELSE DO;
        Charity = Recipients;
        OUTPUT;
    END;
RUN;

TITLE 'Charity Contributions for each Employee';
PROC PRINT DATA=work.split NOOBS;
VAR Employee_ID Charity;
RUN;

/*Problem 4. Calculating Statistics and Rounding
The data set orion.orders_midyear contains an observation for each customer, 
with the total retail value of the customer’s monthly orders for the first half of the year.  

a.	Create a data set named work.sale_stats with three new variables for all months in which the customer placed an order.
•	The variable MonthAvg should contain the average.
•	The variable MonthMax should contain the maximum. 
•	The variable MonthSum should contain the sum of values.
•	Round MonthAvg to the nearest integer.*/

DATA work.sale_stats;
  SET ASS07.orders_midyear;

    MonthAvg= ROUND(MEAN(OF Month1-Month6));
    MonthMax= MAX(OF Month1-Month6);
    MonthSum= SUM(OF Month1-Month6);

RUN;

/*Print your results with an appropriate title.*/
TITLE'Statistics on Months in which the Customer Placed an Order';

PROC PRINT DATA= work.sale_stats NOOBS;
    VAR Customer_ID MonthAvg MonthMax MonthSum;
    FORMAT MonthAvg 8. MonthMax DOLLAR12.2 MonthSum DOLLAR12.2;
RUN;

TITLE;

/*b.	Print the variables Customer_ID, MonthAvg, MonthMax, and MonthSum. Add an appropriate title.*/

TITLE "Statistics on Months in which Customer Placed an Order";
PROC PRINT DATA=work.sale_stats NOOBS;
	VAR Customer_ID MonthAvg MonthMax MonthSum;
RUN;

/*Problem 5. Calculating Statistics for Missing, Median, and Highest Values
The data set orion.orders_midyear contains an observation for each customer, with 
the total retail value of the customer’s monthly orders for the first half of the year.  

a.   Orion Star wants to look at information about the median order and the top two months’ orders, 
but only for frequent customers.
•	Create a data set named work.freqcustomers that contains the requested statistics. 
•	Frequent customers are defined to be those who placed an order in at least five of the six months.*/

DATA work.freqcustomers;
    SET ASS07.orders_midyear;
    Frequent = N(of Month1-Month6);
    IF Frequent >= 5 THEN DO;
        Median = MEDIAN(of Month1-Month6);
        Highest = MAX(of Month1-Month6);
        Second_Highest = LARGEST(2, of Month1-Month6);
    END;
    ELSE DELETE;
    DROP Frequent;
RUN;

*b.   Print your results with an appropriate title.;

TITLE'Month Statistics on Frequent Customers';
PROC PRINT DATA= work.freqcustomers NOOBS;


/*Problem 6 Changing a Variable’s Data Type (4 Points)
The data set orion.US_newhire contains information about newly hired employees.

a.	Create a new data set from orion.US_newhire.
•	Name the new data set US_converted.
•	Remove the embedded hyphens in ID. 
•	Convert ID to a numeric value. 
•	Convert Telephone to character and place a – (hyphen or dash) between the third and fourth digits.
•	Convert Birthday to a SAS date value.*/

DATA work.US_converted (DROP=ID Telephone);
  SET ASS07.US_newhire;
  
  ID_Num = INPUT(COMPRESS(ID,'-'),15.);
  length Telephone_Char $8;
  Telephone_Char= CAT(SUBSTR(PUT(Telephone, 7.), 1, 3), '-', SUBSTR(PUT(Telephone, 7.), 4));
  Birthday=INPUT(Birthday, DATE9.);
  RENAME ID_Num=ID Telephone_Char = Telephone;
  
RUN;

/*b.	Print US_converted with an appropriate title and use PROC CONTENTS to check the variables types.*/

TITLE'US New Hires';
PROC PRINT DATA= work.US_converted NOOBS;
	VAR ID Telephone Birthday;
RUN;

TITLE;
  
PROC CONTENTS DATA= work.US_converted;
RUN;

