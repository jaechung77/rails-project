SELECT t.* from teachings t
EXCEPT
SELECT t2.* 
FROM (teachings as t2   
inner join   enrolments 
on enrolments.teaching_id = t2.id);