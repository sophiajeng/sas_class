/**********************************************
* Generating Data-Dependent Code: Practice #1 *
**********************************************/

title "Group: GOLD HIGH ACTIVITY";
proc print data=mc1.customers;
	where upcase(Type)="GOLD HIGH ACTIVITY";
run;

*/Include the code in a macro named GroupList with two parameters, Tab for the input table and Col for the selected column. This macro generalizes the starter program so that a PROC PRINT report is generated for each unique value of the specified column.
Use a PROC SQL step to select the distinct uppercase values of the Col parameter. Load the values into a numbered series of macro variables starting with Val1. Read the column from the table specified by the Tab parameter.
Add a macro %DO loop to repeat the TITLE statement and PROC PRINT step once for each Valn macro variable created. Note: Use the Sqlobs macro variable created automatically by the PROC SQL step to provide the stop value for the loop.
Use an indirect macro variable reference to replace GOLD HIGH ACTIVITY with Val1 for the first %DO loop iteration, Val2 for the second iteration, and so on.
Call the GroupList macro with mc1.customers and Type as the parameter values. Confirm that a separate PROC PRINT step is executed for each distinct value of Type.
Call the GroupList macro with sashelp.cars and DriveTrain as the parameter values.*/;


options symbolgen;
%macro GroupList(tab,col);
proc sql noprint;
select distinct upcase(&col)
    into :val1- 
    from &tab;
quit;

%let i=1;
%do %while (&i le &sqlobs);
	title "Group: &&val&i";
	proc print data=&tab;
		where upcase(&col)="&&val&i";
	run;
	%let i=%eval(&i+1);
	title;
%end;
%mend;

%GroupList(sashelp.cars,drivetrain)