*/Use the sq.statepopulation table to determine which states have the most estimated births for next year. Include a column showing each state's births as the percent of national births.  
Write a query to remerge summary statistics in the sq.statepopulation table. Use the following requirements:
Select the Name and Births1 columns.
Create a new column named PctBirth by dividing Births1 for each state by the sum of Births1 for all states. Format the new column using the PERCENT format.
Order the results by descending PctBirth.
Add an appropriate title to the report.
Run the query and view the results.;


title "States with Most Estimated Birth for Next Year";
proc sql;
select name, births1,(births1/sum(births1)) as pctbirth format=percent.
from sq.statepopulation
order by pctbirth;
quit;
title;