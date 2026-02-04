-- database creation
Create database hospital_mng_analysis;
use hospital_mng_analysis;

SELECT COUNT(*) AS total_patients FROM hospitalpatient;
SELECT * FROM hospitalpatient LIMIT 10;

-- Queries
-- Patient Count by Gender
SELECT 
    Gender,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hospitalpatient), 2) AS percentage
FROM hospitalpatient
GROUP BY Gender;

-- Top 10 Most Common Medical Conditions
SELECT 
    `Condition`,
    COUNT(*) AS patient_count,
    ROUND(AVG(`Total_Cost`), 2) AS avg_treatment_cost
FROM `hospitalpatient`
GROUP BY `Condition`
ORDER BY patient_count DESC
LIMIT 10;

-- Average Hospital Stay by Condition
SELECT 
    `Condition`,
    COUNT(*) AS total_patients,
    ROUND(AVG(Length_of_Stay), 2) AS avg_stay_days,
    MAX(Length_of_Stay) AS max_stay_days
FROM hospitalpatient
GROUP BY `Condition`
ORDER BY avg_stay_days DESC
LIMIT 5;

-- Total Revenue by Year
SELECT 
    Year_of_Admission,
    COUNT(*) AS total_admissions,
    SUM(Total_Cost) AS total_revenue,
    ROUND(AVG(Total_Cost), 2) AS avg_cost_per_patient
FROM hospitalpatient
GROUP BY Year_of_Admission
ORDER BY Year_of_Admission;

-- State-wise Patient Analysis
SELECT 
    Patient_State,
    COUNT(*) AS patient_count,
    SUM(Total_Cost) AS total_revenue,
    ROUND(AVG(Total_Cost), 2) AS avg_cost,
    ROUND(AVG(Length_of_Stay), 2) AS avg_stay_days
FROM hospitalpatient
GROUP BY Patient_State
ORDER BY patient_count DESC
LIMIT 10;

-- Insurance Claim Comparison
SELECT 
    Insurance_Claimed,
    COUNT(*) AS patient_count,
    ROUND(AVG(Total_Cost), 2) AS avg_cost,
    ROUND(AVG(Length_of_Stay), 2) AS avg_stay,
    ROUND(AVG(Satisfaction), 2) AS avg_satisfaction_rating,
    SUM(CASE WHEN Outcome = 'Recovered' THEN 1 ELSE 0 END) AS recovered_patients
FROM hospitalpatient
GROUP BY Insurance_Claimed;

-- Treatment Outcome Distribution
SELECT 
    Outcome,
    COUNT(*) AS patient_count,
    ROUND(AVG(Length_of_Stay), 2) AS avg_stay,
    ROUND(AVG(Total_Cost), 2) AS avg_cost,
    ROUND(AVG(Satisfaction), 2) AS avg_satisfaction,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hospitalpatient), 2) AS outcome_percentage
FROM hospitalpatient
GROUP BY Outcome;

-- Readmission Rate Analysis
SELECT 
    `Condition`,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END) AS readmitted_patients,
    SUM(CASE WHEN Readmission = 'No' THEN 1 ELSE 0 END) AS not_readmitted,
    ROUND(SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM hospitalpatient
GROUP BY `Condition`
HAVING total_patients >= 10
ORDER BY readmission_rate_percent DESC;