#delimit ;

//use "$box/Main Survey Consistency Checks/all.dta", clear;

label var section_answered "Answered section [...]";
label var MEMID "Member ID";
label var CAMP_YN "Camp sample 1 = Yes, 2 = No";
label var RR "Random respondent";

label var HHRESULT "Result of the household survey";
label var R1RESULT "Survey result of random respondent 1";
label var R2RESULT "Survey result of random respondent 2";

label var survey_month "Month of survey";
label var survey_day "Day of survey";

label var hh_male_indwelling "Number of males living in the dwelling";
label var hh_female_indwelling "Number of females living in the dwelling"; 
label var hh_children "Number of children";
label var hh_working_age "Number of working-age household members" ; 
label var hh_refugees "Number of refugees in the household";
label var hh_idps "Number of IDPs in the household";
label var hh_businesses_A21 "Number of household members in self-employment";
label var hh_employees_A21 "Number of household members in wage-employment";
label var hh_working_A21 "Number of household members working";
label var oldest_hh_member_birth_year "Birth year of the oldest highest member";
label var hh_children_u12 "Number of children 12 years or younger";
label var hh_children_u18 "Number of childre 18 years or younger";
label var after_sept_2010 "Left Syria/source governorate on or after Sept 2010";

label var DISTRICT_standard "District code";
label var CAMPCODE_str "Campcode";
label var CAMPCODE_standard "Campcode";
label var CURRENT_LOCATION "Current district of residence";
label var secA_answered "Dummy variable for whether section A is answered";
label var secB_K_answered "Dummy variable for whether section B to K is answered";
label var R1_answered "Dummy variable for whether random respondent 1 is interviewed";
label var R2_answered "Dummy variable for whether random respondent 2 is interviewed";

cap label var A9 "A9: What is [NAME]'s name or initials? If respondent is uncomfortable giving name, use initials instead   ";
cap label var A10 "A10: What is [NAME]'s gender?   ";
cap label var A11 "A11: What is [NAME]'s relationship to the HH head?   ";
cap label var A12 "A12: What is the main residence of [NAME]?   ";
cap label var A13 "A13: When was [NAME] born?   ";
cap label var A14 "A14: What was [NAME]'s age at his/her last birthday   ";
cap label var A15 "A15: What country was [NAME] born in?   ";
cap label var A16_1 "A16: What nationality or nationalities is [NAME]?   ";
cap label var A17 "A17: What is [NAME]'s marital status?   ";
cap label var A18 "A18: Has [NAME] ever attended school?   ";
cap label var A19 "A19: What is the highest level [NAME] attended in the formal system (i.e. before transferring to vocational system if applicable)?   ";
cap label var A20 "A20: What is the highest level of education [NAME] completed?   ";
cap label var A21 "A21: What is [NAME]'s current work status?   ";
cap label var A22 "A22: Was [NAME] living in Syria in 2010?   ";
cap label var A23 "A23: N/A: THIS QUESTION ONLY RELEVANT IN KURDISTAN   ";
cap label var A24 "A24: Was [NAME] living in Iraq (outside of Kurdistan) in 2013?   ";
cap label var A25 "A25: Is [NAME] currently registered with UNHCR or MDM?   ";
cap label var A26_1 "A26: Why hasn't [NAME] registered?   ";
cap label var A27A "A27A: Does [NAME] have any of the following documents? (Multiple responses allowed)   ";
cap label var A28A "A28A: When did [NAME] leave Syria (Refugees) / source governorate (IDPs)? (NOTE: If someone fits the definition of Refugee and IDP, ask questions with respect to Syria)   ";
cap label var A28B "A28B: When did [NAME] leave Syria (Refugees) / source governorate (IDPs)? (NOTE: If someone fits the definition of Refugee and IDP, ask questions with respect to Syria)   ";
cap label var A29 "A29: At the time of leaving Syria /source governorate: was [NAME] in school";
cap label var A30 "A30: How many levels of school has [NAME] attended in Jordan?   ";
cap label var A31 "A31: At the time of leaving Syria /source governorate: was [NAME] employed or operating a business";

cap label define dist_gov 1 "Center, Duhok" 2 "Sumel, Duhok" 3 "Zaxo, Duhok" 4 "Amedi, Duhok" 5 "Shixan, Duhok" 6 "Akre, Duhok" 7 "Bardarash,Duhok" 
8 "Center, Sulaimaniya" 9 "Qaradax, Sulaimaniya" 10 "Sharazor, Sulaimaniya" 11 "Sayedsadq, Sulaimaniya" 12 "Halabja, Sulaimaniya" 13 "Benjwen, Sulaimaniya" 14 "Mawat, Sulaimaniya" 15 "Mawat, Sulaimaniya" 
 16 "Peshdar, Sulaimaniya" 17 "Ranya, Sulaimaniya" 18 "Dokan, Sulaimaniya" 19 "Darbandexan, Sulaimaniya" 20 "Kelar, Sulaimaniya" 21 "Kefri, Sulaimaniya" 22 "Chamchamal, Sulaimaniya" 23 "Xanagen, Sulaimaniya" 
24 "Center, Erbil" 25 "Dashti Hawler, Erbil" 26 "Soran, Erbil" 27 "Shaqlawa, Erbil" 28 "Choman, Erbil" 29 "Koya, Erbil" 30 "Mergasor, Erbil" 31 "Xabat, Erbil" 32 "Rawndoz, Erbil" 33 "Maxmor, Erbil" 
34 "Mosul Center, Ninawa" 35 "Hamdania, Ninawa" 36 "Talkif, Ninawa" 37 "Senchar, Ninawa" 38 "Telafar, Ninawa" 39 "Shexan, Ninawa" 40 "Hadar, Ninawa" 41 "Behach, Ninawa" 
42 "Karbala Center, Karbala" 43 "Ein tamer, Karbala" 44 "Hendya, Karbala" 45 "Kirkuk Center, Kirkuk" 46 "Hawecha, Kirkuk" 47 "Daquq, Kirkuk" 48 "Dibs, Kirkuk" 
49 "Baquba Center, Diyala" 50 " Miqdadiya, Diyala" 51 "Xalis, Diyala" 52 "Xanaqin, Diyala" 53 "Balad roz, Diyala" 54 "Kefri, Diyala" 
55 "Ramadi Center, Anbar" 56 "Hit, Anbar" 57 "Fallujah, Anbar" 58 "Ana, Anbar" 59 "Haditha, Anbar" 60 "Retba, Anbar" 61 "Al-Qa'im, Anbar" 62 "Rawa, Anbar" 
63 "Nasiriyah Center, ThiQar" 64 "Rifai, ThiQar" 65 "Sog Al Shuokh, ThiQar" 66 "Chabaish, ThiQar" 67 "Shatra, ThiQar" 
68 "Rusafa, Baghdad" 69 "Adhamiya, Baghdad" 70 "M.alsdralthanih, Baghdad" 71 " M.Sadr first, Baghdad" 72 "Karkh, Baghdad" 73 "Kadhimiya, Baghdad" 74 "Mahmudiya, Baghdad" 75 "Abu Ghraib, Baghdad" 76 "Tarmiya, Baghdad" 77 "Madain, Baghdad" 
78 "Hilla Center, Babel" 79 "Mahaweel, Babel" 80 "Hashemia, Babel" 81 "Musayib, Babel" 
82 "Cott, Wasit" 83 "Numaniya, Wasit" 84 "Hay, Wasit" 85 "Badra, Wasit" 86 "Essaouira, Wasit" 87 "Azizia, Wasit" 
88 "Tikrit, Salahadin" 89 "Tooz, Salahadin" 90 "Samarra Center, Salahadin" 91 "Balad, Salahadin" 92 "Peggy, Salahadin" 93 "Dour, Salahadin" 94 "Sharqat, Salahadin" 95 "Dujail, Salahadin" 
96 "Najaf, Najaf" 97 "Kufa, Najaf" 98 "Manathira, Najaf" 99 "Diwaniya Center, Qadisiya" 100 "Afak, Qadisiya" 101 "Shamya, Qadisiya" 102 "Hamza, Qadisiya" 
103 "Samawa Center, Muthanna" 104 "Rumaitha, Muthanna" 105 "Salman, Muthanna" 106 "Khther, Muthanna" 107 "Warka, Muthanna" 
108 "Imara Center, Missan" 109 "Ali Al Xarbi, Missan" 110 "Maymouna, Missan" 111 "Qalat Saleh, Missan" 112 "Machar al Kabir, Missan" 113 "Alekhala, Missan" 
114 "Basra Center, Basra" 115 "Abi Al Xasib, Basra" 116 "Zubir, Basra" 117 "Qurna, Basra" 118 "Faw, Basra" 119 "Shatt al-Arab, Basra" 120 "Al Madina, Basra" 
121 "Dimashiq, Damascus" 
122 "Chabal Saman, Halab" 123 "Bab, Halab" 124 "Afrin, Halab" 125 "Izaz, Halab" 126 "Manbej, Halab" 127 "Ein Arab, Halab" 128 "Safira, Halab" 129 "Jarablos, Halab" 
130 "Dimashiq Village Center, rural Damascus" 131 "Doma, rural Damascus" 132 "Qatifa, rural Damascus" 133 "Tall, rural Damascus" 134 "Yabrood, rural Damascus" 135 "Nabek, rural Damascus" 136 "Zabadani, rural Damascus" 137 "Katana, rural Damascus" 138 "Darya, rural Damascus" 
139 "Homs center, Homs" 140 "Qasir, Homs" 141 "Tlklkh, Homs" 142 "Rastan, Homs" 143 "Tadmor, Homs" 144 "Al Maxram, Homs" 
 145 "Hamat Center, Hamat" 146 "Al-Suqaylabiyah, Hamat" 147 "Sulaima, Hamat" 148 "Masyaf, Hamat" 149 "Mharada, Hamat" 
150 "Lathiqeya Center, Lathiqeya" 151 "Chabla, Lathiqeya" 152 "Hafa, Lathiqeya" 153 "Qerdaha, Lathiqeya" 
 154 "Edlab Center, Edlab" 155 "Muara ala Numan, Edlab" 156 "Harem, Edlab" 157 "Jisr Al Shokhor, Edlab" 158 "Hilla Center, Edlab" 
159 "Haska Center, Haska" 160 "Qamishli, Haska" 161 "Maalikis, Haska" 162 "Ras Al Ain, Haska" 
 163 "Deir al Zowar, Deir Al Noor" 164 "Abu Kamal, Deir Al Noor" 165 "Mayadin, Deir Al Noor" 
 166 "Tartous Center, Tartous" 167 "Banias, Tartous" 168 "Safita, Tartous"  169 "Dreikish, Tartous" 170 "Sheikh Bader, Tartous" 
 171 "Raqa Center, Raqa" 172 "Tell Abyad, Raqa" 173 "Al Thawra, Raqa" 
 174 "Darha Center, Daraa" 175 "Al Sanamayn, Daraa" 176 "Azrah, Daraa" 
 177 "Siwadya Center, Diwadya" 178 "Salkhad, Diwadya" 179 "Shahba, Diwadya"  
 180 "Kenitra, Qantera" 181 "Fiq Zawya, Qantera" ;

label values B1CURRENT B1SEPTEMBER2013 B1SEPTEMBER2010 B1REFUGEESANDIDPS dist_gov;

cap la def HHRESULT 
1 "1- COMPLETED ALL SECTIONS"
2 "2- PARTIALLY COMPLETED (SPECIFY DETAILS IN COMMENTS)"
3 "3- REFUSED TO COOPERATE"
4 "4- ABSENT"
5 "5- HOUSEHOLD MOVED PERMANENTLY"
6 "6- VACANT DWELLING"
7 "7- DWELLING COULD NOT BE LOCATED"
8 "8- HOUSEHOLD ALREADY SURVEYED"
9 "9- NOT APPLICABLE"
10 "10- OTHER(SPECIFY)";

cap la def A1 
1 "yes"
2 "no";

cap la def A2 
1 "yes"
2 "no";

cap la def A3 
1 "1-Lebanon"
2 "2-Syria"
3 "3-Palestine"
4 "4-Iraq"
5 "5-Jordan"
6 "6-US/Canada"
7 "7-Europe"
8 "8-Other, specify";

cap la def A4 
1 "Yes"
2 "no";

cap la def A6 
1 " Yes"
2 "no";

cap la def A9 
1 "Male"
2 " Female";

cap la def A10 
1 "1-Head of household  "
2 "2-Spouse  "
3 "3-Child"
4 "4-Sibling (Jordan) Parent (KRI)"
5 "5-Father/Mother (Jordan) Sibling (KRI)"
6 "6-Son/Daughter in Law"
7 "7-Grandchild"
8 "8-Father/Mother in Law"
9 "9-Other relative"
10 "10-No relation";

cap la def A11 
1 "Yes"
2 "No";

cap la def A14 
1 "1-Iraq"
2 "2-Syria"
3 "3-Palestine"
4 "4-Iran"
5 "5-Jordan"
6 "6-US/Canada";

cap la def A15 
1 "1-Iraqi"
2 "2-Syrian"
3 "3-Palestinian"
4 "4-Iranian"
5 "5-Jordanian"
6 "6-US/Canadian"
7 "7-European";

cap la def A16 
1 "yes"
2 "no";

cap la def A17 
1 "1- Never married"
2 "2-Currently married"
3 "3-Widowed"
4 "4-Divorced  / Separated";

cap la def A18 
1 "1- Never attended, cannot read/write ?"
2 "2- Never attended, can read/write"
3 "3- Attended in the past"
4 "4- Currently attending";

cap la def A19 
1 "1-Pre-primary"
2 "2-Primary"
3 "3-Basic"
4 "4-Secondary (academic)"
5 "5-Secondary (vocational)"
6 "7-University (BA/BS)"
7 "8-Vocational post-secondary"
8 "9-Postgraduate studies (MA/MS/PhD)"
9 "10 - Don't Know";

cap la def A20 
1 "0 if pre-primary"
2 "1"
3 "2"
4 "3"
5 "4"
6 "5"
7 "6"
8 "7"
9 "8"
10 "9"
11 "10"
12 "11"
13 "12"
14 "13 if graduated from university"
99 "99 if Don't Know";

cap la def A21 
1 "1- Employer  "
2 "2- Self-employed   "
3 "3- Paid employee  "
4 "4- Unpaid family worker  "
5 "5- Student who also works   "
6 "6- Full-time student  "
7 "7- Home maker"
8 "8- Unemployed, looking for work (has worked previously)  "
9 "9- Unemployed, looking for work (never worked before)  "
10 "10 - Not looking for a job because of lack of papers  "
11 "11- Not looking for a job due to frustration/discouragement   "
12 "12 - Not interested in working  "
13 "13- Retired / too old   "
14 "14- Disability/illness  "
15 "15- Under age   ";

cap la def A22 
1 "1-Yes"
2 "2-No"
3 "3- Was not born";

cap la def A23 
1 "1-Yes"
2 "2-No"
3 "3- Was not born";

cap la def A24 
1 "1-Yes"
2 "2-No"
3 "3-Not born";

cap la def A25 
1 "1-Yes"
2 "2-No"
3 "3-Not born";

cap la def A26 
1 "1-Yes, with UNHCR"
2 "2-Yes, with Ministry of Displacement and Migration"
3 "3-No";

cap la def A27 
1 "1-Unaware of the process"
2 "2-Cost, distance or difficulty of reaching the registration center"
3 "3-Do not trust data will be kept confidential"
4 "4-See no benefit in registration"
5 "5-Waiting for registration"
6 "6-Not eligible (IR and PRI)";

cap la def A29 
1 "yes"
2 "no";

cap la def A30 
1 "yes"
2 "no";

cap la def A31 
1 "yes"
2 "no";

cap la def A33 
1 "1- HoH was in Jordan in 2010 and was joined by family after the crisis"
2 "2-Other relatives joined the household "
3 "3- Another family is sharing the dwelling";

cap la def A34 
1 "yes"
2 "no";

cap la def A35 
1 "1-Male"
2 "2-Female";

cap la def A36X 
1 "1-They died"
2 "2-They disappeared/are missing/emprisoned"
3 "3-They are working somewhere else"
4 "4-They are studying somewhere else"
5 "5-Marriage/divorce"
6 "6-I moved here without them";

cap la def A37 
1 "1- Yes"
2 "2- No"
3 "3 - N/A: Non-Refugee Household";

cap la def A38 
1 "1- Yes"
2 "2- No"
3 "3 - N/A: Non-Refugee Household";

cap la def A39 
1 "1- Yes"
2 "2- No"
3 "3 - N/A: Non- IDP Household";

cap la def A40 
1 "1- Yes"
2 "2- No"
3 "3 - N/A: Non- IDP Household";

cap la def A41 
1 "1-Yes"
2 "2-No, same head of household";

cap la def A42 
1 "1-Spouse"
2 "2-Child"
3 "3-Sibling"
4 "4-Father/Mother"
5 "5-Son/Daughter in Law"
6 "6-Grandchil"
7 "7-Father/Mother in Law"
8 "8-Other relative"
9 "9-No relation";

cap la def B2CURRENT 
1 "1- Apartment"
2 "2- House"
3 "3- Informal settlement/tent"
4 "4 - Caravan"
5 "5- Collective center"
6 "6- Worksite/unfinished home"
7 "7- Farm building"
8 "8 - Traditional houses"
9 "9- School, mosque, church or other religious building"
10 "10- Garage, shop, workshop, school, or other structure not intended for habitation";

cap la def B5CURRENT 
1 "1- Marble"
2 "2- Parquet"
3 "3- Tiles"
4 "4 - Metal"
5 "5- Concrete"
6 "6- Soil";

cap la def B2DECEMBER2013 
1 "1- Apartment"
2 "2- House"
3 "3- Informal settlement/tent"
4 "4 - Caravan"
5 "5- Collective center"
6 "6- Worksite/unfinished home"
7 "7- Farm building"
8 "8 - Traditional houses"
9 "9- School, mosque, church or other religious building"
10 "10- Garage, shop, workshop, school, or other structure not intended for habitation";

cap la def B5DECEMBER2013 
1 "1- Marble"
2 "2- Parquet"
3 "3- Tiles"
4 "4 - Metal"
5 "5- Concrete"
6 "6- Soil";

cap la def B2SEPTEMBER2010 
1 "1- Apartment"
2 "2- House"
3 "3- Informal settlement/tent"
4 "4 - Caravan"
5 "5- Collective center"
6 "6- Worksite/unfinished home"
7 "7- Farm building"
8 "8 - Traditional houses"
9 "9- School, mosque, church or other religious building"
10 "10- Garage, shop, workshop, school, or other structure not intended for habitation";

cap la def B5SEPTEMBER2010 
1 "1- Marble"
2 "2- Parquet"
3 "3- Tiles"
4 "4 - Metal"
5 "5- Concrete"
6 "6- Soil";

cap la def B2REFUGEESANDIDPSONLY 
1 "1- Apartment"
2 "2- House"
3 "3- Informal settlement/tent"
4 "4 - Caravan"
5 "5- Collective center"
6 "6- Worksite/unfinished home"
7 "7- Farm building"
8 "8 - Traditional houses"
9 "9- School, mosque, church or other religious building"
10 "10- Garage, shop, workshop, school, or other structure not intended for habitation";

cap la def B5REFUGEESANDIDPSONLY 
1 "1- Marble"
2 "2- Parquet"
3 "3- Tiles"
4 "4 - Metal"
5 "5- Concrete"
6 "6- Soil";

cap la def B8 
1 "1- Unrelated person"
2 "2- HH member"
3 "3- Friend or relative"
4 "4- NGO/non-religious charity"
5 "5- Government ministry or municipality"
6 "6- UNHCR"
7 "7- Religious organization/charit"
8 "8- Unowned/squatting";

cap la def B9 
1 "1- Unrelated person"
2 "2- HH member"
3 "3- Friend or relative"
4 "4- NGO/non-religious charity"
5 "5- Government ministry or municipality"
6 "6- UNHCR"
7 "7- Religious organization/charit"
8 "8- Unowned/squatting";

cap la def B10 
1 "1- Owns land and dwelling and does not pay rent"
2 "2- Owns apartment and does not pay rent"
3 "3 - Potentially pays rent on land or dwelling";

cap la def B14 
1 "1 - Lives in at least 1 caravan"
2 "2 - Lives in tent (no caravans)"
3 "3 - No - does not live in tent or caravan";

cap la def B18 
1 "yes"
2 "no";

cap la def B19 
1 "1 - Tent/partial tent"
2 "2 - Metal sheeting"
3 "3 - Concrete blocks"
4 "4 - Caravan panels";

cap la def C3 
1 "1- Latrine (simple pit)"
2 "2- Latrine in house (pour flush with soakage pit)"
3 "3- Latrine in house (pour flush with septic tank)"
4 "4- Latrine in house (pour flush to sewage)"
5 "5- Communal latrine"
6 "6- Near the house";

cap la def C4 
1 "1- Dumpster"
2 "2- Refuse pit/Dump site"
3 "3- Burning"
4 "4- Burying"
5 "5- Leave it where it is"
6 "6- Near the road"
7 "7- Other";

cap la def C5 
1 "1- No electricity"
2 "2- Public network"
3 "3- Camp network"
4 "4- Common generator (shared with other dwellings)"
5 "5- Private generator"
6 "6- Solar charger"
7 "7- Other";

cap la def C9 
1 "1- Much better today"
2 "2- Better today"
3 "3- Same"
4 "4- Worse today"
5 "5- Much worse today";

cap la def D3 
1 "YES"
2 "NO";

cap la def D4 
1 "YES"
2 "NO";

cap la def D5 
1 "1- 1 day or less"
2 "2- Between 1 and 7 days"
3 "3- Between 1 week and 1 month"
4 "4- More than 1 month";

cap la def D6X1 
1 "YES"
2 "NO";

cap la def D7X1 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X1 
1 "YES"
2 "NO";

cap la def D9X1 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X2 
1 "YES"
2 "NO";

cap la def D7X2
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X2 
1 "YES"
2 "NO";

cap la def D9X2 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X3 
1 "YES"
2 "NO";

cap la def D7X3 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X3 
1 "YES"
2 "NO";

cap la def D9X3 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X4 
1 "YES"
2 "NO";

cap la def D7X4 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X4 
1 "YES"
2 "NO";

cap la def D9X4 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X5 
1 "YES"
2 "NO";

cap la def D7X5 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X5 
1 "YES"
2 "NO";

cap la def D9X5 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X6 
1 "YES"
2 "NO";

cap la def D7X6 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X6 
1 "YES"
2 "NO";

cap la def D9X6 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X7 
1 "YES"
2 "NO";

cap la def D7X7 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X7 
1 "YES"
2 "NO";

cap la def D9X7 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X8 
1 "YES"
2 "NO";

cap la def D7X8 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X8 
1 "YES"
2 "NO";

cap la def D9X8 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def D6X9 
1 "YES"
2 "NO";

cap la def D7X9 
1 "1 - Destroyed"
2 "2 - Partially destroyed"
3 "3 - Intact, left in Syria"
4 "4 - Intact, brought to Jordan"
5 "5 - Sold in preparation for Jordan"
6 "6 - Sold for other reasons"
7 "7 - Stolen / Confiscated";

cap la def D8X9 
1 "YES"
2 "NO";

cap la def D9X9 
1 "1 - In care of someone else"
2 "2 - Checked on periodically by household"
3 "3 - Abandoned"
4 "1 - Destroyed"
5 "5 - Sold"
6 "6 - Stolen / Confiscated"
7 "7 - Don't Know";

cap la def E1X1 
1 "YES"
2 "NO";

cap la def E1X2 
1 "YES"
2 "NO";

cap la def E1X3 
1 "YES"
2 "NO";

cap la def E1X4 
1 "YES"
2 "NO";

cap la def E1X5 
1 "YES"
2 "NO";

cap la def E1X6 
1 "YES"
2 "NO";

cap la def E1X7 
1 "YES"
2 "NO";

cap la def E1X8 
1 "YES"
2 "NO";

cap la def E4 
1 "1- Less than 150,000 Ids"
2 "2- 150,000 - 300,000 IDs"
3 "3- 301,000 - 500,000 IDs"
4 "4- 501,000 - 750,000 IDs"
5 "5- 751,000 - 1,000,000 IDs"
6 "6- 1,001,000 -1,500,000 IDs"
7 "7- 1,500,000 -2,000,000 IDs"
8 "8- 2,001,000 -3,000,000 IDs"
9 "9- 3,001,000-4,500,000 IDs"
10 "10- 4,500,000 IDs and above"
11 "11- Refused (98)";

cap la def E6 
1 "yes"
2 "no";

cap la def E7 
1 "1- Yes"
2 "2- No";

cap la def E8 
1 "1- Yes"
2 "2- No";

cap la def E9 
1 "1- Poor"
2 "2- Non-poor";

cap la def E11 
1 "yes"
2 "no";

cap la def F1X1 
1 "1- Yes"
2 "2- No";

cap la def F2X1 
1 "YES"
2 "NO";

cap la def F3X1 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X2 
1 "1- Yes"
2 "2- No";

cap la def F2X2 
1 "YES"
2 "NO";

cap la def F3X2 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X3 
1 "1- Yes"
2 "2- No";

cap la def F2X3 
1 "YES"
2 "NO";

cap la def F3X3 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X4 
1 "1- Yes"
2 "2- No";

cap la def F2X4 
1 "YES"
2 "NO";

cap la def F3X4 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X5 
1 "1- Yes"
2 "2- No";

cap la def F2X5 
1 "YES"
2 "NO";

cap la def F3X5 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X6 
1 "1- Yes"
2 "2- No";

cap la def F2X6 
1 "YES"
2 "NO";

cap la def F3X6 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X7 
1 "1- Yes"
2 "2- No";

cap la def F2X7 
1 "YES"
2 "NO";

cap la def F3X7 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X8 
1 "1- Yes"
2 "2- No";

cap la def F2X8 
1 "YES"
2 "NO";

cap la def F3X8 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X9 
1 "1- Yes"
2 "2- No";

cap la def F2X9 
1 "YES"
2 "NO";

cap la def F3X9 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X10 
1 "1- Yes"
2 "2- No";

cap la def F2X10 
1 "YES"
2 "NO";

cap la def F3X10 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X11 
1 "1- Yes"
2 "2- No";

cap la def F2X11 
1 "YES"
2 "NO";

cap la def F3X11 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X12 
1 "1- Yes"
2 "2- No";

cap la def F2X12 
1 "YES"
2 "NO";

cap la def F3X12 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def F1X13 
1 "1- Yes"
2 "2- No";

cap la def F2X13 
1 "YES"
2 "NO";

cap la def F3X13 
1 "1- Kurdistan regional government"
2 "2-Central government"
3 "3-Ministry of Displacement and Migration"
4 "4- UNHCR"
5 "5- UNICEF"
6 "6- WFP"
7 "7- UN agency (do not know which)"
8 "8-  Emirati Foundation"
9 "9- Other International NGO"
10 "10- Barzani Foundation"
11 "11 - Other Local NGO" 12 "12 - Religious Organizations" 13 "13- Foreign Government" 14 "14 - Individual Citizen";

cap la def G1 
1 "yes"
2 "no";

cap la def G2 
1 "yes"
2 "no";

cap la def G3 
1 "1- Depended on cash or in-kind assistance from others"
2 "2- Relied on own savings"
3 "3- Reduced food stocks or purchases"
4 "4- Reduced expenditures on health/education"
5 "5- Employed HH members took on more work or HH members who were not previously working began to work "
6 "6- HH members (inc. children) migrated"
7 "7- Took out loans or made purchases on credit "
8 "8- Sold assets, buildings, land, crops, or livestock"
9 "9- Nothing";

cap la def H4 
1 "Less affordable"
2 "About the same"
3 "More afforable";

cap la def I1 
1 "yes"
2 "no";

cap la def I2 
1 "yes"
2 "no";

cap la def I3 
1 "yes"
2 "no";

cap la def I4 
1 "yes"
2 "no";

cap la def I5 
1 "yes"
2 "no";

cap la def I6 
1 "yes"
2 "no";

cap la def J2 
1 "1- Yes"
2 "2- No";

cap la def J4 
1 "1- Pregnancy/ delivery"
2 "2- Diarrhea"
3 "3- Cough"
4 "4- Difficulty breathing"
5 "5- Chest pain"
6 "6- Injury"
7 "7- Hypertension"
8 "8- Diabetes"
9 "9- Vaccinations"
10 "10- To get medication"
11 "11- Cold / Flu"
12 "12- Don't Know";

cap la def J5 
1 "1- Hospital"
2 "2- Health clinic/PHC"
3 "3- Mobile clinic"
4 "4- Doctor in private clinic"
5 "5- Pharmacist";

cap la def J7 
1 "1- Kurdistan region government"
2 "2- Local municipality"
3 "3- UN"
4 "4- NGO/non-religious charity"
5 "5- Religious group or religious charity"
6 "6- Privately-run"
7 "7- Don't Know";

cap la def J8 
1 "1- Walk"
2 "2- Shared cab (service)"
3 "3- Motorbike"
4 "4- Taxi"
5 "5- Bus / Minivan"
6 "6- Ambulance"
7 "7- Car"
8 "8- Carpool (with fee)"
9 "9- Carpool (without fee)"
10 "10 - Don't Know";

cap la def J11 
1 "1- Yes"
2 "2- No"
3 "3 - Don't Know";

cap la def J12 
1 "1- Government agency"
2 "2-  UN"
3 "3- NGO/non-religious charity"
4 "4- Religious group or religious charity"
5 "5- Non-HH family member"
6 "6- Non-HH friend"
7 "7- Health insurance"
8 "8 - Don't Know";

cap la def J13 
1 "1- Usual provider/family doctor"
2 "2- Cheaper"
3 "3- Only they offer the treatment I needed/Only option"
4 "4- Closer"
5 "5- Political/sectarian/confessional reasons"
6 "6- References/recommended by friends or relatives"
7 "7- Others are too crowded"
8 "8- Refused by other providers"
9 "9- Accept my means of payment"
10 "10 - Don't Know";

cap la def J14 
1 "1- No illness/was not asked to accompany anyone  "
2 "2- Doctor's fees too expensive  "
3 "3- Medicine too expensive  "
4 "4- No insurance"
5 "5- Refused service";

cap la def J15 
1 "yes"
2 "no";

cap la def J16 
1 "1- Look in newspaper"
2 "2- Listen to radio"
3 "3- Ask religious leader"
4 "4- Ask family member"
5 "5- Ask government official"
6 "6- Ask friend/neighbor"
7 "7- Ask UN official"
8 "8- Ask other NGO official"
9 "9- Ask community volunteer";

cap la def J17 
1 "1- No improvement"
2 "2- Easier to reach"
3 "3- Less crowded"
4 "4- Safer"
5 "5- Better treatment by staff"
6 "6- Better treatment by other users"
7 "7- Service became more affordable"
8 "8- Don't know";

cap la def J18 
1 "1- No worsening"
2 "2- Harder to reach"
3 "3- More crowded"
4 "4- Less safe"
5 "5- Treated worse by staff"
6 "6- Treated worse by other user"
7 "7- Service became less affordable"
8 "8- Don't know";

cap la def J19 
1 "1- You moved to a new location"
2 "2- Lost health coverage/insurance"
3 "3- Arrival of refugees";

cap la def K5 
1 "1- Yes"
2 "2- No, but can read and write"
3 "3- No, can't read and write";

cap la def K6 
1 "1- Has to work to support the family"
2 "2- HH could not afford school's expenses"
3 "3- Household thought that education is not useful to get a better job"
4 "4- Social reasons: family disapproves / does not think child needs to study"
5 "5- Sickness or disability"
6 "6- Still too young"
7 "7- Parents do not understand how to enroll"
8 "8- Schools were full and not accepting new students"
9 "9- No documents";

cap la def K7 
1 "yes"
2 "no";

cap la def K9 
1 "yes"
2 "no";

cap la def K10 
1 "yes"
2 "no";

cap la def K11 
1 "1- School holiday"
2 "2- Child was ill"
3 "3- Needed to work to support family"
4 "4- Needed to take care of family member"
5 "5- Security concerns";

cap la def K12 
1 "1- Walk"
2 "2- Shared cab (service)"
3 "3- Motorbike"
4 "4- Taxi"
5 "5- Bus"
6 "6- Minibus"
7 "7- Car"
8 "8- Carpool";

cap la def K14 
1 "1- Public school (ministry of education)"
2 "2- UN agency (including UNRWA)"
3 "3- NGO/non-religious charity"
4 "4- Religious group/charity"
5 "5- Private school"
6 "6- Semi/free-private (subsidized school)"
7 "7- Don't know";

cap la def K15 
1 "1- Yes"
2 "2- No"
3 "3 -Don't Know";

cap la def K16 
1 "1- Yes"
2 "2- No"
3 "3 -Don't Know";

cap la def K17 
1 "1- Kurdish"
2 "2- Arabic";

cap la def K18 
1 "1- Closest"
2 "2- Best school"
3 "3- Cheapest"
4 "4- No other school accepted my child"
5 "5- Confessional"
6 "6 - Local public school";

cap la def K19 
1 "1- Has to work to support family"
2 "2- HH could not afford school's expenses"
3 "3- Social reasons: Family disapproves"
4 "4- Sickness or disability"
5 "5- Not interested in going to school"
6 "6- Schools are full and not accepting new students"
7 "7- Curriculum doesn't match previous schooling"
8 "8- Household thought that education is not useful to get a better job"
9 "9- School year hasn't started";

cap la def K20 
1 "yes"
2 "no";

cap la def K21 
1 "1- Has to work to support family"
2 "2- Helping in house chores  "
3 "3- HH could not afford school's expenses  "
4 "4- Social reasons: Family disapproves"
5 "5- Sickness or disability"
6 "6- Going to school is hazardous"
7 "7- Not interested in going to school"
8 "8- Still too young  ";

cap la def K22 
1 "1- Kurdish"
2 "2- Arabic";

cap la def K23 
1 "1- No improvement"
2 "2- Easier to reach"
3 "3- Less crowded"
4 "4- Safer"
5 "5- Better treatment by teachers"
6 "6- Better treatment by other children/less bullying"
7 "7- School became cheaper"
8 "8- Quality has improved";

cap la def K24 
1 "1-  No worsening"
2 "2- Harder to reach"
3 "3- More crowded"
4 "4- Less safe"
5 "5- Treated worse by teachers"
6 "6- Treated worse by other students"
7 "7- School became less affordable"
8 "8- Topics taught in foreign language"
9 "9- Quality has worsened";

cap la def K25 
1 "1- You moved to a new location/new school"
2 "2- Child is attending new level of schooling"
3 "3- Arrival of Refugees / IDPs";

cap la def L2 
1 "yes"
2 "no";

cap la def L14 
1 "1- I or a member of my household got a job/started a business here, or came here looking for work  "
2 "2-Educational reasons: I began school here or finished school where I lived before"
3 "3- Marital reasons: I got married or divorced  "
4 "4- I joined my relatives/friends here  "
5 "5- Cost of living/rent  in previous dwelling was too high "
6 "6- Area in previous dwelling was too dangerous"
7 "7- Evicted from previous dwelling by formal/informal armed forces"
8 "8- Evicted from previous dwelling by landlord  "
9 "9- Evicted from previous dwelling by municipality or local government  "
10 "10-Other areas were blocked/borders were closed  "
11 "11- Bigger/better home"
12 "12- Lack of food";

cap la def L15 
1 "0"
2 "1-5"
3 "6-10"
4 "11-20"
5 "5- More than 20";

cap la def L18 
1 "1- Yes, I am moving on a specific date"
2 "2- Yes, I have looked for other residences"
3 "3- Yes, but I have not started looking for other residences"
4 "4- No, I do not have plans to change residences";

cap la def L20 
1 "1- I or a member of my household got a job/started a business somewhere else or going to look for work"
2 "2 - I am going to join my relatives"
3 "3 - Cost of living/rent is here too high"
4 "4 - Want to move to a bigger/better home"
5 "5 - Security situation has improved there";

cap la def L22 
1 "1- I don't want to"
2 "2 - Too costly"
3 "3 - Trip is too dangerous"
4 "4 -  I don't know anyone there"
5 "5 - I don't know what life would be like there"
6 "6 - I don't know how"
7 "7 - Too risky"
8 "8 - Fear of prejudice/discrimination";

cap la def L23 
1 "1- Applied for asylum/resettlement"
2 "2- Applied for a visa"
3 "3- Contacted an informal agent to help me cross borders"
4 "4- Contacted family/friends abroad for help"
5 "5- Applied for school/university"
6 "6- Sold assets"
7 "7- Took a loan"
8 "8 - Started learning a language";

cap la def L26 
1 "1 - Very likely I will return"
2 "2 - Likely I will return"
3 "3 - Unlikely I will return"
4 "4 - Very unlikely I will return"
5 "5 - Don't know / Depends"
6 "6 - N/A, non-displaced";

cap la def L27 
1 "1 - Very likely I will return"
2 "2 - Likely I will return"
3 "3 - Unlikely I will return"
4 "4 - Very unlikely I will return"
5 "5 - Don't know / Depends";

cap la def L13 1 "yes"
2 "no";
cap la def L14; 
cap la def L15;
cap la def L16 1 "yes"
2 "no";
cap la def L18 1 "1- Yes"
2 "2- No"
3 "3- Don't Know / Depends"
4 "4 - N/A, non-displaced";
cap la def M1 1 "yes"
2 "no";
cap la def M2 1 "yes"
2 "no";
cap la def M4 1 "yes"
2 "no";
cap la def M5 1 "1- I work for wages or payment (either in cash or in kind) for a company, the government or any other individual."
2 "2- I do not work for wages, but rather work on my account or in a business enterprise or farm belonging to me or someone else in my household, for example, as a farmer, trader, shop-keeper, barber, dressmaker, carpenter or taxi driver";
cap la def N1 1 "yes"
2 "no";
cap la def N2 1 "1- Too young"
2 "2- Fulltime student"
"3 "3- Social reasons (family doesn't let me work) "
4 "4- Disability or chronic illness"
5 "5- Retired"
6 "6- Housewife"
7 "7- Don't want to work"
8 "8- Discrimination"
9 "9- No good jobs available"
10 "10- Don't plan on staying in this area for very long"
11 "11- Local security situation"
12 "12- Discouragement"
13 "13 - Don't have the right papers"
cap la def N3 1 "Yes"
2 "no";
cap la def N4 1 "1- 7 days or less"
2 "2- Between 7 and 30 days"
3 "3- Between 1 and 6 months"
4 "4- More than 6 months";
"cap la def N5 1 "1- Contacted public employment office  "
"2 "2- Contacted commercial employment office"
"3 "3- Placed/answered job advertisements in newspapers"
"4 "4- Asked friends, relatives or other personal connections"
"5 "5- Contacted employer directly "
"6 "6- Tried to find land, workplace, equipment, financial resources/credit to start own business, applied for relevant licenses, permits, etc   "
7 "7- Sought to obtain working permit"
8 "8- Went door to door looking for employment"
9 "9- Contacted cash-for-work program"
"10 "10- Contacted an NGO"
11 "11- Contacted local authorities or municipal government"
12 "12 - Searched online job sites"
cap la def N6 1 "1- Job ads in print media"
2 "2- Job ads on radio or TV"
3 "3- Job ads on the internet/SMS"
4 "4- Public employment agency"
5 "5- Private employment agency"
6 "6- Family relations"
7 "7- Friends"
8 "8- Political connections"
9 "9- NGO"
10 "10- Door-to-door searches"
11 "11- Local authorities or municipal government"
12 "12- Don't have any sources of information"
cap la def N7 1 "1- Too many people searching for jobs"
2 "2- Underqualified for available jobs"
"3 "3- Legal issues"
"4 "4- Available jobs are too far away  "
5 "5- Discrimination by employers"
6 "6- No jobs available that are suitable for education"
7 "7- Lack of personal or political connections"
8 "8- Don't have enough time to look for work"
"9 "9- Wages are too low  "
"10 "10- Overqualified for available jobs  "
11 "11- Harassment or discrimination (other than by employers)"
12 "12- Jobs are too dangerous"
13 "13- Language barrier"
14 "14- Disability or chronic illness"
cap la def N8 1 "yes"
2 "no";
cap la def N9 1 "1- I work for wages or payment (either in cash or in kind) for a company, the government or any other individual"
2 "2- I do not work for wages, but rather work on my account or in a business enterprise or farm belonging to me or someone else in my household, for example, as a farmer, trader, shop-keeper, barber, dressmaker, carpenter or taxi driver";
cap la def O3 1 "1- Private sector"
2 "2- NGO or international organization"
3 "3- Public sector (non-military)"
4 "4-Military";
cap la def O4 1 "1- Fewer than 5"
2 "2- [5-9]"
3 "3- [10-19]"
4 "4- 20 or more";
cap la def O5 1 "1- Walk"
2 "2- Shared cab (service)"
3 "3- Motorbike"
4 "4- Taxi"
5 "5- Bus"
6 "6- Minibus"
7 "7- Car"
8 "8- Carpool"
9 "9- I live at my work place"
cap la def O7 1 "yes"
2 "no";
cap la def O8 1 "1- Fixed-term"
2 "2- Open-ended";
cap la def O10 1 "1- Yes: Public insurance only"
2 "2- Yes: private insurance only"
3 "3- Yes: both public and private"
4 "2- No";
cap la def O11 1 "yes"
2 "no";
cap la def O12 1 "1- Hourly"
2 "2- Daily"
3 "3- Weekly"
4 "4- Bi-monthly"
5 "5- Monthly"
6 "6- Quarterly"
cap la def O13 1 "1- Yes on time and in full"
2 "2-Yes on time but not in full"
3 "3- No";
cap la def O17 1 "1-  Less than 150,000 Ids"
2 "2- 150,000 - 300,000 IDs"
3 "3- 301,000 - 500,000 IDs"
4 "4- 501,000 - 750,000 IDs"
5 "5- 751,000 - 1,000,000 IDs"
6 "6- 1,001,000 -1,500,000 IDs"
7 "7- 1,500,000 -2,000,000 IDs"
8 "8- 2,001,000 -3,000,000 IDs"
9 "9- 3,001,000-4,500,000 IDs"
10 "10- 4,500,000 IDs and above"
11 "11- Refused";

cap la def O18 1 "1- Food"
2 "2- Housing"
3 "3- Mobile phone"
4 "4- Work car"
5 "5- Insurance"
6 "6- Travel"
cap la def O19 1 "1- No relationship"
2 "2- Member of my household"
3 "3- Close relative"
4 "4- Distant relative"
5 "5- Friend"
6 "6- Friend of friend or relative"
cap la def O20 1 "1- Asked close relative or HH member"
2 "2- Asked distant relative"
3 "3- Asked friend"
4 "4- Asked friend of friend or relative"
5 "5- Asked member of same community"
6 "6- Asked politician or political party"
7 "7- Applied at employment office"
8 "8- Responded to ad in newspaper"
9 "9- Applied directly to the firm"
10 "10- Responded to an ad in a website"
cap la def O21 1 "yes"
2 "no";
cap la def O22 1 "yes"
2 "no";
cap la def O23 1 "yes"
2 "no";
cap la def O25 1 "yes"
2 "no";
cap la def O27 1 "1- More satisfied today"
2 "2- More satisfied in 2013"
3 "3- No difference";
cap la def O28 1 "1 - More satisfied today"
2 "2 - More satisfied in 2013"
3 "3 - No difference";
cap la def O29 1 "1 - More hours today"
2 "2 - More hours in 2013"
3 "3 - No difference";
cap la def O30 1 "yes"
2 "no";
cap la def O32 1 "1- More satisfied today"
2 "2- More satisfied in 2010"
3 "3- No difference";
cap la def O33 1 "1 - More satisfied today"
2 "2 - More satisfied in 2010"
3 "3 - No difference";
cap la def O34 1 "1 - More hours today"
2 "2 - More hours in 2010"
3 "3 - No difference";
cap la def P3 1 "yes"
2 "no";
cap la def P4 1 "yes"
2 "no";
cap la def P5 1 "yes"
2 "no";
cap la def P6 1 "yes"
2 "no";
cap la def P9 1 "yes"
2 "no";
cap la def P11 1 "1- Very stable"
2 "2- Moderately stable"
3 "3- Unstable";
cap la def P13 1 "YES"
2 "NO";
cap la def P14 1 "1- More stable today"
2 "2- More stable in 2013"
3 "3- No difference";
cap la def P15 1 "1 - More satisfied today"
2 "2 - More satisfied in 2013"
3 "3 - No difference";
cap la def P16 1 "YES"
2 "NO";
cap la def P17 1 "YES"
2 "NO";
cap la def P20 1 "1- More stable today"
2 "2- More stable in 2010"
3 "3- No difference";
cap la def P21 1 "1 - More satisfied today"
2 "2 - More satisfied in 2010."
3 "3 - No difference";
cap la def Q27 1 "1-   Less than 150,000 Ids"
2 "2- 150,000 - 300,000 IDs"
3 "3- 301,000 - 500,000 IDs"
4 "4- 501,000 - 750,000 IDs"
5 "5- 751,000 - 1,000,000 IDs"
6 "6- 1,001,000 -1,500,000 IDs"
7 "7- 1,500,000 -2,000,000 IDs"
8 "8- 2,001,000 -3,000,000 IDs"
9 "9- 3,001,000-4,500,000 IDs"
10 "10- 4,500,000 IDs and above"
11 "11- Refused";
cap la def Q28 1 "1- More satisfied today"
2 "2- More satisfied in 2013"
3 "3- No difference";
cap la def Q29 1 "1 - More satisfied today"
2 "2 - More satisfied in 2013"
3 "3 - No difference";
cap la def Q30 1 "1 - More hours today"
2 "2 - More hours in 2013"
3 "3 - No difference";
cap la def Q31 1 "yes"
2 "no";
cap la def Q33 1 "1-  Less than 150,000 Ids"
2 "2- 150,000 - 300,000 IDs"
3 "3- 301,000 - 500,000 IDs"
4 "4- 501,000 - 750,000 IDs"
5 "5- 751,000 - 1,000,000 IDs"
6 "6- 1,001,000 -1,500,000 IDs"
7 "7- 1,500,000 -2,000,000 IDs"
8 "8- 2,001,000 -3,000,000 IDs"
9 "9- 3,001,000-4,500,000 IDs"
10 "10- 4,500,000 IDs and above"
11 "11- Refused";
cap la def Q34 1 "1- More satisfied today"
2 "2- More satisfied in 2010"
3 "3- No difference";
cap la def Q35 1 "1 - More satisfied today"
2 "2 - More satisfied in 2010"
3 "3 - No difference";
cap la def Q36 1 "1 - More hours today"
2 "2 - More hours in 2010"
3 "3 - No difference";
cap la def Q1 1 "1- employed"
2 "2- not employed";
cap la def Q4 1 "1- wage worker"
2 "2- self-employed/employer";
cap la def Q6 1 "1-  Less than 150,000 Ids"
"2 "2- 150,000 - 300,000 IDs"
"3 "3- 301,000 - 500,000 IDs"
"4 "4- 501,000 - 750,000 IDs"
"5 "5- 751,000 - 1,000,000 IDs"
"6 "6- 1,001,000 -1,500,000 IDs"
7 "7- 1,500,000 -2,000,000 IDs"
8 "8- 2,001,000 -3,000,000 IDs"
9 "9- 3,001,000-4,500,000 IDs"
10 "10- 4,500,000 IDs and above"
11 "11- Refused";
cap la def Q7 1 "1- More satisfied today"
2 "2- More satisfied in 2013."
3 "3- No difference";
cap la def Q8 1 "1 - More hours today"
2 "2 - More hours in 2013."
3 "3 - No difference";
cap la def Q9 1 "1- More stable today"
2 "2- More stable in 2013."
3 "3- No difference";
cap la def Q10 1 "1 - More satisfied today"
2 "2 - More satisfied in 2013."
3 "3 - No difference";
cap la def Q11 1 "1 - Today's activity"
2 "2 - My activity in 2013"
3 "3 - No difference";
cap la def Q12 1 "1- wage worker"
2 "2- self-employed/employer"
3 "3- not employed";
cap la def R3 1 "1- Private sector"
2 "2- NGO or international organization"
3 "3- Public sector (non-military)"
4 "4- Military";
cap la def R4 1 "yes"
2 "no";
cap la def R5 1 "1- Yes: NSSF insurance only"
2 "2- Yes: private insurance only"
3 "3- Yes: both NSSF and private"
4 "4- No";
cap la def R6 1 "yes"
2 "no";
cap la def R7 1 "1- Hourly"
2 "2- Daily"
3 "3- Weekly"
4 "4- Bi-monthly"
5 "5- Monthly"
6 "6- Quarterly"
cap la def R10 1 "1-  Less than 150,000 Ids"
2 "2- 150,000 - 300,000 IDs"
3 "3- 301,000 - 500,000 IDs"
4 "4- 501,000 - 750,000 IDs"
5 "5- 751,000 - 1,000,000 IDs"
6 "6- 1,001,000 -1,500,000 IDs"
7 "7- 1,500,000 -2,000,000 IDs"
8 "8- 2,001,000 -3,000,000 IDs"
9 "9- 3,001,000-4,500,000 IDs"
10 "10- 4,500,000 IDs and above"
11 "11- Refused";
cap la def R11 1 "1- More satisfied today"
2 "2- More satisfied in 2010."
3 "3- No difference";
cap la def R12 1 "1- More satisfied today"
2 "2- More satisfied in 2010."
3 "3 - No difference";
cap la def R13 1 "1 - More hours today"
2 "2 - More hours in 2010."
3 "3 - No difference";
cap la def R14 1 "1 - Today's activity"
2 "2 - My activity in 2013"
3 "3 - No difference";
"cap la def R17 1 "1- Fired or dismissed"
"2 "2- Found a better job"
"3 "3- Pay was too low"
"4 "4- Moved further away  "
"5 "5- Bad experience on the job"
"6 "6- Contract ended  "
"7 "7- Season ended  "
"8 "8- Needed to take care of family members"
9 "9- Business shut down"
"10 "10- Security reasons  "
"11 "11- Sickness or injury  "
"12 "12- Retirement"
"13 "13- Did not need to work anymore  "
"14 "14- Got married  "
"15 "15- Became pregnant"
"16 "16- Family stopped allowing me to work (social reasons)  "
cap la def S2 1 "yes"
2 "no";
cap la def S3 1 "yes"
2 "no";
cap la def S4 1 "yes"
2 "no";
cap la def S7 1 "1- More stable today"
2 "2- More stable in 2013."
3 "3- No difference";
cap la def S8 1 "1 - More satisfied today"
2 "2 - More satisfied in 2010."
3 "3 - No difference";
cap la def S9 1 "1 - Today's activity"
2 "2 - My activity in 2010"
3 "3 - No difference";
cap la def S10 1 "yes"
2 "no";
cap la def S13 1 "1- Fired or dismissed"
2 "2- Found a better job"
3 "3- Pay was too low"
4 "4- Moved further away"
5 "5- Bad experience on the job"
6 "6- Contract ended"
7 "7- Season ended"
8 "8- Needed to take care of family members"
9 "9- Business shut down"
10 "10- Security reasons"
11 "11- Sickness or injury"
12 "12- Retirement"
13 "13- Did not need to work anymore"
14 "14- Got married"
15 "15- Became pregnant"
16 "16- Family stopped allowing me to work (social reasons)"
cap la def T1 1 "yes"
2 "no";
cap la def T2 1 "1- Too many people searching for jobs  "
"2 "2- Underqualified for available jobs  "
"3 "3- Legal issues"
"4 "4- Available jobs are too far away  "
"5 "5- Discrimination by employers  "
"6 "6- No jobs available that are suitable for education"
"7 "7- Lack of personal or political connections  "
"8 "8- Don't have enough time to look for work"
"9 "9- Wages are too low  "
"10 "10- Overqualified for available jobs  "
"11 "11- Harassment or discrimination (other than by employers)  "
"12 "12- Jobs are too dangerous"
"13 "13- Disability or chronic illness  "
"14 "14- Housewife"
"15 "15- Too young"
"16 "16- Full-time student"
cap la def T3 1 "yes"
2 "no";
cap la def MM1 1 "yes"
2 "no";
cap la def MM2 1 "yes"
2 "no";
cap la def MM4 1 "yes"
2 "no";
cap la def MM5 1 "1- I work for wages or payment (either in cash or in kind) for a company, the government or any other individual."
2 "2- I do not work for wages, but rather work on my account or in a business enterprise or farm belonging to me or someone else in my household, for example, as a farmer, trader, shop-keeper, barber, dressmaker, carpenter or taxi driver";
cap la def NN1 1 "yes"
2 "no";
cap la def NN2 1 "1- Too young"
2 "2- Fulltime student"
3 "3- Social reasons (family doesn't let me work)"
4 "4- Disability or chronic illness"
5 "5- Retired"
6 "6- Housewife"
7 "7- Don't want to work"
8 "8- Discrimination"
9 "9- No good jobs available"
10 "10- Don't plan on staying in this area for very long"
11 "11- Local security situation"
12 "12- Discouragement"
13 "13 - Don't have the right papers"
cap la def NN3 1 "yes"
2 "no";
cap la def NN4 1 "1- 7 days or less"
2 "2- Between 7 and 30 days"
3 "3- Between 1 and 6 months"
4 "4- More than 6 months";
"cap la def NN5 1 "1- Contacted public employment office  "
"2 "2- Contacted commercial employment office"
"3 "3- Placed/answered job advertisements in newspapers"
"4 "4- Asked friends, relatives or other personal connections"
"5 "5- Contacted employer directly  "
6 "6- Tried to find land, workplace, equipment, financial resources/credit to start own business, applied for relevant licenses, permits, etc"
"7 "7- Sought to obtain working permit  "
"8 "8- Went door to door looking for employment"
"9 "9- Contacted cash-for-work program  "
"10 "10- Contacted an NGO  "
"11 "11- Contacted local authorities or municipal government"
"12 "12 - Searched online job sites  "
cap la def NN6 1 "1- Job ads in print media"
2 "2- Job ads on radio or TV"
3 "3- Job ads on the internet/SMS"
4 "4- Public employment agency"
5 "5- Private employment agency"
6 "6- Family relations"
7 "7- Friends"
8 "8- Political connections"
9 "9- NGO"
10 "10- Door-to-door searches"
11 "11- Local authorities or municipal government"
12 "12- Don't have any sources of information"
cap la def NN7 1 "1- Too many people searching for jobs"
2 "2- Underqualified for available jobs"
3 "3- Legal issues"
4 "4- Available jobs are too far away"
5 "5- Discrimination by employers"
6 "6- No jobs available that are suitable for education"
7 "7- Lack of personal or political connections"
8 "8- Don't have enough time to look for work"
9 "9- Wages are too low"
10 "10- Overqualified for available jobs"
11 "11- Harassment or discrimination (other than by employers)"
12 "12- Jobs are too dangerous"
13 "13- Language Barrier"
14 "14- Disability or chronic illness"
cap la def NN8 1 "yes"
2 "no";
cap la def NN9 1 "1- I work for wages or payment (either in cash or in kind) for a company, the government or any other individual."
2 "2- I do not work for wages, but rather work on my account or in a business enterprise or farm belonging to me or someone else in my household, for example, as a farmer, trader, shop-keeper, barber, dressmaker, carpenter or taxi driver";
cap la def OO3 1 "1- Private sector"
2 "2- NGO or international organization"
3 "3- Public sector (non-military)"
4 "4-Military";
cap la def OO4 1 "1- Fewer than 5"
2 "2- [5-9]"
"3 "3- [10-19]"
"4 "4- 20 or more";"
cap la def OO5 1 "1- Walk"
2 "2- Shared cab (service)"
3 "3- Motorbike"
4 "4- Taxi"
5 "5- Bus"
"6 "6- Minibus  "
"7 "7- Car"
"8 "8- Carpool  "
"9 "9- I live at my work place  "
cap la def OO7 1 "yes"
2 "no";
cap la def OO8 1 "1- Fixed-term"
2 "2- Open-ended";
cap la def OO10 1 "1- Yes: Public insurance only"
2 "2- Yes: private insurance only"
3 "3- Yes: both public and private"
4 "2- No";
cap la def OO11 1 "yes"
2 "no";
cap la def OO12 1 "1- Hourly"
2 "2- Daily"
3 "3- Weekly"
4 "4- Bi-monthly"
5 "5- Monthly"
6 "6- Quarterly"
cap la def OO13 1 "1- Yes on time and in full"
2 "2-Yes on time but not in full"
3 "3- No";
cap la def OO15 1 "yes"
2 "no";
cap la def OO16 1 "1- Food"
2 "2- Housing"
3 "3- Mobile phone"
4 "4- Work car"
5 "5- Insurance"
6 "6- Travel"
cap la def OO17 1 "1- No relationship"
2 "2- Member of my household"
3 "3- Close relative"
4 "4- Distant relative"
5 "5- Friend"
6 "6- Friend of friend or relative"
cap la def OO19 1 "1- Asked close relative or HH member"
2 "2- Asked distant relative"
3 "3- Asked friend"
4 "4- Asked friend of friend or relative"
5 "5- Asked member of same community"
6 "6- Asked politician or political party"
7 "7- Applied at employment office"
8 "8- Responded to ad in newspaper"
9 "9- Applied directly to the firm"
cap la def OO20 1 "yes"
2 "no";
cap la def OO21 1 "yes"
2 "no";
cap la def OO22 1 "yes"
2 "no";
cap la def OO24 1 "yes"
2 "no";
cap la def OO26 1 "1- More satisfied today"
2 "2- More satisfied in 2013"
3 "3- No difference";
cap la def OO27 1 "1- More satisfied today"
2 "2- More satisfied in 2013"
3 "3- No difference";
cap la def OO28 1 "1 - More hours today"
2 "2 - More hours in 2013"
3 "3 - No difference";
cap la def OO29 1 "yes"
2 "no";
cap la def OO31 1 "1- More satisfied today"
2 "2- More satisfied in 2010"
3 "3- No difference";
cap la def OO32 1 "1 - More satisfied today"
2 "2 - More satisfied in 2010";
cap la def OO33 1 "1 - More hours today"
2 "2 - More hours in 2010"
3 "3 - No difference";
cap la def PP3 1 "yes"
2 "no";
cap la def PP4 1 "yes"
2 "no";
cap la def PP5 1 "yes"
2 "no";
cap la def PP6 1 "yes"
2 "no";
cap la def PP9 1 "yes"
2 "no";
cap la def PP11 1 "1- Very stable"
2 "2- Moderately stable"
3 "3- Unstable";
cap la def PP13 1 "yes"
2 "no";
cap la def PP14 1 "1- More stable today"
2 "2- More stable in 2013"
3 "3- No difference";
cap la def PP15 1 "1 - More satisfied today"
2 "2 - More satisfied in 2013"
3 "3 - No difference";
cap la def PP16 1 "yes"
2 "no";
cap la def PP17 1 "yes"
2 "no";
cap la def PP20 1 "1- More stable today"
2 "2- More stable in 2010"
3 "3- No difference";
cap la def PP21 1 "1 - More satisfied today"
2 "2 - More satisfied in 2010."
3 "3 - No difference";
cap la def U1 1 "1- Yes"
2 "2- No members of other community in my place of worship"
3 "3- I do not regularly attend church/mosque";
cap la def U2 1 "1- Strongly agree"
2 "2- Agree"
3 "3- Disagree"
4 "4- Strongly disagree";
cap la def U3 1 "1- Strongly agree"
2 "2- Agree"
3 "3- Disagree"
4 "4- Strongly disagree";
cap la def U4 1 "1- Yes"
2 "2- No"
3 "3- N/A";
cap la def U5 1 "1- Yes"
2 "2- No"
3 "3- N/A";
cap la def U6 1 "1- Lack of proper ID documents"
2 "2- Inadequate income/work"
3 "3- Lack of cash"
4 "4- Lack of food"
5 "5- Quality of dwelling"
6 "6- Access to services (health, education)"
7 "7- Discrimination"
8 "8- Safety 9- Psychological stress"
9 "10- Worrying about family members who are away"
11 " Nothing"
cap la def U7 1 "1- Kurdistan should host both Syrians and Iraqis fleeing violence"
2 "2- Kurdistan should host only Syrians fleeing violence"
3 "3- Kurdistan should host only Iraqis fleeing violence"
4 "4-Kurdistan should not host any more IDPs or refugees ";
cap la def U8 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def U9 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def U10 1 "1- Better"
2 "2- Same"
3 "3- Worse";
cap la def U11 1 "yes"
2 "no";
cap la def U12 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def U13 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def U14 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def U15 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def U16 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def U17 1 "1- Very safe"
2 "2- Safe"
3 "3- Unsafe"
4 "4- Very unsafe";
cap la def V1X1 1 "yes"
2 "no";
cap la def V2X1 1 "yes"
2 "no";
cap la def V3X1 1 "yes"
2 "no";
cap la def V4X1 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X1 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X1 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X2 1 "yes"
2 "no";
cap la def V2X2 1 "yes"
2 "no";
cap la def V3X2 1 "yes"
2 "no";
cap la def V4X2 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X2 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X2 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X3 1 "yes"
2 "no";
cap la def V2X3 1 "yes"
2 "no";
cap la def V3X3 1 "yes"
2 "no";
cap la def V4X3 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X3 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X3 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X4 1 "yes"
2 "no";
cap la def V2X4 1 "yes"
2 "no";
cap la def V3X4 1 "yes"
2 "no";
cap la def V4X4 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X4 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X4 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X5 1 "yes"
2 "no";
cap la def V2X5 1 "yes"
2 "no";
cap la def V3X5 1 "yes"
2 "no";
cap la def V4X5 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X5 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X5 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X6 1 "yes"
2 "no";
cap la def V2X6 1 "yes"
2 "no";
cap la def V3X6 1 "yes"
2 "no";
cap la def V4X6 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X6 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X6 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X7 1 "yes"
2 "no";
cap la def V2X7 1 "yes"
2 "no";
cap la def V3X7 1 "yes"
2 "no";
cap la def V4X7 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X7 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X7 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X8 1 "yes"
2 "no";
cap la def V2X8 1 "yes"
2 "no";
cap la def V3X8 1 "yes"
2 "no";
cap la def V4X8 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X8 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X8 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def V1X9 1 "yes"
2 "no";
cap la def V2X9 1 "yes"
2 "no";
cap la def V3X9 1 "yes"
2 "no";
cap la def V4X9 1 "1- Police"
2 "2- Lawyer/court"
3 "3- Elected official"
4 "4- Other government official"
5 "5 - Moneylenders  "
6 "6 - Bank"
7 "7 - Shopkeepers"
8 "8- NGO or UN  "
9 "9- Political party or political connections"
10 "10- Religious organization"
11 "11- Neighbors / friends  "
12 "12 -Other household members  "
cap la def V5X9 1 "1- Solved through direct negotiation with other party"
2 "2- Solved through mediation of relatives / neighbors / friends"
3 "3- It would take too much time  "
4 "4- It would cost too much money"
5 "5- Other party is more powerful than I am, no chance of winning  "
6 "6- It would cause problems for me or my family"
7 "7- Don't know how to prove"
8 "8- I don't know who to ask for help  "
9 "9 - N/A (debt)"
cap la def V6X9 1 "1-Very satisfied"
2 "2- Satisfied"
3 "3- Dissatisfied"
4 "4- Very dissatisfied";
cap la def W1 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W2 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W3 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W4 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W5 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W6 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W7 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W8 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def W9 1 "1"
2 "2"
3 "3"
4 "4"
5 "5"
6 "6"
7 "7"
8 "8"
9 "9"
10 "10";
cap la def QQ1 1 "1- employed"
2 "2- not employed";
cap la def QQ4 1 "1- wage worker"
2 "2- self-employed/employer";
cap la def QQ6 1 "1- More satisfied today"
2 "2- More satisfied in 2013."
3 "3- No difference";
cap la def QQ7 1 "1 - More hours today"
2 "2 - More hours in 2013."
3 "3 - No difference";
cap la def QQ8 1 "1- More stable today"
2 "2- More stable in 2013."
3 "3- No difference";
cap la def QQ9 1 "1 - More satisfied today"
2 "2 - More satisfied in 2013."
3 "3 - No difference";
cap la def QQ10 1 "1- wage worker"
2 "2- self-employed/employer"
3 "3- not employed";
cap la def QQ11 1 "1 - Today's activity"
2 "2 - My activity in 2013"
3 "3 - No difference";
cap la def RR3 1 "1- Private sector"
2 "2- NGO or international organization"
3 "3- Public sector (non-military)"
4 "4- Military";
cap la def RR4 1 "yes"
2 "no";
cap la def RR5 1 "1- Yes: NSSF insurance only"
2 "2- Yes: private insurance only"
3 "3- Yes: both NSSF and private"
4 "4- No";
cap la def RR6 1 "yes"
2 "no";
cap la def RR7 1 "1- Hourly"
2 "2- Daily"
3 "3- Weekly"
4 "4- Bi-monthly"
5 "5- Monthly"
6 "6- Quarterly"
cap la def RR10 1 "1- More satisfied today"
2 "2- More satisfied in 2010."
3 "3- No difference";
cap la def RR11 1 "1- More satisfied today"
2 "2- More satisfied in 2010."
3 "3- No difference";
cap la def RR12 1 "1 - More hours today"
2 "2 - More hours in 2010."
3 "3 - No difference";
cap la def RR13 1 "1 - Today's activity"
2 "2 - My activity in 2010";
cap la def RR15 1 "1- Fired or dismissed"
2 "2- Found a better job"
3 "3- Pay was too low"
4 "4- Moved further away"
5 "5- Bad experience on the job"
6 "6- Contract ended"
7 "7- Season ended"
8 "8- Needed to take care of family members"
9 "9- Business shut down"
10 "10- Security reasons"
11 "11- Sickness or injury"
12 "12- Retirement"
13 "13- Did not need to work anymore"
14 "14- Got married"
15 "15- Became pregnant"
16 "16- Family stopped allowing me to work (social reasons)"
cap la def SS3 1 "yes"
2 "no";
cap la def SS4 1 "yes"
2 "no";
cap la def SS7 1 "1- More stable today"
2 "2- More stable in 2013.  .  Ì§è„ „…‚? ò‚‹ 2013"
3 "3- No difference";
cap la def SS8 1 "1 - More satisfied today"
2 "2 - More satisfied in 2010"
3 "3 - No difference";
cap la def SS19 1 "1 - Today's activity"
2 "2 - My activity in 2010"
3 "3 - No difference";
cap la def SS10 1 "yes"
2 "no";
cap la def SS12 1 "1- Fired or dismissed"
2 "2- Found a better job"
3 "3- Pay was too low"
4 "4- Moved further away  "
5 "5- Bad experience on the job"
6 "6- Contract ended  "
7 "7- Season ended  "
8 "8- Needed to take care of family members"
9 "9- Business shut down  "
10 "10- Security reasons  "
11 "11- Sickness or injury  "
12 "12- Retirement"
13 "13- Did not need to work anymore  "
14 "14- Got married  "
15 "15- Became pregnant"
16 "16- Family stopped allowing me to work (social reasons)  "
cap la def TT1 1 "yes"
2 "no";
cap la def TT2 1 "1- Too many people searching for jobs  "
2 "2- Underqualified for available jobs  "
3 "3- Legal issues"
4 "4- Available jobs are too far away  "
5 "5- Discrimination by employers  "
6 "6- No jobs available that are suitable for education"
7 "7- Lack of personal or political connections  "
8 "8- Don't have enough time to look for work"
9 "9- Wages are too low  "
10 "10- Overqualified for available jobs  "
11 "11- Harassment or discrimination (other than by employers)  "
12 "12- Jobs are too dangerous"
13 "13- Disability or chronic illness  "
14 "14- Housewife"
15 "15- Too young"
16 "16- Full-time student"
cap la def TT3 1 "yes"
2 "no";

*/;


la val HHRESULT HHRESULT;
la val A1 A1;
la val A2 A2;
la val A3 A3;
la val A4 A4;
la val A6 A6;

la val A10 A10;
la val A11 A11;
la val A14 A14;
la val A15 A15;
la val A16_1 A16_2 A16_3 A16;
la val A17 A17;
la val A18 A18;
la val A19 A19;
la val A20 A20;
la val A21 A21;
la val A22 A22;
la val A23 A23;
la val A24 A24;
la val A25 A25;
la val A26_1 A26_2 A26_3 A26;
la val A27? A27;
la val A29 A29;
la val A30 A30;
la val A31 A31;
la val A33 A33;
la val A35 A35;
la val A37_1 A37_2 A37;
la val A38 A38;
la val A39* A39;
la val A40* A40;
la val A41* A41;
la val A42 A42;

la val B2CURRENT B2CURRENT;
la val B5CURRENT B5CURRENT;
la val B2SEPTEMBER2013 B2DECEMBER2013;
la val B5SEPTEMBER2013 B5DECEMBER2013;
la val B2SEPTEMBER2010 B2SEPTEMBER2010;
la val B5SEPTEMBER2010 B5SEPTEMBER2010;
la val B2REFUGEESANDIDPS B2REFUGEESANDIDPSONLY;
la val B5REFUGEESANDIDPS B5REFUGEESANDIDPSONLY;
la val B8 B8;
la val B9 B9;
la val B10 B10;
la val B14 B14;
la val B18 B18;
la val B19 B19;

la val C3 C3;
la val C4 C4;
la val C5* C5;
la val C9 C9;

la val D3 D3;
la val D4 D4;
la val D5 D5;
la val D6X1 D6X1;
la val D7X1 D7X1;
la val D8X1 D8X1;
la val D9X1 D9X1;
la val D6X2 D6X2;
la val D7X2 D7X2;
la val D8X2 D8X2;
la val D9X2 D9X2;
la val D6X3 D6X3;
la val D7X3 D7X3;
la val D8X3 D8X3;
la val D9X3 D9X3;
la val D6X4 D6X4;
la val D7X4 D7X4;
la val D8X4 D8X4;
la val D9X4 D9X4;
la val D6X5 D6X5;
la val D7X5 D7X5;
la val D8X5 D8X5;
la val D9X5 D9X5;
la val D6X6 D6X6;
la val D7X6 D7X6;
la val D8X6 D8X6;
la val D9X6 D9X6;
la val D6X7 D6X7;
la val D7X7 D7X7;
la val D8X7 D8X7;
la val D9X7 D9X7;
la val D6X8 D6X8;
la val D7X8 D7X8;
la val D8X8 D8X8;
la val D9X8 D9X8;
la val D6X9 D6X9;
la val D7X9 D7X9;
la val D8X9 D8X9;
la val D9X9 D9X9;

la val E1X1 E1X1;
la val E1X2 E1X2;
la val E1X3 E1X3;
la val E1X4 E1X4;
la val E1X5 E1X5;
la val E1X6 E1X6;
la val E1X7 E1X7;
la val E1X8 E1X8;

la val E4 E4;
la val E6 E6;
la val E7 E7;
la val E8 E8;
la val E9 E9;
la val E11 E11;

la val F1X1 F1X1;
la val F2X1 F2X1;
la val F3X1* F3X1;
la val F1X2 F1X2;
la val F2X2 F2X2;
la val F3X2* F3X2;
la val F1X3 F1X3;
la val F2X3 F2X3;
la val F3X3* F3X3;
la val F1X4 F1X4;
la val F2X4 F2X4;
la val F3X4* F3X4;
la val F1X5 F1X5;
la val F2X5 F2X5;
la val F3X5* F3X5;
la val F1X6 F1X6;
la val F2X6 F2X6;
la val F3X6* F3X6;
la val F1X7 F1X7;
la val F2X7 F2X7;
la val F3X7* F3X7;
la val F1X8 F1X8;
la val F2X8 F2X8;
la val F3X8* F3X8;
la val F1X9 F1X9;
la val F2X9 F2X9;
la val F3X9* F3X9;
la val F1X10 F1X10;
la val F2X10 F2X10;
la val F3X10* F3X10;
la val F1X11 F1X11;
la val F2X11 F2X11;
la val F3X11* F3X11;
la val F1X12 F1X12;
la val F2X12 F2X12;
la val F3X12* F3X12;

la val G1? G1;
la val G2 G2;
la val G3* G3;

la val H4? H4;
la val I1 I1;
la val I2 I2;
la val I3 I3;
la val I4 I4;
la val I5 I5;
la val I6 I6;

la val J2 J2;
la val J4 J4;
la val J5 J5;
la val J7 J7;
la val J8 J8;
la val J11 J11;
la val J12 J12;
la val J13 J13;
la val J14* J14;
la val J15 J15;
la val J16* J16;
la val J17* J17;
la val J18* J18;
la val J19 J19;

la val K5 K5;
la val K6 K6;
la val K7 K7;
la val K9 K9;
la val K10 K10;
la val K11 K11;
la val K12 K12;
la val K14 K14;
la val K15 K15;
la val K16 K16;
la val K17 K17;
la val K18 K18;
la val K19 K19;
la val K20 K20;
la val K21 K21;
la val K22 K22;
la val K23* K23;
la val K24* K24;
la val K25 K25;

/*;
la val L2 L2;
la val L8 L8;
la val L9 L9;
la val L10 L10;
la val L12 L12;
la val L13 L13;
la val L14 L14;
la val L15 L15;
la val L16 L16;
la val L18 L18;
la val M1 M1;
la val M2 M2;
la val M4 M4;
la val M5 M5;
la val N1 N1;
la val N2 N2;
la val N3 N3;
la val N4 N4;
la val N5 N5;
la val N6 N6;
la val N7 N7;
la val N8 N8;
la val N9 N9;
la val O3 O3;
la val O4 O4;
la val O5 O5;
la val O7 O7;
la val O8 O8;
la val O10 O10;
la val O11 O11;
la val O12 O12;
la val O13 O13;
la val O17 O17;
la val Q17 Q17;
la val O18 O18;
la val O19 O19;
la val O20 O20;
la val O21 O21;
la val O22 O22;
la val O23 O23;
la val O25 O25;
la val O27 O27;
la val O28 O28;
la val O29 O29;
la val O30 O30;
la val O32 O32;
la val O33 O33;
la val O34 O34;
la val P3 P3;
la val P4 P4;
la val P5 P5;
la val P6 P6;
la val P9 P9;
la val P11 P11;
la val P13 P13;
la val P14 P14;
la val P15 P15;
la val P16 P16;
la val P17 P17;
la val P20 P20;
la val P21 P21;
la val Q27 Q27;
la val Q28 Q28;
la val Q29 Q29;
la val Q30 Q30;
la val Q31 Q31;
la val Q33 Q33;
la val Q34 Q34;
la val Q35 Q35;
la val Q36 Q36;
la val Q1 Q1;
la val Q4 Q4;
la val Q6 Q6;
la val Q7 Q7;
la val Q8 Q8;
la val Q9 Q9;
la val Q10 Q10;
la val Q11 Q11;
la val Q12 Q12;
la val R3 R3;
la val R4 R4;
la val R5 R5;
la val R6 R6;
la val R7 R7;
la val R10 R10;
la val R11 R11;
la val R12 R12;
la val R13 R13;
la val R14 R14;
la val R17 R17;
la val S2 S2;
la val S3 S3;
la val S4 S4;
la val S7 S7;
la val S8 S8;
la val S9 S9;
la val S10 S10;
la val S13 S13;
la val T1 T1;
la val T2 T2;
la val T3 T3;
la val MM1 MM1;
la val MM2 MM2;
la val MM4 MM4;
la val MM5 MM5;
la val NN1 NN1;
la val NN2 NN2;
la val NN3 NN3;
la val NN4 NN4;
la val NN5 NN5;
la val NN6 NN6;
la val NN7 NN7;
la val NN8 NN8;
la val NN9 NN9;
la val OO3 OO3;
la val OO4 OO4;
la val OO5 OO5;
la val OO7 OO7;
la val OO8 OO8;
la val OO10 OO10;
la val OO11 OO11;
la val OO12 OO12;
la val OO13 OO13;
la val OO15 OO15;
la val OO16 OO16;
la val OO17 OO17;
la val OO19 OO19;
la val OO20 OO20;
la val OO21 OO21;
la val OO22 OO22;
la val OO24 OO24;
la val OO26 OO26;
la val OO27 OO27;
la val OO28 OO28;
la val OO29 OO29;
la val OO31 OO31;
la val OO32 OO32;
la val OO33 OO33;
la val PP3 PP3;
la val PP4 PP4;
la val PP5 PP5;
la val PP6 PP6;
la val PP9 PP9;
la val PP11 PP11;
la val PP13 PP13;
la val PP14 PP14;
la val PP15 PP15;
la val PP16 PP16;
la val PP17 PP17;
la val PP20 PP20;
la val PP21 PP21;
la val U1 U1;
la val U2 U2;
la val U3 U3;
la val U4 U4;
la val U5 U5;
la val U6 U6;
la val U7 U7;
la val U8 U8;
la val U9 U9;
la val U10 U10;
la val U11 U11;
la val U12 U12;
la val U13 U13;
la val U14 U14;
la val U15 U15;
la val U16 U16;
la val U17 U17;
la val V1X1 V1X1;
la val V2X1 V2X1;
la val V3X1 V3X1;
la val V4X1 V4X1;
la val V5X1 V5X1;
la val V6X1 V6X1;
la val V1X2 V1X2;
la val V2X2 V2X2;
la val V3X2 V3X2;
la val V4X2 V4X2;
la val V5X2 V5X2;
la val V6X2 V6X2;
la val V1X3 V1X3;
la val V2X3 V2X3;
la val V3X3 V3X3;
la val V4X3 V4X3;
la val V5X3 V5X3;
la val V6X3 V6X3;
la val V1X4 V1X4;
la val V2X4 V2X4;
la val V3X4 V3X4;
la val V4X4 V4X4;
la val V5X4 V5X4;
la val V6X4 V6X4;
la val V1X5 V1X5;
la val V2X5 V2X5;
la val V3X5 V3X5;
la val V4X5 V4X5;
la val V5X5 V5X5;
la val V6X5 V6X5;
la val V1X6 V1X6;
la val V2X6 V2X6;
la val V3X6 V3X6;
la val V4X6 V4X6;
la val V5X6 V5X6;
la val V6X6 V6X6;
la val V1X7 V1X7;
la val V2X7 V2X7;
la val V3X7 V3X7;
la val V4X7 V4X7;
la val V5X7 V5X7;
la val V6X7 V6X7;
la val V1X8 V1X8;
la val V2X8 V2X8;
la val V3X8 V3X8;
la val V4X8 V4X8;
la val V5X8 V5X8;
la val V6X8 V6X8;
la val V1X9 V1X9;
la val V2X9 V2X9;
la val V3X9 V3X9;
la val V4X9 V4X9;
la val V5X9 V5X9;
la val V6X9 V6X9;
la val W1 W1;
la val W2 W2;
la val W3 W3;
la val W4 W4;
la val W5 W5;
la val W6 W6;
la val W7 W7;
la val W8 W8;
la val W9 W9;
la val QQ1 QQ1;
la val QQ4 QQ4;
la val QQ6 QQ6;
la val QQ7 QQ7;
la val QQ8 QQ8;
la val QQ9 QQ9;
la val QQ10 QQ10;
la val QQ11 QQ11;
la val RR3 RR3;
la val RR4 RR4;
la val RR5 RR5;
la val RR6 RR6;
la val RR7 RR7;
la val RR10 RR10;
la val RR11 RR11;
la val RR12 RR12;
la val RR13 RR13;
la val RR15 RR15;
la val SS3 SS3;
la val SS4 SS4;
la val SS7 SS7;
la val SS8 SS8;
la val SS19 SS19;
la val SS10 SS10;
la val SS12 SS12;
la val TT1 TT1;
la val TT2 TT2;
la val TT3 TT3;

