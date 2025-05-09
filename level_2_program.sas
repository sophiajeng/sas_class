title "November/December Transactions";
proc sql;
select customername label="Customer Name", 
	merchantname, 
	amount format=dollar10.2 label="Transaction Amount",
	datepart(datetime) label="transactiondate" format=date9.
from sq.transactionfull
where month(datepart(datetime)) in (11,12)
order by datetime;
quit;
title;
*/where calculated month(datetime) in ('NOV','DEC')
