# Life Science Laboratory Management System
## Description
The Life Science Laboratory Management System is a SQL Server Management System database for managing various aspects of a laboratory, including sample tracking, test management, employee scheduling, and inventory management. Python was used in order to populate the database with dummmy data.
## Features
* Sample Tracking: Allows tracking of samples from reception to analysis to reporting.
* Test Management: Manages various tests performed on samples, including test details and pricing.
* Employee Management: Tracks employee details, positions, departments, and schedules.
* Shift Scheduling: Generates employee shift schedules based on predefined shifts.
* Inventory Management: Manages laboratory inventory, including reagents, consumables, and equipment.

## Usage
1. Create a databse model using online tools (I am using Quickdatabasediagram.com) for this project
![Table Relationship](https://github.com/DanHuuTran/Life-Science-Laboratory-Management-System/assets/133534096/1c40211a-803e-44f9-8dce-7c42d09f77bb)

2. Populate the database tables
* Run the provided SQL scripts to create the necessary database tables.
* More tables and relationship can be added to the database as needed using SQL scripts
* Generate dummy data using Python scripts provided in the 'scripts' directory and save each file in a folder.(The python codes for generating such data are provided in the Python Codes folder)
* Bulk import each cvs file to the corresponding database table with SQL queries.

3. Access the database via SQL Server Management Studio
![Database](https://github.com/DanHuuTran/Life-Science-Laboratory-Management-System/assets/133534096/644a99f1-0ee8-455c-acf3-d59fb511fcf1)


## Contributing
Contributions are welcome! Please fork the repository, make changes, and submit a pull request.

## License
This project is licensed under MIT License- See LISENCE file for details

## Acknowledgements
All the data in this database is randomly generated using Python libraries, specifically utilizing the Faker library for generating simulated data and the random module for randomization. It's important to note that the data does not represent real companies, individuals, or test results, and should not be considered as valid or accurate in any real-world context.

