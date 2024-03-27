USE life_science;

-- All samples in  February ------------------
SELECT sample_id,
	company_name, 
	num_sample, 
	samples.test_name, 
	receive_date, 
	result, test_type,
	department
FROM samples
JOIN customers ON samples.customerID = customers.customerID
JOIN tests ON samples.test_name = tests.test_name
WHERE receive_date >= '2024-02-01' 
	AND receive_date <= '2024-02-28'


-- Number of customers that sent samples in this month ----------------
SELECT COUNT(DISTINCT customerID) AS count
FROM samples
WHERE receive_date >= '2024-02-01' 
	AND receive_date <= '2024-02-28'


-- which customer send the most sample in February ----------------
SELECT DISTINCT company_name,  SUM(num_sample) as 'num of samples'
FROM samples JOIN customers ON samples.customerID = customers.customerID
WHERE receive_date >= '2024-02-01' 
	AND receive_date <= '2024-02-28'
GROUP BY company_name
ORDER BY SUM(num_sample) DESC




-- List of all positive samples (Pathogens) --------------
SELECT sample_id, 
	company_name, 
	test_name, 
	result, 
	receive_date, 
	report_date, 
	DATEDIFF(day,receive_date, report_date) AS 'days reported'
FROM samples
JOIN customers on samples.customerID = customers.customerID
WHERE result = 'Positive' 
	AND receive_date >= '2024-02-01' 
	AND receive_date <= '2024-02-28'



-- All micro quantitative samples that have higher count than 1 -------
SELECT sample_id, company_name, test, result, receive_date
FROM
(
SELECT sample_id, company_name, 
	samples.test_name AS test, 
	result, 
	receive_date, 
	report_date, 
	DATEDIFF(day,receive_date, report_date) AS 'days reported'
FROM samples
JOIN customers on samples.customerID = customers.customerID
JOIN tests on samples.test_name = tests.test_name
WHERE result NOT IN ('Positive', 'Negative') AND department = 'micro'
	AND receive_date >= '2024-02-01' 
	AND receive_date <= '2024-02-28')  AS subquery
WHERE result NOT LIKE '%<%';


-- All  chemistry samples-----
SELECT sample_id, company_name, test_name, result, receive_date, report_date, 
	DATEDIFF(day,receive_date, report_date) AS 'days reported'
FROM samples
JOIN customers on samples.customerID = customers.customerID
WHERE test_name IN ('Aflatoxin', 'Ochratoxin')
	AND receive_date >= '2024-02-01' 
	AND receive_date <= '2024-02-28'


-- Count of all Aflatoxin samples ---------
SELECT 
	COUNT(*) AS 'total samples',
    SUM(CASE WHEN result LIKE '%<1%' THEN 1 ELSE 0 END) AS 'clean sample',
    COUNT(*) - SUM(CASE WHEN result LIKE '%<1%' THEN 1 ELSE 0 END) AS 'positive samples'
FROM 
    (SELECT 
         sample_id, 
         company_name, 
         test_name AS test, 
         result, 
         receive_date, 
         report_date, 
         DATEDIFF(day, receive_date, report_date) AS 'days reported'
     FROM 
         samples
     JOIN 
         customers ON samples.customerID = customers.customerID
     WHERE 
         test_name = 'Aflatoxin'
         AND receive_date >= '2024-02-01' 
         AND receive_date <= '2024-02-28'
    ) AS subquery;


-- Get all Ochratoxin samples-----
	SELECT 
	COUNT(*) AS 'total samples',
    SUM(CASE WHEN result LIKE '%<1%' THEN 1 ELSE 0 END) AS 'clean sample',
    COUNT(*) - SUM(CASE WHEN result LIKE '%<1%' THEN 1 ELSE 0 END) AS 'positive samples'
FROM 
    (SELECT 
         sample_id, 
         company_name, 
         test_name AS test, 
         result, 
         receive_date, 
         report_date, 
         DATEDIFF(day, receive_date, report_date) AS 'days reported'
     FROM 
         samples
     JOIN 
         customers ON samples.customerID = customers.customerID
     WHERE 
         test_name  ='Ochratoxin'
         AND receive_date >= '2024-02-01' 
         AND receive_date <= '2024-02-28'
    ) AS subquery;




-- Aflatoxin and Ochratoxin ---------------
SELECT 
    COUNT(*) AS Total,
    SUM(CASE WHEN test_name = 'Aflatoxin' THEN 1 ELSE 0 END) AS Aflatoxin_count,
    SUM(CASE WHEN test_name = 'Ochratoxin' THEN 1 ELSE 0 END) AS Ochratoxin_count
FROM 
    samples 
WHERE 
    test_name IN ('Aflatoxin', 'Ochratoxin')
    AND receive_date >= '2024-02-01' 
    AND receive_date <= '2024-02-28';

