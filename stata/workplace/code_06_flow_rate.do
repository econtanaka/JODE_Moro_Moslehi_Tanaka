/* for strucrual change and marriage project */
/* last updated: 01/09/2017 */

use $data/data_00.dta, replace

/*----------------------------------------------------------------------------*/

gen     name = "Australia"   if country == "australia"
replace name = "Belgium"     if country == "belgium"
replace name = "Canada"      if country == "canada"
replace name = "Denmark"     if country == "denmark"
replace name = "Finland"     if country == "finland"
replace name = "France"      if country == "france"
replace name = "Germany"     if country == "germany"
replace name = "Italy"       if country == "italy"
replace name = "Japan"       if country == "japan"
replace name = "Netherlands" if country == "netherlands"
replace name = "Norway"      if country == "norway"
replace name = "Spain"       if country == "spain"
replace name = "Sweden"      if country == "sweden"
replace name = "Switzerland" if country == "switzerland"
replace name = "UK"          if country == "uk"
replace name = "US"          if country == "us"

#delimit ;
local name_list
Australia
Belgium
Canada
Denmark
Finland
France
Germany
Italy
Japan
Netherlands
Norway
Spain
Sweden
Switzerland
UK
US;
#delimit cr

keep if min_age <= 40

gen mid_age = (min_age + max_age)/2
drop if total_m == .
drop if max_age == 999
drop if country == "uk" & year == 1900
drop if country == "canada" & year == 1940

/*----------------------------------------------------------------------------*/

sort country year min_age
egen temp_01 = min(year) if frac_ma_t_15 != ., by(country)
egen temp_02 = max(temp_01), by(country)
gen  syear_ma = (year == temp_02)
egen temp_03 = max(year) if frac_ma_t_15 != ., by(country)
egen temp_04 = max(temp_03), by(country)
gen  eyear_ma = (year == temp_04)
drop temp*

/*----------------------------------------------------------------------------*/

bysort country year: gen mort_m = 1 - (total_m[_n+1]/total_m)^(1/5) if (country != "france" | min_age[_n+1] < 20) & (country != "spain" | min_age[_n+1] < 50)
bysort country year: gen mort_f = 1 - (total_f[_n+1]/total_f)^(1/5) if (country != "france" | min_age[_n+1] < 20) & (country != "spain" | min_age[_n+1] < 50)
bysort country year: gen ma_rate_m = 1 - (single_m[_n+1]/single_m/((1-mort_m)^5))^(1/5) if (country != "france" | min_age[_n+1] < 20) & (country != "spain" | min_age[_n+1] < 50)
bysort country year: gen ma_rate_f = 1 - (single_f[_n+1]/single_f/((1-mort_f)^5))^(1/5) if (country != "france" | min_age[_n+1] < 20) & (country != "spain" | min_age[_n+1] < 50)

bysort country year: replace mort_m = 1 - (total_m[_n+1]/total_m)^(1/10) if (country == "france" & min_age[_n+1] >= 20) | (country == "spain" & min_age[_n+1] >= 50) | (country == "spain" & min_age[_n+1] <= 18 & year == 2000)
bysort country year: replace mort_f = 1 - (total_f[_n+1]/total_f)^(1/10) if (country == "france" & min_age[_n+1] >= 20) | (country == "spain" & min_age[_n+1] >= 50)
bysort country year: replace ma_rate_m = 1 - (single_m[_n+1]/single_m/((1-mort_m)^10))^(1/10) if (country == "france" & min_age[_n+1] >= 20) | (country == "spain" & min_age[_n+1] >= 50)
bysort country year: replace ma_rate_f = 1 - (single_f[_n+1]/single_f/((1-mort_f)^10))^(1/10) if (country == "france" & min_age[_n+1] >= 20) | (country == "spain" & min_age[_n+1] >= 50)

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* age-specific marriage rate for male*/

keep if ma_rate_m != .
keep if ma_rate_f != .

local y_title "Likelihood of Marriage for Males"
local x_title "Age"

foreach c in `name_list' {
	twoway ///
	(scatter ma_rate_m mid_age if name == "`c'" & syear_ma == 1, mcolor(blue) msize(small) msymbol(O)) ///
	(line ma_rate_m mid_age if name == "`c'" & syear_ma == 1, clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter ma_rate_m mid_age if name == "`c'" & peak == 1, mcolor(red) msize(small) msymbol(D)) ///
	(line ma_rate_m mid_age if name == "`c'" & peak == 1, clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	(scatter ma_rate_m mid_age if name == "`c'" & eyear_ma == 1, mcolor(midblue) msize(small) msymbol(T)) ///
	(line ma_rate_m mid_age if name == "`c'" & eyear_ma == 1, clcolor(midblue) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	xlabel(15(5)40) ///
        ylabel(0(0.1)0.3) ///
	saving($results/fig_ma_rate_m_by_age_`c', replace)
	
	local files `files' $results/fig_ma_rate_m_by_age_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_ma_rate_m_by_age.eps, replace
local files ""
*/
/*--------------------------------------------------------------------------*/
/* age-specific marriage rate for female*/

local y_title "Likelihood of Marriage for Females"
local x_title "Age"

foreach c in `name_list' {
	twoway ///
	(scatter ma_rate_f mid_age if name == "`c'" & syear_ma == 1, mcolor(blue) msize(small) msymbol(O)) ///
	(line ma_rate_f mid_age if name == "`c'" & syear_ma == 1, clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter ma_rate_f mid_age if name == "`c'" & peak == 1, mcolor(red) msize(small) msymbol(D)) ///
	(line ma_rate_f mid_age if name == "`c'" & peak == 1, clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	(scatter ma_rate_f mid_age if name == "`c'" & eyear_ma == 1, mcolor(midblue) msize(small) msymbol(T)) ///
	(line ma_rate_f mid_age if name == "`c'" & eyear_ma == 1, clcolor(midblue) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	xlabel(15(5)40) ///
        ylabel(0(0.1)0.3) ///
	saving($results/fig_ma_rate_f_by_age_`c', replace)
	
	local files `files' $results/fig_ma_rate_f_by_age_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_ma_rate_f_by_age.eps, replace
local files ""
