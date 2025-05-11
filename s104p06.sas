/*s104p06.sas*/

title 'High Credit Threshold by Zipcode';
proc sql;
create view highcreditzip as
select Zip, 
       sum(avg(CreditScore),(2*std(CreditScore))) as HighZipCredit
    from sq.customer
	where CreditScore is not null
    group by Zip;
quit;

title 'Customers with High Credit Scores By Zipcode';
proc sql;
select c.customerid, c.zip format=z5., c.creditscore, s.highzipcredit
from sq.customer as c
inner join highcreditzip as s on
c.zip=s.zip
where c.creditscore>s.highzipcredit
order by zip, creditscore desc;
quit;
title;