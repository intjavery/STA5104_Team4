libname orion "C:\Users\Morgan31955\Desktop\2018\UCFDocuments\STA5104\SAS_PG02\SASData_USED";

data correct;
	set orion.clean_up;
	if find(Product,'Mittens','I') > 0 then do;
		substr(Product_ID,9,1) = '5';
		Product = tranwrd(Product,'Luci ','Lucky ');
	end;
	Product_ID = compress(Product_ID);
	Product = propcase(Product);
run;

proc print data=correct noobs;
run;
