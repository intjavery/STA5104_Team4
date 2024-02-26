proc print data=orion.sales noobs;
	var Last_Name First_Name Country Job_Title;
run;

proc print data=orion.sales noobs;
	var Last_Name First_Name Country Job_Title;
	where Country='AU' and 
         Job_Title contains 'Rep';
run;
