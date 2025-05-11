***********************************************************;
*  Activity 3.06                                          *;
*  1) Run the query to create a left join between the     *;
*     sq.smalltransaction2 and sq.smallcustomer2 tables.  *;
*     Examine the report. Notice that the rows with       *;
*     missing values in AccountID have been joined.       *;
*  2) In the ON clause, add the expression AND            *;
*     t.AccountID is not null. Run the query. Confirm     *;
*     that missing values were not joined.                *;
*  3) Add a WHERE clause with the expression c.AccountID  *;
*     is NULL to filter for all transactions without a    *;
*     documented customer. Run the query and examine the  *;
*     report. How many transactions do not have a         *;
*     customer associated with them?                      *;
***********************************************************;

proc sql number;
select FirstName, LastName, Income, 
       c.AccountID "c.AccountID", 
       t.AccountID "t.AccountID", 
       DateTime, MerchantID
    from sq.smalltransaction2 as t left join 
         sq.smallcustomer2 as c
      on c.AccountID = t.AccountID and t.accountid is not null
      where c.accountid is null;
quit;




