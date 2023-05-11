USE projectdb;

-- q1
WITH k AS (
    SELECT 
        COUNT(code_gender) as gc,
        code_gender,
        target
    FROM application_data ad
    GROUP BY code_gender, target
)
INSERT OVERWRITE LOCAL DIRECTORY 'output/q1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT * FROM k;

-- q2
INSERT OVERWRITE LOCAL DIRECTORY 'output/q2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
select children01.no_children_target1 / sum(children01.no_children_target1 + children11.children_target1) children0_target1_ratio,
       children11.children_target1 / sum(children01.no_children_target1 + children11.children_target1 ) children1_target1_ratio
from (
        select count(cnt_children) as no_children_target1
        from application_data
        where cnt_children = 0 and target = 1
    ) as children01,
    (
        select count(cnt_children) as children_target1
        from application_data
        where cnt_children = 1 and target = 1
    ) as children11
group by children01.no_children_target1, children11.children_target1;

-- q3
INSERT OVERWRITE LOCAL DIRECTORY 'output/q3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
select 
    count(name_income_type) / (a.n) woking_ratio_target1
from 
    (
        select sum(target) n 
        from application_data 
        where target=1
    ) as a, application_data
where 
    name_income_type = 'Working' and target = 1
group by a.n;

-- q4
INSERT OVERWRITE LOCAL DIRECTORY 'output/q4'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
select a2030.age20_30 / (a.n) age_20_30,
       a3040.age30_40 / (a.n) age30_40,
       a4050.age40_50 / (a.n) age40_50,
       a5060.age50_60 / (a.n) age50_60,
       a60_.age_60_ / (a.n) age_60_
from
    (
        select count(days_birth) age20_30
        from application_data
        where target = 1 and days_birth > -11328 and days_birth <= -7678
    ) as a2030,
    (
        select count(days_birth) age30_40
        from application_data
        where target = 1 and days_birth > -15978 and days_birth <= -1132
    ) as a3040,
    (
        select count(days_birth) age40_50
        from application_data
        where target = 1 and days_birth > -18628 and days_birth <= -15978
    )as a4050,
    (
        select count(days_birth) age50_60
        from application_data
        where target = 1 and days_birth > -22278 and days_birth <= -18628
    )as a5060,
    (
        select count(days_birth) age_60_
        from application_data
        where target = 1 and days_birth <= -22278
    ) as a60_,
    (
        select sum(target) n from application_data where target=1
    ) as a
group by a.n, a2030.age20_30, a3040.age30_40, a4050.age40_50, a5060.age50_60, a60_.age_60_;

-- q5
INSERT OVERWRITE LOCAL DIRECTORY 'output/q5'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
select rented.n / a.n rented_ap, co_op.n / a.n co_op_ap, office.n / a.n office_ap,
       municip.n / a.n municip_ap, parents.n / a.n parents_with, h_apart.n / a.n house_apart
from
    (
        select count(name_housing_type) n
        from application_data
        where target = 1 and name_housing_type = 'Rented apartment'
    ) as rented,
    (
        select count(name_housing_type) n
        from application_data
        where target = 1 and name_housing_type = 'Co-op apartment'
    ) as co_op,
    (
        select count(name_housing_type) n
        from application_data
        where target = 1 and name_housing_type = 'Office apartment'
    ) as office,
    (
        select count(name_housing_type) n
        from application_data
        where target = 1 and name_housing_type = 'Municipal apartment'
    ) as municip,
    (
        select count(name_housing_type) n
        from application_data
        where target = 1 and name_housing_type = 'With parents'
    ) as parents,
    (
        select count(name_housing_type) n
        from application_data
        where target = 1 and name_housing_type = 'House / apartment'
    ) as h_apart,
    (
        select sum(target) n 
        from application_data 
        where target=1
    ) as a
order by rented_ap, co_op_ap, office_ap, municip_ap, parents_with, house_apart;

-- select 
--     a_avg.n_avg / sum(a_count.target) as ratio_n_of_people_with_loan_income_ratio_less_than_average
-- from
--     (
--         select count(1) as n_avg
--         from application_data as a
--         where a.target = 1 
--         and a.amt_credit / a.amt_income_total < 
--         (
--             select avg(amt_credit / amt_income_total) as cr_inc_ratio
--             from application_data
--             where target = 1
--         )
--     ) as a_avg,
--     application_data as a_count
-- group by a_avg.n_avg
-- having target = 1;