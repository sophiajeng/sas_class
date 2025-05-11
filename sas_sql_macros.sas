%let regionnum=2;

proc sql noprint;
select median(npopchg3) into :medianest trimmed
from sq.statepopulation
where region = "&regionnum";
quit;
%put &=medianest;

title1 "States in Region &regionnum with a 3-Year Estimated Population Change Greater than the Median";
title2 "Median Estimate: &MedianEst";
proc sql number;
select name, npopchg3 format=comma11.2
from sq.statepopulation
where region = "&regionnum" and npopchg3>&medianest
order by npopchg3;
quit;
title1;
title2;

%let regionvalue='North America';
proc sql noprint;
select distinct(quote(countrycode)) into :countries separated by ','
from sq.globalmetadata
where region=&regionvalue;
quit;
%put &=countries;

proc sql;
select countrycode, indicatorname,
	estyear1/100 as EstYear1PCT format=pct3.2, 
	estyear3/100 as estyear3pct format=pct3.2,
	case
		when (calculated EstYear1PCT is null or calculated estyear3pct is null) then "Unknown"
		when calculated EstYear1PCT < calculated estyear3pct then "Increasing"
		when calculated EstYear1PCT > calculated estyear3pct then "Decreasing"
	end as forecast
from sq.globalfindex
where countrycode in (&countries) and 
indicatorname="Borrowed from a financial institution or used a credit card (% age 15+)"
order by forecast;
quit;