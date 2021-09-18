proc sql; 
create table male as select date_trunc('week', occurred_at) as week, 
count distinct(case when customerN = 1 then male as) 
from sales where e.customer_type = 'purchased' and e.paid_status in ('cash', 'credit')
group by 1 
order by 1 limit 1000 
quit; 
run;

proc sql; create table female as select date_trunc('week', occurred_at) as week, count distinct(case when customerN = 2 then female as) 
from sales 
where e.customer_type = 'purchased' and e.paid_status in ('cash', 'credit') 
group by 1 
order by 1 
limit 1000 
quit; 
run;

proc sql data = male outobs=1000; 
create table male_paid_expect as 
select * from male 
where e.paid_status order by ranuni(0); 
quit;

proc sql data = female outobs=1000; 
create table female_paid_expect as 
select * from female 
where e.paid_status 
order by ranuni(0); 
quit;

proc sql; 
create table final_expectation_sheet as select * from male_paid_expect union (select * from female_paid_expect); quit;

title; 
footnote; 
title1 h=10pt f=tahoma j=left 'SAS-code practice' j=right 'Protocol No: G-2021-923-JEON'; title2 h=10pt f=tahoma j=left 'OPENSOURCE' j=right 'NON-Confidential'; title4 h=14pt f=tahoma bold j=center 'Practice Sheet'; title6 h=10pt f=tahoma j=right 'Date: ~{nbspace 30} (Signature)';
