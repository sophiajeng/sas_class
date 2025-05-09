*/Distinct country codes */
title "Unique Country Code";
proc sql;
 select distinct(countrycode) as dist_cc
 from sq.globalfull
 order by dist_cc;
 quit;
 title;
 
*/Number of distinct country codes */ 
title "Count of Unique Country Code";
proc sql;
 select count(distinct(countrycode))
 from sq.globalfull;
 quit;
title;

*/Customers with a high percentage of suspicous transactions */
title "Customers with High Percentage of Suspicious Transactions";
proc sql;
select customerid, count(*) as totaltransactions,
sum(amount > 500) as SuspiciousTransactions,
(calculated SuspiciousTransactions/calculated totaltransactions) as PCTSuspicious format=percent8.2
from sq.transactionfull
where service <> "University"
group by customerid
having calculated PCTSuspicious gt 0.05
order by PCTSuspicious;
quit;
title;