/* for strucrual change and marriage project */
/* last updated: 01/10/2017 */

clear all
set more off

/* ---------------------------------------------------------------------------*/
/* ---------------------------------------------------------------------------*/
/* ---------------------------------------------------------------------------*/
/* You should change the base_folder path here*/

global base_folder /media/satoshi/second_hdd/Dropbox/project_shared/structural_change_and_marriage/online_data/stata

/* ---------------------------------------------------------------------------*/
/* ---------------------------------------------------------------------------*/
/* ---------------------------------------------------------------------------*/

global workplace $base_folder/workplace
global results   $base_folder/results
global data      $base_folder/data
global marriage  $base_folder/marriage
global gdp       $base_folder/gdp
global fertility $base_folder/fertility

/* ---------------------------------------------------------------------------*/
/* ---------------------------------------------------------------------------*/
/* ---------------------------------------------------------------------------*/

/* setup */
do $workplace/setup.do

/* main analysis */
do $workplace/code_01_calc_marriage.do
do $workplace/code_02_graph_countries.do
do $workplace/code_03_graph_cubic.do
do $workplace/code_04_statistics.do
do $workplace/code_05_age_distribution.do
do $workplace/code_06_flow_rate.do
do $workplace/code_07_regression.do



