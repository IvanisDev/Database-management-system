Question 1
Please refer to the table in the dreamhome database. Which statement is FALSE if we run the following SQL statement?

select * from dreamhome.Staff where sex='F';
+---------+-------+-------+-----------+------+------------+----------+----------+
| staffNo | fName | lName | position  | sex  | DOB        | salary   | branchNo |
+---------+-------+-------+-----------+------+------------+----------+----------+
| SA9     | Mary  | Howe  | Assistant | F    | 1970-02-19 |  9000.00 | B007     |
| SG37    | Ann   | Beech | Assistant | F    | 1960-11-10 | 12000.00 | B003     |
| SG5     | Susan | Brand | Manager   | F    | 1940-06-03 | 24000.00 | B003     |
| SL41    | Julie | Lee   | Assistant | F    | 1965-06-13 |  9000.00 | B005     |
+---------+-------+-------+-----------+------+------------+----------+----------+

--Ans: The output has a person born after 1980-01-01.




Question 2

Please refer to the table in the dreamhome database. Which statement is FALSE if we run the following SQL statement?

select fname, sex, position from dreamhome.Staff where salary >15000;
+-------+------+------------+
| fname | sex  | position   |
+-------+------+------------+
| David | M    | Supervisor |
| Susan | F    | Manager    |
| John  | M    | Manager    |
+-------+------+------------+

--Ans: The output has 2 females and 1 male.




Question 3

Please refer to the table in the dreamhome database. Which statement is TRUE if we run the following SQL statement?

select branchno, city, street, postcode from dreamhome.Branch where street like '%ee_' order by city desc;
+----------+----------+------------------+----------+
| branchno | city     | street           | postcode |
+----------+----------+------------------+----------+
| B003     | Glasgow  | 163 Main Street  | G11 9QX  |
| B007     | Aberdeen | 16 Argyll Street | AB2 3SU  |
+----------+----------+------------------+----------+

--Ans: London is not in the output.




Question 4

Please refer to the table in the dreamhome database. Which statement is TRUE if we run the following two SQL statements?

SQL 1
select staffNo, fName, lName, position FROM dreamhome.Staff WHERE position='Manager' AND position='Supervisor';

Empty set (0.00 sec)


SQL 2
select staffNo, fName, lName, position FROM dreamhome.Staff WHERE position in ('Manager', 'Supervisor');
+---------+-------+-------+------------+
| staffNo | fName | lName | position   |
+---------+-------+-------+------------+
| SG14    | David | Ford  | Supervisor |
| SG5     | Susan | Brand | Manager    |
| SL21    | John  | White | Manager    |
+---------+-------+-------+------------+

--Ans: SQL1 output has 2 managers and 1 supervisor.


Question 5


Please refer to the table in the dreamhome database. Create a view vLab11_xxxx in the class database 
listing all double or family rooms with a price below 50.00 per night, in ascending order of price. 
The output header should be (roomno, hotelno, type, price).  Please note that the view name is case-sensitive.
( DO NOT hardcode result, 0 point will be given for hardcoded result). Note: How to submit this question 
(1) Create the view base on the requirement in our class database. (2) Verify the view result meets the requirements. 
(3) Indicate “Complete, Partial Complete or Not Complete” in the Canvas answer. I will base on our class database to 
grade this question, not based on the Canvas.


CREATE VIEW vLab11_iagboada AS
SELECT roomno, hotelno, type, price
FROM Room
WHERE type IN ('double', 'family') AND price < 50.00
ORDER BY price ASC;


select * from vLab11_iagboada;

SELECT roomno, hotelno, type, price
FROM vLab11_iagboada;
+--------+---------+--------+-------+
| roomno | hotelno | type   | price |
+--------+---------+--------+-------+
|    801 | ch02    | double | 15.00 |
|    601 | fb01    | double | 29.00 |
|   1001 | dc01    | double | 30.00 |
|   1101 | dc01    | family | 35.00 |
|    701 | fb01    | family | 39.00 |
+--------+---------+--------+-------+




Question 6

Please refer to the table in the dreamhome database. Which statement is TRUE if we run the following SQL statement?

 select fname, salary, sex from dreamhome.Staff where branchno = (select branchno from dreamhome.Branch where city!='London');

--Ans: The statement causes an error.



Question 7

Please refer to the table in the dreamhome database. If the connection is successful and we run the following PHP codes on obi.kean.edu, which statement is TRUE?

<?php
include "dbconfig.php";
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("<br>Cannot connect to DB\n");

$query = "SELECT fname FROM dreamhome.Staff WHERE sex = 'F' AND salary > 20000";
$result = mysqli_query($con, $query);

if ($result) {
    if (mysqli_num_rows($result) > 0) {
        echo "Monkey\n";
    } else {
        echo "Tiger\n";
    }
} else {
    echo "Dog\n";
}

mysqli_close($con);
?>

--Ans: Tiger is the only output.



Question 8 


Please refer to the table in the dreamhome database. Create a view vLab12_xxxx in the class database listing 
the number of staff and the maximum and minimum salary for each branch city. Your view header names should be: 
(city, count, max_salary, min_salary), in ascending order of count. Please note that the view name is 
case-sensitive. ( DO NOT hardcode result, 0 point will be given for hardcoded result).
Note: How to submit this question (1) Create the view base on the requirement in our class database. 
(2) Verify the view result meets the requirements. (3) Indicate “Complete, Partial Complete or Not Complete” 
in the Canvas answer. I will base on our class database to grade this question, not based on the Canvas.


CREATE VIEW vLab12_iagboada AS
SELECT
    B.city AS city,
    COUNT(*) AS count,
    MAX(S.salary) AS max_salary,
    MIN(S.salary) AS min_salary
FROM
    Staff4 AS S
INNER JOIN
    Branch AS B ON S.branchNo = B.branchno
GROUP BY
    B.city
ORDER BY
    count ASC;



select * from vLab12_iagboada;

SELECT city, count, max_salary, min_salary
FROM vLab12_iagboada;
+----------+-------+------------+------------+
| city     | count | max_salary | min_salary |
+----------+-------+------------+------------+
| Aberdeen |     1 |    9000.00 |    9000.00 |
| London   |     2 |   30000.00 |    9000.00 |
| Glasgow  |     3 |   24000.00 |   12000.00 |
+----------+-------+------------+------------+


Question 9

Please put your display_staff.php web page link here, and make sure the link is generating the correct results on the browser before the Lab 1 deadline. 

Your program should display all the records and columns in the dreamhome.Staff table without login when it is entered directly on the URL and executed by the webserver.
The output should be formatted well in HTML TABLE format, and the first row should be the column headers. Every column should be separated and aligned.
If the gender is “M”, the gender “M” should be in blue color.
If the gender is “F”, the gender “F” should be in red color.
Please refer to the demo website: https://vader.kean.edu/database/display_staff.phpLinks to an external site.




