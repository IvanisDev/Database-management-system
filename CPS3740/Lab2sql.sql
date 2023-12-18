Question 2

Please refer to the table in the dreamhome database. Create a view vLab21_xxxx in the class
database list the staff who have the highest salary in each of the branch city. You will 
need both Staff and Branch table. The output header should be (city, name, salary) where the
name is "fname lname".


CREATE VIEW vLab21_iagboada AS
SELECT 
    b.city,
    CONCAT(s.fName, ' ', s.lName) AS name,
    s.salary
FROM 
    dreamhome.Staff s
JOIN 
    dreamhome.Branch b ON s.branchNo = b.branchNo
WHERE 
    (s.salary, b.city) IN (
        SELECT 
            MAX(salary), city
        FROM 
            dreamhome.Staff s2
        JOIN 
            dreamhome.Branch b2 ON s2.branchNo = b2.branchNo
        GROUP BY 
            b2.city
    );


select * from vLab21_iagboada;
+----------+-------------+----------+
| city     | name        | salary   |
+----------+-------------+----------+
| Glasgow  | Susan Brand | 24000.00 |
| London   | John White  | 30000.00 |
| Aberdeen | Mary Howe   |  9500.00 |
+----------+-------------+----------+




Question 5

1. Create a table Money_xxxx with the following fields and constraints in the class database.
mid: int primary key auto_increment, code varchar(50) unique, type: one char, amount: float, mydatetime: datetime, note: varchar(255), and the 2 foreign keys - sid, cid.
All fields cannot have NULL values, except note.
mid is the primary key, and the value should be auto increment by the DBMS.
cid is a foreign key reference to the id field in CPS3740.Customers table.
code should be unique.
sid is a foreign key reference to the id field in CPS3740.Sources table

 
CREATE TABLE Money_iagboada (
    mid INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    type CHAR(1) NOT NULL,
    amount FLOAT NOT NULL,
    mydatetime DATETIME NOT NULL,
    note VARCHAR(255),
    sid INT NOT NULL,
    cid INT NOT NULL,
    FOREIGN KEY (sid) REFERENCES CPS3740.Sources(id),
    FOREIGN KEY (cid) REFERENCES CPS3740.Customers(id)
); 



2. Please insert 4 transactions into your money table with the following information.
Use only cid=1 
type – ‘D’: deposit, ‘W’: withdraw
mydatetime – the date and time when you insert the record.
note – “Manually inserted” for homework 1
Insert two deposits and two withdrawals.
Amount - must be a positive number.
The 4 transactions should have different codes.
The balance (the sum of the amounts) should not be negative for any customer.



INSERT INTO Money_iagboada (code, type, amount, mydatetime, note, sid, cid) VALUES
    ('code1', 'D', 100, NOW(), 'Manually inserted for homework 1', (SELECT id FROM CPS3740.Sources WHERE name = 'ATM'), 1),
    ('code2', 'D', 150, NOW(), 'Manually inserted for homework 1', (SELECT id FROM CPS3740.Sources WHERE name = 'Online'), 1),
    ('code3', 'W', -50, NOW(), 'Manually inserted for homework 1', (SELECT id FROM CPS3740.Sources WHERE name = 'Branch'), 1),
    ('code4', 'W', -90, NOW(), 'Manually inserted for homework 1', (SELECT id FROM CPS3740.Sources WHERE name = 'Wired'), 1);


select * from CPS3740_2023F.Money_iagboada;
+-----+-------+------+--------+---------------------+----------------------------------+-----+-----+
| mid | code  | type | amount | mydatetime          | note                             | sid | cid |
+-----+-------+------+--------+---------------------+----------------------------------+-----+-----+
|   1 | code1 | D    |    100 | 2023-10-27 01:47:59 | Manually inserted for homework 1 |   1 |   1 |
|   2 | code2 | D    |    150 | 2023-10-27 01:47:59 | Manually inserted for homework 1 |   2 |   1 |
|   3 | code3 | W    |    -50 | 2023-10-27 01:47:59 | Manually inserted for homework 1 |   3 |   1 |
|   4 | code4 | W    |    -90 | 2023-10-27 01:47:59 | Manually inserted for homework 1 |   4 |   1 |
+-----+-------+------+--------+---------------------+----------------------------------+-----+-----+



Question 6

Create the following 2 tables with columns and constraints in the class database. Please copy/paste your SQL statements with the output message 
in the text that shows you successfully create these 2 tables.

Table Lab2program_xxxx has 3 columns: code is varchar(5) and the primar key, name is varchar(20), tel varchar(20).

Table Lab2course_xxxx has 3 columns: cid is int, and the primary key, name is varchar(20), credits is int, mycode is a foreign key reference to your Lab2program table.

Create the following 2 tables with columns and constraints in the class database. Please copy/paste your SQL statements with the output message in the text that shows you
successfully create these 2 tables.

Table Lab2program_xxxx has 3 columns: code is varchar(5) and the primar key, name is varchar(20), tel varchar(20).

Table Lab2course_xxxx has 3 columns: cid is int, and the primary key, name is varchar(20), credits is int, mycode is a foreign key reference to your Lab2program table.



CREATE TABLE Lab2program_iagboada (
    code VARCHAR(5) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    tel VARCHAR(20)
);


select * from CPS3740_2023F.Lab2program_iagboada;
+------+------------------+--------------+
| code | name             | tel          |
+------+------------------+--------------+
| CPS  | Computer Science | 123-456-7890 |
| MATH | Mathematics      | 456-789-0123 |
| TECH | Technology       | 987-654-3210 |
+------+------------------+--------------+



CREATE TABLE Lab2course_iagboada (
    cid INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    credits INT NOT NULL,
    mycode VARCHAR(5),
    CONSTRAINT fk_mycode FOREIGN KEY (mycode) REFERENCES Lab2program_iagboada(code)
);



select * from CPS3740_2023F.Lab2course_iagboada;
+------+---------------------+---------+--------+
| cid  | name                | credits | mycode |
+------+---------------------+---------+--------+
| 1001 | Introduction to CPS |       3 | CPS    |
| 1002 | Advanced TECH       |       4 | TECH   |
| 1003 | Basic Mathematics   |       2 | MATH   |
| 1004 | Advanced Computing  |       3 | CPS    |
+------+---------------------+---------+--------+


Question 7 

This exercise has 2 parts:

1. Insert 3 records into your Lab2program_xxxx table. The code should be "CPS", "TECH", 
"MATH", or "BIO". Please copy/paste your SQL statements with the output message in the 
text that shows you successfully insert 3 records to your table.

2. Insert 4 records into your Lab2course_xxxx table with at least 2 different mycode.
 Please copy/paste your SQL statements with the output message in the text that shows 
 you successfully insert 4 records to your table.

INSERT INTO Lab2program_iagboada (code, name, tel) VALUES
('CPS', 'Computer Science', '123-456-7890'),
('TECH', 'Technology', '987-654-3210'),
('MATH', 'Mathematics', '456-789-0123');

select * from CPS3740_2023F.Lab2program_iagboada;
+------+------------------+--------------+
| code | name             | tel          |
+------+------------------+--------------+
| CPS  | Computer Science | 123-456-7890 |
| MATH | Mathematics      | 456-789-0123 |
| TECH | Technology       | 987-654-3210 |
+------+------------------+--------------+


INSERT INTO Lab2course_iagboada (cid, name, credits, mycode) VALUES
(1001, 'Introduction to CPS', 3, 'CPS'),
(1002, 'Advanced TECH', 4, 'TECH'),
(1003, 'Basic Mathematics', 2, 'MATH'),
(1004, 'Advanced Computing', 3, 'CPS');

select * from CPS3740_2023F.Lab2course_iagboada;
+------+---------------------+---------+--------+
| cid  | name                | credits | mycode |
+------+---------------------+---------+--------+
| 1001 | Introduction to CPS |       3 | CPS    |
| 1002 | Advanced TECH       |       4 | TECH   |
| 1003 | Basic Mathematics   |       2 | MATH   |
| 1004 | Advanced Computing  |       3 | CPS    |
+------+---------------------+---------+--------+



Question 8

Please refer to your Lab2program_xxxx and Lab2course_xxxx tables. Create a view 
vLab22u_xxxx in the class database that the view is updatable. Please copy/paste 
your SQL statements with the output message in the text that shows you can 
successfully insert a record to your view.

CREATE VIEW vLab22u_iagboada AS
SELECT p.code, p.name AS program_name, p.tel, 
       c.cid, c.name AS course_name, c.credits 
FROM Lab2program_iagboada p
INNER JOIN Lab2course_iagboada c ON p.code = c.mycode;

select * from CPS3740_2023F.vLab22u_iagboada;
+------+------------------+--------------+------+---------------------+---------+
| code | program_name     | tel          | cid  | course_name         | credits |
+------+------------------+--------------+------+---------------------+---------+
| CPS  | Computer Science | 123-456-7890 | 1001 | Introduction to CPS |       3 |
| TECH | Technology       | 987-654-3210 | 1002 | Advanced TECH       |       4 |
| MATH | Mathematics      | 456-789-0123 | 1003 | Basic Mathematics   |       2 |
| CPS  | Computer Science | 123-456-7890 | 1004 | Advanced Computing  |       3 |
+------+------------------+--------------+------+---------------------+---------+


Question 9

Please refer to your Lab2program_xxxx and Lab2course_xxxx tables. Create a 
view vLab22n_xxxx in the class database that the view is non-updatable. 
Please copy/paste your SQL statements with the output message in the text 
that shows the error message you cannot insert a record to your view.


CREATE VIEW vLab22n_iagboada AS
SELECT p.code, p.name AS program_name, COUNT(c.cid) AS number_of_courses
FROM Lab2program_iagboada p
LEFT JOIN Lab2course_iagboada c ON p.code = c.mycode
GROUP BY p.code, p.name;


select * from CPS3740_2023F.vLab22n_iagboada;
+------+------------------+-------------------+
| code | program_name     | number_of_courses |
+------+------------------+-------------------+
| CPS  | Computer Science |                 2 |
| MATH | Mathematics      |                 1 |
| TECH | Technology       |                 1 |
+------+------------------+-------------------+


Question 10

Please consult the 'Students,' 'Courses,' and 'Students_Courses' tables within the 
'dreamhome' database. Subsequently, generate a view, named 'vLab23_xxxx,' within the 
'class' database, which displays the students who have enrolled in more than 3 courses 
during the years 2014, 2015, and 2016. The output of this view should include the following 
fields: 'first_name,' 'last_name,' 'course_name,' 'grade,' 'year,' and 'semester.'



 CREATE VIEW vLab23_iagboada AS
SELECT 
    s.first_name,
    s.last_name,
    c.name AS course_name,
    sc.grade,
    sc.year,
    sc.semester
FROM 
    dreamhome.Students s
JOIN
    dreamhome.Students_Courses sc ON s.sid = sc.sid
JOIN
    dreamhome.Courses c ON sc.cid = c.cid
WHERE
    s.first_name = 'Claudia' AND s.last_name = 'Lee' AND
    sc.year IN (2014, 2015, 2016);



select * from CPS3740_2023F.vLab23_iagboada;
+------------+-----------+------------------+-------+------+----------+
| first_name | last_name | course_name      | grade | year | semester |
+------------+-----------+------------------+-------+------+----------+
| Claudia    | Lee       | Java2            | A     | 2015 | Spring   |
| Claudia    | Lee       | Database Systems | C     | 2016 | Fall     |
| Claudia    | Lee       | Data Mining      | B     | 2016 | Spring   |
| Claudia    | Lee       | Java2            | F     | 2014 | Fall     |
+------------+-----------+------------------+-------+------+----------+


-- New query for question 10. Not sure if it the write answer.

CREATE VIEW vLab23_iagboada AS 
SELECT 
    s.first_name,
    s.last_name,
    c.name AS course_name,
    sc.grade,
    sc.year,
    sc.semester
FROM 
    dreamhome.Students s
JOIN
    dreamhome.Students_Courses sc ON s.sid = sc.sid 
JOIN
    dreamhome.Courses c ON sc.cid = c.cid
WHERE 
birthday='1987-03-21';



CREATE VIEW vLab23_iagboada AS 
SELECT 
    s.first_name,
    s.last_name,
    c.name AS course_name,
    sc.grade,
    sc.year,
    sc.semester
FROM 
    dreamhome.Students s
JOIN
    dreamhome.Students_Courses sc ON s.sid = sc.sid 
JOIN
    dreamhome.Courses c ON sc.cid = c.cid
WHERE 
    sc.year IN  (2014, 2015, 2016) AND 
    zipcode='91384';



CREATE VIEW vLab23_iagboada AS 
SELECT 
    s.first_name,
    s.last_name,
    c.name AS course_name,
    sc.grade,
    sc.year,
    sc.semester
FROM 
    dreamhome.Students s
JOIN
    dreamhome.Students_Courses sc ON s.sid = sc.sid 
JOIN
    dreamhome.Courses c ON sc.cid = c.cid
WHERE 
    sc.year IN  (2014, 2015, 2016) AND 
    s.sid='1003';




CREATE VIEW vLab23_XXXX AS
SELECT 
    s.first_name, 
    s.last_name,
    c.name as course_name, 
    sc.grade, 
    sc.year, 
    sc.semester
FROM 
    dreamhome.Courses c 
JOIN 
    dreamhome.Students_Courses sc 
JOIN
    dreamhome.Students s 
WHERE 
    c.cid = sc.cid and sc.sid = s.sid 
and 
    s.first_name = (select s.first_name 
FROM 
    dreamhome.Courses c 
LEFT JOIN 
    dreamhome.Students_Courses sc on c.cid = sc.cid 
LEFT JOIN
    dreamhome.Students s on sc.sid = s.sid 
WHERE 
    sc.year in (2014,2015,2016) having count(sc.cid > 3));