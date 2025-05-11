proc sql;
select sum(EstYear1Pop) as EstPct format=comma16.
from (select distinct countrycode, EstYear1Pop from sq.globalfull)
quit;

title "Estimated Global Population Percentage by Country";
proc sql outobs=10;
select distinct gf.countrycode, gf.shortname, (gf.estyear1pop/
(select sum(EstYear1Pop) as EstPct format=comma16.
from (select distinct countrycode, EstYear1Pop from sq.globalfull))) as pctpop format=percent7.2
from sq.globalfull as gf
order by pctpop desc;
quit;
title;