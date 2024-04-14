*----------------------------------------------------------------------------*
| STA 5104 - Advanced Computer Processing                                    |
| Team 4: Avery Tran (C), Yasmeen Sawyers, Anabella Segura, Manoj Gunturu    |
| Assignment 09                                                             |
| Due: 04/12/24                                                              |
*----------------------------------------------------------------------------*;

%let PATH = ~/ASS09/;
LIBNAME ASS09 "/home/u63737872/ASS09";

/* Problem 1*/
DATA work.medical;
    INFILE "/home/u63737872/ASS09/medical.txt" dlm=' ';
    INPUT Date :mmddyy8. Patient_Name $ Cholesterol HBP LBP;
        IF Cholesterol = 999 then Cholesterol = .;
        IF HBP = 999 then HBP = .;
        IF LBP = 999 then LBP = .;
        
    Format Date mmddyy8.;    
    
RUN;    

/*Print results*/
proc print DATA=work.medical;
RUN;


/*Problem 2*/
/*Sort DATA*/

PROC SORT DATA=work.medical;
    BY Patient_Name Date;
RUN;

/*Create DATASET with variables*/
DATA work.patient_summary;
    SET work.medical;
    BY Patient_Name Date;

    RETAIN First_Cholesterol Last_Cholesterol
           First_HBP Last_HBP
           First_LBP Last_LBP;

    IF first.Patient_Name THEN DO;
        First_Cholesterol = Cholesterol;
        First_HBP = HBP;
        First_LBP = LBP;
    END;

    IF last.Patient_Name THEN DO;
        Last_Cholesterol = Cholesterol;
        Last_HBP = HBP;
        Last_LBP = LBP;
        OUTPUT;
    END;
    
    DROP Date Cholesterol HBP LBP;
RUN;

/*Print results*/
proc print DATA=work.patient_summary;
RUN;