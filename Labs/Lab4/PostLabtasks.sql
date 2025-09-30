-- POST-LAB TASKS

-- Q11. Show departments where the total fees collected exceed 1 million.
SELECT s.department, SUM(e.fee) AS total_fees
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
GROUP BY s.department
HAVING SUM(e.fee) > 1000000;

-- Q12. Display faculty departments where more than 5 faculty members earn above 100,000 salary.
SELECT department, COUNT(*) AS highly_paid_faculty_count
FROM faculty
WHERE salary > 100000
GROUP BY department
HAVING COUNT(*) > 5;

-- Q13. Delete all students whose GPA is below the overall average GPA.
DELETE FROM students
WHERE gpa < (SELECT AVG(gpa) FROM students);

-- Q14. Delete courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM enrollments);

-- Q15. Copy all students who paid more than the average fee into a new table HighFee_Students.
CREATE TABLE HighFee_Students AS
SELECT *
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
    GROUP BY e.student_id
    HAVING SUM(e.fee) > (SELECT AVG(fee) FROM enrollments)
);

-- Q16. Insert faculty into Retired_Faculty if their joining date is earlier than the minimum joining date in the university.
INSERT INTO Retired_Faculty
SELECT *
FROM faculty
WHERE joining_date < (SELECT MIN(joining_date) FROM faculty);

-- Q17. Find the department having the maximum total fee collected.
SELECT department, total_fees
FROM (
    SELECT s.department, SUM(e.fee) AS total_fees
    FROM enrollments e
    JOIN students s ON e.student_id = s.student_id
    GROUP BY s.department
    ORDER BY total_fees DESC
)
WHERE ROWNUM = 1;

-- Q18. Show the top 3 courses with the highest enrollments using ROWNUM or LIMIT.
SELECT course_id, COUNT(student_id) AS enrollment_count
FROM enrollments
GROUP BY course_id
ORDER BY enrollment_count DESC
FETCH FIRST 3 ROWS ONLY;

-- Q19. Display students who have enrolled in more than 3 courses and have GPA greater than the overall average.
SELECT s.student_id, s.name, s.gpa, COUNT(e.course_id) AS courses_enrolled
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE s.gpa > (SELECT AVG(gpa) FROM students)
GROUP BY s.student_id, s.name, s.gpa
HAVING COUNT(e.course_id) > 3;

-- Q20. Find faculty who do not teach any course and insert them into Unassigned_Faculty.
INSERT INTO Unassigned_Faculty
SELECT f.*
FROM faculty f
WHERE f.faculty_id NOT IN (
    SELECT DISTINCT faculty_id
    FROM teaches
    WHERE faculty_id IS NOT NULL
);
