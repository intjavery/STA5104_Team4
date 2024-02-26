proc print data=orion.customer_dim;
    where Customer_Age=21;
	 id Customer_ID;
	 var Customer_Name Customer_Gender 
        Customer_Country Customer_Group 
        Customer_Age_Group Customer_Type; 
run;

