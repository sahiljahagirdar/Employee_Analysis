/*
Employee Demographics & Hiring Trends
1.What is the gender distribution of employees?
2.What is the average age of employees at the time of hiring?
3.How has the hiring trend changed over the years? (e.g., number of hires per year)
4.Which year had the highest number of employees hired?
5.What is the distribution of employees by department?
*/


/*1.What is the gender distribution of employees?*/
select count(gender) as gender_count,gender
from employees
group by gender;

/*2.What is the average age of employees at the time of hiring?*/
select round(avg(year(hire_date) - year(birth_date)),2) as avg_hire_age
from employees;

/*3.How has the hiring trend changed over the years? (e.g., number of hires per year)*/
select year(hire_date) as hire_year, count(*) as total_hire
from employees
group by hire_year
order by hire_year;

/*4.Which year had the highest number of employees hired?*/
select year(hire_date) as hire_year , count(*) as hired
from employees
group by hire_year
order by hired desc
limit 1;


/*5.What is the distribution of employees by department?*/
select d.dept_name, count(de.emp_no) as employee_count
from dept_emp de
join departments d on d.dept_no = de.dept_no
group by d.dept_name;



/*
Department & Management Analysis
1.Which department has had the most managers over time?
2.Which department has the highest number of employees?
3.What is the average tenure of a department manager?
*/


/*1.Which department has had the most managers over time?*/
select count(de.emp_no) as managers, d.dept_name
from dept_manager de
join departments d on de.dept_no = d.dept_no
group by d.dept_name
order by managers desc;


/*2.Which department has the highest number of employees?*/
select de.dept_name,count(d.emp_no) as employee_count
from dept_emp d
join departments de on d.dept_no = de.dept_no
group by de.dept_name
order by employee_count desc
limit 1;

/*3.What is the average tenure of a department manager?*/
select d.dept_name,ROUND(AVG(DATEDIFF(dm.to_date, dm.from_date) / 365), 2) AS avg_tenure_years
from dept_manager dm
join departments d on dm.dept_no = d.dept_no
group by d.dept_name
order by avg_tenure_years desc;

/*
Salary Analysis
1.What is the average salary of employees across all departments?
2.Which department has the highest average salary?
3.How do salaries change over time for employees?
4.What is the salary trend for employees based on their job titles?
*/


/*1.What is the average salary of employees across all departments?*/
SELECT ROUND(AVG(salary), 2) AS avg_salary
FROM salaries;

/*2.Which department has the highest average salary?*/
select  d.dept_name,round(avg(s.salary),2) as avg_salary 
from dept_emp de
join salaries s on s.emp_no = de.emp_no
join departments d on d.dept_no = de.dept_no
group by d.dept_name
order by avg_salary desc
limit 1;

/*3.How do salaries change over time for employees?*/
select emp_no,from_date,salary
from salaries
order by emp_no,from_date;

/*4.What is the salary trend for employees based on their job titles?*/
select t.title, round(avg(s.salary),2) as avg_salary
from titles t
join salaries s on t.emp_no = s.emp_no
group by t.title
order by avg_salary desc;


/*
Employee Tenure & Turnover
1.What is the average length of employment for employees?
2.How many employees stay for more than 5, 10, or 15 years?
3.Which department has the highest employee retention?
*/

/*1.What is the average length of employment for employees?*/
select round(avg(datediff(to_date,from_date)/365),2) as avg_salary_years
from dept_emp;

/*2.How many employees stay for more than 5, 10, or 15 years?*/
select count(*) as employee_count,
case
when datediff(to_date,from_date) / 355 > 15 then 'More than 15 years'
when datediff(to_date,from_date) / 355 > 10 then 'More than 10 years'
when datediff(to_date,from_date) / 365 > 5 then 'More than 5 years'
else 'Less than 5 years'
end as tenure_group
from dept_emp
group by tenure_group;



/*
Job Titles & Promotions
1.What are the most common job titles in the company?
2.What is the average time employees spend in a title before changing?
3.Which job title has the highest average salary?
*/


/*1.What are the most common job titles in the company?*/
select title,count(title) as common_title
from titles
group by title
order by common_title desc;


/*2.What is the average time employees spend in a title before changing?*/
select round(avg(datediff(to_date,from_date) / 365),2) as total_time
from titles;


/*3.Which job title has the highest average salary?*/
select t.title,round(avg(s.salary),2) as avg_salary
from titles t
join salaries s on t.emp_no = s.emp_no
group by title
order by avg_salary desc
limit 1;


/*
Advanced Insights
1.How many employees have worked in multiple departments?
*/

/*1.How many employees have worked in multiple departments?*/
select emp_no, count(distinct dept_no) as department_count
from dept_emp
group by emp_no
having department_count > 1
order by department_count;

























