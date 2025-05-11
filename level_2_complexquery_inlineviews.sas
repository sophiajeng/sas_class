title "Employees with Highest Salary for Job Title by State";
proc sql;
create view employeeview as 
select upper(state) as State, jobtitle, max(salary) as MaxJobSalary
from sq.employee
where state is not null
group by calculated state, jobtitle
order by state;
quit;
title;
proc sql;
select detail.employeeid, detail.employeename, detail.state, detail.jobtitle, detail.salary format=dollar7.2
from sq.employee as detail
inner join 
	(select upper(state) as State, jobtitle, max(salary) as MaxJobSalary
	from sq.employee
	where state is not null
	group by calculated state, jobtitle) as summary 
on detail.jobtitle=summary.jobtitle and upper(detail.state)=summary.state and detail.salary=summary.maxjobsalary
order by detail.state, detail.jobtitle;
quit;
