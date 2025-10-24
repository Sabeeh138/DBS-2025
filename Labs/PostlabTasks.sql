-- Q11. Students and teachers where student city = teacher city
SELECT s.name AS student, t.teacher_name, s.city
FROM students s
JOIN teachers t ON s.city = t.city;

-- Q12. Employees and their manager names (include employees without managers)
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- Q13. Employees who don’t belong to any department
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- Q14. Average salary per department where avg > 50,000
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 50000;

-- Q15. Employees earning more than avg salary in their department
SELECT e.emp_name, e.salary, e.dept_id
FROM employees e
WHERE e.salary > (
  SELECT AVG(salary)
  FROM employees
  WHERE dept_id = e.dept_id
);

-- Q16. Departments where no employee earns less than 30,000
SELECT d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING MIN(e.salary) >= 30000;

-- Q17. Students and their courses where city = 'Lahore'
SELECT s.name AS student, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.city = 'Lahore';

-- Q18. Employees with manager + department (hire date between 2020–2023)
SELECT e.emp_name, m.emp_name AS manager, d.dept_name, e.hire_date
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.hire_date BETWEEN DATE '2020-01-01' AND DATE '2023-01-01';

-- Q19. Students enrolled in courses taught by ‘Sir Ali’
SELECT s.name AS student, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN teachers t ON c.teacher_id = t.teacher_id
WHERE t.teacher_name = 'Sir Ali';

-- Q20. Employees whose manager is from the same department
SELECT e.emp_name, m.emp_name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.dept_id = m.dept_id;
