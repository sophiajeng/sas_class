title "Large Non-Educational Transactions";
proc sql;
select customername label="Customer Name", 
	merchantname, 
	type,
	service, 
	amount format=dollar10.2 label="Transaction Amount"
from sq.transactionfull
where amount>1000 and service <> "University"
order by amount desc;
quit;
title;
