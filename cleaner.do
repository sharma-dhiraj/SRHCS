clear all
timer clear 1
timer on 1
pause on
set more off

global path = "/Users/Stinson/Desktop/github/SRHCS/"
cd "$path"

global country 	= "Kurdistan"
if "$country" == "Kurdistan" global filename "Kurdistan Main Survey Final.xlsx"
if "$country" == "Jordan" global filename "Jordan Main Survey Final.xlsx"

global keep_vars Serial MEMID RR CAMP_YN

do programs

clear
set obs 1
gen issue = ""

*********************
*****  Import *******
*********************

import excel using "$path/rawdata/$filename", clear first


if "$country" == "Kurdistan" {

rename COMMENTS QUEST_NUM

recode L13AX1 L13AX2 L13AX3 L13AX4 L13AX5 L13AX6 L13AX7 L13AX1Y L13AX2Y L13AX3Y L13AX4Y L13AX5Y L13AX6Y L13AX7Y (-998 998 999 = .)	//They entered 999 or 998 instead of 0 for camp

recode NUMBEROFHOUSEHOLDMALE TOTAL NUMBEROFHOUSEHOLDFEMALE (0 = .) if PROXY==5							//They entered 0 when they couldn't talk to anyone.
recode NUMBEROFHOUSEHOLDMALE TOTAL NUMBEROFHOUSEHOLDFEMALE (0 = .) if HHRESULTV4 >= 3 & HHRESULTV4 !=. 
recode NUMBEROFHOUSEHOLDMALE TOTAL NUMBEROFHOUSEHOLDFEMALE (0 = .) if HHRESULTV3 >= 3 & HHRESULTV3 !=. 
recode NUMBEROFHOUSEHOLDMALE TOTAL NUMBEROFHOUSEHOLDFEMALE (0 = .) if HHRESULTV2 >= 3 & HHRESULTV2 !=. 
recode NUMBEROFHOUSEHOLDMALE TOTAL NUMBEROFHOUSEHOLDFEMALE (0 = .) if HHRESULTV1 >= 3 & HHRESULTV1 !=. 

*PROXYRESPONDENT is left missing when there was no proxy respondent.  I'm changing it to 5 (= None).
replace PROXYRESPONDENT = 5 if HHRESULTV4 >= 3 & HHRESULTV4 <= 7 & PROXYRESPONDENT == . 
replace PROXYRESPONDENT = 5 if HHRESULTV3 >= 3 & HHRESULTV3 <= 7 & PROXYRESPONDENT == . 
replace PROXYRESPONDENT = 5 if HHRESULTV2 >= 3 & HHRESULTV2 <= 7 & PROXYRESPONDENT == .
replace PROXYRESPONDENT = 5 if HHRESULTV1 >= 3 & HHRESULTV1 <= 7 & PROXYRESPONDENT == .


recode A2 (2 = .) if PROXY !=.
recode A49 (-983 -99 -98 98 = -98)

recode CURRENCY1 (1 2 3 = .) if O33 == 2	//Fatma says QPS asks for currency even when the questionnaire demands a skip
recode CURRENCY1Y (1 2 3 = .) if O33Y == 2	

recode CURRENCY2 (1 2 3 = .) if O43 == 2
recode CURRENCY2Y (1 2 3 = .) if O43Y == 2

recode CURRENCY3 (1 2 3 = .) if O47 == 2
recode CURRENCY3Y (1 2 3 = .) if O47Y == 2

recode CURRENCY4 (1 2 3 = .) if O57 == 2
recode CURRENCY4Y (1 2 3 = .) if O57Y == 2

recode CURRENCY5 (1 2 3 = .) if P44 == 2
recode CURRENCY5Y (1 2 3 = .) if P44Y == 2

recode CURRENCY6 (1 2 3 = .) if P59 == 2
recode CURRENCY6Y (1 2 3 = .) if P59Y == 2

recode CURRENCY7 (1 2 3 = .) if Q4 == 2
recode CURRENCY7Y (1 2 3 = .) if Q4Y == 2

recode CURRENCY8 (1 2 3 = .) if Q17 == 2
recode CURRENCY8Y (1 2 3 = .) if Q17Y == 2

recode CURRENCY9 (1 2 3 = .) if R7 == 9
recode CURRENCY9Y (1 2 3 = .) if R7Y == 9

recode CURRENCY11 (1 2 3 = .) if R23 == 2
recode CURRENCY11Y (1 2 3 = .) if R23Y == 2

recode CURRENCY12 (1 2 3 = .) if S20 == 2
recode CURRENCY12Y (1 2 3 = .) if S20Y == 2

replace E2H1 = E2H if Serial == 1519	//Expenditure was coded entered in percent column.
replace E2H = . if Serial == 1519

recode B1SEPTEMBER2010 (500 = .) 		

replace GOVERNORATE = "Sulamaniyah" if inlist(Serial,924)
replace	GOVERNORATE = "Duhok" if inlist(Serial, 1888)
}



if "$country" == "Jordan" {

gen QUEST_NUM = Serial

*IPSOS has entered CAMP and CAMPCODE the same way.  Just changing the CAMP variable. 

replace CAMP = 1 if inlist(CAMPCODE, 1, 2) 
replace CAMP = 2 if inlist(CAMPCODE, .) 

forval i = 1/7 {
replace L13AX`i' = 0 if L13BX`i' != . 
replace L13AX`i'Y = 0 if L13BX`i'Y != . 
} 

recast str244 GENERALCOMMENTS, force 	//GENERALCOMMENTS variable in Jordan data has more than 244 characters. Older versions of Stata cannot handle this.

replace B1REF = 212 if CAMPCODE == 2 & B1REF >= 2514 & B1REF <= 2521	//Subdistrict of Azraq is entered instead of district in B1REFUGEESANDIDPs.

}

quietly: destring _all, replace

gen section_answered = .
gen MEMID = .
gen CAMP_YN = CAMP
gen RR = .

duplicates drop


forvalues i = 1/4 {
	cap replace COMMENTSV`i' = upper(COMMENTSV`i')
	cap replace COMMENTSV`i' = "" if COMMENTSV`i' == "NONE" | COMMENTSV`i' == "none" | COMMENTSV`i' == "None" | COMMENTSV`i' == "n one" | COMMENTSV`i' == "non e" | COMMENTSV`i' == "non e." | COMMENTSV`i' == "none3"
}



rename (A16X*_1 ) (A16_1X* )
rename (A26X*_1 A26X*_2 A26X*_3) (A26_1X* A26_2X* A26_3X*)
rename (A27*A A27*B A27*C A27*D A27*E A27*F A27*G) (A27A* A27B* A27C* A27D* A27E* A27F* A27G*)
	
rename *ONLY *
rename (J3X L9X P17X ENDHX ENDMX VARENDX) (J3A L9A P17A ENDHR1 ENDMR1 VARENDR1)
rename L10AYY L10AY
rename *Y_? *_?Y
drop VE
cap rename *KURDISTAN *SEPTEMBER2013
cap rename U7 U7_1

rename REGISTRATIONNUMBERA REGISTRATIONNUMBER1

gen HHRESULT = .
gen R1RESULT = .
gen R2RESULT = .

gen survey_month = .
gen survey_day = .

forvalues i = 1/4 {

	replace R1RESULTV`i' = 9 if RESPONDENTID1 == 0 | (HHRESULTV`i' >= 3 & HHRESULTV`i' <= 8)
	replace R2RESULTV`i' = 9 if RESPONDENTID2 == 0 | (HHRESULTV`i' >= 3 & HHRESULTV`i' <= 8)
	
	local j = 5 - `i'
	
	replace HHRESULT = HHRESULTV`j' if HHRESULT == .
	replace R1RESULT = R1RESULTV`j' if R1RESULT == .
	replace R2RESULT = R2RESULTV`j' if R2RESULT == .
	
	replace survey_month = MONTHV`i' if survey_month == .
	replace survey_day = DAYV`i' if survey_day == .
	
}

replace CHILDID  = . if HHRESULT > 2
replace R1RESULT = . if HHRESULT > 2
replace R2RESULT = . if HHRESULT > 2

replace CHILDID = . if HHRESULT > 2 & HHRESULT < 9
replace RESPONDENTID1 = . if HHRESULT > 2 & HHRESULT < 9
replace RESPONDENTID2 = . if HHRESULT > 2 & HHRESULT < 9

************************************************

sum MEMBER
local max_members = r(max)

forvalues i = 1/`max_members' {
	cap gen A16_2X`i' = .
	cap gen A16_3X`i' = .
	order A16_2X`i' A16_3X`i', a(A16_1X`i')
}

ds A31X*
local empty_roster = word("`r(varlist)'",-1)

drop A9X`max_members' - `empty_roster'
reshape long A9X A10X A11X A12X A13X A14X A15X A16_1X A16_2X A16_3X A17X A18X A19X A20X A21X A22X A23X A24X A25X A26_1X A26_2X A26_3X A27AX A27BX A27CX A27DX A27EX A27FX A27GX A28AX A28BX A29X A30X A31X, i(Serial) j(MEMBID)
drop if MEMBID > MEMBER

rename *X *
replace MEMID = MEMBID

bys Serial: egen hh_male_indwelling = total(A10 == 1 & A12 <= 5)
bys Serial: egen hh_female_indwelling = total(A10 == 2 & A12 <= 5)
bys Serial: egen hh_children = total(A14 >= 4 & A14 <= 18 & A12 <= 3)
bys Serial: egen hh_working_age = total(A14 >= 15 & A14 <= 64 & A12 <= 3)
bys Serial: egen hh_refugees = total(A24 == 1 | A24 == 3)
bys Serial: egen hh_idps = total(A24 == 2 | A24 == 3)
bys Serial: egen hh_businesses_A21 = total(A21 <= 2)
bys Serial: egen hh_employees_A21 = total(A12 == 4 | A21 == 3 | A21 == 4 | A21 == 6)
bys Serial: egen hh_working_A21 = total(A21 <= 4 | A21 == 6)
bys Serial (A13): gen oldest_hh_member_birth_year = A14[_N]
bys Serial: egen hh_children_u12 = total(A14 < 12 & A12 <= 3)
bys Serial: egen hh_children_u18 = total(A14 < 18 & A12 <= 3)
gen after_sept_2010 = (A28A > 2010 | (A28B >= 9 & A28B <= 12))


if "$country" == "Kurdistan" {
replace GOVERNO = upper(GOVERNO)
replace GOVERNO = "11" if strpos(GOVERNORATE,"D") == 1 | strpos(GOVERNORATE,"OK") > 0
replace GOVERNO = "13" if strpos(GOVERNORATE,"SU") > 0 | strpos(GOVERNORATE,"LA") > 0
replace GOVERNO = "15" if strpos(GOVERNORATE,"ER") > 0 | strpos(GOVERNORATE,"IL") > 0
}


if "$country" == "Jordan" {
g 		GOVERNOR = "2" if strpos(GOVERNORATE,"Am") == 1 | strpos(GOVERNORATE,"an") > 0
replace	GOVERNOR = "1" if GOVERNORATE == "mafraq" | strpos(GOVERNORATE,"alm") == 1 | strpos(GOVERNORATE,"maf") > 0 | strpos(GOVERNORATE,"Maf") > 0 | strpos(GOVERNORATE,"MAF") > 0 | strpos(GOVERNORATE,"Alm") == 1 | strpos(GOVERNORATE,"za'") > 0 | strpos(GOVERNORATE,"zat") > 0 | strpos(GOVERNORATE,"zaat") > 0 | strpos(GOVERNORATE,"ZAT") > 0 | strpos(GOVERNORATE,"zar") > 0 | strpos(GOVERNORATE,"zta") > 0 | strpos(GOVERNORATE,"z't") > 0 | strpos(GOVERNORATE,"z'a") > 0 | strpos(GOVERNORATE,"mof") > 0 | strpos(GOVERNORATE,"mfr") > 0 | GOVERNORATE == "maraq" | GOVERNORATE == "madraq"  
replace	GOVERNOR = "4" if GOVERNORATE == "azraq" | strpos(GOVERNORATE,"rqa") > 0 | strpos(GOVERNORATE,"RQA") > 0 | strpos(GOVERNORATE,"AZR") > 0 | strpos(GOVERNORATE,"azr") > 0 | GOVERNORATE == "ZQARA" | GOVERNORATE == "alzraq" | GOVERNORATE == "ZARQZ" 
}

gen DISTRICT_standard = .

if "$country" == "Kurdistan" {
replace DISTRICT_standard = DISTRICT if GOVERNOR == "11"
replace DISTRICT_standard = DISTRICT + 7 if GOVERNOR == "13"
replace DISTRICT_standard = DISTRICT + 23 if GOVERNOR == "15" & DISTRICT <= 6 
replace DISTRICT_standard = DISTRICT + 22 if GOVERNOR == "15" & DISTRICT >= 8 
tostring DISTRICT_standard, replace
}

if "$country" == "Kurdistan" {
gen CAMPCODE_str = CAMPCODE
tostring CAMPCODE_str, replace
gen CAMPCODE_standard = GOVERNOR + "0" + CAMPCODE_str if CAMPCODE < 10
replace CAMPCODE_standard = GOVERNOR + CAMPCODE_str if CAMPCODE >= 10 & CAMP == 1
}

if "$country" == "Jordan" destring CAMPCODE, replace

*gen CURRENT_LOCATION = CAMPCODE_standard if CAMP == 1
*replace CURRENT_LOCATION = DISTRICT_standard if CURRENT_LOC == ""
g CURRENT_LOCATION = DISTRICT_standard
destring CURRENT_LOC GOVERNOR DISTRICT_standard, replace

ds BEGHA - ROSTERIDE8
local vars `r(varlist)'
egen secA_answered = rownonmiss(`vars'), strok

ds B1CURRENT - K25
local vars `r(varlist)'
egen secB_K_answered = rownonmiss(`vars'), strok

ds BEGHL - ZX13B3
local vars `r(varlist)'
egen R1_answered = rownonmiss(`vars'), strok

ds BEGHLY - T3Y
local vars `r(varlist)'
egen R2_answered = rownonmiss(`vars'), strok

if "$country" == "Jordan" drop if HHRESULT >= 3 & PROXYRESPONDENT == . //In Jordan, they didn't contact proxy respondents.

if "$country" == "Jordan" do labels_j
if "$country" == "Kurdistan" do labels_k 

//order A47XX  , after(A47X1)
//order A47XXX2, after(A47X2)
//order A47XXX3, after(A47X3)

gen Checkvars = .
label var Checkvars "******Variables created for consistency checks******"
order Checkvars, before(MEMID)

order section_answered, before(secA_answered)

saveold "all_$country", replace

keep Serial - ROSTERIDE8 
saveold "roster_$country", replace

use "all_$country", clear
bys Serial (MEMBID): gen hh_level = _n
keep if hh_level == 1
drop hh_level

saveold "hh_level_$country", replace

use "all_$country", clear
bys Serial: gen hh_level = _n
keep if A32 == MEMBID | (A32 == 88 & hh_level == 1)
drop hh_level

saveold "main_respondent_$country", replace

use "all_$country", clear
keep if K1 == MEMBID
saveold "selected_child_$country", replace

use "all_$country", clear
keep if RESPONDENTID2 == MEMBID
replace RR = 2
gen RR_answered = R2_answered
drop BEGHL-VARENDR1
rename *Y *

saveold "RR2_$country", replace

use "all_$country", clear
keep if RESPONDENTID1 == MEMBID
gen RR_answered = R1_answered
replace RR = 1
drop *Y
append using "RR2"

gen yearofarrival_SecL = .
gen monthofarrival_SecL = .
gen districtarrived_SecL = .
gen movedtoSyria = 0

label var yearofarrival_SecL "Year of arrival to country from Section L"
label var monthofarrival_SecL "Month of arrival to country from Section L"
label var districtarrived_SecL "First district of residence in country"
label var movedtoSyria "Moved back to Syria"

if "$country" == "Kurdistan" {
forval i = 1/7 {
local j = 8 - `i'
	local k = `j' - 1
	replace yearofarrival_SecL = L12BX`j' if (L13AX`j' == 1 | (L13AX`j' == . & L13BX`j' != .)) & A24 < 3
	replace monthofarrival_SecL = L12AX`j' if L13AX`j' == 1
	replace districtarrived_SecL = L13CX`j' if L13AX`j' == 1
	if `k' > 0 replace movedtoSyria = (L13AX`j' == 3 & L13AX`k' == 1) if movedtoSyria == 0 & "$country" == "I" 
}
}

if "$country" == "Jordan" {
forval i = 1/7 {
local j = 8 - `i'
	local k = `j' - 1
	replace yearofarrival_SecL = L12BX`j' if (L13AX`j' == 1 | (L13AX`j' == 0 & L13BX`j' != .)) & A24 < 3
	replace monthofarrival_SecL = L12AX`j' if L13AX`j' == 1
	replace districtarrived_SecL = L13CX`j' if L13AX`j' == 1
	if `k' > 0 & movedtoSyria == 0 replace movedtoSyria = (L13AX`j' == 2 & L13AX`k' == 1) 
}
}

egen 	moves_within_country_secL = anycount(L13AX?), v(1)
if "$country" == "Kurdistan" egen CAMP_moves_within_country_secL = anycount(L13BX?), v(1100/1509)
if "$country" == "Jordan" egen CAMP_moves_within_country_secL = anycount(L13CX?), v(2502/2521)
replace moves_within_country_secL = moves_within_country_secL + CAMP_moves_within_country_secL - 1
replace moves_within_country_secL = 0 if moves_within_country_secL < 0

foreach var of varlist yearofarrival_SecL - districtarrived_SecL {
	bysort Serial (`var'): replace `var' = `var'[1] if `var' == . /* L7 should =1 */
}

foreach var of varlist movedtoSyria - CAMP_moves_within_country_secL  {
	bysort Serial (`var'): replace `var' = `var'[_N] if L7 == 1
}

order L9X, after(L9A)
order P17X, after(P17A)
order ENDHT ENDMT VARENDT, after(VARENDR1)

saveold "random_respondents_$country", replace
