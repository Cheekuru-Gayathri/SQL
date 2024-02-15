SELECT * FROM org.insurance;
#1. Count for each categories of ‘region 
select region, count(region)as no_of_cust from insurance group by region;

#2. Find 50 records of highest ‘age’ and export data/table to desktop 
select * from insurance order by age desc limit 50;

#3. Add index name ‘quick’ on ‘id’ 
select * from insurance;
create index quick on insurance (id);

#4. Describe the schema of table 
describe insurance;
#5. Create view name as ‘gender’ where users can not see ‘sex’ [Hint: first run appropriate query then create view] 
create view gender as (select id, age, bmi, children, smoker, region, charges from insurance);
select * from gender;

#6. Rename the view as ‘type’ 
rename table gender to type;
select* from type;

#7. Count how many are ‘northwest’ insurance holders 
select count(*), region from insurance where region = 'northwest';

#8. Count how many insurance holders were ‘femail’
select count(*), sex from insurance where sex = 'female'; 

#9. Create Primary key on a suitable column 
alter table insurance modify id int primary key;

#10. Create a new column ‘ratio’ which is age multiply by bmi 
alter table insurance add column ratio double after bmi;
update insurance set ratio = round(age * bmi);
select * from insurance;

#11. Arrange the table from high to low according to charges
select * from insurance order by charges desc; 
#12. Find MAX of ‘charges’ 
select* from insurance where charges = (select max(charges) from insurance);

#13. Find MIN of ‘charges’ 
select min(charges) from insurance;

#14. Find average of ‘charges’ of male and female 
select sex, round(avg(charges),2) as avg_charges from insurance group by sex;

#15. Write a Query to rename column name sex to Gender
alter table insurance rename column sex to gender;
select* from insurance;

#16. Add new column as HL_Charges where more than average charges should be categorized as HIGH and less than average charges should be categorized as LOW 
alter table insurance add column hl_charges varchar(10);
select round(avg(charges)) from insurance;
update insurance set hl_charges = case when charges >= 13270 then 'high' else 'low' end;
select * from insurance;
select * from insurance where hl_charges is null;
 
#17. Change location/position of ‘smoker’ and bring before ‘children’
alter table insurance add column dummy varchar(10) after ratio;
update insurance set dummy = smoker;
 alter table insurance drop column smoker;
 alter table insurance rename column dummy to smoker;
 select * from insurance;
 
#18. Show top 20 records
 select * from insurance order by charges desc limit 20;
#19. Show bottom 20 records 
select * from insurance order by charges asc limit 20;

#20. Randomly select 20% of records and export to desktop 
select* from insurance where id <= (select round(count(*)*.2,0) from insurance) order by rand();
select round(count(*)*.2,0) from insurance;
select * from insurance order by rand() limit 20;
#21. Remove column ‘ratio’ 
alter table insurance drop column ratio;
select * from insurance;

#22. Craete one example of Sub Queries involving ‘bmi’ and ‘sex’ and give explanation in the script itself with remarks by using # 
# write a sql queiry to detemine second highest bmi based on gender male
# extract those information whose bmi is less than the max of female bmi
select * from insurance;
select * from insurance where bmi<(select max(bmi) from insurance where gender = 'female');

#23. Create a view called Female_HL_Charges that shows only those data where HL_Charges is High, Female, Smokers and with 0 children 
create view female_hl_charges as (select * from insurance where hl_charges= 'high'and gender='female'and smoker='yes'and children=0);
select* from female_hl_charges;
#24. Update children column if there is 0 children then make it as Zero Children, if 1 then one_children, if 2 then two_children, if 3 then three_children, if 4 thenfour_children if 5 then five_children else print it as More_than_five_children.
alter table insurance modify children varchar(20);
update insurance set children = case when children =0 then 'zero children' when children =2 then 'two_children'when children =3 then 'three_children' when children =4 then 'four_children'else more_than_five_children;
select* from insurance;

#25. Mail the script to jeevan.raj@imarticus.com by EOD