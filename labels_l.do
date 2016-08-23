#delimit ;

la drop _all;

foreach var of varlist _all {;
	label var `var' "";
};

la var A1 "A1: Main Respondent part of 2010 Household";


la var MM1 "M1: Worked at Least One Hour in Past 7 Days ";


la def yn 1 "Yes"
2 "No"
3 "DK / NA";

la val A1 A2 A4 A6 A11 A16 A24 A27 A28 A29 A32 A35 A36 A37 B10 B11 
	C1_? C3_? C5 C13 C15 D2 D3_? D5_? D7_? E1_? E7 E8 F1 F3_? F4_? G1_? G2 I? 
	J2 J11 J12 J16 K4 K6 K7 K13 K14 K17 L2 L10 L13 M1 M2 M4 N1 N3 N8 O11 O23 O28 
	P3 P4 P5 P6 P9 P13 P16 P17 R4 R5 R6 S3 S4 S9_1 T1 T3 U12 V1_? V2_? V3_? yn;
	
la def A3 1 "1-Lebanon"
lab def ISCO 1 "1 Commissioned armed forces officers"


la val A10 A10;
la val O1 P1 Q2 R1 S1 ISIC;
la val O2 P2 Q3 R2 S2 ISCO;


la val MM5 M5;
la val OO1 PP1 QQ2 RR1 SS1 ISIC;
la val OO2 PP2 QQ3 RR2 SS2 ISCO;