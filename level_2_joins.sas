*Generate a report showing the count of customer marital status descriptions for each primary bank. The sq.customer table contains a marital code (Married) and a primary bank ID. The final results should contain BankID, MaritalStatus, Name (name of bank), and Count.  
Write a PROC SQL step to join the sq.customer and sq.maritalcode tables. Use the following requirements:
Select BankID from the sq.customer table and MaritalStatus value from the sq.maritalcode table. Create a new column named Count to count the number of customers. Format the new column using commas.
Use a left join to select all customers from the sq.customer table, with or without matches in the sq.maritalcode table.
Use the Married column in the sq.customer table and the MaritalCode column in the sq.maritalcode table as the join criteria.
Filter rows where the customer's bank ID is not missing.
Group the data by BankID and MaritalStatus.
Order the table by descending Count.
As a checkpoint, run the query.;

proc sql;
select c.bankid, m.maritalstatus, b.name, count(*) as count format=comma10.
from sq.customer as c 
left join sq.maritalcode as m
on
c.married = m.maritalcode 
left join sq.bank as b on
c.bankid=b.bankid
where customerid is not null
group by c.bankid, maritalstatus, name
order by count;
quit;

