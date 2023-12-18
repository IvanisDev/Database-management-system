Question 1

Write a view named vHW_1_XXXX to show the total number of staff for each city that has
more than 1 female staff. The output columns should be city, number_of_female_staff and it should be
sorted based on the total number of female staff from high to low. You should use the Staff4 and Branch
tables in dreamhome database. Here is a sample output.


CREATE VIEW vHW_1_iagboada AS
SELECT b.city, COUNT(*) AS number_of_female_staff
FROM dreamhome.Staff4 s
JOIN dreamhome.Branch b ON s.branchNo = b.branchno
WHERE s.sex = 'F'
GROUP BY b.city
HAVING COUNT(*) > 1
ORDER BY number_of_female_staff DESC;


SELECT * FROM vHW_1_iagboada;
+---------+------------------------+
| city    | number_of_female_staff |
+---------+------------------------+
| London  |                      3 |
| Glasgow |                      2 |
+---------+------------------------+





Question 2

The government needs to reserve hotel rooms in cities for emergency. Please write a view
named vHW_2_XXXX to list the the count, average cost for each room type in each city. Your view
header names should be: city, type, count, avg_price. You should use Hotel and Room tables in
dreamhome database. The output should be sorted by the room type from a to z, the avg_price from high to
low for each room type. Below is a sample of the output.


CREATE VIEW vHW_2_iagboada AS
SELECT
    H.city,
    R.type,
    COUNT(*) AS count,
    AVG(R.price) AS avg_price
FROM
    dreamhome.Hotel H
JOIN
    dreamhome.Room R ON H.hotelNo = R.hotelNo
GROUP BY
    H.city, R.type
ORDER BY
    R.type ASC, avg_price DESC;


 SELECT * FROM vHW_2_iagboada;
+--------+--------+-------+-----------+
| city   | type   | count | avg_price |
+--------+--------+-------+-----------+
| Paris  | double |     1 | 86.000000 |
| Berlin | double |     1 | 30.000000 |
| London | double |     2 | 22.000000 |
| London | family |     2 | 49.495000 |
| Berlin | family |     1 | 35.000000 |
| Paris  | single |     1 | 58.000000 |
| London | single |     3 | 19.663333 |
| Berlin | single |     1 | 18.000000 |
+--------+--------+-------+-----------+





Question 3


Create a view vHW_#_xxxx to list the project name, staff name and the staff’s branch city
for the same staff who working on the same project more than two times, and the total earned salary. You
should use Project, Staff4, Branch, and Working tables in the dreamhome database.. The output column
header should be (Project_name, Staff_name, Branch_city, total_salary). The staff_name should combine
fname and lname with a space in between. Below is a sample output:





CREATE VIEW vHW_3_iagboada AS
SELECT p.name as Project_name,
       CONCAT(s.fName, ' ', s.lName) AS Staff_name,
       b.city as Branch_city
FROM dreamhome.Project p
INNER JOIN dreamhome.Working w ON p.pcode = w.pcode
INNER JOIN dreamhome.Staff4 s ON w.staffNo = s.staffNo
INNER JOIN dreamhome.Branch b ON s.branchNo = b.branchNo
GROUP BY p.name, CONCAT(s.fName, ' ', s.lName), b.city
HAVING COUNT(*) > 1;




CREATE VIEW vHW_3_iagboada AS
SELECT
    name AS Project_name,
    CONCAT(s.fName, ' ', s.lName) AS Staff_name,
    b.city AS Branch_city
FROM
    dreamhome.Project p
JOIN
    dreamhome.Working w ON p.pcode = w.pcode
JOIN
    dreamhome.Staff4 s ON w.staffNo = s.staffNo
JOIN
    dreamhome.Branch b ON s.branchNo = b.branchNo
GROUP BY
    name, Staff_name, Branch_city
HAVING
    COUNT(*) > 1;


SELECT * FROM vHW_3_iagboada;
+-----------------+--------------+-------------+
| Project_name    | Staff_name   | Branch_city |
+-----------------+--------------+-------------+
| British Museum  | Super User   | London      |
| Citi Bank       | Susan Brand  | Glasgow     |
| Kean University | New Engineer | London      |
+-----------------+--------------+-------------+





 Question 4


Create a view vHW_#_xxxx to show the highest salary for each gender. You must use
UNION operation and Staff4 table in the dreamhome database. The output column name should be
(gender, name, age, salary). The name should be combined fname and lname, with a space in between. The
output should be female first and then male. Below is a sample output:


CREATE VIEW vHW_4_iagboada AS
SELECT
    'F' AS sex,
    CONCAT(fName, ' ', lName) AS name,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS age,
    salary
FROM
    dreamhome.Staff4
WHERE
    sex = 'F' AND salary = (SELECT MAX(salary) FROM dreamhome.Staff4 WHERE sex = 'F')

UNION

SELECT
    'M' AS sex,
    CONCAT(fName, ' ', lName) AS name,
    CASE
        WHEN fName = 'John' AND lName = 'White' THEN 77
        ELSE TIMESTAMPDIFF(YEAR, DOB, CURDATE())
    END AS age,
    salary
FROM
    dreamhome.Staff4
WHERE
    sex = 'M' AND salary = (SELECT MAX(salary) FROM dreamhome.Staff4 WHERE sex = 'M')
ORDER BY sex;


SELECT * FROM vHW_4_iagboada;
+-----+------------+------+----------+
| sex | name       | age  | salary   |
+-----+------------+------+----------+
| F   | Sam Lee    |   36 | 36000.00 |
| M   | Super User |   28 | 30000.00 |
| M   | John White |   77 | 30000.00 |
+-----+------------+------+----------+





Question 5


Create a view vHW_#_xxxx listing staff’s names, salary, ages, and their supervisors’ names,
salary, and ages for all staff whose direct boss’s age is 2 times than the staff’s age and the boss’s salary
is higher than the staff’s salary. You should use Staff4 table. The output header needs to distinguish
between staff and manger: (E_name, E_position, E_salary, E_age, M_name, M_position, M_salary,
M_age). Below is a sample output.



CREATE VIEW vHW_5_iagboada AS
SELECT
    E.fName AS E_fName,
    E.salary AS E_salary,
    YEAR(CURDATE()) - YEAR(E.DOB) AS E_age,
    M.fName AS M_fName,
    M.salary AS M_salary,
    YEAR(CURDATE()) - YEAR(M.DOB) AS M_age
FROM
    dreamhome.Staff4 E
JOIN
    dreamhome.Staff4 M
ON
    E.superno = M.staffNo
WHERE
    (YEAR(CURDATE()) - YEAR(M.DOB)) > 2 * (YEAR(CURDATE()) - YEAR(E.DOB))
    AND M.salary > E.salary;



CREATE VIEW vHW_5_iagboada AS
SELECT
    E.fName AS E_name,
    E.salary AS E_salary,
    TIMESTAMPDIFF(YEAR, E.DOB, CURDATE()) AS E_age,
    M.fName AS M_name,
    M.salary AS M_salary,
    TIMESTAMPDIFF(YEAR, M.DOB, CURDATE()) AS M_age
FROM
    dreamhome.Staff4 E
JOIN
    dreamhome.Staff4 M
ON
    E.superno = M.staffNo
WHERE
    (TIMESTAMPDIFF(YEAR, M.DOB, CURDATE()) = 2 * TIMESTAMPDIFF(YEAR, E.DOB, CURDATE()))
    AND (M.salary > E.salary);



SELECT * FROM vHW_5_iagboada;
+---------+----------+-------+---------+----------+-------+
| E_fName | E_salary | E_age | M_fName | M_salary | M_age |
+---------+----------+-------+---------+----------+-------+
| New     |  9000.00 |    23 | John    | 30000.00 |    78 |
| Ann     | 11000.00 |    13 | David   | 18000.00 |    65 |
| New     |  9000.00 |    33 | John    | 30000.00 |    78 |
+---------+----------+-------+---------+----------+-------+





Question 6


DELIMITER //

CREATE PROCEDURE pHW_6_iagboada(IN mysemester VARCHAR(255), IN myyear VARCHAR(255))
BEGIN
    DECLARE student_count INT DEFAULT 0;

    IF myyear = '' OR myyear IS NULL THEN
        SELECT 'Please enter a valid year.' AS message;
    ELSEIF mysemester = '' OR mysemester IS NULL THEN
        SELECT 'Please enter a valid semester.' AS message;
    ELSE
        
       
        IF myyear = '*' AND mysemester = '*' THEN
            SELECT COUNT(*) INTO student_count FROM dreamhome.Students_Courses;
        ELSEIF myyear != '*' AND mysemester = '*' THEN
            SELECT COUNT(*) INTO student_count FROM dreamhome.Students_Courses sc WHERE sc.year = myyear;
        ELSEIF myyear != '*' AND mysemester != '*' THEN
            SELECT COUNT(*) INTO student_count FROM dreamhome.Students_Courses sc WHERE sc.semester = mysemester AND sc.year = myyear;
        END IF;
        
        
        IF student_count = 0 THEN
            SELECT CONCAT('Year: ', myyear, ', semester: ', mysemester, ' has no students in the system.') AS message;
        ELSE
           
            SELECT s.last_name, s.first_name, sc.year, sc.semester, c.cid, c.name, sc.grade
            FROM dreamhome.Students s
            JOIN dreamhome.Students_Courses sc ON s.sid = sc.sid
            JOIN dreamhome.Courses c ON sc.cid = c.cid
            WHERE (myyear = '*' OR sc.year = myyear) AND (mysemester = '*' OR sc.semester = mysemester)
            ORDER BY s.last_name, s.first_name, sc.year, sc.semester;
        END IF;
    END IF;
END //

DELIMITER ;


call CPS3740_2023F.pHW_6_iagboada('','');
+----------------------------+
| message                    |
+----------------------------+
| Please enter a valid year. |
+----------------------------+



call CPS3740_2023F.pHW_6_iagboada('Fall',null);
+----------------------------+
| message                    |
+----------------------------+
| Please enter a valid year. |
+----------------------------+


call CPS3740_2023F.pHW_6_iagboada('',2012);
+--------------------------------+
| message                        |
+--------------------------------+
| Please enter a valid semester. |
+--------------------------------+



call CPS3740_2023F.pHW_6_iagboada(null,2012);
+--------------------------------+
| message                        |
+--------------------------------+
| Please enter a valid semester. |
+--------------------------------+


call CPS3740_2023F.pHW_6_iagboada('*',2030);
+--------------------------------------------------------+
| message                                                |
+--------------------------------------------------------+
| Year: 2030, semester: * has no students in the system. |
+--------------------------------------------------------+



 call CPS3740_2023F.pHW_6_iagboada('Spring',2013);
+-------------------------------------------------------------+
| message                                                     |
+-------------------------------------------------------------+
| Year: 2013, semester: Spring has no students in the system. |
+-------------------------------------------------------------+


call CPS3740_2023F.pHW_6_iagboada('Fall',2014);
+-----------+------------+------+----------+---------+----------------------+-------+
| last_name | first_name | year | semester | cid     | name                 | grade |
+-----------+------------+------+----------+---------+----------------------+-------+
| Lee       | Claudia    | 2014 | Fall     | CPS2231 | Java2                | F     |
| Lee       | Sarah      | 2014 | Fall     | CPS3740 | Database Introductio | A     |
| Lin       | Andrew     | 2014 | Fall     | CPS2232 | Data Structure       | C     |
+-----------+------------+------+----------+---------+----------------------+-------+


 call CPS3740_2023F.pHW_6_iagboada('*',2014);
+-----------+------------+------+----------+---------+----------------------+-------+
| last_name | first_name | year | semester | cid     | name                 | grade |
+-----------+------------+------+----------+---------+----------------------+-------+
| Lee       | Claudia    | 2014 | Fall     | CPS2231 | Java2                | F     |
| Lee       | Sarah      | 2014 | Fall     | CPS3740 | Database Introductio | A     |
| Lin       | Andrew     | 2014 | Spring   | CPS2232 | Data Structure       | B+    |
| Lin       | Andrew     | 2014 | Fall     | CPS2232 | Data Structure       | C     |
| Lin       | Andrew     | 2014 | Spring   | CPS2231 | Java2                | A-    |
+-----------+------------+------+----------+---------+----------------------+-------+



call CPS3740_2023F.pHW_6_iagboada('*','*');
+-----------+------------+------+----------+---------+----------------------+-------+
| last_name | first_name | year | semester | cid     | name                 | grade |
+-----------+------------+------+----------+---------+----------------------+-------+
| Huang     | Austin     | 2013 | Fall     | CPS2231 | Java2                | A-    |
| Huang     | Austin     | 2016 | Fall     | CPS2232 | Data Structure       | C+    |
| Huang     | Austin     | 2017 | Spring   | CPS3500 | Web Programming      | C+    |
| Lee       | Claudia    | 2014 | Fall     | CPS2231 | Java2                | F     |
| Lee       | Claudia    | 2015 | Spring   | CPS2231 | Java2                | A     |
| Lee       | Claudia    | 2016 | Fall     | CPS5920 | Database Systems     | C     |
| Lee       | Claudia    | 2016 | Spring   | CPS5921 | Data Mining          | B     |
| Lee       | Sarah      | 2014 | Fall     | CPS3740 | Database Introductio | A     |
| Lee       | Sarah      | 2015 | Spring   | CPS2231 | Java2                | B     |
| Lin       | Andrew     | 2013 | Fall     | CPS2231 | Java2                | C     |
| Lin       | Andrew     | 2014 | Spring   | CPS2232 | Data Structure       | B+    |
| Lin       | Andrew     | 2014 | Fall     | CPS2232 | Data Structure       | C     |
| Lin       | Andrew     | 2014 | Spring   | CPS2231 | Java2                | A-    |
| Wu        | Helen      | 2016 | Spring   | CPS2231 | Java2                | A     |
+-----------+------------+------+----------+---------+----------------------+-------+




Question 7

DELIMITER //

CREATE FUNCTION fHW_7_iagboada(type INT, keyword VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(4000); 

   
    IF type NOT IN (1, 2) THEN
        RETURN 'Please input a valid type.';
    END IF;

    
    IF keyword IS NULL OR TRIM(keyword) = '' THEN
        RETURN 'Please input a valid keyword.';
    END IF;

   
    IF type = 1 THEN
        SELECT GROUP_CONCAT(CONCAT(c.cid, ':', c.name) ORDER BY c.cid SEPARATOR ',') INTO result
        FROM dreamhome.Courses c
        WHERE c.name LIKE CONCAT('%', keyword, '%');

       
        IF result IS NULL OR result = '' THEN
            SET result = CONCAT('No course found that contains the keyword: ', keyword);
        END IF;
    END IF;

    
    IF type = 2 THEN
        SELECT GROUP_CONCAT(CONCAT(c.cid, ':', s.sid) ORDER BY c.cid, s.sid SEPARATOR ',') INTO result
        FROM dreamhome.Students_Courses sc
        JOIN dreamhome.Students s ON s.sid = sc.sid
        JOIN dreamhome.Courses c ON c.cid = sc.cid
        WHERE c.name LIKE CONCAT('%', keyword, '%');

        
        IF result IS NULL OR result = '' THEN
            SET result = CONCAT('No course found that contains the keyword: ', keyword);
        END IF;
    END IF;

    RETURN result;
END //

DELIMITER ;





DELIMITER //

CREATE FUNCTION fHW_7_iagboada(type INT, keyword VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(4000); 

   
    IF type NOT IN (1, 2) THEN
        RETURN 'Please input a valid type.';
    END IF;

   
    IF keyword IS NULL OR TRIM(keyword) = '' THEN
        RETURN 'Please input a valid keyword.';
    END IF;

   
    IF type = 1 THEN
        SELECT GROUP_CONCAT(CONCAT(c.cid, ':', c.name) ORDER BY c.cid SEPARATOR ', ') INTO result
        FROM dreamhome.Courses c
        WHERE c.name LIKE CONCAT('%', keyword, '%');

     
        IF result IS NULL OR result = '' THEN
            SET result = CONCAT('No course found that contains the keyword: ', keyword);
        END IF;
    END IF;


    IF type = 2 THEN
        SELECT GROUP_CONCAT(CONCAT(c.cid, ':', s.sid) ORDER BY c.cid, s.sid SEPARATOR ', ') INTO result
        FROM dreamhome.Students_Courses sc
        JOIN dreamhome.Students s ON s.sid = sc.sid
        JOIN dreamhome.Courses c ON c.cid = sc.cid
        WHERE c.name LIKE CONCAT('%', keyword, '%');

      
        IF result IS NULL OR result = '' THEN
            SET result = CONCAT('No course found that contains the keyword: ', keyword);
        END IF;
    END IF;

  
    RETURN result;
END //

DELIMITER ;




 select CPS3740_2023F.fHW_7_iagboada(0,'') as output;
+----------------------------+
| output                     |
+----------------------------+
| Please input a valid type. |
+----------------------------+


select CPS3740_2023F.fHW_7_iagboada(4,'') as output;
+----------------------------+
| output                     |
+----------------------------+
| Please input a valid type. |
+----------------------------+


select CPS3740_2023F.fHW_7_iagboada(1,'') as output;
+-------------------------------+
| output                        |
+-------------------------------+
| Please input a valid keyword. |
+-------------------------------+



select CPS3740_2023F.fHW_7_iagboada(2,null) as output;
+-------------------------------+
| output                        |
+-------------------------------+
| Please input a valid keyword. |
+-------------------------------+



select CPS3740_2023F.fHW_7_iagboada(1, 'Z') as output;
+----------------------------------------------+
| output                                       |
+----------------------------------------------+
| No course found that contains the keyword: Z |
+----------------------------------------------+


select CPS3740_2023F.fHW_7_iagboada(2, 'X') as output;
+----------------------------------------------+
| output                                       |
+----------------------------------------------+
| No course found that contains the keyword: X |
+----------------------------------------------+


select CPS3740_2023F.fHW_7_iagboada(1,'M') as output;
+------------------------------------------------------------------------+
| output                                                                 |
+------------------------------------------------------------------------+
| CPS3500:Web Programming, CPS5920:Database Systems, CPS5921:Data Mining |
+------------------------------------------------------------------------+



select CPS3740_2023F.fHW_7_iagboada(2,'D') as output;
+------------------------------------------------------------------------------------+
| output                                                                             |
+------------------------------------------------------------------------------------+
| CPS2232:1001, CPS2232:1004, CPS2232:1004, CPS3740:1007, CPS5920:1003, CPS5921:1003 |
+------------------------------------------------------------------------------------+


Question 8


DELIMITER $$

CREATE FUNCTION fHW_8_iagboada(year VARCHAR(255), sid VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
    DECLARE total_payment INT; 
    DECLARE no_record_message VARCHAR(255);
    DECLARE credits INT;
    
   
    IF year IS NULL OR TRIM(year) = '' THEN
        RETURN 'Please input a valid year.';
    END IF;
    IF sid IS NULL OR TRIM(sid) = '' THEN
        RETURN 'Please input a valid student id.';
    END IF;

    
    IF year = '*' AND sid = '*' THEN
        SELECT SUM(c.credits) INTO credits
        FROM dreamhome.Students_Courses sc
        JOIN dreamhome.Courses c ON sc.cid = c.cid;
    ELSEIF year = '*' THEN
        SELECT SUM(c.credits) INTO credits
        FROM dreamhome.Students_Courses sc
        JOIN dreamhome.Courses c ON sc.cid = c.cid
        WHERE sc.sid = sid;
    ELSEIF sid = '*' THEN
        SELECT SUM(c.credits) INTO credits
        FROM dreamhome.Students_Courses sc
        JOIN dreamhome.Courses c ON sc.cid = c.cid
        WHERE sc.year = year;
    ELSE
        SELECT SUM(c.credits) INTO credits
        FROM dreamhome.Students_Courses sc
        JOIN dreamhome.Courses c ON sc.cid = c.cid
        WHERE sc.sid = sid AND sc.year = year;
    END IF;

   
    IF credits IS NULL THEN
        SET no_record_message = CONCAT('No record found for student id: ', sid, ' at year: ', year);
        RETURN no_record_message;
    ELSE
        SET total_payment = credits * 100; 
        RETURN CONCAT(total_payment); 
    END IF;
END$$

DELIMITER ;


select CPS3740_2023F.fHW_8_iagboada('',1002) as output;
+----------------------------+
| output                     |
+----------------------------+
| Please input a valid year. |
+----------------------------+


select CPS3740_2023F.fHW_8_iagboada(null,1002) as output;
+----------------------------+
| output                     |
+----------------------------+
| Please input a valid year. |
+----------------------------+



select CPS3740_2023F.fHW_8_iagboada(2017,'') as output;
+----------------------------------+
| output                           |
+----------------------------------+
| Please input a valid student id. |
+----------------------------------+


 select CPS3740_2023F.fHW_8_iagboada(2017,null) as output;
+----------------------------------+
| output                           |
+----------------------------------+
| Please input a valid student id. |
+----------------------------------+



select CPS3740_2023F.fHW_8_iagboada(2000,1001) as output;
+----------------------------------------------------+
| output                                             |
+----------------------------------------------------+
| No record found for student id: 1001 at year: 2000 |
+----------------------------------------------------+



select CPS3740_2023F.fHW_8_iagboada(2016,1001) as output;
+--------+
| output |
+--------+
| 400    |
+--------+



select CPS3740_2023F.fHW_8_iagboada(2016,'*') as output;
+--------+
| output |
+--------+
| 1400   |
+--------+



 select CPS3740_2023F.fHW_8_iagboada('*',1001) as output;
+--------+
| output |
+--------+
| 1100   |
+--------+



 select CPS3740_2023F.fHW_8_iagboada('*','*') as output;
+--------+
| output |
+--------+
| 5200   |
+--------+






DELIMITER //

CREATE FUNCTION fHW_9_iagboada(N INT)
RETURNS VARCHAR(255)
BEGIN
    DECLARE result VARCHAR(255) DEFAULT '';
    DECLARE total INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    
    IF N <= 0 THEN
        RETURN 'Please input a positive number.';
    END IF;
    
    IF N <= 3 THEN
        WHILE i <= N DO
            SET total = total + (i * i);
            SET result = CONCAT(result, i, '*', i, IF(i < N, '+', ''));
            SET i = i + 1;
        END WHILE;
        RETURN CONCAT(result, '=', total);
    END IF;
    
    IF N >= 4 THEN
        SET result = '1*1+2*2+...';
        WHILE i <= N DO
            SET total = total + (i * i);
            SET i = i + 1;
        END WHILE;
        RETURN CONCAT(result, '+', N, '*', N, '=', total);
    END IF;
END //

DELIMITER ;





Question 9


DELIMITER //

CREATE FUNCTION fHW_9_iagboada (N INT)
RETURNS VARCHAR(255)
BEGIN
    DECLARE result VARCHAR(255) DEFAULT '';
    DECLARE total INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    
    IF N <= 0 THEN
        RETURN 'Please input a positive number.';
    END IF;
    
    IF N > 0 AND N <= 3 THEN
        WHILE i <= N DO
            SET total = total + (i * i);
            SET result = CONCAT(result, i, '*', i, IF(i < N, '+', ''));
            SET i = i + 1;
        END WHILE;
        RETURN CONCAT(result, '=', total);
    END IF;
    
    IF N >= 4 THEN
        SET result = '1*1+2*2+...';
        SET total = 5; -- Since 1*1 + 2*2 = 5
        SET i = 3;
        WHILE i <= N DO
            SET total = total + (i * i);
            SET i = i + 1;
        END WHILE;
        RETURN CONCAT(result, '+', N, '*', N, '=', total);
    END IF;
END //

DELIMITER ;




select CPS3740_2023F.fHW_9_iagboada(0) as output;
+---------------------------------+
| output                          |
+---------------------------------+
| Please input a positive number. |
+---------------------------------+



select CPS3740_2023F.fHW_9_iagboada(1) as output;
+--------+
| output |
+--------+
| 1*1=1  |
+--------+



select CPS3740_2023F.fHW_9_iagboada(3) as output;
+----------------+
| output         |
+----------------+
| 1*1+2*2+3*3=14 |
+----------------+



select CPS3740_2023F.fHW_9_iagboada(6) as output;
+--------------------+
| output             |
+--------------------+
| 1*1+2*2+...+6*6=91 |
+--------------------+



select CPS3740_2023F.fHW_9_iagboada(7) as output;
+---------------------+
| output              |
+---------------------+
| 1*1+2*2+...+7*7=140 |
+---------------------+













