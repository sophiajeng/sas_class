Title "Merchants without Transactions";
proc sql number;
select merchantid from sq.merchant
except
select merchantid from sq.transaction
order by merchantid
;
quit;
title;

title "States without Customers";
proc sql;
select distinct name from sq.statepopulation
except
select distinct state from sq.customer
;
quit;
title;

*/Using the sq.salesphone table as input, write a query to list the following columns:  
CustomerID
a new column named Response based on the existing PhoneResp column
SalesRep labeled Sales Rep
a new column named Channel with the constant text Phone
Run the query and view the results.;

proc sql;
select customerid, phoneresp as response, salesrep as 'Sales Rep'n, 'phone' as channel from sq.salesphone;
quit;

*/Using the sq.salesemail table as input, write a query to list the following columns:
CustomerID
a new column named Response based on the existing EmailResp column
a new column named Channel with the constant text Email
Run the query and view the results.;

proc sql;
select customerid, emailresp as response, 'email' as channel
from sq.salesemail;
quit;

proc sql;
select customerid, phoneresp as response, salesrep as 'Sales Rep'n, 'phone' as channel from sq.salesphone
outer union corr
select customerid, emailresp as response, 'email' as channel
from sq.salesemail
order by customerid, response;
quit;