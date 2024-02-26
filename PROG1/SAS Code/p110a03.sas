proc sort data=orion.customer
          out=cust_by_type;
	by Customer_Type_ID;
run;

data customers;
   merge cust_by_type orion.customer_type;
	by Customer_Type_ID;
	where Country='US';
run;
