/* for strucrual change and marriage project */
/* last updated: 08/14/2015 */

/* ---------------------------------------------------------------------------*/
/* data for marriage */

#delimit ;
local c_list
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

foreach name in `c_list' {
import excel using $marriage/`name'/`name'_marriage_data.xls, firstrow clear
gen country = "`name'"
order country, before(year)
save $data/marriage_`name'.dta, replace
}

#delimit ;
local c_list
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

use $data/marriage_australia.dta, replace

foreach name in `c_list' {
append using $data/marriage_`name'.dta
}

order country, last
order area_code, last
order year, last
order min_age, last
order max_age, last
order total_m, last
order married_m, last
order single_m, last
order widowed_m, last
order divorced_m, last
order separated_m, last
order consensual_m, last
order married_prev_m, last
order registered_prev_m, last
order unknown_m, last
order total_f, last
order married_f, last
order single_f, last
order widowed_f, last
order divorced_f, last
order separated_f, last
order consensual_f, last
order registered_prev_f, last
order married_prev_f, last
order unknown_f, last

sort country year
save $data/marriage.dta, replace
export excel using $data/marriage.xlsx, firstrow(variables) replace





