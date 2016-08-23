clear all
timer clear 1
timer on 1
pause on
set more off

* Toggle These Options
cd "~/Desktop/github/SRHCS/" // Change the path to your working directory
global country 	= "Lebanon" // Change the country to the country that you want to replicate

******************************
********** Setup *************
******************************



if "$country" == "Kurdistan" global filename "Kurdistan Main Survey Final.xlsx"
if "$country" == "Jordan" global filename "Jordan Main Survey Final.xlsx"

global keep_vars Serial MEMID RR CAMP_YN

clear
set obs 1
gen issue = ""


*********************
*****  Import *******
*********************
if "$country" != "Lebanon" {

import excel using "rawdata/$filename", clear first

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
append using "RR2_$country"

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

saveold "data/random_respondents_$country", replace
}



***Lebanon***



if "$country" == "Lebanon" {




**********************************
*****  Main Sample Import ********
**********************************


import excel using "rawdata/Members1 Batch 10.xlsx", clear first
rename _all, upper
drop QUESTION
replace MAINID = 999999 if QUEST_ID == 628
duplicates drop
tostring *O *O_EN, replace

tempfile members_checks
save `members_checks', replace


import excel using "rawdata/HH1 Batch 10.xlsx", clear first
rename _all, upper
tostring *O *O_EN, replace

tempfile hh_checks
save `hh_checks', replace


**********************************
********  Booster Import *********
************************(*********


import excel using "rawdata/Members1 Booster Batch 4.xlsx", clear first
rename _all, upper
drop QUESTION
tostring *O *O_EN, replace

tempfile members_checks_booster
save `members_checks_booster', replace

import excel using "rawdata/HH1 Booster Batch 4.xlsx", clear first
rename _all, upper
tostring NB? NB?_EN *O *O_EN, replace

tempfile hh_checks_booster
save `hh_checks_booster', replace


********************************************
*****  Main Sample Merge - HH Level ********
********************************************

use `hh_checks', clear 	/* Now includes multiple observations for multiple HH's in dwelling */
cap drop DURATION 

egen COMPLETED = anycount(VR1 VR2 VR3 VR4), v(1)
egen COMPLETED_wo_R2 = anycount(VR1 VR2 VR3 VR4), v(8)
egen LEFT = anycount(VR1 VR2 VR3 VR4), v(5)
egen ABSENT = anycount(VR1 VR2 VR3 VR4), v(6)
egen REFUSED = anycount(VR1 VR2 VR3 VR4), v(7)

gen RESULT = 4 if ABSENT == 4 & QUEST_ID < 5000
replace RESULT = 3 if REFUSED == 1
replace RESULT = 2 if LEFT > 0
replace RESULT = 1 if COMPLETED == 1 | COMPLETED_wo == 1

forvalues i = 1 / 4 {
	cap replace RESULT = 5 if (VR`i' == 9 | VR`i' == 4) & (VR`i'_O_EN != "" | NB`i'_EN != "") & RESULT == .
}

replace RESULT = 2 if QUEST_ID == 1023
replace RESULT = 2 if QUEST_ID == 1079
replace RESULT = 2 if QUEST_ID == 1430
replace RESULT = 2 if QUEST_ID == 164
replace RESULT = 2 if QUEST_ID == 2014
replace RESULT = 2 if QUEST_ID == 2283
replace RESULT = 2 if QUEST_ID == 2437
replace RESULT = 2 if QUEST_ID == 2438
replace RESULT = 2 if QUEST_ID == 2523
replace RESULT = 2 if QUEST_ID == 2526
replace RESULT = 2 if QUEST_ID == 2629
replace RESULT = 2 if QUEST_ID == 2643
replace RESULT = 2 if QUEST_ID == 2665
replace RESULT = 2 if QUEST_ID == 2666
replace RESULT = 2 if QUEST_ID == 2667
replace RESULT = 2 if QUEST_ID == 2745
replace RESULT = 2 if QUEST_ID == 363
replace RESULT = 2 if QUEST_ID == 364
replace RESULT = 2 if QUEST_ID == 413
replace RESULT = 2 if QUEST_ID == 426
replace RESULT = 2 if QUEST_ID == 427
replace RESULT = 2 if QUEST_ID == 432
replace RESULT = 2 if QUEST_ID == 546
replace RESULT = 2 if QUEST_ID == 548
replace RESULT = 2 if QUEST_ID == 551
replace RESULT = 2 if QUEST_ID == 552
replace RESULT = 2 if QUEST_ID == 553
replace RESULT = 2 if QUEST_ID == 554
replace RESULT = 2 if QUEST_ID == 566
replace RESULT = 2 if QUEST_ID == 580
replace RESULT = 2 if QUEST_ID == 586
replace RESULT = 2 if QUEST_ID == 587
replace RESULT = 2 if QUEST_ID == 588
replace RESULT = 2 if QUEST_ID == 607
replace RESULT = 2 if QUEST_ID == 609
replace RESULT = 2 if QUEST_ID == 616
replace RESULT = 2 if QUEST_ID == 619
replace RESULT = 2 if QUEST_ID == 671
replace RESULT = 2 if QUEST_ID == 675
replace RESULT = 2 if QUEST_ID == 830

replace RESULT = 2 if QUEST_ID == 110
replace RESULT = 2 if QUEST_ID == 348
replace RESULT = 2 if QUEST_ID == 440
replace RESULT = 2 if QUEST_ID == 1724
replace RESULT = 2 if QUEST_ID == 2547

replace RESULT = 2 if QUEST_ID == 119
replace RESULT = 3 if QUEST_ID == 489
replace RESULT = 5 if QUEST_ID == 1426
replace RESULT = 1 if QUEST_ID == 1442
replace COMPLETED_wo_R2 = 1 if QUEST_ID == 1442
replace RESULT = 1 if QUEST_ID == 1451
replace COMPLETED_wo_R2 = 1 if QUEST_ID == 1451
replace RESULT = 1 if QUEST_ID == 1478
replace COMPLETED_wo_R2 = 1 if QUEST_ID == 1478
replace RESULT = 5 if QUEST_ID == 1544
replace RESULT = 1 if QUEST_ID == 1738
replace COMPLETED_wo_R2 = 1 if QUEST_ID == 1738
replace RESULT = 3 if QUEST_ID == 499
replace RESULT = 5 if QUEST_ID == 1490

replace RESULT = 4 if QUEST_ID == 110
replace RESULT = 4 if QUEST_ID == 413
replace RESULT = 5 if QUEST_ID == 517
replace RESULT = 5 if QUEST_ID == 523
replace RESULT = 5 if QUEST_ID == 531
replace RESULT = 5 if QUEST_ID == 536
replace RESULT = 4 if QUEST_ID == 546
replace RESULT = 4 if QUEST_ID == 548
replace RESULT = 4 if QUEST_ID == 551
replace RESULT = 4 if QUEST_ID == 552
replace RESULT = 4 if QUEST_ID == 553
replace RESULT = 4 if QUEST_ID == 554
replace RESULT = 5 if QUEST_ID == 566
replace RESULT = 4 if QUEST_ID == 580
replace RESULT = 4 if QUEST_ID == 646
replace RESULT = 4 if QUEST_ID == 671
replace RESULT = 4 if QUEST_ID == 722
replace RESULT = 4 if QUEST_ID == 1023
replace RESULT = 5 if QUEST_ID == 1327
replace RESULT = 5 if QUEST_ID == 1566
replace RESULT = 5 if QUEST_ID == 1754
replace RESULT = 5 if QUEST_ID == 1814
replace RESULT = 5 if QUEST_ID == 1826
replace RESULT = 4 if QUEST_ID == 1828
replace RESULT = 5 if QUEST_ID == 2121
replace RESULT = 5 if QUEST_ID == 2128
replace RESULT = 5 if QUEST_ID == 2238
replace RESULT = 5 if QUEST_ID == 2239
replace RESULT = 5 if QUEST_ID == 2240
replace RESULT = 5 if QUEST_ID == 2241
replace RESULT = 5 if QUEST_ID == 2243
replace RESULT = 5 if QUEST_ID == 2256
replace RESULT = 4 if QUEST_ID == 2283
replace RESULT = 4 if QUEST_ID == 2304
replace RESULT = 5 if QUEST_ID == 2378
replace RESULT = 5 if QUEST_ID == 2473
replace RESULT = 5 if QUEST_ID == 2629
replace RESULT = 4 if QUEST_ID == 2643
replace RESULT = 4 if QUEST_ID == 2665
replace RESULT = 4 if QUEST_ID == 2666
replace RESULT = 4 if QUEST_ID == 2667
replace RESULT = 4 if QUEST_ID == 2745

replace MAINID = 99 if QUEST_ID == 894 | QUEST_ID == 668 | QUEST_ID == 696 | QUEST_ID == 2451
replace MAINID = 999999 if QUEST_ID == 677 | QUEST_ID == 2420 | QUEST_ID == 745

replace PROXY = 0 if RESULT == 1 & QUEST_ID != 3428
replace PROXY = 2 if RESULT == 2 & PROXY == 0
replace PROXY = 2 if RESULT == 3 & PROXY == 0
replace PROXY = 2 if RESULT == 5 & PROXY == 0
replace PROXY = 2 if QUEST_ID == 742 | QUEST_ID == 872
replace PROXY = 2 if PROXY == 1 & MAINID == 999999

gen COMMENTS = "SECONDARY RESIDENCE" if QUEST_ID == 137 | QUEST_ID == 2121 | QUEST_ID == 2277 | QUEST_ID == 517  | QUEST_ID == 523 | QUEST_ID == 531 | QUEST_ID == 566 | QUEST_ID == 1327 | QUEST_ID == 1814 | QUEST_ID == 2629 | QUEST_ID == 2238 | QUEST_ID == 2239 | QUEST_ID == 2240 | QUEST_ID == 2241 | QUEST_ID == 2243 | QUEST_ID == 2256
replace COMMENTS = "WRONG ADDRESS" if QUEST_ID == 536 | QUEST_ID == 745 | QUEST_ID == 853
replace COMMENTS = "DIED" if QUEST_ID == 105 | QUEST_ID == 1566 | QUEST_ID == 1754 | QUEST_ID == 1826 | QUEST_ID == 2128 | QUEST_ID == 2378 | QUEST_ID == 2473
replace COMMENTS = VR3_O_EN if QUEST_ID == 2305
replace COMMENTS = NB1_EN if QUEST_ID == 1323
replace COMMENTS = VR1_O_EN if QUEST_ID == 1544 | QUEST_ID == 1426
replace COMMENTS = RG_EN if QUEST_ID == 1490

replace RESULT = 1 if QUEST_ID == 1634
replace RESULT = 2 if QUEST_ID == 547 | QUEST_ID == 1740 | QUEST_ID == 1792 | QUEST_ID == 2339 | QUEST_ID == 2350 | QUEST_ID == 2586
replace RESULT = 3 if QUEST_ID == 2142 | QUEST_ID == 2358
replace RESULT = 4 if QUEST_ID == 353 | QUEST_ID == 360 | QUEST_ID == 783 | QUEST_ID == 788 | QUEST_ID == 2123 | QUEST_ID == 2125
replace RESULT = 5 if QUEST_ID == 105

replace NOFHH  = 1 if QUEST_ID == 2198 | QUEST_ID == 2721 | QUEST_ID == 613 | QUEST_ID == 615 | QUEST_ID == 649 | QUEST_ID == 819 | QUEST_ID == 854

replace RAND2ID = 1 if QUEST_ID == 1442
replace RAND1ID = 0 if QUEST_ID == 1634
replace RAND2ID = 0 if QUEST_ID == 1634

keep if QUEST_ID < 4000

tempfile main_survey_merged
save `main_survey_merged', replace


***************************************
***** Booster Merge - HH Level ********
***************************************

use `hh_checks_booster', clear
drop DURATION 

egen COMPLETED = anycount(VR1 VR2 VR3 VR4), v(1)
egen COMPLETED_wo_R2 = anycount(VR1 VR2 VR3 VR4), v(8)
egen LEFT = anycount(VR1 VR2 VR3 VR4), v(5)
egen ABSENT = anycount(VR1 VR2 VR3 VR4), v(6)
egen REFUSED = anycount(VR1 VR2 VR3 VR4), v(7)

gen RESULT = 4 if ABSENT == 4 & QUEST_ID < 5000
replace RESULT = 3 if REFUSED == 1
replace RESULT = 2 if LEFT > 0
replace RESULT = 1 if COMPLETED == 1 | COMPLETED_wo == 1

gen COMMENTS = ""
gen VR4_O_EN = ""
forvalues i = 1 / 4 {
	tostring VR`i'_O_EN NB`i'_EN, replace
	replace RESULT = 5 if (VR`i' == 9 | VR`i' == 4) & (VR`i'_O_EN != "" | NB`i'_EN != "") & RESULT == .
	replace COMMENTS = VR`i'_O_EN if (VR`i' == 9 | VR`i' == 4) & RESULT == 5
	replace COMMENTS = NB`i'_EN   if (VR`i' == 9 | VR`i' == 4) & RESULT == 5 & COMMENTS == ""
}

replace RESULT = 2 if RESULT == 5
replace COMMENTS = ""
replace RESULT = 2 if QUEST_ID == 4023 | QUEST_ID == 4416 | QUEST_ID == 4418 | QUEST_ID == 4419 | QUEST_ID == 4424| QUEST_ID == 4425 | QUEST_ID == 4427 | QUEST_ID == 4428

replace PROXY = . if RESULT == 1
replace PROXY = 2 if RESULT > 1 & QUEST_ID < 5000
replace PROXY = 2 if QUEST_ID == 4025


tempfile 	main_survey_merged_booster
save `main_survey_merged_booster', replace


************************************************
***** Main Sample Merge - Members Level ********
************************************************

use `members_checks', clear
merge m:m QUEST_ID using `main_survey_merged', force
drop _me

replace MEMBID = 5 if QUEST_ID == 3462 & MEMBID == 999999

replace A22 = 3 if A13 < 5
replace A23 = 3 if A13 < 5
replace A22 = 2 if MEMBID == 1 & A13 == 84 & A22 == 3
replace A23 = 2 if MEMBID == 999999 & A13 == 47 & A23 == 3
replace A23 = 2 if MEMBID == 1 & A13 == 84 & A23 == 3

replace PP18 = 2 if QUEST_ID == 2343
replace PP19 = 0 if QUEST_ID == 2343
replace CHILDID1 = 0 if QUEST_ID == 1634

replace A23 = 1 if QUEST_ID == 4053 & MEMBID < 6
replace K11 = 0 if QUEST_ID == 4047

replace A10 = . if QUEST_ID == 706
replace A9  = . if QUEST_ID == 706
replace A9  = . if QUEST_ID == 363 | QUEST_ID == 413 | QUEST_ID == 546 | QUEST_ID == 547 | QUEST_ID == 548 | QUEST_ID == 551 | QUEST_ID == 616  | QUEST_ID == 619  | QUEST_ID == 1023  | QUEST_ID == 1740 | QUEST_ID == 1792   | QUEST_ID == 2523  | QUEST_ID == 2526 | QUEST_ID == 2547

replace A39 = . if QUEST_ID == 864
replace N8  = . if QUEST_ID == 395 | QUEST_ID == 1552
replace NN8 = . if QUEST_ID == 1424 | QUEST_ID == 1437
replace L1  = . if QUEST_ID == 395
replace W1  = . if QUEST_ID == 1424
replace L4  = . if L4 > 2010

replace COMPLETED_wo_R2 = . if QUEST_ID == 1254 | QUEST_ID == 1257
replace PROXY = 1 if RESULT >= 2 & RESULT <= 4 & PROXY_1_EN != "" & (A9 != . | A10 != .)

keep if QUEST_ID < 4000

tempfile main_survey_merged
save `main_survey_merged', replace


************************************************
******** Booster Merge - Members Level *********
************************************************


use `members_checks_booster', clear

merge m:m QUEST_ID using `main_survey_merged_booster', force
drop _me

replace A23 = 1 if QUEST_ID == 4053 & MEMBID < 6
replace K11 = 0 if QUEST_ID == 4047

replace PROXY = 2 if QUEST_ID == 135 | QUEST_ID == 2137 | QUEST_ID == 2394 | QUEST_ID == 4025
replace PROXY_1 = "" if QUEST_ID == 135 | QUEST_ID == 2137 | QUEST_ID == 2394 | QUEST_ID == 4025
replace PROXY_1_EN = "" if QUEST_ID == 135 | QUEST_ID == 2137 | QUEST_ID == 2394 | QUEST_ID == 4025



*************************************************************
***********Append "original" and boostersurveys**************
*************************************************************

append using `main_survey_merged', force
sort QUEST_ID


***************************************************************
******Export 'raw' Excel data to the "Replication" folder******
***************************************************************


keep if RESULT == 1

export excel using "rawdata/Lebanon Main Survey Final.xlsx", replace first(var)



************************************************
*********** Create more variables **************
************************************************

cap rename *_O *_OTHER
cap rename *_OT* *_OTHER
forvalues i = 1/7 {
	rename L6C_O`i' L6C_`i'_OTHER
	rename L7C_O`i' L7C_`i'_OTHER
}
order MEMBID, a(QUEST_ID)
order A9-A28, a(A7)
quietly: destring _all, replace

cap rename A21O_EN A21_O_EN
cap rename D4_1O_EN D4_1_O_EN
cap rename LC6_O1_EN L6C_1_O_EN
cap rename L6C_O2_EN L6C_2_O_EN
cap rename L6C_O3_EN L6C_3_O_EN
cap rename L7C_O1_EN L7C_1_O_EN
cap rename L7C_O2_EN L7C_2_O_EN

quietly: ds *, not(type string)
local vars `r(varlist)'
local numerics N_MALE	N_FEMALE CHILDID1 RAND1ID RAND2ID	A5	A7	A13	A20	A30	A33	A39	B4_1 B4_2 B9 D1_1 D1_2 D1_3 D1_4	D1_5 D1_6 D1_7	D1_8 D1_9 D1_10	D1_11 D1_12	D1_13 D1_14	D1_15 E3	H3	J8 J9	J10	K5	K8	K11 M3	O14 P8	P19	R16	S6	S12 MM3 OO14 PP8 PP19 RR16 SS6 SS12
foreach var of local numerics {
	replace `var' = . if `var' == 999999
}

local to_replace : list vars - numerics
di "`to_replace'"
foreach var of local to_replace {
	replace `var' = . if `var' == 0 | `var' == 999999
}

replace A20 = 12 if A20 == . & A19 == 7
replace A20 = 13 if A20 == . & A19 == 9

replace HHNUM = 1 if HHNUM > 9

bys QUEST_ID: egen HHcheck = total(MAINID == MEMBID)
bys QUEST_ID: egen max_MEMBID = max(MEMBID) /* Not always equal to HH size if out of dwelling */
bys QUEST_ID: egen hh_refugees = total(A23 == 1)
bys QUEST_ID: egen hh_registered_unhcr = total(A24 == 1) 
bys QUEST_ID: egen hh_working_age = total(A13 >= 15 & A13 <= 64 & A11 == 1)
bys QUEST_ID: egen hh_businesses_A21 = total(A21 <= 2)
bys QUEST_ID: egen hh_employees_A21 = total(A21 == 3 | A21 == 5) 
bys QUEST_ID: egen hh_working_A21 = total(A21 <= 3 | A21 == 5)
bys QUEST_ID: egen hh_children = total(A13 >= 3 & A13 <= 18 & A11 == 1)
bys QUEST_ID: egen hh_children_3_15 = total(A13 >= 3 & A13 <= 15 & A11 == 1)
bys QUEST_ID: egen hh_children_u12 = total(A13 < 12 & A11 == 1)
bys QUEST_ID: egen hh_children_u18 = total(A13 <= 18 & A11 == 1)
bys QUEST_ID: egen hh_male_indwelling = total(A9 == 1 & A11 == 1)
bys QUEST_ID: egen hh_female_indwelling = total(A9 == 2 & A11 == 1)
gen hh_indwelling = hh_male_indwelling + hh_female_indwelling
gen A30_neg = -A30
egen hh_workers_2010 = rowtotal(hh_working_age A33 A30_neg)
replace hh_workers_2010 = 1 if hh_workers_2010 < 1
gen after_sept_2010 = (A26_Y > 2010 | (A26_M >= 9 & A26_M <= 12))

gen hh_level = (MAINID == MEMBID & MAINID != .)
bys QUEST_ID: egen hh_level_all = total(hh_level)
bys QUEST_ID (MEMBID): replace hh_level = 1 if _n == 1 & hh_level_all == 0 & QUEST_ID != .

forvalues i = 1 / 9 {
	egen RESULT_`i' = anymatch(VR1 VR2 VR3 VR4), v(`i')
}

gen main_survey_month = .
gen main_survey_day = .
forvalues i = 1 / 4 {
	replace main_survey_month = VM`i' if VR`i' == 1
	replace main_survey_day = VD`i' if VR`i' == 1
	replace main_survey_month = VM`i' if VM`i' != . & RESULT_1 != 1
	replace main_survey_day = VD`i' if VD`i' != . & RESULT_1 != 1
}
gen main_survey_year = 2015
replace main_survey_year = 2016 if main_survey_month < 4

egen moves_within_Lebanon_secL = anycount(L6C_?), v(1)
gen year_arrived_Lebanon_secL = .
gen month_arrived_Lebanon_secL = .
gen district_arrived_Lebanon_secL = .
gen moved_to_Syria = 0
forvalues i = 1/8 {
	local j = 9 - `i'
	replace year_arrived_Lebanon_secL = L5Y_`j' if L7C_`j' == 1
	replace month_arrived_Lebanon_secL = L5M_`j' if L7C_`j' == 1
	replace district_arrived_Lebanon_secL = L7A_`j' if L7C_`j' == 1
	replace moved_to_Syria = (L6C_`i' == 1 & L7C_`i' == 2) if moved_to_Syria == 0
}
replace year_arrived_Lebanon_secL = . if L3_C == 1
replace month_arrived_Lebanon_secL = . if L3_C == 1

tostring *OTHER *O_EN, replace
rename SEGCODE SEGCODE_CRI

ds A1-A39
local vars `r(varlist)'
egen secA_answered = rownonmiss(`vars'), strok

ds B1_1-K22_O_EN
local vars `r(varlist)'
egen secB_K_answered = rownonmiss(`vars'), strok

ds L1-L15_O_EN U1-W9
local vars `r(varlist)'
egen secL_W_answered = rownonmiss(`vars'), strok

ds M1-T3
local vars `r(varlist)'
egen secM_T_answered = rownonmiss(`vars'), strok

ds MM1-TT3
local vars `r(varlist)'
egen secMM_TT_answered = rownonmiss(`vars'), strok


do "labels_l.do"


order VR4_O_EN, after(VR4_OTHER)
order B1_2_O_EN, after(B1_2_OTHER)
order F2_O_EN, after(F2_OTHER) 
order NN6_O_EN, after(NN6_OTHER)


***Export the 'raw' Excel file and cleaned data files to the Replication folder***

export excel using "rawdata/Lebanon Main Survey Final.xlsx", replace first(var)

preserve

drop A1 - A7 A29 - TT3
keep if RESULT == 1
saveold "data/Lebanon_roster", replace

restore

preserve

keep if (RANDID1 == MEMBID | RANDID2 == MEMBID) & RESULT == 1
save "data/Lebanon_random_respondents", replace

restore

preserve

keep if CHILDID1 == MEMBID & RESULT == 1
saveold "data/Lebanon_selected_child", replace

restore

preserve

drop A9 - A28
duplicates drop QUEST_ID, force
saveold "dataLebanon_hh_level", replace

restore


}


