/* for strucrual change and marriage project */
/* last updated: 10/05/2015 */

use $data/data_01.dta, replace

local exception country != "germany"

/*----------------------------------------------------------------------------*/

gen frac_ma_t_15_adja = frac_ma_t_15_adja_peak
gen frac_ma_t_15_adjm = frac_ma_t_15_adjm_peak

/*----------------------------------------------------------------------------*/

keep country year frac_ma_t_15 frac_ma_t_15_adja frac_ma_t_15_adjm peak max_ma year_max

/* identify group */
gen group = peak
bysort country: replace group = group[_n-1] if _n != 1 & peak != 1
replace group = 2 if group == 1
replace group = 1 if group == 0
replace group = 0 if peak  == 1

/* sort country year group */
bysort country group: egen temp_01 = min(frac_ma_t_15) if group == 1
bysort country: egen min_ma_1 = max(temp_01)
gen temp_02 = year if min_ma_1 == frac_ma_t_15 & min_ma_1 != .
bysort country: egen year_min_1 = max(temp_02)
gen temp_03 = frac_ma_t_15_adja if year == year_min_1 & `exception'
gen temp_04 = frac_ma_t_15_adjm if year == year_min_1 & `exception'
bysort country: egen min_ma_adja_1 = max(temp_03) if `exception'
bysort country: egen min_ma_adjm_1 = max(temp_04) if `exception'
drop temp*

bysort country group: egen temp_01 = min(frac_ma_t_15) if group == 2
bysort country: egen min_ma_2 = max(temp_01)
gen temp_02 = year if min_ma_2 == frac_ma_t_15 & min_ma_2 != .
bysort country: egen year_min_2 = max(temp_02)
gen temp_03 = frac_ma_t_15_adja if year == year_min_2 & `exception'
gen temp_04 = frac_ma_t_15_adjm if year == year_min_2 & `exception'
bysort country: egen min_ma_adja_2 = max(temp_03) if `exception'
bysort country: egen min_ma_adjm_2 = max(temp_04) if `exception'
drop temp*

/* calculate difference */
by country: gen temp_01 = (max_ma - min_ma_1) if group == 1
by country: gen temp_02 = (max_ma - min_ma_adja_1) if group == 1
by country: gen temp_03 = (max_ma - min_ma_adjm_1) if group == 1
by country: egen inc_peak = max(temp_01)
by country: egen inc_peak_adja = max(temp_02)
by country: egen inc_peak_adjm = max(temp_03)
by country: gen temp_04 = (min_ma_2 - max_ma) if group == 2
by country: gen temp_05 = (min_ma_adja_2 - max_ma) if group == 2
by country: gen temp_06 = (min_ma_adjm_2 - max_ma) if group == 2
by country: egen dec_peak = max(temp_04)
by country: egen dec_peak_adja = max(temp_05)
by country: egen dec_peak_adjm = max(temp_06)
drop temp*

replace inc_peak = 100*inc_peak
replace inc_peak_adja = 100*inc_peak_adja
replace inc_peak_adjm = 100*inc_peak_adjm
replace dec_peak = 100*dec_peak
replace dec_peak_adja = 100*dec_peak_adja
replace dec_peak_adjm = 100*dec_peak_adjm

/* indetify records to be reported */
keep country year_* max_ma min_ma_1 min_ma_2 inc_peak* dec_peak*

order country, last

order max_ma, last
order year_max, last
order min_ma_1, last
order year_min_1, last
order min_ma_2, last
order year_min_2, last
order inc_peak, last
order inc_peak_adja, last
order inc_peak_adjm, last
order dec_peak, last
order dec_peak_adja, last
order dec_peak_adjm, last

bysort country: keep if _n == 1
export excel $results/table_stats.xls, firstrow(variables) replace

/*----------------------------------------------------------------------------*/

use $data/data_01.dta, replace

local vlist frac_ma_t_15 frac_ma_m_15 frac_ma_f_15 frac_nev_t_15 frac_nev_m_15 frac_nev_f_15 frac_div_t_15 frac_div_m_15 frac_div_f_15 frac_wid_t_15 frac_wid_m_15 frac_wid_f_15 agri manuf serv gdp_per_cap

matrix define table_sum = J(16,5,0)

local l = 1
foreach v of local vlist {
qui summarize `v'
matrix table_sum[`l',1] = r(N)
matrix table_sum[`l',2] = r(mean)
matrix table_sum[`l',3] = r(sd)
matrix table_sum[`l',4] = r(min)
matrix table_sum[`l',5] = r(max)
local l = `l' + 1
}

matrix colnames table_sum = "N of Obs" "Mean" "St Dev" "Min" "Max"
matrix rownames table_sum = "Married Total" "Married Male" "Married Female" ///
				"Never Married Total" "Never Married Male" "Never Married Female" ///
				"Divorced Total" "Divorced Male" "Divorced Female" ///
				"Widowed Total" "Widowed Male" "Widowed Female" ///
				"Agricultural Share" "Manufacturing Share" "Service Share" "Real GDP per Capita"
putexcel A1=matrix(table_sum, names) using $results/table_sum.xls, replace

