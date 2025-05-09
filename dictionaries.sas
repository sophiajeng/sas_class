*/Write a query to create a report that displays the count of the number of tables in the SQ library.  
Use DICTIONARY.tables as input.
Name the calculated column TableCount.
Add an appropriate title.
Run the program and view the results.;

proc sql;
describe table dictionary.tables;
select count(*) as tablecount
	from dictionary.tables
	where libname='SQ';
quit;

*/Write a query to create a report that displays the count of the number of tables in all libraries.
Use DICTIONARY.tables as input.
Name the calculated column TableCount.
Group the results by the library name.
Add an appropriate title and display the library name and table count.
Run the program and view the results.*/;

proc sql;
title "Number of Tables in Each Library"
describe table dictionary.tables;
select libname,count(*) as tablecount
	from dictionary.tables
	group by libname;
quit;
title;


