-- Q1. All possible pairs of employees and departments
SELECT e.emp_name, d.dept_name
FROM employees e CROSS JOIN departments d;

-- Q2. All departments and employees (even if no employees)
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT OUTER JOIN departments d ON e.dept_id = d.dept_id;

-- Q3. Employee names with their manager names
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- Q4. Employees not assigned any project
SELECT e.emp_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.emp_id IS NULL;

-- Q5. Student names with their enrolled course names
SELECT s.name AS student, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Q6. All customers with their orders (even if none placed)
SELECT c.customer_name, o.order_id
FROM customers c
LEFT OUTER JOIN orders o ON c.customer_id = o.customer_id;

-- Q7. All departments and employees (even if no employee)
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT OUTER JOIN employees e ON d.dept_id = e.dept_id;

-- Q8. All pairs of teachers and subjects (taught or not)
SELECT t.teacher_name, s.subject_name
FROM teachers t
CROSS JOIN subjects s;

-- Q9. Departments with total employees
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Q10. Each student, their course, and their teacher
SELECT s.name AS student, c.course_name, t.teacher_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN teachers t ON c.teacher_id = t.teacher_id;
