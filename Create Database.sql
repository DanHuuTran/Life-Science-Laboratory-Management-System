-- Drop the database if it exists
DROP DATABASE IF EXISTS life_science;

-- Create the database
CREATE DATABASE life_science;

-- Use the database
USE life_science;

-- Create the customers table
CREATE TABLE customers (
    customerID INT PRIMARY KEY,
    company_name VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    phone VARCHAR(20)
);

-- Create the tests table
CREATE TABLE tests (
    test_name VARCHAR(255) PRIMARY KEY,
    price DECIMAL(10, 2),
    test_type VARCHAR(255),
    reagent VARCHAR(255),
    department VARCHAR(255)
);

-- Create the samples table
CREATE TABLE samples (
    sample_id INT PRIMARY KEY,
    customerID INT,
    num_sample INT,
    test_name VARCHAR(255),
    receive_date DATE,
    analysis_date DATE,
    report_date DATE,
    result VARCHAR(20),
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (test_name) REFERENCES tests(test_name)
);

-- Create the employee table
CREATE TABLE employee (
    employeeID INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    position VARCHAR(255),
    department VARCHAR(255),
    report_to INT,
    hourly_rate DECIMAL(10, 2),
    FOREIGN KEY (report_to) REFERENCES employee(employeeID)
);

-- Create the shift table
CREATE TABLE shift (
    shift_id INT PRIMARY KEY,
    day_of_week VARCHAR(20),
    shift_start TIME,
    shift_end TIME
);

-- Create the inventory table
CREATE TABLE inventory (
    reagent VARCHAR(255) PRIMARY KEY,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Create the rota table
CREATE TABLE rota (
    rota_id VARCHAR(50) PRIMARY KEY,
    date DATE,
    shift_id INT,
    employeeID INT,
    FOREIGN KEY (shift_id) REFERENCES shift(shift_id),
    FOREIGN KEY (employeeID) REFERENCES employee(employeeID)
);



-- import data to the table 'samples' from a csv file 
-- that I generated using Python
TRUNCATE TABLE samples;
GO
	-- import the file
BULK INSERT samples
FROM 'C:\Users\tranh\Desktop\Projects\Project Lab\samples_data_with_result.csv'
WITH 
( 
FORMAT = 'CSV',
FIRSTROW = 2
)


INSERT INTO tests (test_name, price, test_type, reagent, department)
VALUES 
('Salmonella', 50, 'qualitative', 'ES6 buffer', 'micro'),
('Listeria Spp', 50, 'qualitative', 'LG buffer', 'micro'),
('EO157', 50, 'qualitative', 'EC& buffer', 'micro'),
('Listeria Mono', 50, 'qualitative', 'LM buffer', 'micro'),
('Aflatoxin', 80, 'quantitative', 'HPLC', 'chemistry'),
('Ochratoxin', 100, 'quantitative', 'TLC', 'chemistry'),
('Aerobic Place Count', 20, 'quantitative', 'APC microfilm', 'micro'),
('Total Coliform', 20, 'quantitative', 'TCC microfilm', 'micro'),
('E.Coli Count', 25, 'quantitative', 'ECC microfilm', 'micro'),
('Yeast', 30, 'quantitative', 'Y microfilm', 'micro'),
('Mold', 30, 'quantitative', 'M microfilm', 'micro'),
('Staph', 30, 'quantitative', 'Staph petrifilm', 'micro'),
('Enterobateria', 30, 'quantitative', 'EB petrifilm', 'micro');
SELECT * FROM tests


-- Import data to the customers table using python-generated data
GO
BULK INSERT customers
FROM 'C:\Users\tranh\Desktop\Projects\Project Lab\customers_data.csv'
WITH 
( 
FORMAT = 'CSV',
FIRSTROW = 2
)
SELECT * FROM customers;


-- Import data to the employees table using python-generated data
GO
BULK INSERT employee
FROM 'C:\Users\tranh\Desktop\Projects\Project Lab\employees_data.csv'
WITH 
( 
FORMAT = 'CSV',
FIRSTROW = 2
)
SELECT * FROM employee;


-- insert supervisors, QA officers, and managers
INSERT INTO employee(employeeID, first_name, last_name, position, department, report_to, hourly_rate)
VALUES
(65232, 'Nicholas','Wilson','Supervisor', NULL, 'Hans Richter', 35),
(65951, 'Kimberly','Strickland','Supervisor', 'Hans Richter', NULL, 37),
(65157, 'Nicholas','Carter','Supervisor', NULL, 'Hans Richter', 37),
(65952, 'Russell','Peterson','Supervisor', NULL, 'Hans Richter', 36),
(65784, 'Christina','Good','Supervisor', NULL, 'Hans Richter', 35),
(65782, 'Caly','Pineda','QA Officer', NULL, 'Hans Richter', 32),
(65128, 'Hans','Richter','Manager', NULL, NULL, 43)


-- insert data to the inventory table using python-generated data
GO
BULK INSERT inventory
FROM 'C:\Users\tranh\Desktop\Projects\Project Lab\inventory_data.csv'
WITH 
( 
FORMAT = 'CSV',
FIRSTROW = 2
);
SELECT * FROM inventory;



-- insert data to the shift table using python-generated data
GO
BULK INSERT shift
FROM 'C:\Users\tranh\Desktop\Projects\Project Lab\shift_data.csv'
WITH 
( 
FORMAT = 'CSV',
FIRSTROW = 2
);
SELECT * FROM shift;


-- insert data to the rota table using python-generated data
GO
BULK INSERT rota
FROM 'C:\Users\tranh\Desktop\Projects\Project Lab\rota_data.csv'
WITH 
( 
FORMAT = 'CSV',
FIRSTROW = 2
);
SELECT * FROM rota;


 