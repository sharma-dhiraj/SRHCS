
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
				keep if (`var' < `min' & `var' != -97 & `var' != -99 & `var' != -98 & `var' != -999) | (`var' > `max' & `var' != . & `var' != -99 & `var' != -98  & `var' != -999) | test != 1;
			count;
			if `r(N)' > 0 {;		
				gen question = "`var'";
				tostring `var', replace force;
				gen entry = `var';
				gen issue = "expected range: `min' to `max'";
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
			drop if `var1' == . | `var1' == -97 | `var1' == -98 | `var1' == -99 | `var2' == . | `var2' == -98 | `var2' == -99;
			
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
				else 							drop if `var' == . | `var' == -98 | `var' == -99;
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
				
				restrict `var'BX`i', max(1509);
				restrict `var'CX`i', max(181);
				
				restrictif `var'BX`i' == 11 if `var'CX`i' >= 1 & `var'CX`i' <= 7 & `var'AX`i' != .;
				restrictif `var'BX`i' == 13 if `var'CX`i' >= 8 & `var'CX`i' <= 23 & `var'AX`i' != .;
				restrictif `var'BX`i' == 15 if `var'CX`i' >= 24 & `var'CX`i' <= 33 & `var'AX`i' != .;
				restrictif `var'BX`i' == 12 if `var'CX`i' >= 34 & `var'CX`i' <= 41 & `var'AX`i' != .;
				restrictif `var'BX`i' == 25 if `var'CX`i' >= 42 & `var'CX`i' <= 44 & `var'AX`i' != .;
				restrictif `var'BX`i' == 14 if `var'CX`i' >= 45 & `var'CX`i' <= 48 & `var'AX`i' != .;
				restrictif `var'BX`i' == 21 if `var'CX`i' >= 49 & `var'CX`i' <= 54 & `var'AX`i' != .;
				restrictif `var'BX`i' == 22 if `var'CX`i' >= 55 & `var'CX`i' <= 62 & `var'AX`i' != .;
				restrictif `var'BX`i' == 33 if `var'CX`i' >= 63 & `var'CX`i' <= 67 & `var'AX`i' != .;
				restrictif `var'BX`i' == 23 if `var'CX`i' >= 68 & `var'CX`i' <= 77 & `var'AX`i' != .;
				restrictif `var'BX`i' == 24 if `var'CX`i' >= 78 & `var'CX`i' <= 81 & `var'AX`i' != .;
				restrictif `var'BX`i' == 26 if `var'CX`i' >= 82 & `var'CX`i' <= 87 & `var'AX`i' != .;
				restrictif `var'BX`i' == 27 if `var'CX`i' >= 88 & `var'CX`i' <= 95 & `var'AX`i' != .;
				restrictif `var'BX`i' == 28 if `var'CX`i' >= 96 & `var'CX`i' <= 98 & `var'AX`i' != .;
				restrictif `var'BX`i' == 31 if `var'CX`i' >= 99 & `var'CX`i' <= 102 & `var'AX`i' != .;
				restrictif `var'BX`i' == 32 if `var'CX`i' >= 103 & `var'CX`i' <= 107 & `var'AX`i' != .;
				restrictif `var'BX`i' == 34 if `var'CX`i' >= 108 & `var'CX`i' <= 113 & `var'AX`i' != .;
				restrictif `var'BX`i' == 35 if `var'CX`i' >= 114 & `var'CX`i' <= 120 & `var'AX`i' != .;
				restrictif `var'BX`i' == 7 if `var'CX`i' == 121 & `var'AX`i' != .;
				restrictif `var'BX`i' == 8 if `var'CX`i' >= 122 & `var'CX`i' <= 129 & `var'AX`i' != .;
				restrictif `var'BX`i' == 9 if `var'CX`i' >= 130 & `var'CX`i' <= 138 & `var'AX`i' != .;
				restrictif `var'BX`i' == 10 if `var'CX`i' >= 139 & `var'CX`i' <= 144 & `var'AX`i' != .;
				restrictif `var'BX`i' == 11 if `var'CX`i' >= 145 & `var'CX`i' <= 149 & `var'AX`i' != .;
				restrictif `var'BX`i' == 12 if `var'CX`i' >= 150 & `var'CX`i' <= 153 & `var'AX`i' != .;
				restrictif `var'BX`i' == 13 if `var'CX`i' >= 154 & `var'CX`i' <= 158 & `var'AX`i' != .;
				restrictif `var'BX`i' == 14 if `var'CX`i' >= 159 & `var'CX`i' <= 162 & `var'AX`i' != .;
				restrictif `var'BX`i' == 15 if `var'CX`i' >= 163 & `var'CX`i' <= 165 & `var'AX`i' != .;
				restrictif `var'BX`i' == 16 if `var'CX`i' >= 166 & `var'CX`i' <= 170 & `var'AX`i' != .;
				restrictif `var'BX`i' == 17 if `var'CX`i' >= 171 & `var'CX`i' <= 173 & `var'AX`i' != .;
				restrictif `var'BX`i' == 18 if `var'CX`i' >= 174 & `var'CX`i' <= 176 & `var'AX`i' != .;
				restrictif `var'BX`i' == 19 if `var'CX`i' >= 177 & `var'CX`i' <= 179 & `var'AX`i' != .;
				restrictif `var'BX`i' == 20 if `var'CX`i' >= 180 & `var'CX`i' <= 181 & `var'AX`i' != .;
				
				restrictif `var'BX`i' >= 1100 if `var'AX`i' == . & `var'CX`i' != .;
				restrictif `var'BX`i' == 11 | `var'BX`i' == 13 | `var'BX`i' == 15 if `var'AX`i' == 1;
				restrictif `var'BX`i' == 12 | `var'BX`i' == 14 | (`var'BX`i' >= 21 & `var'BX`i' <= 28) 
					| (`var'BX`i' >= 31 & `var'BX`i' <= 35) if `var'AX`i' == 2;
				restrictif `var'BX`i' >= 7 & `var'BX`i' <= 20 if `var'AX`i' == 3;				
				
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
