/* for strucrual change and marriage project */
/* last updated: 12/09/2015 */

use $data/data_01.dta, replace

/*----------------------------------------------------------------------------*/

drop if frac_ma_t_15 == .

foreach v in ma nev div {
gen frac_`v'_t_15_adja = frac_`v'_t_15_adja_2000
gen frac_`v'_m_15_adja = frac_`v'_m_15_adja_2000
gen frac_`v'_f_15_adja = frac_`v'_f_15_adja_2000
gen frac_`v'_t_15_49_adja = frac_`v'_t_15_49_adja_2000
gen frac_`v'_m_15_49_adja = frac_`v'_m_15_49_adja_2000
gen frac_`v'_f_15_49_adja = frac_`v'_f_15_49_adja_2000
}

/*----------------------------------------------------------------------------*/

encode country,gen(country_temp)
drop country
rename country_temp country

gen ln_gdp = log(gdp_per_cap)
gen ln_gdp_2 = (ln_gdp)^2
gen ln_gdp_3 = (ln_gdp)^3

xtset country year

/* shares */
xtreg agri ln_gdp ln_gdp_2 ln_gdp_3, fe
predict agri_gdp_fe, u
xtreg manuf ln_gdp ln_gdp_2 ln_gdp_3, fe
predict manuf_gdp_fe, u
xtreg serv ln_gdp ln_gdp_2 ln_gdp_3, fe
predict serv_gdp_fe, u

foreach v in ma nev div {
/* 15+ */
xtreg frac_`v'_t_15 ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_t_15_gdp_fe, u
xtreg frac_`v'_m_15 ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_m_15_gdp_fe, u
xtreg frac_`v'_f_15 ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_f_15_gdp_fe, u

/* 15-49 */
xtreg frac_`v'_t_15_49 ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_t_15_49_gdp_fe, u
xtreg frac_`v'_m_15_49 ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_m_15_49_gdp_fe, u
xtreg frac_`v'_f_15_49 ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_f_15_49_gdp_fe, u

/* 15+ adjusted */
xtreg frac_`v'_t_15_adja ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_t_15_adja_gdp_fe, u
xtreg frac_`v'_m_15_adja ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_m_15_adja_gdp_fe, u
xtreg frac_`v'_f_15_adja ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_f_15_adja_gdp_fe, u

/* 15-49 adjusted */
xtreg frac_`v'_t_15_49_adja ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_t_15_49_adja_gdp_fe, u
xtreg frac_`v'_m_15_49_adja ln_gdp ln_gdp_2 ln_gdp_3 , fe
predict frac_`v'_m_15_49_adja_gdp_fe, u
xtreg frac_`v'_f_15_49_adja ln_gdp ln_gdp_2 ln_gdp_3, fe
predict frac_`v'_f_15_49_adja_gdp_fe, u
}

/* take out fixed effects */
gen agri_fltd = agri - agri_gdp_fe
gen manuf_fltd = manuf - manuf_gdp_fe
gen serv_fltd = serv - serv_gdp_fe
gen ratio_m2s = manuf_fltd/serv_fltd

foreach v in ma nev div {
gen frac_`v'_t_15_fltd = frac_`v'_t_15 - frac_`v'_t_15_gdp_fe
gen frac_`v'_m_15_fltd = frac_`v'_m_15 - frac_`v'_m_15_gdp_fe
gen frac_`v'_f_15_fltd = frac_`v'_f_15 - frac_`v'_f_15_gdp_fe
gen frac_`v'_t_15_49_fltd = frac_`v'_t_15_49 - frac_`v'_t_15_49_gdp_fe
gen frac_`v'_m_15_49_fltd = frac_`v'_m_15_49 - frac_`v'_m_15_49_gdp_fe
gen frac_`v'_f_15_49_fltd = frac_`v'_f_15_49 - frac_`v'_f_15_49_gdp_fe
gen frac_`v'_t_15_adja_fltd = frac_`v'_t_15_adja - frac_`v'_t_15_adja_gdp_fe
gen frac_`v'_m_15_adja_fltd = frac_`v'_m_15_adja - frac_`v'_m_15_adja_gdp_fe
gen frac_`v'_f_15_adja_fltd = frac_`v'_f_15_adja - frac_`v'_f_15_adja_gdp_fe
gen frac_`v'_t_15_49_adja_fltd = frac_`v'_t_15_49_adja - frac_`v'_t_15_49_adja_gdp_fe
gen frac_`v'_m_15_49_adja_fltd = frac_`v'_m_15_49_adja - frac_`v'_m_15_49_adja_gdp_fe
gen frac_`v'_f_15_49_adja_fltd = frac_`v'_f_15_49_adja - frac_`v'_f_15_49_adja_gdp_fe
}

/*----------------------------------------------------------------------------*/
/* share and marriage 15+ */
foreach v in ma nev div {
reg frac_`v'_t_15_fltd ln_gdp ln_gdp_2 ln_gdp_3
predict frac_`v'_t_15_fit
reg frac_`v'_t_15_49_fltd ln_gdp ln_gdp_2 ln_gdp_3
predict frac_`v'_t_15_49_fit
reg frac_`v'_t_15_adja_fltd ln_gdp ln_gdp_2 ln_gdp_3
predict frac_`v'_t_15_adja_fit
}

foreach v in agri manuf serv {
reg `v'_fltd ln_gdp ln_gdp_2 ln_gdp_3
predict `v'_fit
}

/*----------------------------------------------------------------------------*/
/* shares */

twoway (scatter agri_fltd ln_gdp, mcolor(blue)) || (line agri_fit ln_gdp, sort), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(0.0(0.2)0.6) ///
ytitle("Agriculture Share") ///
title("Agriculture Share in GDP", size(medsmall)) ///
saving($results/fig_agri_share, replace) ///
graphregion(color(white))

twoway (scatter manuf_fltd ln_gdp, mcolor(blue)) || (line manuf_fit ln_gdp, sort), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.2(0.1).5) ///
ytitle("Manufacturing Share") ///
title("Manufacturing Share in GDP", size(medsmall)) ///
saving($results/fig_manuf_share, replace) ///
graphregion(color(white))

twoway (scatter serv_fltd ln_gdp, mcolor(blue)) || (line serv_fit ln_gdp, sort), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.3(0.2).9) ///
ytitle("Service Share") ///
title("Service Share in GDP", size(medsmall)) ///
saving($results/fig_serv_share, replace) ///
graphregion(color(white))

/*----------------------------------------------------------------------------*/
/* marriage */

twoway (scatter frac_ma_t_15_fltd ln_gdp, mcolor(blue)) || (line frac_ma_t_15_fit ln_gdp, sort), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.4(0.1).75) ///
ytitle("Fraction of the Married") ///
title("Fraction of the Married, Age 15+", size(medsmall)) ///
saving($results/fig_frac_ma_total_15, replace) ///
graphregion(color(white))

twoway (scatter frac_ma_t_15_adja_fltd ln_gdp, mcolor(blue)) || (line frac_ma_t_15_adja_fit ln_gdp, sort), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.4(0.1).75) ///
ytitle("Fraction of the Married") ///
title("Fraction of the Married, Age Adjusted", size(medsmall)) ///
saving($results/fig_frac_ma_total_15_adja, replace) ///
graphregion(color(white))

twoway (scatter frac_ma_t_15_49_fltd ln_gdp, mcolor(blue)) || (line frac_ma_t_15_49_fit ln_gdp, sort), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.4(0.1).75) ///
ytitle("Fraction of the Married") ///
title("Fraction of the Married, Age 15-49", size(medsmall)) ///
saving($results/fig_frac_ma_total_15_49, replace) ///
graphregion(color(white))

/*----------------------------------------------------------------------------*/
/* non-parametric plot: shares */

twoway (lpolyci agri ln_gdp) || (lpoly agri ln_gdp, lcolor(blue)), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(0.0(0.2)0.6) ///
ytitle("Agriculture Share") ///
title("Agriculture Share in GDP", size(medsmall)) ///
saving($results/fig_agri_share_nonparam, replace) ///
graphregion(color(white))

twoway (lpolyci manuf ln_gdp) || (lpoly manuf ln_gdp, lcolor(blue)), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.2(0.1).5) ///
ytitle("Manufacturing Share") ///
title("Manufacturing Share in GDP", size(medsmall)) ///
saving($results/fig_manuf_share_nonparam, replace) ///
graphregion(color(white))

twoway (lpolyci serv ln_gdp) || (lpoly serv ln_gdp, lcolor(blue)), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.3(0.2).9) ///
ytitle("Service Share") ///
title("Service Share in GDP", size(medsmall)) ///
saving($results/fig_serv_share_nonparam, replace) ///
graphregion(color(white))

/*----------------------------------------------------------------------------*/
/* non-parametric plot: marriage */

twoway (lpolyci frac_ma_t_15 ln_gdp) || (lpoly frac_ma_t_15 ln_gdp, lcolor(blue)), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.4(0.1).7) ///
ytitle("Fraction of the Married") ///
title("Fraction of the Married, Age 15+", size(medsmall)) ///
saving($results/fig_frac_ma_total_15_nonparam, replace) ///
graphregion(color(white))

twoway (lpolyci frac_ma_t_15_adja ln_gdp) || (lpoly frac_ma_t_15_adja ln_gdp, lcolor(blue)), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.4(0.1).7) ///
ytitle("Fraction of the Married") ///
title("Fraction of the Married, Age Adjusted", size(medsmall)) ///
saving($results/fig_frac_ma_total_15_adja_nonparam, replace) ///
graphregion(color(white))

twoway (lpolyci frac_ma_t_15_49 ln_gdp) || (lpoly frac_ma_t_15_49 ln_gdp, lcolor(blue)), ///
legend(off) ///
xtitle("Log GDP Per Capita") ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.4(0.1).7) ///
ytitle("Fraction of the Married") ///
title("Fraction of the Married, Age 15-49", size(medsmall)) ///
saving($results/fig_frac_ma_total_15_49_nonparam, replace) ///
graphregion(color(white))

/*----------------------------------------------------------------------------*/
/* combine */

/* marriage, 6 panels */
graph combine $results/fig_frac_ma_total_15.gph $results/fig_frac_ma_total_15_adja.gph $results/fig_frac_ma_total_15_49.gph ///
              $results/fig_frac_ma_total_15_nonparam.gph $results/fig_frac_ma_total_15_adja_nonparam.gph $results/fig_frac_ma_total_15_49_nonparam.gph, col(3) graphregion(color(white))
graph export  $results/fig_frac_ma_6_panels.eps, replace

/* shares and marriage, 4 panels */
graph combine $results/fig_agri_share.gph $results/fig_manuf_share.gph ///
              $results/fig_serv_share.gph $results/fig_frac_ma_total_15.gph, col(2) graphregion(color(white))
graph export  $results/fig_shares_frac_ma_4_panels.eps, replace

/* shares and marriage, 4 panels, nonparametric */
graph combine $results/fig_agri_share_nonparam.gph $results/fig_manuf_share_nonparam.gph ///
              $results/fig_serv_share_nonparam.gph $results/fig_frac_ma_total_15_nonparam.gph, col(2) graphregion(color(white))
graph export  $results/fig_shares_frac_ma_4_panels_nonparam.eps, replace

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* main figure */

twoway (scatter frac_ma_t_15_fltd ln_gdp, mcolor(blue) msize(medlarge)) || (line frac_ma_t_15_fit ln_gdp, sort lwidth(medthick)), ///
legend(off) ///
xtitle("Log GDP Per Capita", size(medlarge)) ///
ytitle("Fraction of the Married, Age 15+", size(medlarge)) ///
xlabel(7.5(0.5)10, grid) ///
ylabel(.4(0.1).7) ///
saving($results/fig_frac_ma_total_15, replace) ///
graphregion(color(white))
graph export  $results/fig_frac_ma_total_15.eps, replace

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* calculate correlations */

pwcorr frac_ma_t_15 manuf, sig
pwcorr frac_ma_t_15_adja manuf, sig
pwcorr frac_ma_t_15_49 manuf, sig

/* -------------------------------------------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------------------------------------------- */
/* Manufacturing Share v.s. Marriage 15+ */

twoway (lfitci frac_ma_t_15 manuf, sort range(0.1 0.6)) || (scatter frac_ma_t_15 manuf, mcolor(blue)), ///
legend(off) ///
title("Age 15+", size(vlarge)) ///
xtitle("") ///
ytitle("") ///
graphregion(color(white)) ///
xlabel(0.1(0.1)0.6, grid) ///
ylabel(0.4(0.1)0.75, grid) ///
saving($results/fig_manuf_vs_frac_ma_total_15, replace)
graph export $results/fig_manuf_vs_frac_ma_total_15.eps, replace

twoway (lfitci frac_ma_t_15_adja manuf, sort range(0.1 0.6)) || (scatter frac_ma_t_15_adja manuf, mcolor(blue)), ///
legend(off) ///
title("Age 15+ Adjusted", size(vlarge)) ///
xtitle("") ///
ytitle("") ///
graphregion(color(white)) ///
xlabel(0.1(0.1)0.6, grid) ///
ylabel(0.4(0.1)0.75, grid) ///
saving($results/fig_manuf_vs_frac_ma_total_15_adja, replace)
graph export $results/fig_manuf_vs_frac_ma_total_15_adja.eps, replace

twoway (lfitci frac_ma_t_15_49 manuf, sort range(0.1 0.6)) || (scatter frac_ma_t_15_49 manuf, mcolor(blue)), ///
legend(off) ///
title("Age 15-49", size(vlarge)) ///
xtitle("") ///
ytitle("") ///
graphregion(color(white)) ///
xlabel(0.1(0.1)0.6, grid) ///
ylabel(0.4(0.1)0.75, grid) ///
saving($results/fig_manuf_vs_frac_ma_total_15_49, replace)
graph export $results/fig_manuf_vs_frac_ma_total_15_49.eps, replace

graph combine $results/fig_manuf_vs_frac_ma_total_15.gph $results/fig_manuf_vs_frac_ma_total_15_adja.gph $results/fig_manuf_vs_frac_ma_total_15_49.gph, ///
b1title("Manufacturing Share in GDP", size(large)) ///
l1title("Fraction of the Married", size(large)) ///
col(3) graphregion(color(white)) xcommon ycommon xsize(20) ysize(10)
graph export $results/fig_manuf_vs_frac_ma_total_3_panels.eps, replace
