select * from cardio_base;

-- Avg weight for each age group

Select age, round(avg(weight)) as Average_Weight from cardio_base
Group by age
order by age;

-- Descriptive Statistics & Distributions
-- What is the average height and weight for males and females?

SELECT gender, avg(height) AS Average_height FROM cardio_base
Group by gender;

SELECT gender, avg(weight) AS Average_weight FROM cardio_base
Group by gender;

-- What is the distribution of cholesterol levels across different age groups?
SELECT age, count(cholesterol) AS "No. of individuals with Cholesterol", cholesterol FROM cardio_base
Group by age, cholesterol
Order by age;

-- What percentage of people in the dataset are smokers?

SELECT 
(SELECT count(*) AS Smokers FROM cardio_base WHERE smoke=1) * 100 /
(SELECT count(*) AS 'Non-Smokers' FROM cardio_base WHERE smoke=0)  AS "%_of_Smokers";

SELECT count(*) AS Smokers FROM cardio_base WHERE smoke=1;
SELECT count(*) AS 'Non-Smokers' FROM cardio_base WHERE smoke=0;


-- Comparisons & Correlations
-- Do smokers tend to have higher cholesterol levels compared to non-smokers?

Select count(cholesterol), cholesterol, smoke FROM cardio_base
Group by cholesterol, smoke ;

-- How does BMI (Body Mass Index) differ between males and females? (BMI = weight / (height/100)^2)

SELECT * FROM cardio_base;

SELECT round(weight/(Power((height/100),2))) AS BMI, gender from cardio_base;

SELECT avg(round(weight/(Power((height/100),2)))) AS BMI, gender from cardio_base
Group by gender;

-- Does age have a correlation with cholesterol levels?
Select age, cholesterol FROM cardio_base;


-- Hypothesis Testing & Trends
-- Do males have a higher smoking rate than females?
	-- Smoking rate Males (number of males as smokers / total number of males)

SELECT * FROM cardio_base;

-- Male
SELECT count(gender) into @No_of_males FROm cardio_base WHERE gender = 1;

-- Female
SELECT count(gender) into @No_of_females FROm cardio_base WHERE gender = 2;

-- Male Smokers
SELECT count(gender) into @No_of_males_smokers FROM cardio_base WHERE gender = 1 AND smoke = 1;

Select count(gender), smoke, gender, @No_of_males, @No_of_females  FROM cardio_base
WHERE smoke = 1
group by smoke, gender;

-- Does high cholesterol (level 3) correlate with high blood pressure?
SELECT cholesterol, ap_hi, gender from cardio_base
WHERE cholesterol = 3;


-- Are older individuals (above 50) more likely to have high blood pressure than younger ones?

SELECT age, avg(ap_hi) FROM cardio_base
Group by age;

-- Are smokers more likely to have high blood pressure than non-smokers?

SELECT gender, smoke, avg(ap_hi) FROm cardio_base
Group by smoke, gender;
 

