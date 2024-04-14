*----------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 4: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 08                                                              |
| Due: 03/26/24                                                              |
*----------------------------------------------------------------------------*;

%let PATH = ~/ASS08/;
LIBNAME ASS08 "/home/u63737872/ASS08";

*Problem 1. Performing Computations with Conditional DO Loops;
DATA future_expenses;
   DROP start stop;
   Wages = 12874000;
   Retire = 1765000;
   Medical = 649000;
   Income = 50000000;
   
   start = YEAR(TODAY())+1;
   stop = start+24;

   DO YEAR = start TO stop UNTIL (Total_Cost > 50000000 );
      wages = wages*1.06;
      retire = retire*1.014;
      medical = medical*1.095;
      Income = Income*1.01;
      Total_Cost = SUM(wages, retire, medical);
      OUTPUT;
   END;
   
   FORMAT Income COMMA16.2 Total_Cost COMMA16.2;
   
RUN;

/*Print your results with an appropriate title.*/
PROC PRINT DATA = future_expenses;
    VAR Year Income Total_Cost;
RUN;

*Problem 2. Using an Iterative DO Statement with a Conditional Clause;
DATA work.expenses;
	DROP start stop;
	
	Income = 50000000;
	Expenses = 38750000;
	
	start = 1;
	stop = start+28;
	
	DO Year=start TO stop UNTIL (Expenses > Income);
	Income=Income*1.01;
	Expenses=Expenses*1.02;
	END;
	
	FORMAT Income DOLLAR16.2 Expenses DOLLAR16.2;
   
RUN;

/*Print your results with an appropriate title.*/
PROC PRINT DATA = work.expenses;
    VAR Income Expenses Year;
RUN;

*Problem 3. Using Other Loop Control Statements;
DATA work.expenses;
	DROP start stop;
	
	Income = 50000000;
	Expenses = 38750000;
	
	start = 1;
	stop = start + 73;
	
	DO Year = start TO stop;
   	Income = Income*1.01;
   	Expenses = Expenses*1.02;
   	
   	IF Expenses > Income THEN leave;
   	END;
   	
   	FORMAT Income DOLLAR16.2 Expenses DOLLAR16.2;
   
RUN;

/*Print your results with an appropriate title.*/

PROC PRINT DATA = work.expenses;
    VAR Income Expenses Year;
RUN;

*Problem 4. Using Arrays for Repetitive Computations;

DATA work.discount_sales;
    SET ASS08.orders_midyear;
    ARRAY MON{6} Month1-Month6;

    DO i=1 to 6;
    MON{i}=MON{i}-(MON{i}*.05);
    
    END;
    
    FORMAT Month1-Month6 DOLLAR12.2; 
RUN;

/*Print your results with an appropriate title.*/
TITLE 'Monthly Sales with 5% Discount';
PROC PRINT DATA = work.discount_sales NOOBS;
    VAR Customer_ID Month1-Month6;
RUN;

TITLE;

*Problem 5. Using Arrays for Repetitive Computations;
DATA special_offer;
    SET ASS08.orders_midyear;
    ARRAY Mon {3} Month1-Month3;
    Total_Sales = SUM(of Month1-Month6); 
    DO i = 1 to 3;
        Mon[i] = Mon[i] *0.1; 
    END;
    
    Projected_Sales = Total_Sales-SUM(of Month1-Month3);
    Difference = Total_Sales- Projected_Sales; 
    KEEP Total_Sales Projected_Sales Difference;
RUN;

TITLE "Sales for all the Months with 10% Discount in First Three Months";
PROC PRINT DATA = special_offer NOOBS LABEL LABEL;
    FORMAT Total_Sales Projected_Sales Difference DOLLAR12.2;
RUN;

*Problem 6. Using an Array for Table Lookup;
DATA preferred_cust;
   SET ASS08.orders_midyear;
   ARRAY Mon{6} Month1-Month6;
   ARRAY Target {6} _temporary_ (200, 400, 300, 100, 100, 200);
   ARRAY Over{6} Over1-Over6;
   Total_Over = 0;

   DO i = 1 to 6;
      IF Mon[i] > Target[i] THEN DO;
         Over[i] = Mon[i] - Target[i];
         Total_Over + Over[i];
      END;
      ELSE Over[i] = 0; 
   END;

   IF Total_Over > 500 THEN OUTPUT;

   KEEP Customer_ID Over1-Over6 Total_Over;
RUN;

PROC PRINT DATA = preferred_cust NOOBS;
   TITLE "Preferred Customers with Total Over $500";
   VAR Customer_ID Over1-Over6 Total_Over;
   FORMAT Over1-Over6 Total_Over DOLLAR12.2;
RUN;

*Problem 7. Using a Character Array for Table Lookup;
*Read the test answers data from a text file;
DATA passed failed;
    SET ASS08.test_answers;

    ARRAY C[10] $1. ('A', 'C', 'C', 'B', 'E', 'E', 'D', 'B', 'B', 'A');

    *Initializing score;
    Score = 0;

    ARRAY Q[10] $1. Q1-Q10;

    *Calculating score;
    DO i = 1 to 10;
        IF C[i] = Q[i] THEN Score + 1;
    END;

    *Sorting into passed and failed datasets;
    IF Score >= 7 THEN OUTPUT passed;
    ELSE OUTPUT failed;

    DROP i;
RUN;

*Printing passed dataset /;
PROC PRINT DATA=passed;
    TITLE 'Passed';
RUN;

*Printing failed dataset */;
PROC PRINT DATA=failed;
    TITLE 'Failed';
RUN;

*Problem 8. Rotating a Data Set;
DATA ASS08.orders_midyear;
INPUT Obs Customer_ID Month1 Month2 Month3 Month4 Month5 Month6;
DATALINES;
1 5 213.10 . 478.0 525.80 394.35 191.79
2 10 188.10 414.09 2876.9 3164.59 2373.44 169.29
3 11 78.20 . . . . 70.38
4 12 135.60 . 117.6 129.36 97.02 122.04
5 18 . . 29.4 32.34 24.26 .
;
RUN;

*Rotation to create new dataset sixmonths;
DATA sixmonths;
    SET ASS08.orders_midyear;
    ARRAY months{6} Month1-Month6;
    DO i = 1 to 6;
        IF NOT missing(months{i}) THEN DO;
            Month = i;
            Sales = months{i};
            OUTPUT;
        END;
    END;
    DROP i Month1-Month6;
RUN;

PROC PRINT DATA=sixmonths NOOBS;
    TITLE 'Sales Data for the First Six Months';
RUN;


*Problem 8. Rotating a Data Set and Using a Lookup Table;
DATA ASS08.travel_expense;
INPUT Trip_ID $ Employee_ID Exp1 Exp2 Exp3 Exp4 Exp5;
DATALINES;
1044-1 121044 345.97 568.54 235.00 320.00 .
0145-1 120145 256.00 675.90 343.25 125.00 67.50
0656-1 120656 312.26 . 236.98 325.00 45.00
1119-1 121119 597.80 780.99 345.87 195.00 50.75
0812-1 120812 345.24 865.45 534.20 430.50 76.75
;
RUN;

DATA travel(KEEP = Trip_ID Employee_ID Expense_Type Amount);
  SET ASS08.travel_expense;
  LENGTH Expense_Type $15;
  ARRAY expenses(5) Exp1 Exp2 Exp3 Exp4 Exp5;
  ARRAY exp_types(5) $15. ('Airfare', 'Hotel', 'Meals', 'Transportation', 'Miscellaneous');
  DO i = 1 to 5;
    IF NOT missing(expenses(i)) THEN DO;
      Expense_Type = exp_types(i);
      Amount = expenses(i);
      OUTPUT;
    END;
  END;
  DROP i;
RUN;

PROC PRINT DATA=travel NOOBS;
  FORMAT Amount DOLLAR12.2;
  TITLE 'Travel Expenses';
RUN;


*Problem 9. Performing a Match-Merge on Two Data Sets;
PROC SQL;
   CREATE TABLE revenue AS 
   SELECT o.Product_ID, p.Price, p.Product_Name, o.Quantity, o.Customer, 
          (p.Price * o.Quantity) AS Revenue
   FROM ASS08.web_orders AS o
   INNER JOIN ASS08.web_products AS p
   ON o.Product_ID = p.Product_ID;
QUIT;

PROC SQL;
   CREATE TABLE notsold AS
   SELECT p.Product_ID, p.Price, p.Product_Name
   FROM ASS08.web_products AS p
   WHERE NOT EXISTS (
       SELECT 1
       FROM ASS08.web_orders AS o
       WHERE p.Product_ID = o.Product_ID
   );
QUIT;

PROC SQL;
   CREATE TABLE invalidcode AS
   SELECT o.Product_ID, o.Quantity, o.Customer
   FROM ASS08.web_orders AS o
   WHERE NOT EXISTS (
       SELECT 1
       FROM ASS08.web_products AS p
       WHERE o.Product_ID = p.Product_ID
   );
QUIT;

TITLE "Revenue Generated From Each Sale";
PROC PRINT DATA = revenue NOOBS;
RUN;

TITLE "Products Not Sold";
PROC PRINT DATA = notsold NOOBS;
RUN;

TITLE "Orders With Invalid Product Codes";
PROC PRINT DATA = invalidcode NOOBS;
RUN;

*Problem 10. Handling Same-Named Variables and Different Data Types for BY Variables;
DATA web_converted;
    SET ASS08.web_products2(RENAME=(Product_ID=nProduct_ID));
    LENGTH Product_ID $20;
    Product_ID = STRIP(PUT(nProduct_ID, BEST20.));
    DROP nProduct_ID;
RUN;

PROC SQL;
    CREATE TABLE revenue AS
    SELECT c.Product_ID,
           c.Name AS Product_Name,
           o.Quantity,
           o.Name AS Customer_Name,
           c.Price,
           c.Price * o.Quantity AS Revenue
    FROM web_converted AS c
    INNER JOIN ASS08.web_orders2 AS o
    ON c.Product_ID = o.Product_ID;
QUIT;

PROC SQL;
    CREATE TABLE notsold AS
    SELECT Product_ID, Price, Name AS Product_Name
    FROM web_converted
    WHERE Product_ID NOT IN (SELECT Product_ID FROM ASS08.web_orders2);
QUIT;

PROC SQL;
    CREATE TABLE invalidcode AS
    SELECT o.Product_ID, o.Quantity, o.Name AS Customer_Name
    FROM ASS08.web_orders2 AS o
    WHERE NOT EXISTS (SELECT 1 FROM web_converted AS c WHERE c.Product_ID = o.Product_ID);
QUIT;

PROC PRINT DATA=revenue NOOBS;
    TITLE "Revenue Generated from Sales";
RUN;

PROC PRINT DATA=notsold NOOBS;
    TITLE "Products That Were Not Sold";
RUN;

PROC PRINT DATA=invalidcode NOOBS;
    TITLE "Orders with Invalid Product Codes";
RUN;