*/Join the sq.globalpop and sq.globalmetadata tables to create the work.meta table. Use the work.meta table to generate a report showing the country codes for countries in the sq.globalpop table that do not have any country metadata in the sq.globalmetadata table.  
Write a PROC SQL step to join the sq.globalpop and sq.globalmetadata tables and create a table named work.meta. Use the following requirements:
Select the CountryCode, SeriesName, EstYear1, and EstYear3 columns from the sq.globalpop table and the ShortName and IncomeGroup columns from the sq.globalmetadata table.
Perform a left join on the sq.globalpop and sq.globalmetadata tables.
Use the CountryCode column in both tables for the join criteria.
Run the program and view the results.
/;

proc sql;
create table work.meta as 
select p.countrycode, p.seriesname, p.estyear1, p.estyear3, d.shortname, d.incomegroup
from sq.globalpop as p
left join sq.globalmetadata as d on
p.countrycode = d.countrycode;
quit;

*/Create a report showing the unique country codes for which there is no global metadata using the work.meta table.
Select the CountryCode column from the work.meta table and eliminate duplicate values.
Filter for rows where the ShortName column is missing. The ShortName column contains values from the sq.globalmetadata table. If the results are missing, then the row did not retrieve information from sq.globalmetadata.
Order the results by CountryCode./*;

proc sql;
select distinct countrycode from work.meta
where shortname is null
order by countrycode;
quit;