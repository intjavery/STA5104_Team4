*----------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 4: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 05                                                              |
| Due: 02/27/24                                                              |
*----------------------------------------------------------------------------*;

%let PATH = ~/ASS05/;
LIBNAME ASS05 "/home/u63737872/ASS05";

/*Problem 1. Writing Observations Explicitly
The orion.prices data set contains price information for Orion Star products.*/

/*a.   Write a DATA step to create a new data set that forecasts unit prices for the next three years. This data set contains three observations for each input observation read from orion.prices.
•    Open file p202e01. It reads orion.prices and creates a new data set named work.price_increase. 
•    Use explicit OUTPUT statements to forecast unit prices for the next three years, using Factor as the annual rate of increase. */

DATA work.price_increase;
	SET ASS05.prices;
	
	Year = 1;
	Unit_Price = Unit_Price * (Factor);
	OUTPUT;
	
	Year = 2;
	Unit_Price = Unit_Price * (Factor);
	OUTPUT;
	
	Year = 3;
	Unit_Price = Unit_Price * (Factor);
	OUTPUT;
RUN;

/*b.   Print the new data set.
•    Include only Product_ID, Unit_Price, and Year in the report. 
•    Verify your results.*/

PROC PRINT DATA=work.price_increase (KEEP = Product_ID Unit_Price Year);
RUN;


/*Problem 2. Writing Observations Explicitly
The data set orion.discount contains information about various discounts that Orion Star runs on its products.*/

/*a.	Due to excellent sales, all discounts from December 2011 are repeated in July 2012. Both the December 2011 and the July 2012 discounts are called the Happy Holidays promotion. 
•	Create a new data set named work.extended that contains all discounts for the Happy Holidays promotion.
•	Use a WHERE statement to read-only observations with a start date of 01Dec2011.
•	Create a new variable, Promotion, which has the value Happy Holidays for each observation.
•	Create another new variable, Season, that has a value of Winter for the December observations
•	Use an explicit OUTPUT statement to write the December observations.
•	Specify a new start date of 01Jul2012 and an end date of 31Jul2012 for the July 2012 discounts.
•	For the July observations, overwrite value for Season with Summer.
•	Use an explicit OUTPUT statement to write the July observations.
•	Drop the Unit_Sales_Price variable. 
*/


DATA work.extended;
	SET ASS05.discount;
	WHERE Start_Date = '01Dec2011'd;
	Promotion = 'Happy Holidays';
	Season = 'Winter';
	OUTPUT;
	
	Start_Date = '01Jul2012'd;
	End_Date = '31Jul2012'd;
	Season = 'Summer';
	OUTPUT;
	DROP Unit_Sales_Price;
RUN;

/*b.	Print the new data set.
•	Add an appropriate title
•	Verify the results.
Partial PROC PRINT (332 Total Observations) */

TITLE 'Holiday Discounts for December 2011 & July 2012';
PROC PRINT DATA=work.extended;
RUN;


/*Problem 3. Creating Multiple SAS Data Sets
The data set orion.employee_organization contains information about employee job titles, departments, and managers.*/

/*a.	Create a separate data set for each department.
Name the data sets work.admin, work.stock, and work.purchasing.
Use conditional logic and explicit OUTPUT statements to write to these data sets depending on whether the value of Department is Administration, Stock & Shipping, or Purchasing, respectively. Ignore all other Department values. 
Hint: Be careful with capitalization and the spelling of the Department values.*/


DATA work.admin work.stock work.purchasing;
	SET ASS05.employee_organization;
	
	IF Department = 'Administration'
	THEN OUTPUT work.admin;
	
	ELSE IF Department = 'Stock & Shipping'
	THEN OUTPUT work.stock;
	
	ELSE IF Department = 'Purchasing'
	THEN OUTPUT work.purchasing;
RUN;

/*b.	Print work.admin and verify your results. Add an appropriate title.*/
TITLE 'Administration Department';
PROC PRINT data=work.admin;
RUN;

/*c.    Print work.stock and verify your results. Add an appropriate title.*/
TITLE 'Stock & Shipping Department';
PROC PRINT DATA=work.stock;
RUN;

/*d.    Print work.purchasing and verify your results. Add an appropriate title.*/
TITLE 'Purchasing Department';
PROC PRINT DATA=work.purchasing;
RUN;

/*Problem 4. Creating Multiple SAS Data Sets
The data set orion.orders contains information about in-store, catalog, and Internet orders 
as well as delivery dates.*/

/*a.	Orion Star wants to study catalog and Internet orders that were delivered quickly, as well 
as those that went slowly. 
•	Create three data sets named work.fast, work.slow, and work.veryslow.
•	Write a WHERE statement to read only the observations with Order_Type equal 
to 2 (catalog) or 3 (Internet). 
•	Create a variable named ShipDays that is the number of days between when the order 
is placed and when the order is delivered. 
•	Handle the output as follows:
–	Output to work.fast when the value of ShipDays is less than 3.
–	Output to work.slow when the value of ShipDays is 5 to 7.
–	Output to work.veryslow when the value of ShipDays is greater than 7. 
–	Do not output an observation when the value of ShipDays is 3 or 4. 
•	Drop the variable Employee_ID.
•	There should be 80 observations in work.fast, 69 observations in work.slow, and 5 observations in work.veryslow. 
*/

DATA work.fast work.slow work.veryslow;
	SET ASS05.orders;
	
	WHERE Order_Type = 2 OR 3;
	ShipDays = Delivery_Date - Order_Date;
	
	IF ShipDays < 3
	THEN OUTPUT work.fast;
	
	ELSE IF Ship_Days >= 5 AND <= 7
	THEN OUTPUT work.slow;
	
	ELSE IF Ship_Days > 7
	THEN OUTPUT work.veryslow;
	
	DROP Employee_ID;
RUN;

/*Successfully shows 80 obs:
PROC PRINT data=work.fast;
RUN;

Successfully shows 69 obs:
PROC PRINT data=work.slow;
RUN;*/

/*b.	Print your results from work.veryslow with an appropriate title.*/

TITLE 'Very Slow Shipping Time in Days';
PROC PRINT data=work.veryslow;
RUN;
	

/*Problem 5. Using a SELECT Group 
Write a solution to the previous exercise using SELECT logic instead of IF-THEN/ELSE logic. Refer to SAS documentation to explore the use of a compound expression in a SELECT statement. Print the data set work.veryslow. */

DATA work.fast work.slow work.veryslow;
	SET ASS05.orders;
	
	WHERE Order_Type = 2 OR 3;
	ShipDays = Delivery_Date - Order_Date;
	DROP Employee_ID;
	
	SELECT;
		WHEN (ShipDays < 3) OUTPUT work.fast;
		WHEN (ShipDays >= 5 AND <= 7) OUTPUT work.slow;
		WHEN (ShipDays > 7) OUTPUT work.veryslow;
		OTHERWISE;
	END;
RUN;


TITLE 'Very Slow Shipping Time in Days';
PROC PRINT DATA=work.veryslow;
RUN;


/*Problem 6. Specifying Variables and Observations
The data set orion.orders contains information about in-store, catalog, and Internet orders 
as well as delivery dates.*/

/*a.    Create two data sets, work.instore and work.delivery, to analyze in-store sales.
•	Use a WHERE statement to read-only observations with Order_Type equal to 1. 
•	Create a variable ShipDays that is the number of days between when the order was placed and when the order was delivered. 
•	Output to work.instore when ShipDays is equal to 0.
•	Output to work.delivery when ShipDays is greater than 0. 
•	The work.instore data set should contain three variables (Order_ID, Customer_ID, and Order_Date). 
The work.delivery data set should contain four variables (Order_ID, Customer_ID, Order_Date, and ShipDays).
•	Test this program by reading the first 30 observations that satisfy the WHERE statement. Check the SAS log to verify that no warnings or errors were reported.*/

DATA work.instore (KEEP = Order_ID Customer_ID Order_Date)
	work.delivery (KEEP = Order_ID Customer_ID Order_Date ShipDays);
	SET ASS05.orders (OBS = 30);
	
	WHERE Order_Type = 1;
	ShipDays = Delivery_Date - Order_Date;
	
	SELECT;
		WHEN (ShipDays = 0) OUTPUT work.instore;
		WHEN (ShipDays > 0) OUTPUT work.delivery;
		OTHERWISE;
	END;
RUN;
		

/*b.    Modify the program to read the full orion.orders data set. Of the 490 observations in orion.orders, only 260 are read due to the WHERE statement.*/

DATA work.instore (KEEP = Order_ID Customer_ID Order_Date)
    work.delivery (KEEP = Order_ID Customer_ID Order_Date ShipDays);
    SET ASS05.orders;
    
    WHERE Order_Type = 1;
    ShipDays = Delivery_Date - Order_Date;
  
	SELECT;
		WHEN (ShipDays = 0) OUTPUT work.instore;
		WHEN (ShipDays > 0) OUTPUT work.delivery;
		OTHERWISE;
	END;
RUN;


/*c.    Print your results from work.delivery with an appropriate title.*/

TITLE 'Deliveries From In-Store Purchases';

PROC PRINT DATA=work.delivery;
RUN;

/*d.    Use PROC FREQ to display the number of orders per year in work.instore. Add an appropriate title.
Hint:    Format the variable Order_Date with a YEAR. format. Restrict the analysis to the variable Order_Date with a TABLES statement.*/

TITLE 'Number of Orders Per Year for In-store Purchases';

PROC FREQ DATA=work.instore;

	FORMAT Order_Date YEAR.;
	TABLES Order_Date;

RUN;