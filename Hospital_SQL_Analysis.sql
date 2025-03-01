UPDATE patient_survival.ps_data
SET ethnicity = CASE
    WHEN ethnicity = '' THEN 'Mixed'
    ELSE ethnicity
END;

-- Calculate total hospital deaths and the corresponding mortality rate
SELECT COUNT(CASE WHEN hospital_death = 1 THEN 1 END) AS total_hospital_deaths, 
ROUND(COUNT(CASE WHEN hospital_death = 1 THEN 1 END) * 100.0 / COUNT(*), 2) AS mortality_rate
FROM patient_survival.ps_data;

-- Count deaths by ethnicity
SELECT ethnicity, COUNT(hospital_death) AS total_hospital_deaths
FROM patient_survival.ps_data
WHERE hospital_death = '1'
GROUP BY ethnicity;

-- Count deaths by gender
SELECT gender, COUNT(hospital_death) AS total_hospital_deaths
FROM patient_survival.ps_data
WHERE hospital_death = '1'
GROUP BY gender;

-- Compare average and maximum ages of deceased and surviving patients
SELECT ROUND(AVG(age), 2) AS avg_age,
MAX(age) AS max_age, 
hospital_death
FROM patient_survival.ps_data
WHERE hospital_death = '1'
GROUP BY hospital_death
UNION
SELECT ROUND(AVG(age), 2) AS avg_age,
MAX(age) AS max_age, 
hospital_death
FROM patient_survival.ps_data
WHERE hospital_death = '0'
GROUP BY hospital_death;

-- Count of deaths and survivals by age
SELECT age,
    COUNT(CASE WHEN hospital_death = '1' THEN 1 END) AS amount_that_died,
    COUNT(CASE WHEN hospital_death = '0' THEN 1 END) AS amount_that_survived
FROM patient_survival.ps_data
GROUP BY age
ORDER BY age ASC;

-- Age distribution in 10-year intervals
SELECT
    CONCAT(FLOOR(age / 10) * 10, '-', FLOOR(age / 10) * 10 + 9) AS age_interval,
    COUNT(*) AS patient_count
FROM patient_survival.ps_data
GROUP BY age_interval
ORDER BY age_interval;

-- Count of patients over 65 who died vs those aged 50-65 who died
SELECT COUNT(CASE WHEN age > 65 AND hospital_death = '0' THEN 1 END) AS survived_over_65,
       COUNT(CASE WHEN age BETWEEN 50 AND 65 AND hospital_death = '0' THEN 1 END) AS survived_between_50_and_65,
       COUNT(CASE WHEN age > 65 AND hospital_death = '1' THEN 1 END) AS died_over_65,
       COUNT(CASE WHEN age BETWEEN 50 AND 65 AND hospital_death = '1' THEN 1 END) AS died_between_50_and_65
FROM patient_survival.ps_data;

-- Average probability of hospital death by age group
SELECT
    CASE
        WHEN age < 40 THEN 'Under 40'
        WHEN age >= 40 AND age < 60 THEN '40-59'
        WHEN age >= 60 AND age < 80 THEN '60-79'
        ELSE '80 and above'
    END AS age_group,
    ROUND(AVG(apache_4a_hospital_death_prob), 3) AS average_death_prob
FROM patient_survival.ps_data
GROUP BY age_group;

-- Identify ICU admit sources with the highest death counts
SELECT icu_admit_source,
    COUNT(CASE WHEN hospital_death = '1' THEN 1 END) AS amount_that_died,
    COUNT(CASE WHEN hospital_death = '0' THEN 1 END) AS amount_that_survived
FROM patient_survival.ps_data
GROUP BY icu_admit_source;

-- Average age and death count for each ICU admit source
SELECT icu_admit_source,
    COUNT(hospital_death) AS amount_that_died,
    ROUND(AVG(age), 2) AS avg_age
FROM patient_survival.ps_data
WHERE hospital_death = '1'
GROUP BY icu_admit_source;

-- Average age and death count for each ICU type
SELECT icu_type,
    COUNT(hospital_death) AS amount_that_died,
    ROUND(AVG(age), 2) AS avg_age
FROM patient_survival.ps_data
WHERE hospital_death = '1'
GROUP BY icu_type;

-- Average weight, BMI, and maximum heart rate of deceased patients
SELECT ROUND(AVG(weight), 2) AS avg_weight,
    ROUND(AVG(bmi), 2) AS avg_bmi, 
    ROUND(AVG(d1_heartrate_max), 2) AS avg_max_heartrate
FROM patient_survival.ps_data
WHERE hospital_death = '1';

-- Top 5 ethnicities with the highest average BMI
SELECT ethnicity,
    ROUND(AVG(bmi), 2) AS average_bmi
FROM patient_survival.ps_data
GROUP BY ethnicity
ORDER BY average_bmi DESC
LIMIT 5;

-- Count of patients with each comorbidity
SELECT
    SUM(aids) AS patients_with_aids,
    SUM(cirrhosis) AS patients_with_cirrhosis,
    SUM(diabetes_mellitus) AS patients_with_diabetes,
    SUM(hepatic_failure) AS patients_with_hepatic_failure,
    SUM(immunosuppression) AS patients_with_immunosuppression,
    SUM(leukemia) AS patients_with_leukemia,
    SUM(lymphoma) AS patients_with_lymphoma,
    SUM(solid_tumor_with_metastasis) AS patients_with_solid_tumor
FROM patient_survival.ps_data;

-- Percentage of patients with each comorbidity among those who died
SELECT
    ROUND(SUM(CASE WHEN aids = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS aids_percentage,
    ROUND(SUM(CASE WHEN cirrhosis = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cirrhosis_percentage,
    ROUND(SUM(CASE WHEN diabetes_mellitus = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS diabetes_percentage,
    ROUND(SUM(CASE WHEN hepatic_failure = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS hepatic_failure_percentage,
    ROUND(SUM(CASE WHEN immunosuppression = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS immunosuppression_percentage,
    ROUND(SUM(CASE WHEN leukemia = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS leukemia_percentage,
    ROUND(SUM(CASE WHEN lymphoma = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS lymphoma_percentage,
    ROUND(SUM(CASE WHEN solid_tumor_with_metastasis = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS solid_tumor_percentage
FROM patient_survival.ps_data
WHERE hospital_death = 1;

-- Calculate the overall mortality rate
SELECT
    COUNT(CASE WHEN hospital_death = 1 THEN 1 END) * 100.0 / COUNT(*) AS mortality_rate
FROM patient_survival.ps_data;

-- Percentage of patients who had elective surgery
SELECT
    COUNT(CASE WHEN elective_surgery = 1 THEN 1 END) * 100.0 / COUNT(*) AS elective_surgery_percentage
FROM patient_survival.ps_data;

-- Average weight and height for male and female patients who had elective surgery
SELECT
    ROUND(AVG(CASE WHEN gender = 'M' THEN weight END), 2) AS avg_weight_male,
    ROUND(AVG(CASE WHEN gender = 'M' THEN height END), 2) AS avg_height_male,
    ROUND(AVG(CASE WHEN gender = 'F' THEN weight END), 2) AS avg_weight_female,
    ROUND(AVG(CASE WHEN gender = 'F' THEN height END), 2) AS avg_height_female
FROM patient_survival.ps_data
WHERE elective_surgery = 1;

-- Top 10 ICUs with the highest hospital death probability
SELECT icu_id, 
    apache_4a_hospital_death_prob AS hospital_death_prob
FROM patient_survival.ps_data
ORDER BY apache_4a_hospital_death_prob DESC
LIMIT 10;

-- Average length of stay in each ICU for patients who survived and those who did not
SELECT
    icu_type,
    ROUND(AVG(CASE WHEN hospital_death = 1 THEN pre_icu_los_days END), 2) AS avg_icu_stay_death,
    ROUND(AVG(CASE WHEN hospital_death = 0 THEN pre_icu_los_days END), 2) AS avg_icu_stay_survived
FROM patient_survival.ps_data
GROUP BY icu_type
ORDER BY icu_type;

-- Average BMI for deceased patients by ethnicity (excluding null values)
SELECT
    ethnicity,
    ROUND(AVG(bmi), 2) AS average_bmi
FROM patient_survival.ps_data
WHERE bmi IS NOT NULL
AND hospital_death = '1'
GROUP BY ethnicity;

-- Death percentage for each ethnicity
SELECT
    ethnicity,
    ROUND(COUNT(CASE WHEN hospital_death = 1 THEN 1 END) * 100.0 / (SELECT COUNT(*) FROM patient_survival.ps_data), 2) AS death_percentage
FROM patient_survival.ps_data
GROUP BY ethnicity;

-- Count of patients in each BMI category based on their BMI value
SELECT
    COUNT(*) AS patient_count,
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi >= 18.5 AND bmi < 25 THEN 'Normal'
        WHEN bmi >= 25 AND bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category
FROM (
    SELECT
        patient_id,
        ROUND(bmi, 2) AS bmi
    FROM patient_survival.ps_data
    WHERE bmi IS NOT NULL
) AS subquery
GROUP BY bmi_category;

-- Hospital death probabilities for patients in 'SICU' with BMI over 30
SELECT
    patient_id,
    apache_4a_hospital_death_prob AS hospital_death_prob
FROM patient_survival.ps_data
WHERE icu_type = 'SICU' AND bmi > 30
ORDER BY hospital_death_prob DESC;
