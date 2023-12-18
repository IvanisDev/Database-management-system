<? php
$sql ="Insert into Staff_demo01 values
    ('b1'. 'Austin', Huang', 'NULL', 'M', '2020-01-23', 40030, 'B01')";



$position=$_POST[‘position’];
if ($position == "" or $position==null)
   $sql ="   insert into Staff_demo01 (staffno,fname,lname,position) 
    values ('$staffno','$fname','$lname', NULL)";
else
  $sql ="   insert into Staff_demo01 (staffno,fname,lname,position) 
    values ('$staffno','$fname','$lname', '$position')";


?>