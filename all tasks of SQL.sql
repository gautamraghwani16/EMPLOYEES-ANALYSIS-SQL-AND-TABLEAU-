
# Task 1



select 
e.gender,
count(e.emp_no) as num_of_employees,
year(de.from_date) as calender_year
from 
  t_employees e
join 
	t_dept_emp de
on
     e.emp_no=de.emp_no
group by calender_year, gender
having calender_year>=1990;


# Task 2 




select 
ee.gender,
d.dept_name,
e.calendar_year,
dm.from_date,
dm.to_date,
case when year(dm.to_date)>= e.calendar_year And
year(dm.from_date)<= e.calendar_year  then 1
else 0
end as active
from 
  (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) e
cross join 
t_dept_manager dm 
join 
t_departments d on dm.dept_no=d.dept_no
join 
t_employees ee  on dm.emp_no=ee.emp_no
order by dm.emp_no, calendar_year;
 
 
 
 
 
#Task 3



SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;

#Task 4





DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    e.gender, d.dept_name, AVG(s.salary) as avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END$$

DELIMITER ;

CALL filter_salary(50000, 90000);








