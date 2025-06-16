select * from insurance_data;

select avg(charges), min(charges), max(charges) from insurance_data
where smoker = 'yes'


select smoker, count(smoker) from insurance_data
group by smoker

select region, sex, avg(bmi) 
from insurance_data
group by region, sex
order by sex


select sum(charges), region from insurance_data
group by region

select count(sex), age from insurance_data
group by age


select avg(charges), region, smoker
from insurance_data
group by region, smoker


SELECT region, AVG(charges) AS avg_charges
FROM insurance_data
WHERE smoker = 'yes'
GROUP BY region
ORDER BY avg_charges DESC
LIMIT 1;


WITH region_avgs AS (
  SELECT region, AVG(charges) AS avg_charges
  FROM insurance_data
  WHERE smoker = 'yes'
  GROUP BY region
)
SELECT region, avg_charges
FROM region_avgs
WHERE avg_charges = (
  SELECT MAX(avg_charges) FROM region_avgs
);


with NS_BMI as (
    select bmi, count(sex), avg(bmi) from insurance_data
    where smoker = 'no'
)
select count(sex), NS_BMI
from NS_BMI
where bmi > NS_BMI


WITH NS_BMI AS (
    SELECT AVG(bmi) AS avg_bmi
    FROM insurance_data
    WHERE smoker = 'no'
)

SELECT COUNT(*) AS count_above_avg_bmi
FROM insurance_data, NS_BMI
WHERE smoker = 'no'
  AND bmi > NS_BMI.avg_bmi;


select region, avg(charges)
from insurance_data
group by region
order by avg(charges) DESC
limit 1

WITH bmi_75th AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY bmi) AS bmi_cutoff
    FROM insurance_data
)

SELECT AVG(insurance_data.children) AS avg_children
FROM insurance_data
CROSS JOIN bmi_75th
WHERE insurance_data.bmi > bmi_75th.bmi_cutoff;



select *
from insurance_data
where smoker = 'no' and bmi < 25 and region ilike 'northwest'
order by charges DESC
limit 10


with twochildren as (
    select * from insurance_data
    where children <= 2
)
select avg(charges), smoker, region
from twochildren
group by smoker, region
order by region


select avg(charges), smoker
from insurance_data
group by smoker

SELECT
  (AVG(CASE WHEN smoker = 'yes' THEN charges END) -
   AVG(CASE WHEN smoker = 'no' THEN charges END)) /
   AVG(CASE WHEN smoker = 'no' THEN charges END) * 100 AS percent_diff
FROM insurance_data;



