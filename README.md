# JODE_Moro_Moslehi_Tanaka
This repository contains the cross-country data and stata codes for the paper, "Marriage and Economic Development in the Twentieth Century," by Alessio Moro, Solmaz Moslehi, and Satoshi Tanaka, published in the Journal of Demographic Economics.

There are two subfolders, "cross_country_data" and "stata," in this repository.

## (1) The "cross_country_data" subfolder
This subfolder contains an Excel sheet ("marriage.xlsx") a Stata data file ("marriage.dta") that has population data by marital status for all the OECD countries in our sample from 1900 to 2000.

- The data in the "marriage.xls" and "marriage.dta" are the same, and are from each country's census records.

In the "marriage.xls" and the "marriage.dta" files,
- the "country" column includes country's name,
- the "area_code" column includes an indicator for East and West Germany during the period they were separated,
- the "year" column includes the census year,
- the "min_age" column defines the minimum age for that age group,
- the "man_age" column defines the maximum age for that age group,
- the "total_m" column shows the total number of males for that age group,
- the "married_m" column shows the total number of married males for that age group,
- the "single_m" column shows the total number of never-married males for that age group,
- the "widowed_m" column shows the total number of widowed males for that age group,
- the "divorced_m" column shows the total number of divorced males for that age group,
- the "separated_m" column shows the total number of separated males for that age group,
- the "consensual_m" column shows the total number of males who are in a consensual union for that age group,
- the "married_prev_m" column shows the total number of males who are previously married for that age group (the sum of the divorced and the widowed males. see Appendix A in the paper),
- the "registered_prev_m" column shows the total number of males who are previously in a consensual union for that age group (see Appendix A in the paper),
- the "unknown_m" column shows the total number of males whose marital status is unknown for that age group,
- the "married_f" column shows the total number of married females for that age group,
- the "single_f" column shows the total number of never-married females for that age group,
- the "widowed_f" column shows the total number of widowed females for that age group,
- the "divorced_f" column shows the total number of divorced females for that age group,
- the "separated_f" column shows the total number of separated females for that age group,
- the "consensual_f" column shows the total number of females who are in a consensual union for that age group,
- the "married_prev_f" column shows the total number of females who are previously married for that age group (the sum of the divorced and the widowed females. see Appendix A in the paper),
- the "registered_prev_f" column shows the total number of females who are previously in a consensual union for that age group (see Appendix A in the paper),
- the "unknown_f" column shows the total number of females whose marital status is unknown for that age group.

## (2) The "stata" subfolder
This subfolder contains the data and stata codes used for all the results in the paper.

- To run the stata program. Open "main.do" file in this folder, and set the path.
- If you run the "main.do" file, it will run the following eight stata do-files subsequently to reproduce all the results.

### Setup
- do $workplace/setup.do (this do-file will produce "marriage.xls" in the "marriage" subfolder)

### Main Analysis
- do $workplace/code_01_calc_marriage.do
- do $workplace/code_02_graph_countries.do
- do $workplace/code_03_graph_cubic.do
- do $workplace/code_04_statistics.do
- do $workplace/code_05_age_distribution.do
- do $workplace/code_06_flow_rate.do
- do $workplace/code_07_regression.do

For any questions please contact the author at s.tanaka.0509@gmail.com.
