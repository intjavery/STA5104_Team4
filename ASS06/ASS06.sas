*----------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 4: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 06                                                              |
| Due: 03/6/24                                                               |
*----------------------------------------------------------------------------*;

%let PATH = ~/ASS06/;
LIBNAME ASS06 "/home/u63737872/ASS06";

/* Problem 1. Creating Accumulating Totals  
The data set orion.order_fact contains information about orders for several years, sorted by Order_Date. 
Each observation represents one order, and Total_Retail_Price contains the sales value for the order.*/

/*a.   Orion Star would like to examine growth in sales during the date range of 01Nov2008 to 14Dec2008. 
•	Open file p203e01. It creates and prints a data set named work.mid_q4 from orion.order_fact. 
The DATA step uses the following WHERE statement to read only the observations in the specified date range:
•	Modify the program to create an accumulating total, Sales2Dte, to display the sales-to-date total. 
•	Also create an accumulating variable, Num_Orders, indicating how many orders-to-date that total represents. 
Each observation counts as one order.*/

DATA work.mid_q4;
  SET ASS06.order_fact;
	RETAIN Sales2Dte 0 Num_Orders 0;
	Sales2Dte + Total_Retail_Price;
	Num_Orders + 1;
    WHERE '01nov2008'd <= Order_Date <= '14dec2008'd;
RUN;

/* b.   Modify the PROC PRINT step to show your results.
•	Display Sales2Dte with a DOLLAR10.2 format. 
•	Show only the columns Order_ID, Order_Date, Total_Retail_Price, Sales2Dte, and Num_Orders. */

TITLE 'Orders from 01Nov2008 through 14Dec2008';
PROC PRINT DATA=work.mid_q4;
  FORMAT Sales2Dte Dollar10.2;
  VAR Order_ID Order_Date Total_Retail_Price Sales2Dte Num_Orders;
RUN;
TITLE;

/* Problem 2. Creating Accumulating Totals with Conditional Logic 
The data set orion.order_fact contains a group of orders across several years, sorted by Order_Date.*/

/*a.	Orion Star would like to analyze 2009 data by creating accumulating totals for the number 
of items sold from retail, catalog, and Internet channels. 
•	The value of Order_Type indicates whether the sale was retail (=1), catalog (=2), 
or Internet (=3). 
•	Create a data set named work.typetotals with accumulating totals for TotalRetail, TotalCatalog, and TotalInternet, as described above.
The variable Quantity contains the number of items sold for each order.
•	For testing your program in this step, read only the first 10 observations that satisfy the WHERE statement. 
Remember to process only those rows where Order_Date occurs in 2009.*/

DATA work.typetotals;
    SET ASS06.order_fact;
    WHERE YEAR(Order_Date) = 2009;
    RETAIN TotalRetail 0 TotalCatalog 0 TotalInternet 0;
    
    IF Order_Type = 1 THEN TotalRetail + Quantity;
    ELSE IF Order_Type = 2 THEN TotalCatalog + Quantity;
    ELSE IF Order_Type = 3 THEN TotalInternet + Quantity;

RUN;

PROC PRINT DATA=work.typetotals (obs=10);
RUN;

/*b.	Continue testing your program by printing the results from part a. 
Print all the variables and verify that the program is correctly calculating values for the accumulating totals.*/

DATA work.typetotals;
    SET ASS06.order_fact;
    WHERE YEAR(Order_Date) = 2009;
    RETAIN TotalRetail 0 TotalCatalog 0 TotalInternet 0;
    
    IF Order_Type = 1 THEN TotalRetail + Quantity;
    ELSE IF Order_Type = 2 THEN TotalCatalog + Quantity;
    ELSE IF Order_Type = 3 THEN TotalInternet + Quantity;

RUN;

PROC PRINT DATA=work.typetotals;
RUN;

/*c.	When the results from parts a and b are correct, do the following: 
•	Modify the program to read all observations satisfying the WHERE statement. The resulting report contains 90 observations.
•	Keep only the variables Order_Date, Order_ID,  TotalRetail, TotalCatalog, and TotalInternet. 
•	Print your results with an appropriate title.*/

DATA work.typetotals;
    SET ASS06.order_fact;
    WHERE YEAR(Order_Date) = 2009;
    RETAIN TotalRetail 0 TotalCatalog 0 TotalInternet 0;
    
    IF Order_Type = 1 THEN TotalRetail + Quantity;
    ELSE IF Order_Type = 2 THEN TotalCatalog + Quantity;
    ELSE IF Order_Type = 3 THEN TotalInternet + Quantity;
    
    KEEP Order_Date Order_ID TotalRetail TotalCatalog TotalInternet;
RUN;

TITLE "Accumulating Sales Totals by Order Type for 2009";
PROC PRINT DATA=work.typetotals;
RUN;

/* Problem 3. Creating Accumulating Totals by Month
The data set orion.order_fact contains a group of orders across several years, sorted by Order_Date.

Orion Star would like to generate the following report showing all orders in 2011 along with an accumulating total:
•	The accumulating total should reset to zero at the start of each new month. 
•	Remember to process only those rows where Order_Date occurs in 2011.*/

PROC SORT DATA=ASS06.order_fact OUT=monthtot;
    BY Order_Date;
    WHERE YEAR(Order_Date) = 2011;
RUN;

DATA monthtotals;
    SET monthtot;
    BY Order_Date;
    RETAIN MonthSales 0;
    FORMAT Order_Date DATE9.;
    FORMAT MonthSales dollar20.2;

    Month = MONTH(Order_Date);
    Year = YEAR(Order_Date);

    IF FIRST.Order_Date AND Month NE LAG(Month) THEN MonthSales = 0;
    MonthSales + Total_Retail_Price;
    OUTPUT;

    KEEP Order_Date Order_ID Total_Retail_Price MonthSales;
RUN;

PROC PRINT DATA=monthtotals;
    TITLE 'Accumulating Totals by Month in 2011';
RUN;


/* Problem 4. Summarizing Data Using the DATA Step
The data set orion.order_summary contains information about sales in a particular year for each customer, separated by month. 
For a given customer, there might be some months that he did not place an order.

a.	Sort the input data set, orion.order_summary, by Customer_ID.  Use the OUT= option to avoid overwriting the original data set. 
•	Name the output data set work.sumsort.*/

PROC SORT DATA=ASS06.order_summary OUT=work.sumsort;
	BY Customer_ID;
RUN;

PROC PRINT DATA=work.sumsort NOOBS;
RUN;

/*b.	Create a new data set showing a total sales value for each customer.
•	Name the new data set work.customers.
•	Name the new variable Total_Sales. This variable contains the total of sales across all months for each customer.*/

DATA work.customers;
	SET work.sumsort;
	BY Customer_ID;
	
	RETAIN Total_Sales 0;
	
	IF FIRST.Customer_ID THEN Total_Sales = 0;
	
	Total_Sales + Sale_Amt;
	
	IF LAST.Customer_ID THEN OUTPUT;
RUN;

/*c.	Print your result.
•	Display Total_Sales with a DOLLAR11.2 format. 
•	Add an appropriate title.*/

PROC PRINT DATA=work.customers;
    TITLE "Total Sales Value for Each Customer";
    VAR Customer_ID Total_Sales;
    FORMAT Total_Sales DOLLAR11.2;
RUN;


/*Problem 5. Summarizing and Grouping Data Using the DATA Step
The data set orion.order_qtrsum contains information about sales in a particular year for each customer, separated by month.
- For a given customer, there might be some months (and quarters) that the customer did not place an
order.
- The variable Order_Qtr contains the appropriate quarter.*/

PROC SORT DATA=ASS06.order_qtrsum;
    BY Customer_ID Order_Qtr;
RUN;

/* a) Create a data set named work.qtrcustomers that summarizes sales based on customer and quarter.
- The variable Total_Sales should contain the total sales for each quarter within each Customer_ID
value.
- Create a variable named Num_Months that counts the total months within each quarter that the
customer had an order.*/

DATA work.qtrcustomers;
    SET ASS06.order_qtrsum;
    BY Customer_ID Order_Qtr;
    RETAIN Total_Sales 0 Num_Months 0;
    
   IF FIRST.Customer_ID OR FIRST.Order_Qtr THEN DO;
       Total_Sales = 0;
       Num_Months = 0;
   END;
   
   Total_Sales + Sale_Amt;
   Num_Months + 1;

   IF LAST.Order_Qtr THEN OUTPUT;
RUN;

    
/* b) Print your results.
- Display Total_Sales with a DOLLAR11.2 format.
- Add an appropriate title.
Partial PROC PRINT Output (74 Total Observations)*/

TITLE 'Total Sales to each Customer for each Quarter'; 

PROC PRINT DATA=work.qtrcustomers (KEEP = Customer_ID Order_Qtr Total_Sales Num_Months);
    FORMAT Total_Sales DOLLAR11.2;
RUN;

/* c) Summarizing Data and Conditional Output
The data set orion.usorders04 contains a group of orders from U.S. customers.
Partial orion.usorders04 (83 Total Observations, 9 Total Variables)*/

PROC SORT DATA=ASS06.usorders04;
	BY Order_ID;
RUN;

TITLE "U.S. Customer Orders";
PROC PRINT DATA=ASS06.usorders04 NOOBS;
	VAR Order_ID Customer_ID Customer_Name Order_Type Total_Retail_Price;
	FORMAT Total_Retail_Price DOLLAR11.2;
RUN;

/* d) Orion Star wants to reward customers who spent $100 or more through any particular sales channel
(retail, catalog, or Internet).*/

DATA work.discount1 work.discount2 work.discount3;
    SET ASS06.usorders04;
    BY Customer_ID Order_Type;
    RETAIN TotSales 0;
    
   IF FIRST.Customer_ID OR FIRST.Order_Type THEN TotSales=0;
   
           TotSales + Total_Retail_Price;
           
       IF LAST.Order_Type THEN DO;    
        IF Order_Type=1 AND TotSales >=100  THEN OUTPUT work.discount1;
        ELSE IF Order_Type=2 AND TotSales >=100  THEN OUTPUT work.discount2;
        ELSE IF Order_Type=3 AND TotSales >=100  THEN OUTPUT work.discount3;
       END;
       
KEEP Customer_ID Customer_Name TotSales;

RUN;

/* e) Print your results from work.discount1.
- Format TotSales with a DOLLAR11.2 format.
-Add an appropriate title.*/
    
TITLE 'Customers Spending $100 or more in Retail Orders';
PROC PRINT DATA=work.discount1;
    FORMAT TotSales DOLLAR11.2;
RUN;

/* Problem 6. Identifying Extreme Values in Each Group of Data 
The data set orion.customer_dim contains information about Orion Star customers.

Use First./Last. processing to create the report below. Show data on the oldest and youngest customers for each Customer_Type. 
•	The variable o_ID is the Customer_ID value of the oldest customer and y_ID is the Customer_ID value of the youngest customer for each group. 
•	Create a variable named agerange to indicate the spread between these oldest and youngest customers. 
•	Use Customer_BirthDate, rather than Customer_Age, for all age determinations because this is more accurate.
*/

PROC SORT DATA=ASS06.customer_dim;
    BY Customer_Type Customer_BirthDate;
RUN;

DATA oldest_youngest;
    LENGTH Customer_Type $50;
    RETAIN oldest youngest o_ID y_ID agerange;

    SET ASS06.customer_dim;
    BY Customer_Type;

	IF first.Customer_Type THEN DO
        oldest = Customer_BirthDate;
        o_ID = Customer_ID;
    END;

    IF last.Customer_Type THEN DO;
        youngest = Customer_BirthDate;
        y_ID = Customer_ID;
        agerange = (youngest - oldest) / 365.25;
        OUTPUT;
    END;
RUN;


PROC PRINT DATA=oldest_youngest;
    TITLE "Oldest and Youngest Customers of each Customer Type";
    FORMAT oldest youngest DATE9. agerange 8.1;
    VAR Customer_Type oldest youngest o_ID y_ID agerange;
RUN;
