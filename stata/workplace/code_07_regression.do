/* for strucrual change and marriage project */
/* last updated: 19/10/2015 */

use $data/data_01.dta, replace

/*----------------------------------------------------------------------------*/

encode country,gen(country_temp)
drop country
rename country_temp country

/*----------------------------------------------------------------------------*/

gen frac_ma_t_15_adja = frac_ma_t_15_adja_2000
gen frac_ma_f_15_adja = frac_ma_f_15_adja_2000
gen frac_ma_m_15_adja = frac_ma_m_15_adja_2000
gen frac_ma_t_15_49_adja = frac_ma_t_15_49_adja_2000
gen frac_ma_f_15_49_adja = frac_ma_f_15_49_adja_2000
gen frac_ma_m_15_49_adja = frac_ma_m_15_49_adja_2000

/*----------------------------------------------------------------------------*/

gen ln_gdp = ln(gdp_per_cap)
gen ln_gdp_2 = (ln_gdp)^2
gen ln_gdp_3 = (ln_gdp)^3
gen ln_sexratio_15 = ln(sexratio_15)
gen ln_sexratio_15_49 = ln(sexratio_15_49)
gen ln_tfr = ln(tfr)
gen ln_tfr_gapm = ln(tfr_gapm)
gen ln_cbr = ln(cbr)

xi i.country i.year

/*----------------------------------------------------------------------------*/

label var frac_ma_m_15	"Men 15+"
label var frac_ma_f_15	"Women 15+"
label var frac_ma_m_15_49	"Men 15-49"
label var frac_ma_f_15_49	"Women 15-49"
label var frac_ma_m_15_adja	"Men 15+ (Age-Adj)"
label var frac_ma_f_15_adja	"Women 15+ (Age-Adj)"
label var frac_ma_m_15_49_adja	"Men 15-49 (Age-Adj)"
label var frac_ma_f_15_49_adja	"Women 15-49 (Age-Adj)"
label var agri	"Agri. Share (Value-Added)"
label var manuf	"Manuf. Share (Value-Added)"
label var serv	"Service Share (Value-Added)"
label var ln_gdp	"Log(GDP per Capita)"
label var ln_gdp_2	"Log(GDP per Capita)^2"
label var ln_gdp_3	"Log(GDP per Capita)^3"
label var ln_sexratio_15	"Log(Sex Ratio 15+)"
label var ln_sexratio_15_49	"Log(Sex Ratio 15-49)"
label var ln_tfr	"Log(Total Fertility Rate)"
label var ln_tfr_gap	"Log(Total Fertility Rate(Gapminder))"
label var ln_cbr	"Log(Crude Birth Rate)"

/*----------------------------------------------------------------------------*/
/* xlist variables */

global xlist_15_tfr manuf ln_sexratio_15 ln_tfr
global xlist_15_cbr manuf ln_sexratio_15 ln_cbr

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* Section for Men 15+ */
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
   
eststo clear

eststo: reg frac_ma_m_15 $xlist_15_tfr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_m_15 $xlist_15_tfr _Icountry*, robust
estadd local fixed "Yes", replace

eststo: reg frac_ma_m_15 $xlist_15_cbr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_m_15 $xlist_15_cbr _Icountry*, robust
estadd local fixed "Yes", replace

eststo: reg frac_ma_m_15_adja $xlist_15_tfr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_m_15_adja $xlist_15_tfr _Icountry*, robust
estadd local fixed "Yes", replace

eststo: reg frac_ma_m_15_adja $xlist_15_cbr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_m_15_adja $xlist_15_cbr _Icountry*, robust
estadd local fixed "Yes", replace

esttab  ///
	using $results/table_estimation_frac_ma_m_15.tex, ///
	b(4) se(4) drop(_I*) gaps ///
	stats(fixed r2 N, fmt(%~12s %9.2f %9.0g) label("Country Fixed Effect" "R-square" "N")) /// 
	order(manuf ln_sexratio_15 ln_tfr ln_cbr _cons) /// 
	coeflabels(manuf "Manufacturing Share" ln_sexratio_15 "Ln(Sex Ratio 15+)" ln_tfr "Ln(Total Fertility Rate)" ln_cbr "Ln(Crude Birth Rate)" _cons "Constant") ///
	mtitles("Raw" "Raw" "Raw" "Raw" "Adjusted" "Adjusted" "Adjusted" "Adjusted") ///
	substitute(\hline\hline \hline \hline "\noalign{\vskip 1mm} \hline \noalign{\vskip 1mm}" "Standard" "Robust standard") ///
	star(\sym{\dagger} 0.10 \sym{*} 0.05 \sym{**} 0.01) replace

/* -------------------------------------------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------------------------------------------- */
/* Section for Women 15+ */
/* -------------------------------------------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------------------------------------------- */
   
eststo clear

eststo: reg frac_ma_f_15 $xlist_15_tfr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_f_15 $xlist_15_tfr _Icountry*, robust
estadd local fixed "Yes", replace

eststo: reg frac_ma_f_15 $xlist_15_cbr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_f_15 $xlist_15_cbr _Icountry*, robust
estadd local fixed "Yes", replace

eststo: reg frac_ma_f_15_adja $xlist_15_tfr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_f_15_adja $xlist_15_tfr _Icountry*, robust
estadd local fixed "Yes", replace

eststo: reg frac_ma_f_15_adja $xlist_15_cbr, robust
estadd local fixed "No", replace

eststo: reg frac_ma_f_15_adja $xlist_15_cbr _Icountry*, robust
estadd local fixed "Yes", replace

esttab  ///
	using $results/table_estimation_frac_ma_f_15.tex, ///
	b(4) se(4) drop(_I*) gaps ///
	stats(fixed r2 N, fmt(%~12s %9.2f %9.0g) label("Country Fixed Effect" "R-square" "N")) /// 
	order(manuf ln_sexratio_15 ln_tfr ln_cbr _cons) /// 
	coeflabels(manuf "Manufacturing Share" ln_sexratio_15 "Ln(Sex Ratio 15+)" ln_tfr "Ln(Total Fertility Rate)" ln_cbr "Ln(Crude Birth Rate)" _cons "Constant") ///
	mtitles("Raw" "Raw" "Raw" "Raw" "Adjusted" "Adjusted" "Adjusted" "Adjusted") ///
	substitute(\hline\hline \hline \hline "\noalign{\vskip 1mm} \hline \noalign{\vskip 1mm}" "Standard" "Robust standard") ///
	star(\sym{\dagger} 0.10 \sym{*} 0.05 \sym{**} 0.01) replace
