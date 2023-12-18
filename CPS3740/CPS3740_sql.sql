select s.fname, s.lname, s.salary/12 as monthly_Salary from dreamhome.Staff s;
+-------+-------+----------------+
| fname | lname | monthly_Salary |
+-------+-------+----------------+
| Mary  | Howe  |     750.000000 |
| David | Ford  |    1500.000000 |
| Ann   | Beech |    1000.000000 |
| Susan | Brand |    2000.000000 |
| John  | White |    2500.000000 |
| Julie | Lee   |     750.000000 |
+-------+-------+----------------+


select s.fname, s.lname, s.salary/12 as monthly_Salary from dreamhome.Staff;
ERROR 1054 (42S22): Unknown column 's.fname' in 'field list'


select fname, lname, salary/12 as monthly_salary from Staff where salary/12 > 1000;
+-------+-------+----------------+
| fname | lname | monthly_salary |
+-------+-------+----------------+
| David | Ford  |    1500.000000 |
| Susan | Brand |    2000.000000 |
| John  | White |    2500.000000 |
+-------+-------+----------------+


select fname, lname, salary/12 as monthly_salary from Staff where salary/12 > 1000 AND sex='F';
+-------+-------+----------------+
| fname | lname | monthly_salary |
+-------+-------+----------------+
| Susan | Brand |    2000.000000 |
+-------+-------+----------------+


select 1 AND 0;
+---------+
| 1 AND 0 |
+---------+
|       0 |
+---------+


select 1 AND 0 OR 1;
+--------------+
| 1 AND 0 OR 1 |
+--------------+
|            1 |
+--------------+


 select 0 AND ( 0 OR 1);
+-----------------+
| 0 AND ( 0 OR 1) |
+-----------------+
|               0 |
+-----------------+


select * from Viewing where comment=NULL; -- incorrect, no output
Empty set (0.00 sec)


select * from Viewing where comment is NULL;
+----------+------------+------------+---------+
| clientNo | propertyNo | viewDate   | comment |
+----------+------------+------------+---------+
| CR56     | PG4        | 2013-05-26 | NULL    |
+----------+------------+------------+---------+


select * from Viewing where comment is NOT NULL;
+----------+------------+------------+----------------+
| clientNo | propertyNo | viewDate   | comment        |
+----------+------------+------------+----------------+
| CR56     | PA14       | 2013-05-24 | too small      |
| CR56     | PG36       | 2013-04-28 |                |
| CR62     | PA14       | 2013-04-14 | no dining room |
| CR76     | PG4        | 2013-04-20 | too remote     |
+----------+------------+------------+----------------+


 select null and 0;
+------------+
| null and 0 |
+------------+
|          0 |
+------------+


select null or 0;
+-----------+
| null or 0 |
+-----------+
|      NULL |
+-----------+


select null or 1;
+-----------+
| null or 1 |
+-----------+
|         1 |
+-----------+


select null and 1;
+------------+
| null and 1 |
+------------+
|       NULL |
+------------+


select null AND 1, null AND 0, null, null or 1, null or 0;
+------------+------------+------+-----------+-----------+
| null AND 1 | null AND 0 | NULL | null or 1 | null or 0 |
+------------+------------+------+-----------+-----------+
|       NULL |          0 | NULL |         1 |      NULL |
+------------+------------+------+-----------+-----------+


select * from Staff;
+---------+-------+-------+------------+------+------------+----------+----------+
| staffNo | fName | lName | position   | sex  | DOB        | salary   | branchNo |
+---------+-------+-------+------------+------+------------+----------+----------+
| SA9     | Mary  | Howe  | Assistant  | F    | 1970-02-19 |  9000.00 | B007     |
| SG14    | David | Ford  | Supervisor | M    | 1958-03-24 | 18000.00 | B003     |
| SG37    | Ann   | Beech | Assistant  | F    | 1960-11-10 | 12000.00 | B003     |
| SG5     | Susan | Brand | Manager    | F    | 1940-06-03 | 24000.00 | B003     |
| SL21    | John  | White | Manager    | M    | 1945-10-01 | 30000.00 | B005     |
| SL41    | Julie | Lee   | Assistant  | F    | 1965-06-13 |  9000.00 | B005     |
+---------+-------+-------+------------+------+------------+----------+----------+


select fname, lname from Staff where salary > 10000;
+-------+-------+
| fname | lname |
+-------+-------+
| David | Ford  |
| Ann   | Beech |
| Susan | Brand |
| John  | White |
+-------+-------+


select fname, lname from Staff where salary > 10000 order by salary;
+-------+-------+
| fname | lname |
+-------+-------+
| Ann   | Beech |
| David | Ford  |
| Susan | Brand |
| John  | White |
+-------+-------+


select fname, lname, salary from Staff where salary > 10000 order by salary ASC;
+-------+-------+----------+
| fname | lname | salary   |
+-------+-------+----------+
| Ann   | Beech | 12000.00 |
| David | Ford  | 18000.00 |
| Susan | Brand | 24000.00 |
| John  | White | 30000.00 |
+-------+-------+----------+


elect fname, lname, salary from Staff where salary > 10000 order by salary desc;
+-------+-------+----------+
| fname | lname | salary   |
+-------+-------+----------+
| John  | White | 30000.00 |
| Susan | Brand | 24000.00 |
| David | Ford  | 18000.00 |
| Ann   | Beech | 12000.00 |
+-------+-------+----------+

select fname, lname, position, salary from Staff where salary > 10000 order by position ASC, salary desc;
+-------+-------+------------+----------+
| fname | lname | position   | salary   |
+-------+-------+------------+----------+
| Ann   | Beech | Assistant  | 12000.00 |
| John  | White | Manager    | 30000.00 |
| Susan | Brand | Manager    | 24000.00 |
| David | Ford  | Supervisor | 18000.00 |
+-------+-------+------------+----------+



select branchNo, count(staffNo) as myCount, sum(salary) as mySum from dreamhome.Staff group by branchNo order by branchNo;
+----------+---------+----------+
| branchNo | myCount | mySum    |
+----------+---------+----------+
| B003     |       3 | 54000.00 |
| B005     |       2 | 39000.00 |
| B007     |       1 |  9000.00 |
+----------+---------+----------+





 select * from dreamhome.Staff;
+---------+-------+-------+------------+------+------------+----------+----------+
| staffNo | fName | lName | position   | sex  | DOB        | salary   | branchNo |
+---------+-------+-------+------------+------+------------+----------+----------+
| SA9     | Mary  | Howe  | Assistant  | F    | 1970-02-19 |  9000.00 | B007     |
| SG14    | David | Ford  | Supervisor | M    | 1958-03-24 | 18000.00 | B003     |
| SG37    | Ann   | Beech | Assistant  | F    | 1960-11-10 | 12000.00 | B003     |
| SG5     | Susan | Brand | Manager    | F    | 1940-06-03 | 24000.00 | B003     |
| SL21    | John  | White | Manager    | M    | 1945-10-01 | 30000.00 | B005     |
| SL41    | Julie | Lee   | Assistant  | F    | 1965-06-13 |  9000.00 | B005     |

+---------+-------+-------+------------+------+------------+----------+----------+

select branchNo, count(staffNo) as myCount, sum(salary) as mySum from dreamhome.Staff group by branchNo order by branchNo;
+----------+---------+----------+
| branchNo | myCount | mySum    |
+----------+---------+----------+
| B003     |       3 | 54000.00 |
| B005     |       2 | 39000.00 |
| B007     |       1 |  9000.00 |
+----------+---------+----------+

 select count(sex) from Staff where sex='F';
+------------+
| count(sex) |
+------------+
|          4 |
+------------+


select count(sex) from Staff where sex='M';
+------------+
| count(sex) |
+------------+
|          2 |
+------------+


select sex,count(sex) from Staff group by sex,position;
+------+------------+
| sex  | count(sex) |
+------+------------+
| F    |          3 |
| F    |          1 |
| M    |          1 |
| M    |          1 |
+------+------------+


select sex,count(sex) from Staff group by sex;
+------+------------+
| sex  | count(sex) |
+------+------------+
| F    |          4 |
| M    |          2 |
+------+------------+


select sex,count(sex) from Staff group by sex,position;
+------+------------+
| sex  | count(sex) |
+------+------------+
| F    |          3 |
| F    |          1 |
| M    |          1 |
| M    |          1 |
+------+------------+


select sex,position,count(sex) from Staff group by sex,position;
+------+------------+------------+
| sex  | position   | count(sex) |
+------+------------+------------+
| F    | Assistant  |          3 |
| F    | Manager    |          1 |
| M    | Manager    |          1 |
| M    | Supervisor |          1 |
+------+------------+------------+


select sex,position,count(sex) from Staff where dob < '1968-01-01' group by sex, position;
+------+------------+------------+
| sex  | position   | count(sex) |
+------+------------+------------+
| F    | Assistant  |          2 |
| F    | Manager    |          1 |
| M    | Manager    |          1 |
| M    | Supervisor |          1 |
+------+------------+------------+


select sex,position,count(sex) from Staff where dob < '1968-01-01' group by sex, position having count(sex) >=2;
+------+-----------+------------+
| sex  | position  | count(sex) |
+------+-----------+------------+
| F    | Assistant |          2 |
+------+-----------+------------+


select sex,position,count(sex) as ct from Staff where dob < '1968-01-01' group by sex, position having count(sex) >=2;
+------+-----------+----+
| sex  | position  | ct |
+------+-----------+----+
| F    | Assistant |  2 |
+------+-----------+----+



select * from Viewing;
+----------+------------+------------+----------------+
| clientNo | propertyNo | viewDate   | comment        |
+----------+------------+------------+----------------+
| CR56     | PA14       | 2013-05-24 | too small      |
| CR56     | PG36       | 2013-04-28 |                |
| CR56     | PG4        | 2013-05-26 | NULL           |
| CR62     | PA14       | 2013-04-14 | no dining room |
| CR76     | PG4        | 2013-04-20 | too remote     |
+----------+------------+------------+----------------+

select * from Client;
+----------+-------+---------+---------------+---------+---------+------------------------+
| clientNo | fName | lName   | telNo         | preType | maxRent | eMail                  |
+----------+-------+---------+---------------+---------+---------+------------------------+
| CR56     | Aline | Stewart | 0141-848-1825 | Flat    |  350.00 | astewart@hotmal.com    |
| CR62     | Mary  | Tregear | 01224-196720  | Flat    |  600.00 | maryt@hotmail.co.uk    |
| CR74     | Mike  | Richie  | 01475-392178  | House   |  750.00 | mritchie01@yahoo.co.uk |
| CR76     | John  | Kay     | 0207-774-5632 | Flat    |  425.00 | john.kay@gmail.com     |
+----------+-------+---------+---------------+---------+---------+------------------------+


select clientno, fname, propertyno,comment from Client, Viewing;
ERROR 1052 (23000): Column 'clientno' in field list is ambiguous -- wrongtime erroe


select Client.clientno, fname, propertyno,comment from Client, Viewing;
+----------+-------+------------+----------------+
| clientno | fname | propertyno | comment        |
+----------+-------+------------+----------------+
| CR56     | Aline | PA14       | too small      |
| CR62     | Mary  | PA14       | too small      |
| CR74     | Mike  | PA14       | too small      |
| CR76     | John  | PA14       | too small      |
| CR56     | Aline | PG36       |                |
| CR62     | Mary  | PG36       |                |
| CR74     | Mike  | PG36       |                |
| CR76     | John  | PG36       |                |
| CR56     | Aline | PG4        | NULL           |
| CR62     | Mary  | PG4        | NULL           |
| CR74     | Mike  | PG4        | NULL           |
| CR76     | John  | PG4        | NULL           |
| CR56     | Aline | PA14       | no dining room |
| CR62     | Mary  | PA14       | no dining room |
| CR74     | Mike  | PA14       | no dining room |
| CR76     | John  | PA14       | no dining room |
| CR56     | Aline | PG4        | too remote     |
| CR62     | Mary  | PG4        | too remote     |
| CR74     | Mike  | PG4        | too remote     |
| CR76     | John  | PG4        | too remote     |
+----------+-------+------------+----------------+


select Client.clientno, fname, propertyno,comment from Client, Viewing order by Client.clientno;;
+----------+-------+------------+----------------+
| clientno | fname | propertyno | comment        |
+----------+-------+------------+----------------+
| CR56     | Aline | PG36       |                |
| CR56     | Aline | PG4        | too remote     |
| CR56     | Aline | PG4        | NULL           |
| CR56     | Aline | PA14       | too small      |
| CR56     | Aline | PA14       | no dining room |
| CR62     | Mary  | PA14       | too small      |
| CR62     | Mary  | PA14       | no dining room |
| CR62     | Mary  | PG36       |                |
| CR62     | Mary  | PG4        | too remote     |
| CR62     | Mary  | PG4        | NULL           |
| CR74     | Mike  | PG4        | too remote     |
| CR74     | Mike  | PG4        | NULL           |
| CR74     | Mike  | PA14       | too small      |
| CR74     | Mike  | PA14       | no dining room |
| CR74     | Mike  | PG36       |                |
| CR76     | John  | PG36       |                |
| CR76     | John  | PG4        | too remote     |
| CR76     | John  | PG4        | NULL           |
| CR76     | John  | PA14       | too small      |
| CR76     | John  | PA14       | no dining room |
+----------+-------+------------+----------------+


select Client.clientno, fname, propertyno,comment from Client, Viewing 
where Client.clientno=Viewing.clientno 
order by Client.clientno;

+----------+-------+------------+----------------+
| clientno | fname | propertyno | comment        |
+----------+-------+------------+----------------+
| CR56     | Aline | PG36       |                |
| CR56     | Aline | PG4        | NULL           |
| CR56     | Aline | PA14       | too small      |
| CR62     | Mary  | PA14       | no dining room |
| CR76     | John  | PG4        | too remote     |
+----------+-------+------------+----------------+



select Client.clientno, fname, propertyno,comment 
from Client c, Viewing v
where Client.clientno=Viewing.clientno 
order by Client.clientno;  -- syntax error


select Client.clientno, fname, propertyno,comment 
from Client c, Viewing v
where Client.c=v.clientno 
order by Client.clientno;



select * from Staff where branchNo in
  	( select branchNo from Staff where position='Manager');
+---------+-------+-------+------------+------+------------+----------+----------+
| staffNo | fName | lName | position   | sex  | DOB        | salary   | branchNo |
+---------+-------+-------+------------+------+------------+----------+----------+
| SG14    | David | Ford  | Supervisor | M    | 1958-03-24 | 18000.00 | B003     |
| SG37    | Ann   | Beech | Assistant  | F    | 1960-11-10 | 12000.00 | B003     |
| SG5     | Susan | Brand | Manager    | F    | 1940-06-03 | 24000.00 | B003     |
| SL21    | John  | White | Manager    | M    | 1945-10-01 | 30000.00 | B005     |
| SL41    | Julie | Lee   | Assistant  | F    | 1965-06-13 |  9000.00 | B005     |
+---------+-------+-------+------------+------+------------+----------+---------

--In subquery, the second query runs first.



select * from Staff limit 2;
+---------+-------+-------+------------+------+------------+----------+----------+
| staffNo | fName | lName | position   | sex  | DOB        | salary   | branchNo |
+---------+-------+-------+------------+------+------------+----------+----------+
| SA9     | Mary  | Howe  | Assistant  | F    | 1970-02-19 |  9000.00 | B007     |
| SG14    | David | Ford  | Supervisor | M    | 1958-03-24 | 18000.00 | B003     |
+---------+-------+-------+------------+------+------------+----------+---------



select * from CUSTOMERS;
+----+-----------------+-----------------+---------+-------+
| Id | Name            | Address         | City    | State |
+----+-----------------+-----------------+---------+-------+
|  1 | Joe Smith       | 441 Central Ave | Union   | NJ    |
|  2 | Mary Lee        | 31 Morris Ave   | Newark  | TX    |
|  3 | Ann Wong        | 19 North Rd     | Edison  | CA    |
|  4 | Michelle Arthur | 25 oak Street   | Orange  | WA    |
|  5 | Julie Tang      | 810 Wood St     | Boston  | MA    |
|  6 | Arnold Head     | 233 Spring St   | Dallas  | TX    |
|  7 | Bob Bender      | 8794 Garfield   | Chicago | IL    |
+----+-----------------+-----------------+---------+-------+




SELECT 'Customer', name, concat(Address, ', ',city, ', ',state)
    -> as Address FROM CUSTOMERS;
+----------+-----------------+----------------------------+
| Customer | name            | Address                    |
+----------+-----------------+----------------------------+
| Customer | Joe Smith       | 441 Central Ave, Union, NJ |
| Customer | Mary Lee        | 31 Morris Ave, Newark, TX  |
| Customer | Ann Wong        | 19 North Rd, Edison, CA    |
| Customer | Michelle Arthur | 25 oak Street, Orange, WA  |
| Customer | Julie Tang      | 810 Wood St, Boston, MA    |
| Customer | Arnold Head     | 233 Spring St, Dallas, TX  |
| Customer | Bob Bender      | 8794 Garfield, Chicago, IL |
+----------+-----------------+----------------------------+


SELECT 'Employee', concat(Fname,' ',Lname) as name,
    -> Address FROM EMPLOYEE;
+----------+------------------+----------------------------------+
| Employee | name             | Address                          |
+----------+------------------+----------------------------------+
| Employee | Jared James      | 123 Peachtree, Atlanta, GA       |
| Employee | Jon Jones        | 111 Allgood, Atlanta, GA         |
| Employee | Justin Mark      | 2342 May, Atlanta, GA            |
| Employee | Brad Knight      | 176 Main St., Atlanta, GA        |
| Employee | John Smith       | 731 Fondren, Houston, TX         |
| Employee | Evan Wallis      | 134 Pelham, Milwaukee, WI        |
| Employee | Josh Zell        | 266 McGrady, Milwaukee, WI       |
| Employee | Andy Vile        | 1967 Jordan, Milwaukee, WI       |
| Employee | Tom Brand        | 112 Third St, Milwaukee, WI      |
| Employee | Jenny Vos        | 263 Mayberry, Milwaukee, WI      |
| Employee | Chris Carter     | 565 Jordan, Milwaukee, WI        |
| Employee | Kim Grace        | 6677 Mills Ave, Sacramento, CA   |
| Employee | Jeff Chase       | 145 Bradbury, Sacramento, CA     |
| Employee | Franklin Wong    | 638 Voss, Houston, TX            |
| Employee | Alex Freed       | 4333 Pillsbury, Milwaukee, WI    |
| Employee | Bonnie Bays      | 111 Hollow, Milwaukee, WI        |
| Employee | Alec Best        | 233 Solid, Milwaukee, WI         |
| Employee | Sam Snedden      | 987 Windy St, Milwaukee, WI      |
| Employee | Joyce English    | 5631 Rice Oak, Houston, TX       |
| Employee | John James       | 7676 Bloomington, Sacramento, CA |
| Employee | Nandita Ball     | 222 Howard, Sacramento, CA       |
| Employee | Bob Bender       | 8794 Garfield, Chicago, IL       |
| Employee | Jill Jarvis      | 6234 Lincoln, Chicago, IL        |
| Employee | Kate King        | 1976 Boone Trace, Chicago, IL    |
| Employee | Lyle Leslie      | 417 Hancock Ave, Chicago, IL     |
| Employee | Billie King      | 556 Washington, Chicago, IL      |
| Employee | Jon Kramer       | 1988 Windy Creek, Seattle, WA    |
| Employee | Ray King         | 213 Delk Road, Seattle, WA       |
| Employee | Gerald Small     | 122 Ball Street, Dallas, TX      |
| Employee | Arnold Head      | 233 Spring St, Dallas, TX        |
| Employee | Helga Pataki     | 101 Holyoke St, Dallas, TX       |
| Employee | Naveen Drew      | 198 Elm St, Philadelphia, PA     |
| Employee | Carl Reedy       | 213 Ball St, Philadelphia, PA    |
| Employee | Sammy Hall       | 433 Main Street, Miami, FL       |
| Employee | Red Bacher       | 196 Elm Street, Miami, FL        |
| Employee | Ramesh Narayan   | 971 Fire Oak, Humble, TX         |
| Employee | James Borg       | 450 Stone, Houston, TX           |
| Employee | Jennifer Wallace | 291 Berry, Bellaire, TX          |
| Employee | Ahmad Jabbar     | 980 Dallas, Houston, TX          |
| Employee | Alicia Zelaya    | 3321 Castle, Spring, TX          |
+----------+------------------+----------------------------------+




select max(salary) from Staff;
+-------------+
| max(salary) |
+-------------+
|    30000.00 |
+-------------+



select fname,salary from Staff where salary=30000;
+-------+----------+
| fname | salary   |
+-------+----------+
| John  | 30000.00 |
+-------+----------+







select count(staffNo) from Staff group by branchno;
+----------------+
| count(staffNo) |
+----------------+
|              3 |
|              2 |
|              1 |
+----------------+


select branchno, count(staffNo) from Staff group by branchno;
+----------+----------------+
| branchno | count(staffNo) |
+----------+----------------+
| B003     |              3 |
| B005     |              2 |
| B007     |              1 |
+----------+----------------+


select b.city, count(staffNo) from Staff s, Branch b where s.branchno=b.branchno group by b.city;
+----------+----------------+
| city     | count(staffNo) |
+----------+----------------+
| Aberdeen |              1 |
| Glasgow  |              3 |
| London   |              2 |
+----------+----------------+



select * from Branch natural join Staff;
+----------+------------------+----------+----------+---------+-------+-------+------------+------+------------+----------+
| branchNo | street           | city     | postcode | staffNo | fName | lName | position   | sex  | DOB        | salary   |
+----------+------------------+----------+----------+---------+-------+-------+------------+------+------------+----------+
| B007     | 16 Argyll Street | Aberdeen | AB2 3SU  | SA9     | Mary  | Howe  | Assistant  | F    | 1970-02-19 |  9500.00 |
| B003     | 163 Main Street  | Glasgow  | G11 9QX  | SG14    | David | Ford  | Supervisor | M    | 1958-03-24 | 18000.00 |
| B003     | 163 Main Street  | Glasgow  | G11 9QX  | SG37    | Ann   | Beech | Assistant  | F    | 1960-11-10 | 12000.00 |
| B003     | 163 Main Street  | Glasgow  | G11 9QX  | SG5     | Susan | Brand | Manager    | F    | 1940-06-03 | 24000.00 |
| B005     | 22 Deer Road     | London   | SW1 4EH  | SL21    | John  | White | Manager    | M    | 1945-10-01 | 30000.00 |
| B005     | 22 Deer Road     | London   | SW1 4EH  | SL41    | Julie | Lee   | Assistant  | F    | 1965-06-13 |  9000.00 |
+----------+------------------+----------+----------+---------+-------+-------+------------+------+------------+----------+



select * from Branch b, Staff s where s.branchno=b.branchno;
+----------+------------------+----------+----------+---------+-------+-------+------------+------+------------+----------+----------+
| branchNo | street           | city     | postcode | staffNo | fName | lName | position   | sex  | DOB        | salary   | branchNo |
+----------+------------------+----------+----------+---------+-------+-------+------------+------+------------+----------+----------+
| B007     | 16 Argyll Street | Aberdeen | AB2 3SU  | SA9     | Mary  | Howe  | Assistant  | F    | 1970-02-19 |  9500.00 | B007     |
| B003     | 163 Main Street  | Glasgow  | G11 9QX  | SG14    | David | Ford  | Supervisor | M    | 1958-03-24 | 18000.00 | B003     |
| B003     | 163 Main Street  | Glasgow  | G11 9QX  | SG37    | Ann   | Beech | Assistant  | F    | 1960-11-10 | 12000.00 | B003     |
| B003     | 163 Main Street  | Glasgow  | G11 9QX  | SG5     | Susan | Brand | Manager    | F    | 1940-06-03 | 24000.00 | B003     |
| B005     | 22 Deer Road     | London   | SW1 4EH  | SL21    | John  | White | Manager    | M    | 1945-10-01 | 30000.00 | B005     |
| B005     | 22 Deer Road     | London   | SW1 4EH  | SL41    | Julie | Lee   | Assistant  | F    | 1965-06-13 |  9000.00 | B005     |
+----------+------------------+----------+----------+---------+-------+-------+------------+------+------------+----------+----------+





select *
from
(select clientNo, fame, IName from Client) t1,
(select clientNo, propertyNo, comment from Viewing) t2


select *
from
(select cl1entNo, fName,
IName from Client) t1,
(select clientNo, propertyNo, comment from Viewing) t2 where









