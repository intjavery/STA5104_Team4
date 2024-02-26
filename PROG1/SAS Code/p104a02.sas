proc sort data=orion.sales
          out=work.sorted;
   by Country Gender;
run;

proc print data=work.sorted; 
   by Gender;
run;
