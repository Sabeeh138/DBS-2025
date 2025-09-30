-- IN-LAB TASKS

-- Q1. List each department and the number of students in it.
SELECT department, COUNT(*) AS number_of_students
FROM students
GROUP BY department;

-- Q2. Find departments where the average GPA of students is greater than 3.0.
SELECT department, AVG(gpa) AS average_gpa
FROM students
GROUP BY department
HAVING AVG(gpa) > 3.0;

-- Q3. Display the average fee paid by students grouped by course.
SELECT course_id, AVG(fee) AS average_fee
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
GROUP BY course_id;

-- Q4. Count how many faculty members are assigned to each department.
SELECT department, COUNT(*) AS number_of_faculty
FROM faculty
GROUP BY department;

-- Q5. Find faculty members whose salary is higher than the average salary.
SELECT faculty_id, name, salary
FROM faculty
WHERE salary > (SELECT AVG(salary) FROM faculty);

-- Q6. Show students whose GPA is higher than at least one student in the CS department.
SELECT student_id, name, gpa
FROM students
WHERE gpa > ANY (SELECT gpa FROM students WHERE department = 'CS');

-- Q7. Display the top 3 students with the highest GPA.
SELECT *
FROM (SELECT * FROM students ORDER BY gpa DESC)
WHERE ROWNUM <= 3;

-- Q8. Find students enrolled in all the courses that student Ali is enrolled in.
SELECT s.student_id, s.name
FROM students s
WHERE NOT EXISTS (
    SELECT course_id
    FROM enrollments e
    JOIN students s ON e.student_id = s.student_id
    WHERE s.name = 'Ali'
    MINUS
    SELECT course_id
    FROM enrollments e2
    WHERE e2.student_id = s.student_id
);

-- Q9. Show the total fees collected per department.
SELECT s.department, SUM(e.fee) AS total_fees_collected
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
GROUP BY s.department;

-- Q10. Display courses taken by students who have GPA above 3.5.
SELECT DISTINCT c.course_id, c.course_name
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id IN (
    SELECT student_id
    FROM students
    WHERE gpa > 3.5
);
