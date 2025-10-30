CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR2(20),
  h_pay INT,
  y_pay INT
);

INSERT INTO students (student_id, student_name) VALUES (2, 'emman');

SET SERVEROUTPUT ON;

-- Before Insert Trigger
CREATE OR REPLACE TRIGGER inser_data
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
  IF :NEW.h_pay IS NULL THEN
    :NEW.h_pay := 250;
  END IF;
END;
/

-- Before Update Trigger
CREATE OR REPLACE TRIGGER update_salary
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
  :NEW.y_pay := :NEW.h_pay * 1920;
END;
/

-- Test update (make sure the student_id exists)
UPDATE students SET h_pay = 200 WHERE student_id = 3;
--delete
CREATE OR REPLACE TRIGGER prevent_admin
BEFORE DELETE ON students
FOR EACH ROW
BEGIN
IF :OLD.student_name = 'admin'
THEN
RAISE_APPLICATIOON_ERROR(-20000, 'YOU CANNOT DELETE ADMIN RECORD.');
END IF;
END;
/
DELETE FROM students WHERE student_name = 'admin';

-- after insert
CREATE TABLE student_logs (
    student_id INT,
    student_name VARCHAR(20),
    inserted_by VARCHAR(20),
    inserted_on date
);
CREATE OR REPLACE TRIGGER after_ins
AFTER INSERT ON students FOR EACH ROW
BEGIN
INSERT INTO student_logs(student_id, student_name, inserted_by, inserted_on) VALUES
(:NEW.student_id, :NEW.student_name, SYS_CONTEXT('USERENV','SESSION_USER'), SYSDATE);
END;
/
INSERT INTO students(student_id, student_name, h_pay) VALUES (5,'aqsa', 300);
SELECT * FROM student_logs;

-- DDL TRIGGERS
-- PREVENT TABLE TABLE TO DROP
CREATE OR REPLACE TRIGGER prevent_tables
BEFORE DROP ON DATABASE
BEGIN
RAISE_APPLICATION_ERROR (
    num => -20000,
    msg => 'Cannot drop object'
);
END;
/
DROP TABLE student_logs;

-- ddl 2

CREATE TABLE schema_audit (
    ddl_date DATE,
    ddl_user VARCHAR(15),
    object_created VARCHAR(15),
    object_name VARCHAR(15),
    ddl_operation VARCHAR(15)
);
SELECT * FROM schema_audit;

SET serveroutput ON;
CREATE OR REPLACE TRIGGER hr_audit_tr
AFTER DDL ON SCHEMA
BEGIN
INSERT INTO schema_audit VALUES (sysdate, sys_cotext('USERENV', 'CURRENT_USER'), ora_dict_obj_type, ora_dict_obj_name, ora_sysevent);
END;
/
CREATE TABLE abc(
    id INT PRIMARY KEY,
    name VARCHAR(20)
);
INSERT INTO abc VALUES(1, 'Ali');
TRUNCATE TABLE abc;
