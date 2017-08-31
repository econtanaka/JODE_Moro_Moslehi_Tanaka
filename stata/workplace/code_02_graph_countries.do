/* for strucrual change and marriage project */
/* last updated: 09/09/2015 */

use $data/data_01.dta, replace

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

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* fraction of married, age 15+ */

local age "15"
local y_title "Fraction of the Married"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_ma_t_`age' year if name == "`c'", mcolor(red) msize(small)) ///
	(line frac_ma_t_`age' year if name == "`c'", clcolor(red) clwidth(medium) clpattern(solid)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_ma_total_`age'_`c', replace)
	
	local files `files' $results/fig_frac_ma_total_`age'_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_ma_total_`age'.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of never-married, age 15+ */

local age "15"
local y_title "Fraction of the Never-Married"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_nev_t_`age' year if name == "`c'", mcolor(red) msize(small)) ///
	(line frac_nev_t_`age' year if name == "`c'", clcolor(red) clwidth(medium) clpattern(solid)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_nev_total_`age'_`c', replace)
	
	local files `files' $results/fig_frac_nev_total_`age'_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_nev_total_`age'.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of divorced, age 15+ */

local age "15"
local y_title "Fraction of the Divorced"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_div_t_`age' year if name == "`c'", mcolor(red) msize(small)) ///
	(line frac_div_t_`age' year if name == "`c'", clcolor(red) clwidth(medium) clpattern(solid)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_div_total_`age'_`c', replace)
	
	local files `files' $results/fig_frac_div_total_`age'_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_div_total_`age'.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* fraction of married, age 15+: age-adjusted vs non-adjusted */

local age "15"
local y_title "Fraction of the Married"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_ma_t_`age' year if name == "`c'", mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_ma_t_`age' year if name == "`c'", clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_ma_t_`age'_adja_2000 year if name == "`c'", mcolor(red) msize(small) msymbol(D)) ///
	(line frac_ma_t_`age'_adja_2000 year if name == "`c'", clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_ma_`age'_adja_`c', replace)
	
	local files `files' $results/fig_frac_ma_`age'_adja_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_ma_`age'_adja.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of never-married, age 15+: age-adjusted vs non-adjusted */

local age "15"
local y_title "Fraction of the Never-Married"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_nev_t_`age' year if name == "`c'", mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_nev_t_`age' year if name == "`c'", clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_nev_t_`age'_adja_2000 year if name == "`c'", mcolor(red) msize(small) msymbol(D)) ///
	(line frac_nev_t_`age'_adja_2000 year if name == "`c'", clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_nev_`age'_adja_`c', replace)
	
	local files `files' $results/fig_frac_nev_`age'_adja_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_nev_`age'_adja.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of divorced, age 15+: age-adjusted vs non-adjusted */

local age "15"
local y_title "Fraction of the Divorced"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_div_t_`age' year if name == "`c'", mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_div_t_`age' year if name == "`c'", clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_div_t_`age'_adja_2000 year if name == "`c'", mcolor(red) msize(small) msymbol(D)) ///
	(line frac_div_t_`age'_adja_2000 year if name == "`c'", clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_div_`age'_adja_`c', replace)
	
	local files `files' $results/fig_frac_div_`age'_adja_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_div_`age'_adja.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* fraction of married, age 15+: male vs female */

local age "15"
local y_title "Fraction of the Married"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_ma_m_`age' year if name == "`c'", mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_ma_m_`age' year if name == "`c'", clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_ma_f_`age' year if name == "`c'", mcolor(red) msize(small) msymbol(D)) ///
	(line frac_ma_f_`age' year if name == "`c'", clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_ma_`age'_male_female_`c', replace)
	
	local files `files' $results/fig_frac_ma_`age'_male_female_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_ma_`age'_male_female.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of never-married, age 15+: male vs female */

local age "15"
local y_title "Fraction of the Never-Married"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_nev_m_`age' year if name == "`c'", mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_nev_m_`age' year if name == "`c'", clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_nev_f_`age' year if name == "`c'", mcolor(red) msize(small) msymbol(D)) ///
	(line frac_nev_f_`age' year if name == "`c'", clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_nev_`age'_male_female_`c', replace)
	
	local files `files' $results/fig_frac_nev_`age'_male_female_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_nev_`age'_male_female.eps, replace
local files ""

/*----------------------------------------------------------------------------*/
/* fraction of divorced, age 15+: male vs female */

local age "15"
local y_title "Fraction of the Divorced"
local x_title "Year"

foreach c in `name_list' {
	twoway ///
	(scatter frac_div_m_`age' year if name == "`c'", mcolor(blue) msize(small) msymbol(O)) ///
	(line frac_div_m_`age' year if name == "`c'", clcolor(blue) clwidth(medium) clpattern(solid)) ///
	(scatter frac_div_f_`age' year if name == "`c'", mcolor(red) msize(small) msymbol(D)) ///
	(line frac_div_f_`age' year if name == "`c'", clcolor(red) clwidth(medium) clpattern(shortdash)) ///
	, legend(off) ///
	graphregion(color(white)) ///
	title("`c'") ///
	xtitle("") ///
	ytitle("") ///
	saving($results/fig_frac_div_`age'_male_female_`c', replace)
	
	local files `files' $results/fig_frac_div_`age'_male_female_`c'.gph
}

graph combine `files', col(4) xcommon ycommon ///
b1title(`x_title', size(small)) l1title(`y_title', size(small)) ///
graphregion(color(white))
graph export $results/fig_cc_frac_div_`age'_male_female.eps, replace
local files ""
