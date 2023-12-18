Question 1

CREATE VIEW vHW_1_iagboada AS
SELECT b.city, COUNT(*) AS number_of_female_staff
FROM dreamhome.Staff4 s
JOIN dreamhome.Branch b ON s.branchNo = b.branchno
WHERE s.sex = 'F'
GROUP BY b.city
HAVING COUNT(*) > 1
ORDER BY number_of_female_staff DESC;


SELECT * FROM vHW_1_iagboada;




Question 2

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


Question 3

CREATE VIEW vHW_3_iagboada AS
SELECT
    P.projectName AS Project_name,
    CONCAT(S.fName, ' ', S.lName) AS Staff_name,
    B.city AS Branch_city,
    SUM(W.salary) AS total_salary
FROM
    dreamhome.Project P
JOIN
    dreamhome.Working W ON P.projectNo = W.projectNo
JOIN
    dreamhome.Staff4 S ON W.staffNo = S.staffNo
JOIN
    dreamhome.Branch B ON S.branchNo = B.branchno
GROUP BY
    P.projectName, Staff_name, Branch_city
HAVING
    COUNT(*) > 2;


 SELECT * FROM vHW_3_iagboada;




 Question 4

 CREATE VIEW vHW_4_iagboada AS
SELECT
    'F' AS sex,
    CONCAT(fName, ' ', lName) AS name,
    age,
    MAX(salary) AS salary
FROM
    dreamhome.Staff4
WHERE
    sex = 'F'
GROUP BY
    sex, name, age

UNION

SELECT
    'M' AS sex,
    CONCAT(fName, ' ', lName) AS name,
    age,
    MAX(salary) AS salary
FROM
    dreamhome.Staff4
WHERE
    sex = 'M'
GROUP BY
    sex, name, age;


SELECT * FROM vHW_4_iagboada;


