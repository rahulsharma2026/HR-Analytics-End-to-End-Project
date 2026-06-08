CREATE DATABASE hr_analytics;
USE hr_analytics;

CREATE TABLE hr_data (
    Age INT,
    Attrition VARCHAR(5),
    BusinessTravel VARCHAR(30),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(15),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);



DROP TABLE IF EXISTS hr_data;


CREATE TABLE hr_data (
    Age INT,
    Attrition VARCHAR(5),
    BusinessTravel VARCHAR(30),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(15),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);
SELECT COUNT(*) FROM hr_data;

SELECT 
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Attrition_Rate_Percent
FROM hr_data;

SELECT 
    OverTime,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Attrition_Rate
FROM hr_data
GROUP BY OverTime;

SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low (Under 3K)'
        WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN 'Mid (3K-6K)'
        WHEN MonthlyIncome BETWEEN 6001 AND 10000 THEN 'High (6K-10K)'
        ELSE 'Very High (10K+)'
    END AS Salary_Range,
    COUNT(*) AS Total,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Attrition_Rate
FROM hr_data
GROUP BY Salary_Range
ORDER BY Attrition_Rate DESC;

SELECT 
    JobRole,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Attrition_Rate
FROM hr_data
GROUP BY JobRole
ORDER BY Attrition_Rate DESC;

SELECT 
    Gender,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Attrition_Rate
FROM hr_data
GROUP BY Gender;

SELECT 
    CASE 
        WHEN YearsAtCompany <= 2 THEN '0-2 Years (New)'
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '10+ Years (Senior)'
    END AS Tenure_Group,
    COUNT(*) AS Total,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Attrition_Rate
FROM hr_data
GROUP BY Tenure_Group
ORDER BY Attrition_Rate DESC;

SELECT 
    WorkLifeBalance,
    CASE WorkLifeBalance
        WHEN 1 THEN 'Bad'
        WHEN 2 THEN 'Good'
        WHEN 3 THEN 'Better'
        WHEN 4 THEN 'Best'
    END AS WLB_Label,
    COUNT(*) AS Total,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS Attrition_Rate
FROM hr_data
GROUP BY WorkLifeBalance, WLB_Label
ORDER BY WorkLifeBalance;

SELECT 
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    OverTime,
    YearsAtCompany,
    WorkLifeBalance,
    JobSatisfaction
FROM hr_data
WHERE 
    Attrition = 'No'
    AND OverTime = 'Yes'
    AND MonthlyIncome < 5000
    AND JobSatisfaction <= 2
ORDER BY MonthlyIncome ASC
LIMIT 10;













