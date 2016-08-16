
#delimit ;

***************************************;
**** Programs to Export Mistakes ******;
***************************************;

cap program drop answer;
program define answer;
	syntax varlist;
		foreach var of varlist `varlist' {;
			preserve;
				drop if section_answered == 0;
				ds `var', has(type string);
				if "`r(varlist)'" == "`var'" 	keep if `var' == "";
				else 							keep if `var' == . ;
			count;
			if `r(N)' > 0 {;		
				keep $keep_vars;
				gen question = "`var'";
				gen entry = "";
				gen issue = "missing";
				append using "$filename";
				save "$filename", replace;
			};
			restore;
		};
end;

cap program drop answerif;
program define answerif;
	syntax varlist if;
		foreach var of varlist `varlist' {;

			preserve;
				drop if section_answered == 0;
				ds `var', has(type string);
				if "`r(varlist)'" == "`var'" 	drop `if' | `var' == "";
				else 							drop `if' | `var' == .;
			count;
			if `r(N)' > 0 {;		
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "only answer `if'";
				keep $keep_vars question entry issue;
				append using "$filename";
				save "$filename", replace;
			};
			restore;
			
		};		

end;

cap program drop answeriff;
program define answeriff;
	syntax varlist if;
		foreach var of varlist `varlist' {;

			** Should be there and are missing **;
			preserve;
				drop if section_answered == 0;
				ds `var', has(type string);
				if "`r(varlist)'" == "`var'" 	keep `if' & `var' == "";
				else 							keep `if' & `var' == .;
			count;
			if `r(N)' > 0 {;		
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "do not skip `if'";
				keep $keep_vars question entry issue;
				append using "$filename";
				save "$filename", replace;
			};
			restore;
			
			** Should not be there and are filled in **;
			preserve;
				drop if section_answered == 0;
				ds `var', has(type string);
				if "`r(varlist)'" == "`var'" 	drop `if' | `var' == "";
				else 							drop `if' | `var' == .;
			count;
			if `r(N)' > 0 {;		
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "answer only `if'";
				keep $keep_vars question entry issue;
				append using "$filename";
				save "$filename", replace;
			};
			restore;
			
		};		

end;

cap program drop answeriff_alt;
program define answeriff_alt;
	syntax varlist if, alt(string);
		foreach var of varlist `varlist' {;

			** Should be there and are missing **;
			preserve;
				drop if section_answered == 0;
				ds `var', has(type string);
				if "`r(varlist)'" == "`var'" 	keep `if' & `var' == "";
				else 							keep `if' & `var' == .;
			count;
			if `r(N)' > 0 {;		
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "do not skip `if'";
				keep $keep_vars question entry issue;
				append using "$filename";
				save "$filename", replace;
			};
			restore;
			
			** Should not be there and are filled in **;
			preserve;
				drop if section_answered == 0;
				ds `var', has(type string);
				if "`r(varlist)'" == "`var'" 	drop `if' | `alt' | `var' == "";
				else 							drop `if' | `alt' | `var' == .;		
			count;
			if `r(N)' > 0 {;		
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "answer only `if' or `alt'";
				keep $keep_vars question entry issue;
				append using "$filename";
				save "$filename", replace;
			};
			restore;
			
		};		

end;

cap program drop restrict;
program define restrict;
	syntax varlist, [min(integer 1)] [max(string)];
		if "`max'" == "" local max = 2;
		foreach var of varlist `varlist' {;
			preserve;
				drop if section_answered == 0;
				gen test = (round(`var',1) == `var');
				keep if (`var' < `min' & `var' != 99 & `var' != 98 & `var' != 999 & `var' != -99 & `var' != -999 & `var' != -98 & `var' != -97) 
					| (`var' > `max' & `var' != . & `var' != 99 & `var' != 98  & `var' != 999 & `var' != -99 & `var' != -999 & `var' != -98 & `var' != -97)
					| test != 1;
			count;
			if `r(N)' > 0 {;		
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "invalid response";
				keep $keep_vars question entry issue;
				append using "$filename";
				save "$filename", replace;
			};
			restore;
		};
end;

cap program drop restrictif;
program define restrictif;
	syntax anything if;
		preserve;
			drop if section_answered == 0;
			drop `if' & `anything';
			keep `if';
			
			local var1 = subinstr(word("`anything'",1),"(","",.);
			local var1 = subinstr("`var1'",")","",.);
			local var2 = subinstr(word("`anything'",3),"(","",.);
			local var2 = subinstr("`var2'",")","",.);
			drop if `var1' == . | `var1' == -97 | `var1' == -98 | `var1' == -99 | `var2' == . | `var2' == -97 | `var2' == -98 | `var2' == -99;
			
		count;
		if `r(N)' > 0 {;	
			gen question = "`var1'";
			tostring `var1', replace force;
			gen entry = `var1';
			gen issue = "`anything' `if'";
			keep $keep_vars question entry issue;
			append using "$filename";
			save "$filename", replace;
		};
		restore;
end;

cap program drop restricton;
program define restricton;
	syntax anything;
		preserve;
			drop if section_answered == 0;
			drop if `anything';

			local var1 = subinstr(word("`anything'",1),"(","",.);
			local var1 = subinstr("`var1'",")","",.);
			local var2 = subinstr(word("`anything'",3),"(","",.);
			local var2 = subinstr("`var2'",")","",.);
			quietly: ds *;
			local vars `r(varlist)';
			local var1 : list vars & var1;
			local var2 : list vars & var2;
			
			foreach var of varlist `var1' `var2' {;
				ds `var', has(type string);
				if "`r(varlist)'" == "`var'" 	drop if `var' == "";
				else 							drop if `var' == . | `var' == 98 | `var' == 99;
			};

		count;
		if `r(N)' > 0 {;
			gen question = "`var1'";
			tostring `var1', replace force;
			gen entry = `var1';
			gen issue = "`anything'";
			keep $keep_vars question entry issue;
			append using "$filename";
			save "$filename", replace;
		};
		restore;
end;

cap program drop restrictchar;
program define restrictchar;
	syntax varlist, [min(integer 3)] [max(integer 256)];
		foreach var of varlist `varlist' {;
			preserve;
				drop if section_answered == 0;
				gen char_length = length(`var');
				keep if (char_length < `min' | char_length > `max') & char_length > 2;
			count;
			if `r(N)' > 0 {;	
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "No. of Characters";
				keep $keep_vars question entry issue;	
				append using "$filename";
				save "$filename", replace;
			};
			restore;
		};
end;

cap program drop location_check;
program define location_check;
	syntax anything, [loop(integer 1)];
		foreach var in `anything' {;
			preserve;
			if `loop' == 1 rename (`var'A `var'B `var'C) =X1; 
			forvalues i = 1/`loop' {;
				
				restrict `var'BX`i', max(701);
				restrict `var'CX`i', max(2521);
				
				restrictif `var'BX`i' == 1 if `var'CX`i' >= 1 & `var'CX`i' <= 49 & `var'AX`i' != .;
				restrictif `var'BX`i' == 1 if `var'CX`i' >= 2502 & `var'CX`i' <= 2513 & `var'AX`i' == .;	//Zaatari camp sectors
				restrictif `var'BX`i' == 4 if `var'CX`i' >= 2514 & `var'CX`i' <= 2521 & `var'AX`i' == .;	//Azraq camp sectors
				
				restrictif `var'BX`i' == 2 if `var'CX`i' >= 51 & `var'CX`i' <= 78 & `var'AX`i' != .;
				restrictif `var'BX`i' == 3 if `var'CX`i' >= 126 & `var'CX`i' <= 155 & `var'AX`i' != .;
				restrictif `var'BX`i' == 4 if `var'CX`i' >= 201 & `var'CX`i' <= 236 & `var'AX`i' != .;
				restrictif `var'BX`i' == 5 if `var'CX`i' >= 276 & `var'CX`i' <= 281 & `var'AX`i' != .;
				restrictif `var'BX`i' == 6 if `var'CX`i' >= 301 & `var'CX`i' <= 303 & `var'AX`i' != .;
				restrictif `var'BX`i' == 7 if `var'CX`i' >= 326 & `var'CX`i' <= 331 & `var'AX`i' != .;
				restrictif `var'BX`i' == 8 if `var'CX`i' >= 351 & `var'CX`i' <= 353 & `var'AX`i' != .;
				restrictif `var'BX`i' == 9 if `var'CX`i' >= 376 & `var'CX`i' <= 379 & `var'AX`i' != .;
				restrictif `var'BX`i' == 10 if `var'CX`i' >= 401 & `var'CX`i' <= 402 & `var'AX`i' != .;
				restrictif `var'BX`i' == 11 if `var'CX`i' >= 426 & `var'CX`i' <= 426 & `var'AX`i' != .;
				restrictif `var'BX`i' == 12 if `var'CX`i' >= 475 & `var'CX`i' <= 475 & `var'AX`i' != .;
				
				restrictif `var'BX`i' == 13 if `var'CX`i' >= 476 & `var'CX`i' <= 552 & `var'AX`i' != .;
				restrictif `var'BX`i' == 14 if `var'CX`i' >= 576 & `var'CX`i' <= 594 & `var'AX`i' != .;
				restrictif `var'BX`i' == 15 if `var'CX`i' >= 651 & `var'CX`i' <= 710 & `var'AX`i' != .;
				restrictif `var'BX`i' == 16 if `var'CX`i' >= 751 & `var'CX`i' <= 757 & `var'AX`i' != .;
				restrictif `var'BX`i' == 17 if `var'CX`i' >= 776 & `var'CX`i' <= 823 & `var'AX`i' != .;
				restrictif `var'BX`i' == 18 if `var'CX`i' >= 826 & `var'CX`i' <= 837 & `var'AX`i' != .;
				restrictif `var'BX`i' == 19 if `var'CX`i' >= 851 & `var'CX`i' <= 859 & `var'AX`i' != .;
				restrictif `var'BX`i' == 20 if `var'CX`i' >= 876 & `var'CX`i' <= 880 & `var'AX`i' != .;
				restrictif `var'BX`i' == 21 if `var'CX`i' >= 901 & `var'CX`i' <= 923 & `var'AX`i' != .;
				restrictif `var'BX`i' == 22 if `var'CX`i' >= 951 & `var'CX`i' <= 958 & `var'AX`i' != .;
				restrictif `var'BX`i' == 23 if `var'CX`i' >= 976 & `var'CX`i' <= 984 & `var'AX`i' != .;
				restrictif `var'BX`i' == 24 if `var'CX`i' >= 1001 & `var'CX`i' <= 1005 & `var'AX`i' != .;
				restrictif `var'BX`i' == 25 if `var'CX`i' >= 1026 & `var'CX`i' <= 1030 & `var'AX`i' != .;
				restrictif `var'BX`i' == 26 if `var'CX`i' >= 1051 & `var'CX`i' <= 1051 & `var'AX`i' != .;
				
				restrictif `var'BX`i' == 27 if `var'CX`i' >= 1076 & `var'CX`i' <= 1076 & `var'AX`i' != .;
				restrictif `var'BX`i' == 28 if `var'CX`i' >= 1087 & `var'CX`i' <= 1087 & `var'AX`i' != .;
				restrictif `var'BX`i' == 29 if `var'CX`i' >= 1098 & `var'CX`i' <= 1098 & `var'AX`i' != .;
				restrictif `var'BX`i' == 30 if `var'CX`i' >= 1107 & `var'CX`i' <= 1115 & `var'AX`i' != .;
				restrictif `var'BX`i' == 31 if `var'CX`i' >= 1116 & `var'CX`i' <= 1130 & `var'AX`i' != .;
				restrictif `var'BX`i' == 34 if `var'CX`i' >= 1150 & `var'CX`i' <= 1150 & `var'AX`i' != .;
				
				restrictif `var'BX`i' == 81 if `var'CX`i' >= 1151 & `var'CX`i' <= 1170 & `var'AX`i' != .;
				restrictif `var'BX`i' == 82 if `var'CX`i' >= 1171 & `var'CX`i' <= 1190 & `var'AX`i' != .;
				restrictif `var'BX`i' == 83 if `var'CX`i' >= 1191 & `var'CX`i' <= 1192 & `var'AX`i' != .;
				
				restrictif `var'BX`i' == 91 if `var'CX`i' >= 1240 & `var'CX`i' <= 1240 & `var'AX`i' != .;
				restrictif `var'BX`i' == 92 if `var'CX`i' >= 1260 & `var'CX`i' <= 1260 & `var'AX`i' != .;
				restrictif `var'BX`i' == 93 if `var'CX`i' >= 1261 & `var'CX`i' <= 1280 & `var'AX`i' != .;
				restrictif `var'BX`i' == 94 if `var'CX`i' >= 1281 & `var'CX`i' <= 1300 & `var'AX`i' != .;
				restrictif `var'BX`i' == 95 if `var'CX`i' >= 1301 & `var'CX`i' <= 1320 & `var'AX`i' != .;
				restrictif `var'BX`i' == 96 if `var'CX`i' >= 1321 & `var'CX`i' <= 1340 & `var'AX`i' != .;
				restrictif `var'BX`i' == 97 if `var'CX`i' >= 1341 & `var'CX`i' <= 1350 & `var'AX`i' != .;
				restrictif `var'BX`i' == 98 if `var'CX`i' >= 1351 & `var'CX`i' <= 1360 & `var'AX`i' != .;
				restrictif `var'BX`i' == 99 if `var'CX`i' >= 1361 & `var'CX`i' <= 1370 & `var'AX`i' != .;
				restrictif `var'BX`i' == 100 if `var'CX`i' >= 1371 & `var'CX`i' <= 1375 & `var'AX`i' != .;
				
				restrictif `var'BX`i' == 241 if `var'CX`i' >= 1421 & `var'CX`i' <= 1440 & `var'AX`i' != .;
				restrictif `var'BX`i' == 242 if `var'CX`i' >= 1441 & `var'CX`i' <= 1460 & `var'AX`i' != .;
				restrictif `var'BX`i' == 243 if `var'CX`i' >= 1461 & `var'CX`i' <= 1480 & `var'AX`i' != .;
				restrictif `var'BX`i' == 244 if `var'CX`i' >= 1481 & `var'CX`i' <= 1500 & `var'AX`i' != .;
				restrictif `var'BX`i' == 245 if `var'CX`i' >= 1501 & `var'CX`i' <= 1520 & `var'AX`i' != .;
				restrictif `var'BX`i' == 246 if `var'CX`i' >= 1521 & `var'CX`i' <= 1525 & `var'AX`i' != .;
				restrictif `var'BX`i' == 247 if `var'CX`i' >= 1526 & `var'CX`i' <= 1530 & `var'AX`i' != .;
				restrictif `var'BX`i' == 248 if `var'CX`i' >= 1531 & `var'CX`i' <= 1535 & `var'AX`i' != .;
				
				restrictif `var'BX`i' == 251 if `var'CX`i' >= 1541 & `var'CX`i' <= 1555 & `var'AX`i' != .;
				restrictif `var'BX`i' == 252 if `var'CX`i' >= 1556 & `var'CX`i' <= 1599 & `var'AX`i' != .;
				
				restrictif `var'BX`i' == 321 if `var'CX`i' >= 1601 & `var'CX`i' <= 1650 & `var'AX`i' != .;

				restrictif `var'BX`i' == 401 if `var'CX`i' >= 1776 & `var'CX`i' <= 1776 & `var'AX`i' != .;

				restrictif `var'BX`i' <= 82 if `var'AX`i' == . & `var'CX`i' != .;
				
				restrictif `var'BX`i' >= 1 & `var'BX`i' <= 12 if `var'AX`i' == 1;
				restrictif `var'BX`i' >= 13 & `var'BX`i' <= 26 if `var'AX`i' == 2;
				restrictif `var'BX`i' >= 27 & `var'BX`i' <= 80 if `var'AX`i' == 3;
				restrictif `var'BX`i' >= 81 & `var'BX`i' <= 90 if `var'AX`i' == 4;
				restrictif `var'BX`i' >= 91 & `var'BX`i' <= 220 if `var'AX`i' == 5;
				restrictif `var'BX`i' >= 221 & `var'BX`i' <= 240 if `var'AX`i' == 6;
				restrictif `var'BX`i' >= 241 & `var'BX`i' <= 250 if `var'AX`i' == 7;
				restrictif `var'BX`i' >= 251 & `var'BX`i' <= 300 if `var'AX`i' == 8;
				restrictif `var'BX`i' >= 301 & `var'BX`i' <= 320 if `var'AX`i' == 9;
				restrictif `var'BX`i' >= 321 & `var'BX`i' <= 330 if `var'AX`i' == 10;
				restrictif `var'BX`i' >= 331 & `var'BX`i' <= 350 if `var'AX`i' == 11;
				restrictif `var'BX`i' >= 351 & `var'BX`i' <= 370 if `var'AX`i' == 12;
				restrictif `var'BX`i' >= 371 & `var'BX`i' <= 390 if `var'AX`i' == 13;
				restrictif `var'BX`i' >= 391 & `var'BX`i' <= 400 if `var'AX`i' == 14;
				restrictif `var'BX`i' >= 401 & `var'BX`i' <= 425 if `var'AX`i' == 15;
				restrictif `var'BX`i' >= 426 & `var'BX`i' <= 435 if `var'AX`i' == 16;
				restrictif `var'BX`i' >= 436 & `var'BX`i' <= 440 if `var'AX`i' == 17;
				restrictif `var'BX`i' >= 441 & `var'BX`i' <= 445 if `var'AX`i' == 18;
				restrictif `var'BX`i' >= 446 & `var'BX`i' <= 460 if `var'AX`i' == 19;
				restrictif `var'BX`i' >= 461 & `var'BX`i' <= 470 if `var'AX`i' == 20;
				restrictif `var'BX`i' >= 471 & `var'BX`i' <= 480 if `var'AX`i' == 21;
				restrictif `var'BX`i' >= 481 & `var'BX`i' <= 490 if `var'AX`i' == 22;
				restrictif `var'BX`i' >= 491 & `var'BX`i' <= 500 if `var'AX`i' == 23;
				restrictif `var'BX`i' >= 501 & `var'BX`i' <= 510 if `var'AX`i' == 24;
				restrictif `var'BX`i' >= 511 & `var'BX`i' <= 520 if `var'AX`i' == 25;
				restrictif `var'BX`i' >= 521 & `var'BX`i' <= 530 if `var'AX`i' == 26;
				restrictif `var'BX`i' >= 531 & `var'BX`i' <= 540 if `var'AX`i' == 27;
				restrictif `var'BX`i' >= 541 & `var'BX`i' <= 550 if `var'AX`i' == 28;
				restrictif `var'BX`i' >= 551 & `var'BX`i' <= 560 if `var'AX`i' == 29;
				restrictif `var'BX`i' >= 561 & `var'BX`i' <= 570 if `var'AX`i' == 30;
				restrictif `var'BX`i' >= 571 & `var'BX`i' <= 580 if `var'AX`i' == 31;
			};
			
			restore;
		};
end;

cap program drop location_check2;
program define location_check2;
	syntax anything, [loop(integer 1)];
		foreach var in `anything' {;
			preserve;
			if `loop' == 1 rename (`var'A `var'B `var'C) =_1; 
			forvalues i = 1/`loop' {;
				
				restrict `var'A_`i', max(75);
				restrict `var'B_`i', max(26);
				restrict `var'C_`i', max(6);

				restrictif `var'A_`i' >= 1 & `var'A_`i' <= 4 if `var'B_`i' == 1;
				restrictif `var'A_`i' >= 5 & `var'A_`i' <= 10 if `var'B_`i' == 2;
				restrictif `var'A_`i' >= 11 & `var'A_`i' <= 16 if `var'B_`i' == 3;
				restrictif `var'A_`i' >= 17 & `var'A_`i' <= 19 if `var'B_`i' == 4;
				restrictif `var'A_`i' >= 20 & `var'A_`i' <= 23 if `var'B_`i' == 5;
				restrictif `var'A_`i' >= 24 & `var'A_`i' <= 25 if `var'B_`i' == 6;
				restrictif `var'A_`i' == 26 if `var'B_`i' == 7;
 				restrictif `var'A_`i' >= 27 & `var'A_`i' <= 30 if `var'B_`i' == 8;
				restrictif `var'A_`i' >= 31 & `var'A_`i' <= 32 if `var'B_`i' == 9;
				restrictif `var'A_`i' == 33 if `var'B_`i' == 10;
				restrictif `var'A_`i' == 34 if `var'B_`i' == 11;
				restrictif `var'A_`i' >= 35 & `var'A_`i' <= 41 if `var'B_`i' == 12;
				restrictif `var'A_`i' >= 42 & `var'A_`i' <= 44 if `var'B_`i' == 14;
				restrictif `var'A_`i' >= 45 & `var'A_`i' <= 53 if `var'B_`i' == 15;
				restrictif `var'A_`i' >= 54 & `var'A_`i' <= 57 if `var'B_`i' == 16;
				restrictif `var'A_`i' >= 58 & `var'A_`i' <= 62 if `var'B_`i' == 17;
				restrictif `var'A_`i' >= 63 & `var'A_`i' <= 68 if `var'B_`i' == 20;
				restrictif `var'A_`i' >= 69 & `var'A_`i' <= 70 if `var'B_`i' == 21;
				restrictif `var'A_`i' >= 71 & `var'A_`i' <= 72 if `var'B_`i' == 23;
				restrictif `var'A_`i' == 73 if `var'B_`i' == 24;
				restrictif `var'A_`i' >= 74 & `var'A_`i' <= 75 if `var'B_`i' == 26;

				restrictif `var'B_`i' == 1 if `var'C_`i' == 1;
				restrictif `var'B_`i' >= 2 & `var'B_`i' <= 7 if `var'C_`i' == 2;
				restrictif `var'B_`i' >= 8 & `var'B_`i' <= 14 if `var'C_`i' == 3;
				restrictif `var'B_`i' >= 15 & `var'B_`i' <= 17 if `var'C_`i' == 4;
				restrictif `var'B_`i' >= 20 & `var'B_`i' <= 21 if `var'C_`i' == 5;
				restrictif `var'B_`i' >= 23 & `var'B_`i' <= 26 if `var'C_`i' == 6;
				
			};
			
			restore;
		};
end;

cap program drop unique;
program define unique;
	syntax anything;
		preserve;
		cap drop `anything'_OTHER;
		cap drop `anything'_O_EN;
		
		foreach var of varlist `anything'* {;
			drop if `var' == .;
		};
		
		foreach var1 of varlist `anything'* {;
			foreach var2 of varlist `anything'* {;
				if "`var1'" != "`var2'" restrictif `var1' != `var2' if `var2' != .;
			};
		};
		restore;
end;
