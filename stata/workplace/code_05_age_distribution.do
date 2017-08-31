/* for strucrual change and marriage project */
/* last updated: 01/03/2017 */

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

keep if max_age <= 59

gen mid_age = (min_age + max_age)/2
drop if max_age == 999
drop if country == "uk" & year == 1900
drop if country == "canada" & year == 1940

/*----------------------------------------------------------------------------*/

sort country year
egen temp_01 = min(year) if frac_ma_t_15 != ., by(country)
egen temp_02 = max(temp_01), by(country)
gen  syear_ma = (year == temp_02)
egen temp_03 = max(year) if frac_ma_t_15 != ., by(country)
egen temp_04 = max(temp_03), by(country)
gen  eyear_ma = (year == temp_04)
drop temp*

egen temp_01 = min(year) if frac_nev_t_15 != ., by(country)
egen temp_02 = max(temp_01), by(country)
gen  syear_nev = (year == temp_02)
egen temp_03 = max(year) if frac_nev_t_15 != ., by(country)
egen temp_04 = max(temp_03), by(country)
gen  eyear_nev = (year == temp_04)
drop temp*

egen temp_01 = min(year) if frac_div_t_15 != ., by(country)
egen temp_02 = max(temp_01), by(country)
gen  syear_div = (year == temp_02)
egen temp_03 = max(year) if frac_div_t_15 != ., by(country)
egen temp_04 = max(temp_03), by(country)
gen  eyear_div = (year == temp_04)
drop temp*

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* fraction of the married by age */

sort country year mid_age
local y_title "Fraction of the Married"
local x_title "Age"

foreach c in `name_list' {
	twoway ///
	(scatter frac_ma_by_age_t mid_age if name == "`c'" & syear_ma == 1, mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_ma_by_age_t mid_age if name == "`c'" & syear_ma == 1, clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_ma_by_age_t mid_age if name == "`c'" & peak == 1, mcolor(red) msize(small) msymbol(D)) ///
	(line frac_ma_by_age_t mid_age if name == "`c'" & peak == 1, clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	(scatter frac_ma_by_age_t mid_age if name == "`c'" & eyear_ma == 1, mcolor(midblue) msize(small) msymbol(T)) ///
	(line frac_ma_by_age_t mid_age if name == "`c'" & eyear_ma == 1, clcolor(midblue) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_ma_by_age_`c', replace)
	
	local files `files' $results/fig_frac_ma_by_age_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_ma_by_age.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of the never-married by age */

sort country year mid_age
local y_title "Fraction of the Never-Married"
local x_title "Age"

foreach c in `name_list' {
	twoway ///
	(scatter frac_nev_by_age_t mid_age if name == "`c'" & syear_nev == 1, mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_nev_by_age_t mid_age if name == "`c'" & syear_nev == 1, clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_nev_by_age_t mid_age if name == "`c'" & peak == 1, mcolor(red) msize(small) msymbol(D)) ///
	(line frac_nev_by_age_t mid_age if name == "`c'" & peak == 1, clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	(scatter frac_nev_by_age_t mid_age if name == "`c'" & eyear_nev == 1, mcolor(midblue) msize(small) msymbol(T)) ///
	(line frac_nev_by_age_t mid_age if name == "`c'" & eyear_nev == 1, clcolor(midblue) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_nev_by_age_`c', replace)
	
	local files `files' $results/fig_frac_nev_by_age_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_nev_by_age.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of the divorced by age */

sort country year mid_age
local y_title "Fraction of the Divorced"
local x_title "Age"

foreach c in `name_list' {
	twoway ///
	(scatter frac_div_by_age_t mid_age if name == "`c'" & syear_div == 1, mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_div_by_age_t mid_age if name == "`c'" & syear_div == 1, clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_div_by_age_t mid_age if name == "`c'" & peak == 1, mcolor(red) msize(small) msymbol(D)) ///
	(line frac_div_by_age_t mid_age if name == "`c'" & peak == 1, clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	(scatter frac_div_by_age_t mid_age if name == "`c'" & eyear_div == 1, mcolor(midblue) msize(small) msymbol(T)) ///
	(line frac_div_by_age_t mid_age if name == "`c'" & eyear_div == 1, clcolor(midblue) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_div_by_age_`c', replace)
	
	local files `files' $results/fig_frac_div_by_age_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_div_by_age.eps, replace
local files ""

