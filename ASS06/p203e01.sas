data work.mid_q4;
  set orion.order_fact;
  where '01nov2008'd <= Order_Date <= '14dec2008'd;
run;


title 'Orders from 01Nov2008 through 14Dec2008';
proc print data=work.mid_q4;
  var Order_ID Order_Date Total_Retail_Price;
run;
title;
