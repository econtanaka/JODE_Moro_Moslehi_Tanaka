/* for strucrual change and marriage project */
/* last updated: 08/31/2015 */

use $data/marriage.dta, clear

/*----------------------------------------------------------------------------*/
/* consider individuals under consensual union as married */

foreach g in m f {
replace married_`g' = married_`g' + consensual_`g' if consensual_`g' != .
replace divorced_`g' = separated_`g' if divorced_`g' == . & separated_`g' != .
replace divorced_`g' = divorced_`g' + separated_`g' if divorced_`g' != . & separated_`g' != .
}

/*----------------------------------------------------------------------------*/
/* create variables */

foreach name in ma nev div wid {
gen frac_`name'_m_15 = .
gen frac_`name'_f_15 = . 
gen frac_`name'_t_15 = .
gen frac_`name'_m_15_49 = . 
gen frac_`name'_f_15_49 = . 
gen frac_`name'_t_15_49 = . 
gen frac_`name'_m_15_adja_2000 = .
gen frac_`name'_f_15_adja_2000 = .
gen frac_`name'_t_15_adja_2000 = .
gen frac_`name'_m_15_adjm_2000 = . 
gen frac_`name'_f_15_adjm_2000 = .
gen frac_`name'_t_15_adjm_2000 = .
gen frac_`name'_m_15_49_adja_2000 = .
gen frac_`name'_f_15_49_adja_2000 = .
gen frac_`name'_t_15_49_adja_2000 = .
gen frac_`name'_m_15_49_adjm_2000 = .
gen frac_`name'_f_15_49_adjm_2000 = .
gen frac_`name'_t_15_49_adjm_2000 = .
}

foreach name in ma {
gen frac_`name'_m_15_adja_peak = .
gen frac_`name'_f_15_adja_peak = .
gen frac_`name'_t_15_adja_peak = .
gen frac_`name'_m_15_adjm_peak = . 
gen frac_`name'_f_15_adjm_peak = .
gen frac_`name'_t_15_adjm_peak = .
gen frac_`name'_m_15_49_adja_peak = .
gen frac_`name'_f_15_49_adja_peak = .
gen frac_`name'_t_15_49_adja_peak = .
gen frac_`name'_m_15_49_adjm_peak = .
gen frac_`name'_f_15_49_adjm_peak = .
gen frac_`name'_t_15_49_adjm_peak = .
}

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* adjust age structure */
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/

#delimit ;
local var_list
total_m
married_m
single_m
widowed_m
divorced_m
separated_m
consensual_m
unknown_m
total_f
married_f
single_f
widowed_f
divorced_f
separated_f
consensual_f
unknown_f;
#delimit cr

gsort country area_code year max_age -min_age

/* keep only 15+ */
keep if min_age >= 15 

/*----------------------------------------------------------------------------*/
/* australia */

local country country == "australia"

/* 15-19 */
local year (year == 1910)
local min = 15
local max = 19

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 20-24 */
local year (year == 1900 | year == 1910)
local min = 20
local max = 24

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 60-999 */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930 | year == 1940 | year == 1950 | ///
            year == 1960 | year == 1970 | year == 1980 | year == 1990 | year == 2000)
local min = 60
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* belgium */

local country country == "belgium"

/* 75-999 */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930 | year == 1940 | ///
            year == 1950 | year == 1960 | year == 1970 | year == 1980 | year == 2000)
local min = 75
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* ---------------------------------------------------------------------------*/
/* canada */

local country country == "canada"

/* 75-999 */
local year (year == 1910 | year == 1920 | year == 1930 | year == 1950 | ///
            year == 1960 | year == 1970 | year == 1980 | year == 2000)
local min = 75
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 15-49 for 1940 */
local year (year == 1940 )
local min = 15
local max = 44

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* ---------------------------------------------------------------------------*/
/* denmark */

local country country == "denmark"

/* 80-999 */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930 | year == 1940 | ///
            year == 1960 | year == 1970 | year == 1980 | year == 1990 | year == 2000)
local min = 80
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* ---------------------------------------------------------------------------*/
/* finland */

local country country == "finland"

/* 75-999 */
local year (year == 1900 | year == 1910 | year == 1920 | ///
            year == 1930 | year == 1940 | year == 2000)
local min = 75
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* ---------------------------------------------------------------------------*/
/* france */

local country country == "france"

/* 70-999 */
local year (year == 1900 | year == 1910 | year == 1950 | year == 1960 | ///
            year == 1970 | year == 1980 | year == 1990 | year == 2000)
local min = 70
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 20-70 */
local year (year == 1900 | year == 1910 | year == 1950 | year == 1960 | ///
            year == 1970 | year == 1980 | year == 1990 | year == 2000)

forvalues t = 20(10)60 {
local min = `t'
local max = `t'+9

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & min_age >= `min' & max_age <= `max'
}

/* ---------------------------------------------------------------------------*/
/* germany */

local country country == "germany"

/* area code */
local area_list DEU FRG GDR
foreach a in `area_list' {

/* 15-999 for 1960 and 1970 */
local year (year == 1960 | year == 1970)
local min = 15
local max = 999

/* replacing 0 */
foreach v in `var_list' {
replace `v' = 0 if `country' & `year' & area_code == "`a'" & `v' ==.
}

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & (min_age != 15 | max_age != 19) & max_age <= `max' & area_code == "`a'"
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1 & area_code == "`a'"
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max' & area_code == "`a'"
}

/* generating total */
foreach g in m f {
replace total_`g' = married_`g' + single_`g' + widowed_`g' + divorced_`g' if `country' & `year' & area_code == "FRG"
}

/* 15-19 for 1950, GDR */
local year (year == 1950)
local area (area_code == "GDR")
local min = 15
local max = 20

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'
replace max_age = `max'-1 if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'

/* 20-24 for 1950, GDR */
local year (year == 1950)
local area (area_code == "GDR")
local min = 21
local max = 24

replace min_age = `min'-1 if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'

/* 15-19 for 1950, FRG */
local year (year == 1950)
local area (area_code == "FRG")
local min = 15
local max = 19

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'

/* 20-24 for 1950, FRG */
local year (year == 1950)
local area (area_code == "FRG")
local min = 20
local max = 24

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'

/* 15-19,...,70+ for 1950, GDR */
local year (year == 1980)
local area (area_code == "GDR")

forvalues t = 15(5)65 {
local min = `t'
local max = `t'+4

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'
}

local min = 70
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'

/* 70-999 for 1950, GDR and FRG */

local year (year == 1950)
local area (area_code == "GDR" | area_code == "FRG" )
local min = 70
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'

/* 70-999 for 1980, FRG */

local year (year == 1980)
local area (area_code == "FRG" )
local min = 70
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & `area' & min_age >= `min' & max_age <= `max'

/* 15-19,...,70+ */
local year (year == 1900 | year == 1910 | year == 1920 | ///
            year == 1940 | year == 1990 | year == 2000)

forvalues t = 15(5)65 {
local min = `t'
local max = `t'+4

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & min_age >= `min' & max_age <= `max'
}

local min = 70
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & `area' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* ---------------------------------------------------------------------------*/
/* combine east and west germany */

local year (year == 1950 | year == 1960 | year == 1970 | year == 1980)
local area (area_code == "GDR" | area_code == "FRG" )

foreach v in `var_list' {
egen temp_01 = total(`v') if `year' & `country' & `area', by(year min_age)
replace `v' = temp_01 if `year' & `country' & `area'
drop temp_01
}
drop if area_code == "FRG"
drop area_code

gsort country year max_age -min_age

/* ---------------------------------------------------------------------------*/
/* italy */

local country country == "italy"

/* 15-19, 20-24 */
local year (year == 1900)
local min = 15
local max = 20

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* for italy i consider age 20 as age 19, to make the age structure consistent with other years */
replace max_age = 19 if `country' & year == 1900 & min_age == 15 & max_age == 20
replace min_age = 20 if `country' & year == 1900 & min_age == 21 & max_age == 24

/* 90-999 */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930 | year == 1940 | ///
            year == 1950 | year == 1960 | year == 1970 | year == 1990 | year == 2000)
local min = 90
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* japan */

local country country == "japan"

/* 80-999 */
local year (year == 1920 | year == 1930 | year == 1940 | year == 1940 | year == 1960 | ///
            year == 1970 | year == 1980 | year == 1990 | year == 2000 )
local min = 80
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* netherlands */

local country country == "netherlands"

/* 95-999 */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930)
local min = 95
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* norway */

local country country == "norway"

/* 75-999 */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930 | ///
            year == 1950 | year == 1960 | year == 1970 | year == 2000 )
local min = 75
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 15-19 for 1950 */
local year (year == 1950 | year == 1960 )
local min = 15
local max = 19

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* spain */

local country country == "spain"

/* for years, 1900-1930, decrease ages by one to make the age structure consistent with later years */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930 )

replace min_age = min_age-1 if `country' & `year'
replace max_age = max_age-1 if `country' & `year' & max_age != 999

/* 15-19 */
local year (year == 1920 | year == 1930 )
local min = 15
local max = 19

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 50-70 */
local year (year == 1920 | year == 1930 | year == 1950 | year == 1960 | ///
            year == 1970 | year == 1980 | year == 1990 | year == 2000 )
	    
forvalues t = 50(10)60 {
local min = `t'
local max = `t'+9

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'
}

/* 70-999 */
local year (year == 1900 | year == 1910 | year == 1920 | year == 1930 | year == 1950 | ///
            year == 1960 | year == 1970 | year == 1980 | year == 1990 | year == 2000 )
local min = 70
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 15-49 for 1950 and 1970 */

local year (year == 1950 | year == 1970 )
	    
forvalues t = 15(5)45 {
local min = `t'
local max = `t'+4

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'
}

/* 18-19 for 2000 */

local year (year == 2000 )
	    
local t = 18
local min = `t'
local max = `t'+1

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 20-49 for 1950 and 1970 */

local year (year == 2000 )
	    
forvalues t = 20(5)45 {
local min = `t'
local max = `t'+4

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'
}

/*----------------------------------------------------------------------------*/
/* sweden */

local country country == "sweden"

/* 90-999 */
local year (year == 2000 )
local min = 90
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* switzerland */

local country country == "switzerland"

/* 90-999 */
local year (year == 2000)
local min = 85
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* uk */

local country country == "uk"

/* 15-49 for 1900 */
local year (year == 1900 )
local min = 15
local max = 44

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 50-999 for 1900 */
local year (year == 1900 )
local min = 45
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 75-999 */
local year (year == 1910 | year == 1920 | year == 1930 | ///
            year == 1970 | year == 1980 | year == 2000 )
local min = 75
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/* 75-999 for 1960*/
local year (year == 1960)
local min = 75
local max = 999

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

foreach v in `var_list' {
replace `v' = `v'[_n-1] if `country' & `year' & `v' == . & min_age >= `min' & max_age <= `max' & min_age == min_age[_n-1]
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max' & min_age == min_age[_n+1]

/* 15-70 */
forvalues t = 15(5)70 {
local year (year == 1920 | year == 1970 )
local min = `t'
local max = `t'+4

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'
}

/* 15-20 for 2000 */
local year (year == 2000 )
local min = 15
local max = 19

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & `year' & min_age >= `min'+2 & max_age <= `max'
}
drop if `country' & `year' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & `year' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/* us */

local country country == "us"

/* 15-70 */
forvalues t = 15(5)85 {
local min = `t'
local max = `t'+4

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & min_age >= `min' & max_age <= `max'
}

/* 100-999 */
local min = 90
local max = 135

foreach v in `var_list' {
replace `v' = `v' + `v'[_n-1] if `country' & min_age >= `min'+1 & max_age <= `max'
}
drop if `country' & min_age >= `min' & max_age <= `max'-1
replace min_age = `min' if `country' & min_age >= `min' & max_age <= `max'
replace max_age =  999  if `country' & min_age >= `min' & max_age <= `max'

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* calculate marital statistics */
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/

#delimit ;
local name_list
australia
belgium
canada
denmark
finland
france
germany
italy
japan
netherlands
norway
spain
sweden
switzerland
uk
us;
#delimit cr

/*----------------------------------------------------------------------------*/

local exception ((country != "uk" | year != 1900) & (country != "canada" | year != 1940) & (country != "germany" | ((year != 1960) & (year != 1970))))

/*----------------------------------------------------------------------------*/
/* create a variable to keep the population structure in 2000 */

gsort country year max_age -min_age
bysort country year: gen age_cohort = _n if min_age != . & max_age != .

foreach g in m f {
egen total_`g'_15 = total(total_`g') if `exception', by(country year) missing
gen  temp_01 = total_`g'/total_`g'_15 if `exception'
gen  temp_02 = temp_01 if year == 2000
gen  pop_`g'_15 = temp_01
egen pop_`g'_15_2000 = max(temp_02) if `exception', by(country age_cohort)
drop temp*
}

egen total_t_15 = total(total_m + total_f) if `exception', by(country year) missing
gen  temp_01 = (total_m + total_f)/total_t_15 if `exception'
gen  temp_02 = temp_01 if year == 2000
gen  pop_t_15 = temp_01
egen pop_t_15_2000 = max(temp_02) if `exception', by(country age_cohort)
drop temp*

foreach g in m f {
egen total_`g'_15_49 = total(total_`g') if max_age <= 49 & `exception', by(country year) missing
gen  temp_01 = total_`g'/total_`g'_15_49 if max_age <= 49 & `exception'
gen  temp_02 = temp_01 if year == 2000
gen  pop_`g'_15_49 = temp_01
egen pop_`g'_15_49_2000 = max(temp_02) if `exception', by(country age_cohort)
drop temp*
}

egen total_t_15_49 = total(total_m + total_f) if max_age <= 49 & `exception', by(country year) missing
gen  temp_01 = (total_m + total_f)/total_t_15_49 if max_age <= 49 & year == 2000 & `exception'
gen  temp_02 = temp_01 if year == 2000
gen  pop_t_15_49 = temp_01
egen pop_t_15_49_2000 = max(temp_02) if `exception', by(country age_cohort)
drop temp*


/*----------------------------------------------------------------------------*/
/* calculate fractions of the married, never-married, and divorced */

foreach v in married single divorced widowed {
if ("`v'" == "married") {
local name = "ma"
}
if ("`v'" == "single") {
local name = "nev"
}
if ("`v'" == "divorced") {
local name = "div"
}
if ("`v'" == "widowed") {
local name = "wid"
}

/* age >= 15 */

gsort country year max_age -min_age

foreach g in m f {
egen temp_01 = total(`v'_`g'), by(country year)
egen temp_02 = total(total_`g'), by(country year)
gen  temp_03 = temp_01/temp_02
egen temp_04 = max(temp_03) if `v'_`g' != ., by(country year)
replace frac_`name'_`g'_15 = temp_04
drop temp*
}

egen temp_01 = total(`v'_m), by(country year)
egen temp_02 = total(`v'_f), by(country year)
egen temp_03 = total(total_m), by(country year)
egen temp_04 = total(total_f), by(country year)
gen  temp_05 = (temp_01 + temp_02)/(temp_03 + temp_04)
egen temp_06 = max(temp_05) if (`v'_m != . & `v'_f != .), by(country year)
replace frac_`name'_t_15 = temp_06
drop temp*

/*----------------------------------------------------------------------------*/
/* age >= 15 & age <= 49 */

gsort country year max_age -min_age

foreach g in m f {
egen temp_01 = total(`v'_`g') if min_age >= 15 & max_age <= 49, by(country year)
egen temp_02 = total(total_`g') if min_age >= 15 & max_age <= 49, by(country year)
gen  temp_03 = temp_01/temp_02
egen temp_04 = max(temp_03) if `v'_`g' != ., by(country year) 
replace frac_`name'_`g'_15_49 = temp_04
drop temp*
}

egen temp_01 = total(`v'_m) if min_age >= 15 & max_age <= 49, by(country year)
egen temp_02 = total(`v'_f) if min_age >= 15 & max_age <= 49, by(country year)
egen temp_03 = total(total_m) if min_age >= 15 & max_age <= 49, by(country year)
egen temp_04 = total(total_f) if min_age >= 15 & max_age <= 49, by(country year)
gen  temp_05 = (temp_01 + temp_02)/(temp_03 + temp_04)
egen temp_06 = max(temp_05) if (`v'_m != . & `v'_f != .), by(country year)
replace frac_`name'_t_15_49 = temp_06
drop temp*

}

/*----------------------------------------------------------------------------*/
/* identify the peak */

sort country year
by country: egen max_ma = max(frac_ma_t_15)
gen peak = 0
replace peak = 1 if max_ma == frac_ma_t_15
gen temp_01 = year if peak == 1
bysort country: egen year_max = max(temp_01)
drop temp*

/*----------------------------------------------------------------------------*/
/* create a variable to keep the population structure in the peak year */

foreach g in m f {
gen  temp_01 = total_`g'/total_`g'_15 if `exception'
gen  temp_02 = temp_01 if peak == 1
egen pop_`g'_15_peak = max(temp_02) if `exception', by(country age_cohort)
drop temp*
}

gen  temp_01 = (total_m + total_f)/total_t_15 if `exception'
gen  temp_02 = temp_01 if peak == 1
egen pop_t_15_peak = max(temp_02) if `exception', by(country age_cohort)
drop temp*

foreach g in m f {
gen  temp_01 = total_`g'/total_`g'_15_49 if max_age <= 49 & `exception'
gen  temp_02 = temp_01 if peak == 1
egen pop_`g'_15_49_peak = max(temp_02) if `exception', by(country age_cohort)
drop temp*
}

gen  temp_01 = (total_m + total_f)/total_t_15_49 if max_age <= 49 & year == 2000 & `exception'
gen  temp_02 = temp_01 if peak == 1
egen pop_t_15_49_peak = max(temp_02) if `exception', by(country age_cohort)
drop temp*

/*----------------------------------------------------------------------------*/
/* create a variable to keep the marriage rate at the one in 2000 */

foreach v in married single divorced widowed {
if ("`v'" == "married") {
local name = "ma"
}
if ("`v'" == "single") {
local name = "nev"
}
if ("`v'" == "divorced") {
local name = "div"
}
if ("`v'" == "widowed") {
local name = "wid"
}

foreach g in m f {
gen  temp_01 = `v'_`g'/total_`g' if `exception'
gen  temp_02 = temp_01 if peak == 1
egen temp_03 = max(temp_02), by(country age_cohort)
gen  frac_`name'_by_age_`g' = temp_01
gen  frac_`name'_by_age_`g'_2000 = temp_03
drop temp*
}

gen  temp_01 = (`v'_m + `v'_f)/(total_m + total_f) if `exception'
gen  temp_02 = temp_01 if peak == 1
egen temp_03 = max(temp_02), by(country age_cohort)
gen  frac_`name'_by_age_t = temp_01
gen  frac_`name'_by_age_t_2000 = temp_03
drop temp*

/*----------------------------------------------------------------------------*/
/* age >= 15, age-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'*pop_`g'_15_2000) if `exception' & frac_`name'_by_age_`g' != ., by(country year)
replace frac_`name'_`g'_15_adja_2000 = temp_01 if `exception'
drop temp*
}

/*----------------------------------------------------------------------------*/
/* age >= 15 & age <= 49, age-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'*pop_`g'_15_49_2000) if `exception' & frac_`name'_by_age_`g' != ., by(country year)
replace frac_`name'_`g'_15_49_adja_2000 = temp_01 if `exception'
drop temp*
}

/*----------------------------------------------------------------------------*/
/* age >= 15, marriage-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'_2000*pop_`g'_15) if `exception' & frac_`name'_by_age_`g'_2000 != ., by(country year)
replace frac_`name'_`g'_15_adjm_2000 = temp_01 if `exception'
drop temp*
}

/*----------------------------------------------------------------------------*/
/* age >= 15 & age <= 49, marriage-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'_2000*pop_`g'_15_49) if `exception' & frac_`name'_by_age_`g'_2000 != ., by(country year)
replace frac_`name'_`g'_15_49_adjm_2000 = temp_01 if `exception'
drop temp*
}

}

/*----------------------------------------------------------------------------*/
/* create a variable to keep the marriage rate at the peak */

foreach v in married {
if ("`v'" == "married") {
local name = "ma"
}

foreach g in m f {
gen  temp_01 = `v'_`g'/total_`g' if `exception'
gen  temp_02 = temp_01 if peak == 1
egen temp_03 = max(temp_02), by(country age_cohort)
gen  frac_`name'_by_age_`g'_peak = temp_03
drop temp*
}

gen  temp_01 = (`v'_m + `v'_f)/(total_m + total_f) if `exception'
gen  temp_02 = temp_01 if peak == 1
egen temp_03 = max(temp_02), by(country age_cohort)
gen  frac_`name'_by_age_t_peak = temp_03
drop temp*

/*----------------------------------------------------------------------------*/
/* age >= 15, age-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'*pop_`g'_15_peak) if `exception' & frac_`name'_by_age_`g' != ., by(country year)
replace frac_`name'_`g'_15_adja_peak = temp_01 if `exception'
drop temp*
}

/*----------------------------------------------------------------------------*/
/* age >= 15 & age <= 49, age-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'*pop_`g'_15_49_peak) if `exception' & frac_`name'_by_age_`g' != ., by(country year)
replace frac_`name'_`g'_15_49_adja_peak = temp_01 if `exception'
drop temp*
}

/*----------------------------------------------------------------------------*/
/* age >= 15, marriage-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'_peak*pop_`g'_15) if `exception' & frac_`name'_by_age_`g'_2000 != ., by(country year)
replace frac_`name'_`g'_15_adjm_peak = temp_01 if `exception'
drop temp*
}

/*----------------------------------------------------------------------------*/
/* age >= 15 & age <= 49, marriage-adjusted sequence*/

foreach g in m f t {
egen temp_01 = total(frac_`name'_by_age_`g'_peak*pop_`g'_15_49) if `exception' & frac_`name'_by_age_`g'_2000 != ., by(country year)
replace frac_`name'_`g'_15_49_adjm_peak = temp_01 if `exception'
drop temp*
}

}

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* sex ratio 15+ */

egen temp_01 = total(total_m), by(country year)
egen temp_02 = total(total_f), by(country year)
gen  sexratio_15 = temp_01/temp_02
drop temp*

/*----------------------------------------------------------------------------*/
/* sex ratio 15-49 */

egen temp_01 = total(total_m) if min_age >= 15 & max_age <= 49, by(country year)
egen temp_02 = total(total_f) if min_age >= 15 & max_age <= 49, by(country year)
gen  sexratio_15_49 = temp_01/temp_02 if min_age >= 15 & max_age <= 49
drop temp*

save $data/data_00.dta, replace

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* collapse and merging */
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/

/* data for value added shares */

import excel using $gdp/gdp.xls, firstrow clear
sort country year
save $data/gdp.dta, replace

/* ---------------------------------------------------------------------------*/
/* data for fertility */

import excel using $fertility/fertility.xls, firstrow clear
sort country year
save $data/fertility.dta, replace

/* ---------------------------------------------------------------------------*/
/* collapse the data structure */

use $data/data_00.dta, clear
collapse frac_ma* frac_nev* frac_div* frac_wid* sex* peak max_ma year_max, by(country year)

/* ---------------------------------------------------------------------------*/
/* merging */

merge m:1 country year using $data/gdp.dta
drop _merge

merge m:1 country year using $data/fertility.dta
drop _merge

/* ---------------------------------------------------------------------------*/

save $data/data_01.dta, replace
